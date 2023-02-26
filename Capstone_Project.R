# # # # # # # # # # # # # # # # # # # # # # #
#Install and load packages
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("dplyr")
install.packages("RColorBrewer")
library(tidyverse) #for data import and wrangling
library(ggplot2) #for visualization
library(lubridate) #for date functions
library(dplyr) #for data manipulation
library(RColorBrewer) #color palettes for creating beautiful graphics
# # # # # # # # # # # # # # # # # # # # # # # 

#=====================
# STEP 1: COLLECT DATA
#=====================
#Load each monthly trip data .csv files for the year 2022
tripdata_22_01 <- read_csv("202201-divvy-tripdata.csv")
tripdata_22_02 <- read_csv("202202-divvy-tripdata.csv")
tripdata_22_03 <- read_csv("202203-divvy-tripdata.csv")
tripdata_22_04 <- read_csv("202204-divvy-tripdata.csv")
tripdata_22_05 <- read_csv("202205-divvy-tripdata.csv")
tripdata_22_06 <- read_csv("202206-divvy-tripdata.csv")
tripdata_22_07 <- read_csv("202207-divvy-tripdata.csv")
tripdata_22_08 <- read_csv("202208-divvy-tripdata.csv")
tripdata_22_09 <- read_csv("202209-divvy-publictripdata.csv")
tripdata_22_10 <- read_csv("202210-divvy-tripdata.csv")
tripdata_22_11 <- read_csv("202211-divvy-tripdata.csv")
tripdata_22_12 <- read_csv("202212-divvy-tripdata.csv")

#=======================
# STEP 2: CLEAN THE DATA
#=======================

#Check the correct data type of each field and if the files have the same fields
glimpse(tripdata_22_01)
glimpse(tripdata_22_02)
glimpse(tripdata_22_03)
glimpse(tripdata_22_04)
glimpse(tripdata_22_05)
glimpse(tripdata_22_06)
glimpse(tripdata_22_07)
glimpse(tripdata_22_08)
glimpse(tripdata_22_09)
glimpse(tripdata_22_10)
glimpse(tripdata_22_11)
glimpse(tripdata_22_12)

#Union all the monthly data frames into one data frame for the entire year
tripdata_2022 <- bind_rows(tripdata_22_01,
                           tripdata_22_02,
                           tripdata_22_03,
                           tripdata_22_04,
                           tripdata_22_05,
                           tripdata_22_06,
                           tripdata_22_07,
                           tripdata_22_08,
                           tripdata_22_09,
                           tripdata_22_10,
                           tripdata_22_11,
                           tripdata_22_12)

#Display the new data frame
View(tripdata_2022)

#Check for duplicate ride_id
ride_id_freq <- data.frame(table(tripdata_2022$ride_id))
ride_id_freq[ride_id_freq$Freq > 1,]

#Check if the end time of each trip is after the start time
#Add a new column for trip duration and remove the record with negative values
tripdata_2022$trip_duration = difftime(tripdata_2022$ended_at, tripdata_2022$started_at, units="mins")
tripdata_2022 <- subset(tripdata_2022, trip_duration > 0)

#=========================
# STEP 3: PROCESS THE DATA
#=========================

tripdata_2022$week_day_name <- format(tripdata_2022$started_at, "%a")                     
tripdata_2022$month <- format(as.Date(tripdata_2022$started_at), "%b")

#member_coord <- select(tripdata_2022 %>% group_by(start_station_id) %>% filter(member_casual == "member") %>%
#summarise(station_lat = first(start_lat), station_lng = first(start_lng)), station_lat, station_lng)
#mapview(tripdata_2022, xcol = "station_lng", ycol = "station_lat", crs = 4269, grid = FALSE)


#count of rides per member_casual per rideable_type
table_graph_01 <- tripdata_2022 %>%
  group_by(member_casual, rideable_type) %>% 
  count(member_casual)
table_graph_01$rides_millions <- (table_graph_01$n/1000000)
table_graph_01$rides_millions <- as.numeric(format(round(table_graph_01$rides_millions, 2), nsmall = 2))

#total of rides per member_casual
table_graph_01_totals <- table_graph_01  %>%
group_by(member_casual) %>%
summarize(total_rides = sum(rides_millions))

#bar chart
ggplot(table_graph_01, aes(x = member_casual, y = rides_millions, fill = factor(rideable_type))) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = rides_millions), position = position_stack(vjust = 0.5)) +
  geom_text(aes(label = after_stat(table_graph_01_totals$total_rides), group = member_casual), 
    stat = 'summary', fun = sum, vjust = -0.5) +
  labs(title="Number of Trips in 2022",
       x ="User Type", y = "Number of Trips (millions)") +
  scale_x_discrete(labels=c('Casual rider', 'Annual member')) +
  guides(fill=guide_legend(title="Bike Type")) +
scale_fill_brewer(palette = "RdYlBu",labels=c('Classic Bike', 'Docked Bike', 'Electric Bike')) 



#sum of trip duration (million minutes) per member_casual per rideable_type
table_graph_02 <- tripdata_2022 %>%
  group_by(member_casual, rideable_type) %>% 
  summarise(total_trip_duration = sum(trip_duration))
  table_graph_02$trips_duration <- as.numeric(format(round(as.vector(table_graph_02$total_trip_duration/1000000), 2), nsmall = 2))

  #total of trip duration (million minutes) per member_casual
  table_graph_02_totals <- table_graph_02  %>%
    group_by(member_casual) %>%
    summarize(total_trips_duration = sum(trips_duration))
  
  #bar chart
  ggplot(table_graph_02, aes(x = member_casual, y = trips_duration, fill = factor(rideable_type))) + 
    geom_bar(stat = "identity") +  scale_fill_brewer(palette = "RdYlBu") +
    geom_text(aes(label = trips_duration), position = position_stack(vjust = 0.5)) +
    geom_text(aes(label = after_stat(table_graph_02_totals$total_trips_duration), group = member_casual), 
              stat = 'summary', fun = sum, vjust = -1)
  
  
  
