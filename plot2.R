## load libraries for processing data
library(lubridate)
library(dplyr)

## import the data
rawdata <- read.csv("household_power_consumption.txt", sep=';')

## extract the data of interest
keydata <- filter(rawdata, Date == '1/2/2007' | Date == '2/2/2007')

## convert the date and time columns to a single column containing POSIXct and POSIXt
dates <- dmy_hms(paste(keydata$Date, keydata$Time, sep = ' '))
keydata$Date <- dates
keydata$Time <- NULL

## convert other columns to numeric
keydata[,2:7] <- sapply(keydata[,2:7], as.character)
keydata[,2:7] <- sapply(keydata[,2:7], as.numeric)

## plot the chart
png(filename = 'plot2.png')
par(ps=12)
plot(keydata$Date, keydata$Global_active_power, type = 'l',  xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
