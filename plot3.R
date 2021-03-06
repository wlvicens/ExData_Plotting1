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
par(ps=12)
png(filename = 'plot3.png')
plot(keydata$Date, keydata$Sub_metering_1, type = 'l',  xlab = '', ylab = 'Energy sub metering')
lines(keydata$Date, keydata$Sub_metering_2, col = "red")
lines(keydata$Date, keydata$Sub_metering_3, col = "blue")
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
