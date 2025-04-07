import requests
import pandas as pd

def scrap_weather_data_to_parquet():
    # Define API URL
    url = "https://api.open-meteo.com/v1/forecast?latitude=50.88&longitude=4.70&hourly=temperature_2m,relative_humidity_2m,precipitation,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high,wind_speed_10m,wind_direction_10m&forecast_days=1&timezone=Europe%2FBerlin"

    # Request data from API
    response = requests.get(url)
    data = response.json()

    # Extract only the "hourly" section
    hourly_data = data["hourly"]

    # Convert to DataFrame
    #df = pd.DataFrame(hourly_data)

    # Convert "time" column to datetime format
    #df["time"] = pd.to_datetime(df["time"])

    # Save to Parquet file
    #df.to_parquet("weather_data.parquet", engine="pyarrow", index=False)

    return hourly_data

# Run the function and preview output
df_weather = scrap_weather_data_to_parquet()
print(df_weather)