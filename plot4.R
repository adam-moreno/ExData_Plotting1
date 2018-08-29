#Set wd
#Copy folder path to clipboard

setwd(readClipboard())


## Import SQL library to subset on the read in
library(sqldf)

household_data <- read.csv.sql("household_power_consumption.txt", sep = ";", header = TRUE, sql = "select * from file where Date in ('2/1/2007','2/2/2007')")

###Clean out time data and create days

household_data$newdate <- strptime(as.character(household_data$Date), "%m/%d/%Y")
household_data$Date <- format(household_data$newdate, "%Y-%m-%d")
household_data$Global_active_power <- as.numeric(as.character(household_data$Global_active_power))
household_data$datetime <- as.POSIXct(paste(household_data$Date, household_data$Time), format = "%Y-%m-%d %H:%M:%S")


###Save and create plot 4 as .png

par(mfrow=c(2, 2))
#1
plot(household_data$datetime, household_data$Global_active_power, type = "l", xlab = "", ylab = "Global ACtive Power", ylim = c(0, 6))

#2
plot(household_data$datetime, household_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", ylim = c(234, 246))

#3
plot(household_data$datetime, household_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", ylim = c(0, 30))
lines(household_data$datetime, household_data$Sub_metering_2, type = "l", col = "red")
lines(household_data$datetime, household_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#4
plot(household_data$datetime, household_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0.0, 0.5))

dev.off()