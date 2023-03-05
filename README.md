# Google Data Analytics Capstone Project: How Does a Bike-Share Navigate Speedy Success?

This is my Casptone Project for the [**Google Data Analytics Certificate**](https://www.credly.com/badges/123985c2-8ea2-4731-aab7-34617a398919) (Track 1, Case Study 1).

The scope of this project is to answer the key business questions for Cyclistic, a fictional company. I will follow the steps of the data analysis process: ask, prepare, process, analyze, share, and act.

### Table of Content
-   [Business Task](#business-task)
-   [Description of the Data Sources](#description-of-the-data-sources)
-   [R: Step 1 - Collecting the Data](#r-step-1---collecting-the-data)
-   [R: Step 2 - Data Cleaning](#r-step-2---data-cleaning)
-   [R: Step 3 - Process the Data and Analysis](#r-step-3---process-the-data-and-analysis)
-   [R: Step 4 - Data Visualization](#r-step-4---data-visualization)
-   [Analysis Summary](#analysis-summary)
-   [Top 3 Recommendations](#top-3-recommendations)

## Business Task
### Scenario

I am junior data analyst working in the marketing analyst team at **Cyclistic**, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to **convert casual riders into annual members**. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a **network of 692 stations across Chicago**. The bikes can be unlocked from one station and returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its **pricing plans: single-ride passes, full-day passes, and annual memberships**. Customers who purchase single-ride or full-day passes are referred to as **casual riders**. Customers who purchase annual memberships are **Cyclistic members**.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

### Business Question:
**How do annual members and casual riders use Cyclistic bikes differently?**


## Description of the Data Sources
I downloaded the last 12 months (entire 2022 year) of Cyclistic trip data from [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

Each .csv file contains the data for each month.

The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study,
the datasets are appropriate and will enable me to answer the business questions. The data has been made available by
Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).

## R: Step 1 - Collecting the Data
[R code for Collecting the Data](https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/01_Collect_Data.R)
1. Install and load all of the libraries I used.
2. Upload each monthly trip data .csv file for the entire 2022 year and save them as separate data frames.

## R: Step 2 - Data Cleaning
[R code for Data Cleaning](https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/02_Clean_Data.R)
1. Check the correct data type of each field and if all files have the same fields.
2. Union all the monthly data frames into one data frame for the entire year (tripdata_2022).
3. Display the new data frame.
4. Remove the record with NA values
5. Check if the data frame contains records with duplicate ride ID.
6. Check if the end time of each trip is after the start time by creating a new column for the trip duration and remove records with a negative value for trip duration.
7. Rename the values for member_casual and rideable_type to more legible names. 

## R: Step 3 - Process the Data and Analysis
[R code for Process the Data and Analysis](https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/03_Data_Analysis.R)
1. Add new columns for the weekday and month of the ride based on the ride start date and duration.
2. Create a new data frame (totals) containing the totals for the number of rides and duration. Also, determine the average duration per ride.
3. Repeat the previous step for each customer type (totals_customer_type).
4. Create a new data frame (weekdays_df) containing the total number of rides for each weekday.
5. Create a new data frame (weekdays_customer_type_df) containing the total number of rides for each weekday and customer type.
6. Create a new data frame (months_customer_type_df) containing the total number of rides for each month and customer type.
7. Create a new data frame (bike_type_df) containing the total number of rides for each bike type and customer type.
8. Create a new data frame (bike_type_total_df) containing the total number of rides for each bike type.


## R: Step 4 - Data Visualization
[R code for Data Visualization](https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/04_Data_Visualization.R)
1. Create a doughnut chart for the number of rides for each customer type. Prior to this, new columns are added to the totals_customer_type data frame to accomodate creating this chart.
2. Create a bar chart for the average duration of the ride for each customer type. The total average duration is also included in the chart.
3. Create a bar chart for the number of rides per each day of the week.
4. After noticing in the previous chart that annual members have less trips during the weekend compared to the workweek and the oposite is valid for the casual riders, a new data frame is created (weekdays_customer_type_df), to show the average daily number of rides for workweek vs weekend for each customer type. A bar chart is created to display this data.
5. Create a bar chart for the number of rides per each month.
6. Create a bar chart for the number of rides per bike type and customer type.
7. Create a heat map for the number of rides structures as a calendar for the entire year.

## Analysis Summary

The total number of rides in 2022 is 4.4 million, with annual members having a 60% share, and casual riders a 40% share.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz01_doughnut_rides_customer_type.png"
width=40% height=40%>

The average ride time represents a significant difference since the level for casual riders is double compared to the annual members.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz02_bar_average_ride_time.png"
width=40% height=40%>

Another significant difference is revealed in the analysis of the number of rides per day of the week.

The peak for annual members is between Tuesday and Thursday, and the low is on Sunday.

The peak for casual riders is during the weekend, with the work week at significantly lower levels.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz03_bar_weekdays.png"
width=60% height=60%>

Further exploring the previous finding, this difference is better revealed after determining the average daily rides for the weekend compared to the workweek, for each customer type.

The average daily rides for annual members are lower during the weekend and the opposite for casual riders.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz04_bar_weekend_workweek.png"
width=40% height=40%>

The analysis of the number of rides for each month shows a peak during the summer and a low during the winter. This applies to both annual members and casual riders.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz05_bar_months.png"
width=50% height=50%>

The overall trend regarding months and days of the week can be also noticed in this heat map chart.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz06_heat_map.png "
width=100% height=100%>

Regarding the preferred type of bikes, both customer types prefer the classic bike, but at a higher rate for the annual members.

<img src="https://github.com/alin-mihalcea/google-data-analytics-capstone-project/blob/main/viz07_bar_bike_type.png"
width=40% height=40%>


## Top 3 Recommendations
Your top three recommendations based on your analysis

1. Considering the casual riders prefer the weekend, I recommend analyzing the prices of the passes and annual memberships and adjusting them if needed to incentivize the casual riders to save money by purchasing annual memberships.

2. When casual members purchase passes, provide them simulations revealing how much money they would save having an annual membership compared to purchasing passes, with a focus on the summer months, when both casual members and casual riders ride the most.

3. Offer a free subscription to a cycling monitoring app for annual members. Promote testimonials of the app users, explaining how they benefit from this form of gamification.
