
library("data.table")

setwd("F:\Coursera program elective\exploratorydataanalysisproject")

#Reads in data from file then subsets data for specified dates
PowDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
PowDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
PowDT[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
PowDT <- PowDT[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(PowDT[, DateTime], PowDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(PowDT[, DateTime], PowDT[, Sub_metering_2],col="red")
lines(PowDT[, DateTime], PowDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()