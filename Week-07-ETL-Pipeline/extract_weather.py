import requests
from dotenv import load_dotenv
import os
import pandas as pd

# TASK 1

# Step 1: Load the .env file into memory
load_dotenv()

# Step 2: Grab the key from environment variables
api_key = os.getenv("OPENWEATHER_API_KEY")

# Step 3: Build the request
cities = ["Lagos", "Abuja", "Jos"]
url = "https://api.openweathermap.org/data/2.5/weather"

all_data = []

for city in cities:
	params = {
   	 "q": city,
   	 "appid": api_key,
   	 "units": "metric"
	}

# Step 4: Make the request
	response = requests.get(url, params=params)
	data = response.json()
	weather_info = {
		"city": data["name"],
		"temperature": data["main"]["temp"],
		"humidity": data["main"]["humidity"],
		"weather_condition": data["weather"][0]["description"],
		"wind_speed": data["wind"]["speed"],
		"datetime": data["dt"]
	}
	all_data.append(weather_info)

# TASK 2

# Step 1: Convert the list of dictionaries into a DataFrame
	df = pd.DataFrame(all_data)

#Step 2: Convert the Unix timestamp into a readable datetime
	df["datetime"] = pd.to_datetime(df["datetime"], unit="s")

# Step 7: Preview the cleaned dataset
print(df)
print(df.dtypes)

# Step 3: Export to CSV
df.to_csv("weather_data.csv", index=False)

print("Data exported successfully to CSV.") 

# TASK 3

from sqlalchemy import create_engine

# Step 1: Build the connection string  from the .env values
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")

engine = create_engine(f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")

# Step 2: Push the DataFrame into a table
df.to_sql("weather_data", engine, if_exists="replace", index=False)

print("Data loaded successfully into PostgreSQL.")

# TASK 4

# Step 1: Compare temperature across cities
print("\n--- Temperature Comparison ---")
print(df[["city", "temperature"]])

# Step 2: Identify the city with the highes humidity
highest_humidity_city = df.loc[df["humidity"].idxmax(), "city"]
print(f"\nCity with highest humidity: {highest_humidity_city}")

# Step 3: Compare weather conditions
print("\n--- Weather Conditions ---")
print(df[["city", "weather_condition"]])