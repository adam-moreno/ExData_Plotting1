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

###Save and create plot 3 as .png

plot(household_data$datetime, household_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", ylim = c(0, 30))

lines(household_data$datetime, household_data$Sub_metering_2, type = "l", col = "red")

lines(household_data$datetime, household_data$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

dev.off()