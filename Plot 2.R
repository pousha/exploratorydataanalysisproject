library("data.table")

setwd("F:\Coursera program elective\exploratorydataanalysisproject")

#Reads in data from file then subsets data for specified dates
PowDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
PowDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
PowDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
PowDT <- PowDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = PowDT[, dateTime]
     , y = PowDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()