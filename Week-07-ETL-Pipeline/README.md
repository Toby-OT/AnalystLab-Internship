# Week 7: Weather Data ETL Pipeline

## Project Overview
This project builds a basic ETL (Extract, Transform, Load) pipeline that pulls real-time weather data for multiple Nigerian cities, cleans and structures it using Pandas, and stores it for analysis. It demonstrates a full end-to-end data pipeline: from a live external API through to a queryable database.

## Data Source
**OpenWeather API** — Current Weather Data endpoint
Website: https://openweathermap.org/api

Weather data was collected for three cities: **Lagos, Abuja, and Jos**.

## ETL Process

### 1. Extract
- Connected to the OpenWeather API using a secured API key (stored in a `.env` file, excluded from version control via `.gitignore`).
- Looped through a list of three cities, making a request per city.
- Pulled the following fields from each response: city name, temperature, humidity, weather condition, wind speed, and timestamp.

### 2. Transform
- Converted the collected results into a Pandas DataFrame.
- Converted the raw Unix timestamp into a readable datetime format.
- Verified data types (temperature and wind speed as floats, humidity as an integer, city and weather condition as strings, datetime as a proper datetime object).

### 3. Load
- Exported the cleaned dataset to a CSV file (`weather_data.csv`).
- Loaded the same dataset into a **PostgreSQL** database using SQLAlchemy, storing it in a `weather_data` table for persistent, queryable storage.

### 4. Basic Analysis
- Compared temperatures across the three cities.
- Identified the city with the highest humidity.
- Compared weather conditions across cities.

## Tools Used
- Python
- Pandas
- Requests
- python-dotenv
- SQLAlchemy + psycopg2 (PostgreSQL connector)
- PostgreSQL
- OpenWeather API

## Key Findings
- Lagos recorded the highest temperature and humidity among the three cities.
- Jos was the coolest of the three cities at the time of collection.
- All three cities showed overcast cloud conditions at the time of data collection, reflecting current regional weather patterns.

## Challenges & Troubleshooting
Along the way, I ran into a number of small but instructive errors:
- **Environment setup:** `python` and `pip` weren't recognized in Git Bash since Python was installed via Anaconda — switched to Anaconda Prompt for all Python/pip commands, and kept Git Bash for Git commands only.
- **Typos breaking the pipeline:** a misspelled `unit` parameter (`uunit`), a misspelled dictionary key (`dateime` instead of `datetime`), and a missing quotation mark in a `to_sql()` call all caused errors that traced back to single-character typos.
- **Indentation error:** an extra leading space before a line caused Python's `IndentationError: unexpected indent` — a reminder of how strict Python is about consistent whitespace.
- **Environment variable mismatch:** used a hyphen (`DB-NAME`) instead of an underscore (`DB_NAME`) in the `.env` file, which meant `os.getenv()` silently returned `None` instead of raising an error, and the failure only surfaced later when PostgreSQL rejected a connection to a database named "None".
- **Scope decision:** initially planned to export to both CSV and Excel, but since the brief only required one of the two, dropped the Excel export to avoid the extra `openpyxl` dependency.

## What I Learned About ETL Pipelines
This project reinforced how much of building a pipeline is about precision — a single mismatched character (a hyphen instead of an underscore, a missing quote, a misspelled key) can break a step, and the error messages don't always point directly at the real cause. I learned to read tracebacks from the bottom up to find the actual failure, and to verify each stage of the pipeline (Extract, Transform, Load) independently before moving to the next, rather than assuming success.

I also got a clearer sense of why the ETL pattern is structured the way it is: keeping Extract, Transform, and Load as distinct steps made it much easier to isolate exactly where something broke, instead of debugging one large block of code. Working with environment variables and `.gitignore` also gave me a better appreciation for handling credentials securely from the start of a project rather than as an afterthought.
