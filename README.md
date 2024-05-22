# Cyclistic Case Study
##### Performed By: Timothy Morales
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
SQL Code:

Each quarter's CSV data file is uploaded as a table to the 'cyclistic-422905.biketrip_data' dataset. In addition to each individual quarter being analyzed, the 2019 year as a whole will be analyzed as well. In order to do so, I will create a new table and UNION ALL the previous four quarters into one table called 'year_2019'. This full year table contains 3,818,004 rows.

### Cleaning Data
