import pandas as pd
import os

# Define paths
ROOT_DIR = ""
INPUT_PATH = os.path.join(ROOT_DIR, "data/911_ems_dispatches.csv")
OUTPUT_PATH = os.path.join(ROOT_DIR, "data/ems_split_data")

# Ensure output directory exists
os.makedirs(OUTPUT_PATH, exist_ok=True)

# Read CSV (update 'timestamp_column' to match your actual column name)
df = pd.read_csv(INPUT_PATH, parse_dates=['call_year'])

# Extract year and split by year
for year, group in df.groupby(df['call_year'].dt.year):
    output_file = os.path.join(OUTPUT_PATH, f"911_ems_dispatches_{year}.csv")
    group.to_csv(output_file, index=False)
    print(f"Saved: {output_file}")
