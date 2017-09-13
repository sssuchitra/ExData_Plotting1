#Reading data using data.table 
library("data.table")
elecPower <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")
elecPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
elecPower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
#Filter dates from 2007-02-01 to 2007-02-02
elecPower <- elecPower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
png("plot2.png", width=480, height=480)
plot(x = elecPower[, dateTime] , y = elecPower[, Global_active_power] , type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
