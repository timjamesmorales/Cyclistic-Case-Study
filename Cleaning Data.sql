-- Each query executed below was performed on each quarter dataset, as well as the full year combined dataset ex. replace 'q1_2019' with 'q2_2019' etc.

-- Check data type:
SELECT column_name, data_type
FROM cyclistic-422905.biketrip_data.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'q1_2019'

-- Count null values in each column (Replace trip_id with any column to check):
SELECT
 COUNTIF(trip_id IS NULL) AS null_count
FROM `cyclistic-422905.biketrip_data.q1_2019`
  
-- Count duplicate trip_id rows:
SELECT
 COUNT(trip_id) - COUNT(DISTINCT trip_id) AS duplicate_ids
FROM `cyclistic-422905.biketrip_data.q1_2019`

-- Check if string length of all id column rows match:
SELECT
 LENGTH(CAST(trip_id AS STRING)) AS length_trip_id,
 COUNT(trip_id) AS no_of_rows
FROM cyclistic-422905.biketrip_data.q1_2019
GROUP BY length_trip_id

-- ALTER TABLE and RENAME COLUMN to standardize the Q2 column naming convention with that of the other quarters (Replace start_time with any column to rename):
ALTER TABLE cyclistic-422905.biketrip_data.q2_2019
RENAME COLUMN _01___Rental_Details_Local_Start_Time to start_time

-- Create a new table incorporating the original data and adding 'tripduration_minutes', 'day_of_week', and 'month' columns:
CREATE TABLE cyclistic-422905.biketrip_data.q1_2019_combined AS (
SELECT
 trip_id, start_time, end_time, bikeid, tripduration,
 ROUND(tripduration/60) AS tripduration_minutes,
 EXTRACT(DAYOFWEEK FROM start_time) AS day_of_week,
 EXTRACT(MONTH FROM start_time) AS month,
 from_station_id, from_station_name, to_station_id, to_station_name, usertype, gender, birthyear
FROM `cyclistic-422905.biketrip_data.q1_2019`
)

-- Examine the minimum, maximum, and average trip duration of the new table:
SELECT 
 MAX(tripduration_minutes) AS max_duration_min,
 MIN(tripduration_minutes) AS min_duration_min,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`

-- Check for negative trip duration values: 
SELECT
 COUNT(*) AS negative_tripduration
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes < 0
-- 0 negative ride lengths reported for Q1 2019

-- Check for trip duration values over 24 hrs (1440 minutes):
SELECT
 COUNT(*) AS over_24hr
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 1440
-- 192 ride lengths over 24 hrs reported for Q1 2019

-- Filtering techniques will be applied to exclude these error values from final analysis.
