#Reading data using data.table 
library("data.table")
elecPower <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")
elecPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
#Convert date using as.Date
elecPower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
#Filter dates from 2007-02-01 to 2007-02-02
elecPower <- elecPower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
png("plot1.png", width=480, height=480)
hist(elecPower[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()