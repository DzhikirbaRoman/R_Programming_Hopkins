library(tidyverse)
data <- read.csv("hw1_data.csv")
?read.csv
data
class(data)
data[1:2,]
nrow(data)
data[(nrow(data) - 1):nrow(data),]
data[47,]
is.na(data$Ozone)
sum(is.na(data$Ozone))
#mean(data[data$Ozone != NA,]$Ozone)
mean(data[!is.na(data$Ozone),]$Ozone)

mean_ozone <- mean(data$Ozone, na.rm = TRUE)
mean_ozone


mean(data[data$Ozone >31 & data$Temp > 90,]$Solar.R)
data[data$Ozone >31 & data$Temp > 90,]
mean(data[data$Ozone >31 & data$Temp > 90,]$Solar.R, na.rm = TRUE)
?mean

mean(data[data$Month == 6,]$Temp, na.rm = TRUE)
?max
max(data[data$Month == 5,]$Ozone, na.rm = TRUE)
