## Brian
## 2015 07 06
## ExData-030
##

# TODO: Check for NA

# set the filename of interest
filename <- "household_power_consumption.txt"

# read the data into a frame
powerdata <- read.table(filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

dateformat <- "%d/%m/%Y"
timeformat <- "%H:%M:%S"

# convert date strings to posixlt
powerdataDate <- strptime(powerdata$Date, dateformat)

#convert time strings to posixct (will imply today's date)
powerdataTime <- strptime(powerdata$Time, timeformat)

# subtract today's date and store the time portion (difftime)
powerdataTime <- powerdataTime - strptime(Sys.Date(), "%Y-%m-%d")

# add the difftime to the date field and store as posixct date and time
DateTime <- powerdataDate + powerdataTime

# place the new date/time column back into the dataset
powerdata <- cbind(DateTime, powerdata)

#extract a smallset for only 2007-02-01 through 2007-02-02
smallset <- powerdata[(powerdata$Date=="1/2/2007")|(powerdata$Date=="2/2/2007"),]


# plot4
png(filename="Plot4.png", width=480, height=480, units="px", bg="white")

par(mfrow=c(2,2))
with(smallset, {
     plot(DateTime, Global_active_power, col = "black", main= "", xlab= "",
          ylab = "Global Active Power", pch = NA_integer_)
     lines(DateTime, Global_active_power, col = "black")
     
     plot(DateTime, Voltage, col = "black", main = "", xlab = "datetime",
          ylab = "Voltage", pch = NA_integer_)
     lines(DateTime, Voltage, col = "black")
     
     plot(DateTime, Sub_metering_1, pch = NA_integer_, xlab = "", 
          ylab = "Energy sub metering")
     lines(DateTime, Sub_metering_1, col = "black")
     lines(DateTime, Sub_metering_2, col = "red")
     lines(DateTime, Sub_metering_3, col = "blue")
     legend("topright", pch = NA_integer_, col = c("black", "red", "blue"), 
            bty = "n", lty = 1,
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
     plot(DateTime, Global_reactive_power, xlab = "datetime", pch = NA_integer_)
     lines(DateTime, Global_reactive_power)
})

dev.off()




