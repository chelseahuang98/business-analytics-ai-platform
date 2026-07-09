import os
import pandas as pd

DATA_DIR = "data"
OUTPUT_PATH = "docs/03_Data_Profiling.md"

def profile_csv(file_path):
    df = pd.read_csv(file_path)
    return {
        "table": os.path.basename(file_path),
        "rows": df.shape[0],
        "columns": df.shape[1],
        "duplicate_rows": df.duplicated().sum(),
        "missing_values": int(df.isnull().sum().sum()),
        "column_names": list(df.columns)
    }

def main():
    profiles = []

    for file in os.listdir(DATA_DIR):
        if file.endswith(".csv"):
            profiles.append(profile_csv(os.path.join(DATA_DIR, file)))

    markdown = "# Data Profiling\n\n"
    markdown += "## Dataset Summary\n\n"
    markdown += "| Table | Rows | Columns | Duplicate Rows | Missing Values |\n"
    markdown += "|------|------:|--------:|---------------:|---------------:|\n"

    for p in profiles:
        markdown += f"| {p['table']} | {p['rows']} | {p['columns']} | {p['duplicate_rows']} | {p['missing_values']} |\n"

    markdown += "\n---\n\n## Table Details\n\n"

    for p in profiles:
        markdown += f"### {p['table']}\n\n"
        markdown += f"- Rows: {p['rows']}\n"
        markdown += f"- Columns: {p['columns']}\n"
        markdown += f"- Duplicate Rows: {p['duplicate_rows']}\n"
        markdown += f"- Missing Values: {p['missing_values']}\n"
        markdown += "- Column Names:\n"
        for col in p["column_names"]:
            markdown += f"  - {col}\n"
        markdown += "\n"

    os.makedirs("docs", exist_ok=True)

    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write(markdown)

    print(f"Data profiling report created: {OUTPUT_PATH}")

if __name__ == "__main__":
    main()
