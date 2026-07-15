from pathlib import Path

import duckdb


ROOT = Path(__file__).resolve().parent.parent
DATABASE_DIR = ROOT / "database"
DATABASE_PATH = DATABASE_DIR / "ecommerce.duckdb"
OUTPUT_DIR = ROOT / "outputs"

INITIALIZE_SQL = ROOT / "sql" / "01_initialize_database.sql"

ANALYSES = {
    "executive_kpis": ROOT / "sql" / "02_executive_kpis.sql",
    "monthly_sales": ROOT / "sql" / "03_monthly_sales.sql",
    "category_sales": ROOT / "sql" / "04_category_sales.sql",
    "state_sales": ROOT / "sql" / "05_state_sales.sql",
    "payment_analysis": ROOT / "sql" / "06_payment_analysis.sql",
}


def read_sql(path: Path) -> str:
    if not path.exists():
        raise FileNotFoundError(f"SQL file not found: {path}")
    return path.read_text(encoding="utf-8")


def main() -> None:
    DATABASE_DIR.mkdir(exist_ok=True)
    OUTPUT_DIR.mkdir(exist_ok=True)

    with duckdb.connect(str(DATABASE_PATH)) as connection:
        connection.execute(read_sql(INITIALIZE_SQL))

        for analysis_name, sql_path in ANALYSES.items():
            result = connection.execute(read_sql(sql_path)).df()

            output_path = OUTPUT_DIR / f"{analysis_name}.csv"
            result.to_csv(output_path, index=False)

            print(f"\n{analysis_name.replace('_', ' ').title()}:")
            print(result.head(10).to_string(index=False))
            print(f"Saved to: {output_path}")


if __name__ == "__main__":
    main()