-- After uploading each quarter's CSV file as a table to the dataset, I create a new table and merge them all to analyze the year as a whole

CREATE TABLE cyclistic-422905.biketrip_data.year_2019 AS (
SELECT *
FROM `cyclistic-422905.biketrip_data.q1_2019`
UNION ALL


SELECT *
FROM `cyclistic-422905.biketrip_data.q2_2019`
UNION ALL


SELECT *
FROM `cyclistic-422905.biketrip_data.q3_2019`
UNION ALL


SELECT *
FROM `cyclistic-422905.biketrip_data.q4_2019`
)
