-- Each query executed below was performed on each quarter dataset, as well as the full year combined dataset ex. replace 'q1_2019' with 'q2_2019' etc.
-- Each query executed below uses filters that exclude error values discovered during cleaning.

-- Overall Min, Max, Avg tripduration_minutes:
SELECT 
 MAX(tripduration_minutes) AS max_duration_min,
 MIN(tripduration_minutes) AS min_duration_min,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440

-- Overall avg ride length for Subscribers/Customers:
SELECT
 usertype,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY usertype
ORDER BY usertype

-- Avg combined ride length per Weekday:
SELECT
 day_of_week,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY day_of_week
ORDER BY day_of_week

-- Avg Subscriber/Customer ride length per Weekday:
SELECT
 usertype,
 day_of_week,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY day_of_week,usertype
ORDER BY day_of_week,usertype

-- Avg combined ride length per Month:
SELECT
 month,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY month
ORDER BY month

-- Avg Subscriber/Customer ride length per Month: 
SELECT
 month,
 usertype,
 ROUND(AVG(tripduration_minutes),2) AS avg_duration_min
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY month,usertype
ORDER BY month,usertype

-- Overall number of rides for Subscribers/Customers:
SELECT
 usertype,
 COUNT(*) AS user_type
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY usertype

-- Number of combined rides for per Weekday:
SELECT
 day_of_week,
 COUNT(*) AS num_of_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY day_of_week
ORDER BY day_of_week

-- Number of Subscriber/Customer rides per Weekday:
SELECT
 usertype,
 day_of_week,
 COUNT(*) AS num_of_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY day_of_week,usertype
ORDER BY day_of_week,usertype

-- Number of combined rides per Month:
SELECT
 month,
 COUNT(*) AS num_of_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY month
ORDER BY month

-- Number of Subscriber/Customer rides per Month:
SELECT
usertype,
 month,
 COUNT(*) AS num_of_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY month,usertype
ORDER BY month,usertype

-- Number of Subscriber/Customer rides per Hour per Weekday:
SELECT
 usertype,
 CASE
   WHEN day_of_week = 1 THEN 'Sunday'
   WHEN day_of_week = 2 THEN 'Monday'
   WHEN day_of_week = 3 THEN 'Tuesday'
   WHEN day_of_week = 4 THEN 'Wednesday'
   WHEN day_of_week = 5 THEN 'Thursday'
   WHEN day_of_week = 6 THEN 'Friday'
   WHEN day_of_week = 7 THEN 'Saturday'
   END AS day_of_week,
 EXTRACT(hour FROM start_time) AS hour,
 COUNT(*) AS num_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE tripduration_minutes > 0 AND tripduration_minutes < 1440
GROUP BY day_of_week, hour, usertype
ORDER BY day_of_week, hour, usertype

-- Most popular Start stations for Subscribers:
SELECT
 usertype,
 from_station_id,
 from_station_name,
 COUNT (*) AS num_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE usertype = 'Subscriber'
GROUP BY from_station_id, from_station_name, usertype
ORDER BY num_rides DESC

-- Most popular Start stations for Customers:
SELECT
 usertype,
 from_station_id,
 from_station_name,
 COUNT (*) AS num_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE usertype = 'Customer'
GROUP BY from_station_id, from_station_name, usertype
ORDER BY num_rides DESC

-- Most popular End stations for Subscribers:
SELECT
 usertype,
 to_station_id,
 to_station_name,
 COUNT (*) AS num_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE usertype = 'Subscriber'
GROUP BY to_station_id, to_station_name, usertype
ORDER BY num_rides DESC

-- Most popular End stations for Customers:
SELECT
 usertype,
 to_station_id,
 to_station_name,
 COUNT (*) AS num_rides
FROM `cyclistic-422905.biketrip_data.q1_2019_combined`
WHERE usertype = 'Customer'
GROUP BY to_station_id, to_station_name, usertype
ORDER BY num_rides DESC

-- Save the results of the previous 4 queries to tables, then JOIN the start + end stations in order to determine the 10 most visited stations for Subscribers/Customers
  
-- Top Ten Most Visited Subscriber Stations:
SELECT
 f.usertype,
 f.from_station_name AS station_name,
 f.num_rides + t.num_rides AS total_visits
FROM cyclistic-422905.biketrip_data.start_count_subscribers AS f
JOIN cyclistic-422905.biketrip_data.to_count_subscribers AS t
ON f.from_station_name = t.to_station_name
ORDER BY total_visits DESC
LIMIT 10

--Top Ten Most Visited Customer Stations:
SELECT
 f.usertype,
 f.from_station_name AS station_name,
 f.num_rides + t.num_rides AS total_visits
FROM cyclistic-422905.biketrip_data.start_count_customers AS f
JOIN cyclistic-422905.biketrip_data.to_count_customers AS t
ON f.from_station_name = t.to_station_name
ORDER BY total_visits DESC
LIMIT 10
