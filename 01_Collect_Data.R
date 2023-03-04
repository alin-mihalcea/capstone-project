#Install packages
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("dplyr")
install.packages("RColorBrewer")
install.packages("scales")
#Load packages
library(tidyverse) #data import and wrangling
library(ggplot2) #visualization
library(lubridate) #date functions
library(dplyr) #data manipulation
library(RColorBrewer) #color palettes for creating beautiful graphics
library(scales) #converting data values
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
