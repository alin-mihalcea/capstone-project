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

#Remove rows with NA values
tripdata_2022 <- na.omit(tripdata_2022)

#Check rows with duplicate ride_id
ride_id_freq <- data.frame(table(tripdata_2022$ride_id))
ride_id_freq[ride_id_freq$Freq > 1,]

#Add a new column for trip duration and remove the records with negative values
tripdata_2022$trip_duration = difftime(tripdata_2022$ended_at, tripdata_2022$started_at, units="mins")
tripdata_2022 <- subset(tripdata_2022, trip_duration > 0)

#Rename field name and observations of member_casual
tripdata_2022$member_casual <- case_when(tripdata_2022$member_casual=="casual" ~ "Casual Rider", 
                                         tripdata_2022$member_casual=="member" ~ "Annual Member")
colnames(tripdata_2022)[which(names(tripdata_2022) == "member_casual")] <- "customer_type"

#Rename the observations of rideable_type
tripdata_2022$rideable_type <- case_when(tripdata_2022$rideable_type=="electric_bike" ~ "Electric Bike",
                                         tripdata_2022$rideable_type=="classic_bike" ~ "Classic Bike",
                                         tripdata_2022$rideable_type=="docked_bike" ~ "Docked Bike")
