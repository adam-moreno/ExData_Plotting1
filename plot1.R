#Set wd
#Copy folder path to clipboard

setwd(readClipboard())


## Import SQL library to subset on the read in

##If sqldf is not installed uncomment the below 
##install.packages("sqldf")

library(sqldf)

household_data <- read.csv.sql("household_power_consumption.txt", sep = ";", header = TRUE, sql = "select * from file where Date in ('2/1/2007','2/2/2007')")



###Save and create plot1 as .png

png("Plot 1.png")

hist(x = household_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200), col = "red", xlim = c(0, 6))


dev.off()