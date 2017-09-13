#Reading data using data.table 
library("data.table")
elecPower <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")
elecPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
elecPower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
#Filter dates from 2007-02-01 to 2007-02-02
elecPower <- elecPower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# Top Left Plot
plot(elecPower[, dateTime], elecPower[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
# Top Right Plot
plot(elecPower[, dateTime],elecPower[, Voltage], type="l", xlab="datetime", ylab="Voltage")
# Bottom Left Plot
plot(elecPower[, dateTime], elecPower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(elecPower[, dateTime], elecPower[, Sub_metering_2], col="red")
lines(elecPower[, dateTime], elecPower[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ") , lty=c(1,1), bty="n", cex=.5) 
# Bottle Right Plot
plot(elecPower[, dateTime], elecPower[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
