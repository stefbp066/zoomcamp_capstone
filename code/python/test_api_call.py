import requests
import json

# API URL
url = "https://api.open-meteo.com/v1/forecast?latitude=50.88&longitude=4.7&hourly=temperature_2m,relative_humidity_2m,precipitation,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high,wind_speed_10m,wind_direction_10m&timezone=Europe%2FBerlin"

# Make the API request
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    try:
        data = response.json()  # Parse JSON response
        
        # Save data to a JSON file
        with open("weather_data.json", "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4)
        
        print("Weather data saved to weather_data.json")
    except json.JSONDecodeError:
        print("Error: Response is not in valid JSON format.")
else:
    print(f"Error: Failed to fetch data. Status code {response.status_code}")