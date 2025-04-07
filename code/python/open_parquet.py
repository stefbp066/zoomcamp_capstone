import pandas as pd

def read_parquet(file_path):
    """Reads a Parquet file and returns a DataFrame."""
    try:
        df = pd.read_parquet(file_path, engine="pyarrow")
        return df
    except Exception as e:
        print(f"Error reading Parquet file: {e}")
        return None

# Example usage
file_path = "yUDmnPVfCzLI7ibLxOIL9-weather_data-20250331.parquet"  # Replace with your actual file path
df = read_parquet(file_path)

if df is not None:
    print(df.head())  # Print first few rows
