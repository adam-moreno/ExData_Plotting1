#Set wd
#Copy folder path to clipboard

setwd(readClipboard())


## Import SQL library to subset on the read in
library(sqldf)

household_data <- read.csv.sql("household_power_consumption.txt", sep = ";", header = TRUE, sql = "select * from file where Date in ('2/1/2007','2/2/2007')")


###Save and create plot2 as .png

png("Plot 2.png")

household_data$newdate <- strptime(as.character(household_data$Date), "%m/%d/%Y")
household_data$Date <- format(household_data$newdate, "%Y-%m-%d")
household_data$Global_active_power <- as.numeric(as.character(household_data$Global_active_power))
household_data$datetime <- as.POSIXct(paste(household_data$Date, household_data$Time), format = "%Y-%m-%d %H:%M:%S")

plot(household_data$datetime, household_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()