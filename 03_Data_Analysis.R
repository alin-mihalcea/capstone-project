#======================
# STEP 3: DATA ANALYSIS
#======================

#Add new columns for weekday and month based on the ride start date and time
tripdata_2022$week_day_name <- format(tripdata_2022$started_at, "%a")                     
tripdata_2022$month <- format(as.Date(tripdata_2022$started_at), "%b")

#Determine the total number or rides, total time and average time per ride
totals <- tripdata_2022 %>%
  summarise(total_rides=n(),
            total_time = sum(trip_duration))
totals$avg_time <- format(round(totals$total_time/totals$total_rides, 0), nsmall = 0)
totals$total_rides_mil <- as.numeric(format(round(totals$total_rides/1000000, 1),
                                            nsmall = 1))

View(totals)

#Determine the total number or rides, total time and average time per ride for each customer type
totals_customer_type <- tripdata_2022 %>%
  group_by(customer_type) %>%
  summarise(total_rides = n(),
            total_time = sum(trip_duration))
totals_customer_type$total_rides_mil <- as.numeric(format(round(totals_customer_type$total_rides/1000000, 1),
                                                          nsmall = 1))
totals_customer_type$avg_time <- totals_customer_type$total_time/totals_customer_type$total_rides
totals_customer_type$avg_time <- format(round(totals_customer_type$total_time/totals_customer_type$total_rides, 0),
                                        nsmall = 0)
totals_customer_type$total_rides_share <- totals_customer_type$total_rides/sum(totals_customer_type$total_rides)
totals_customer_type$total_rides_percent <- percent(totals_customer_type$total_rides_share)

View(totals_customer_type)

#Determine the total number or rides for each weekday
weekdays_df <- tripdata_2022 %>%
  group_by(week_day_name) %>%
  summarise(total_rides = n())
weekdays_df$total_rides_10k <- as.numeric(format(round(weekdays_df$total_rides/10000, 0), nsmall = 0))

View(weekdays_df)

#Determine the total number or rides for each weekday and customer type
weekdays_customer_type_df <- tripdata_2022 %>%
  group_by(week_day_name, customer_type) %>%
  summarise(total_rides = n())
weekdays_customer_type_df$total_rides_10k <- as.numeric(format(round(
  weekdays_customer_type_df$total_rides/10000, 0),
  nsmall = 0))
View(weekdays_customer_type_df)


#Determine the total number or rides for each month and customer type
months_customer_type_df <- tripdata_2022 %>%
  group_by(month, customer_type) %>%
  summarise(total_rides = n())
months_customer_type_df$total_rides_10k <- as.numeric(format(round(months_customer_type_df$total_rides/10000, 0),
                                                             nsmall = 0))
View(months_customer_type_df)


#Determine the total number or rides for each bike type and customer type
bike_type_df <- tripdata_2022 %>%
  group_by(rideable_type, customer_type) %>%
  summarise(total_rides = n())
bike_type_df$total_rides_10k <- as.numeric(format(round(bike_type_df$total_rides/10000, 0),
                                                  nsmall = 0))
View(bike_type_df)

#Determine the total number or rides for each bike type
bike_type_total_df <- tripdata_2022 %>%
  group_by(rideable_type) %>%
  summarise(total_rides = n())
bike_type_total_df$total_rides_10k <- as.numeric(format(round(bike_type_total_df$total_rides/10000, 0),
                                                        nsmall = 0))
View(bike_type_total_df)