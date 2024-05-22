# Cyclistic Case Study
###### Performed By: Timothy Morales
## Introduction
This case study serves as a capstone project to Google's 6 month Data Analytics Certification Course. It intends to showcase proficiency in SQL, Tableau, and Spreadsheets.  

## Scenario
For this project, I will assume the role of a data analyst working on the marketing analytics team at Cyclistic, a fictional Chicago-based bike-share company. The director of the marketing department believes the company’s future success depends on maximizing the number of annual memberships. My team has therefore been tasked with answering several key business questions and gaining insights that will help to design a new marketing strategy intended to convert casual riders into annual members. My team's recommendations will be presented to the executive team for approval and will be supported by compelling data insights and professional data visualizations. 

## Business Task
Specifically, my task is to analyze how casual riders and annual members use Cyclistic bikes differently. To do so, I will analyze four quarters of 2019 bike trip data using SQL, organize my findings with Spreadsheets, and create visualizations of my discoveries with Tableau. From there, I will suggest several recommendations to help the overall marketing goal.

## Data Source
My analysis will be conducted on four quarters of 2019 historical bike trip data. Given that Cyclistic is a fictional company, the real-world data of Divvy Bikes will be used for this project. The data can be downloaded from [here](https://divvy-tripdata.s3.amazonaws.com/index.html) and has been made publically available through this [license](https://divvybikes.com/data-license-agreement).

All personally identifiable information has been removed from the dataset. The data includes 4 CSV files of long format data, ranging from January 2019 to December 2019. Each file consists of 12 columns: trip_id, start_time, end_time, bikeid, tripduration, from_station_id, from_station_name, to_station_id, to_station_name, usertype, gender, birthyear.

## Process
SQL will be used to perform the data cleaning, analysis, and merger of the datasets. This tool was chosen due to the large amount of raw data I will be working with, exceeding 3.8 million rows. Datasets of this size render spreadsheets impractical, so BigQuery will instead be the platform of choice for this section. 

### Uploading Data
[SQL Code: Merging Data](https://github.com/timjamesmorales/Cyclistic-Case-Study/blob/main/Merging%20Data.sql)

Each quarter's CSV data file is uploaded as a table to the 'cyclistic-422905.biketrip_data' dataset. In addition to each individual quarter being analyzed, the 2019 year as a whole will be analyzed as well. In order to do so, I will create a new table and UNION ALL the previous four quarters into one table called 'year_2019'. This full year table contains 3,818,004 rows.

### Cleaning Data
[SQL Code: Cleaning Data](https://github.com/timjamesmorales/Cyclistic-Case-Study/blob/main/Cleaning%20Data.sql)

Prior to actual data analysis, the raw dataset for each quarter must be inspected, cleaned, and transformed. First, each column's data type is inspected. Next, each column is checked for null values, starting with the 'trip_id' column then substituting for each other column. Duplicate 'trip_id' rows are checked for as well, with none found. Then, the 'trip_id' column is inspected to ensure that each string is the same length: 8 characters. 

During this cleaning phase, I discovered that the Q2 dataset employed a column naming convention quite different than that of the other three quarters, which were all the same. In order to standardize the naming convention to that of the other datasets, I utilized the ALTER TABLE and RENAME COLUMN functions on the Q2 dataset, renaming every column accordingly.

Afterwards, I created a new table for each quarter that contained the original data and added columns recording each trip's duration in minutes, the weekday, and the month of the trip. Then, the minimum, maximum, and average trip duration of these new tables are tested, revealing durations lasting over 24 hours. These values appear to indicate errors that ought to be excluded from final analysis. Filtering techniques are therefore applied to exclude these error values during analysis.

### Analyze Data
[SQL Code: Analyze Data](https://github.com/timjamesmorales/Cyclistic-Case-Study/blob/main/Analyze%20Data.sql)

In order to generate useful insights, several analyses are performed on the new tables for each quarter. Each query is executed with filters that exclude error values discovered earlier. The following insights are gleaned during this phase: 

Minimum, maximum, and average trip duration; Overall average ride length for casual riders vs. annual members; Average ride length for casual riders vs. annual members per weekday; Average ride length for casual riders vs. annual members per month; Overall number of rides for casual riders vs. annual members; Number of rides for casual riders vs. annual members per weekday; Number of rides for casual riders vs. annual members per month.

To observe ride patterns throughout the day, the number of rides for casual riders vs. annual members per hour per weekday is determined. To avoid confusion later during Tableau visualization, the 'day_of_week' column is modified to change the numeric values of the days of the week into their proper names.

The most popular start and end stations for casual riders vs. annual members is also determined. The results of these queries are stored as tables that can be JOINed so as to determine the total number of visits to each station for casual riders vs. annual members. Then, the top ten most visited stations for casual riders vs. annual members are determined.

Each query result is saved as a CSV file and organized into its respective Drive folder within the overall project folder. Then, each CSV file is merged into one spreadsheet separated by labeled tabs. Each quarter's spreadsheet (and the full year's) will be used as data sources for Tableau visualization.

## Visualize and Share
Link to the [Tableau Dashboard](https://public.tableau.com/app/profile/timothy.morales6239/viz/CyclisticRideAnalysis2019/Q1):
