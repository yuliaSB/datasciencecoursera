
Consumption <- read.table("household_power_consumption.txt",sep = ";", header = TRUE)

# choose only two days in February
ConsumptionFor2days <- subset(Consumption, Date == "1/2/2007" | Date == "2/2/2007" ,select=(Date:Sub_metering_3))

# collapse the date and time data in one column
NewConsumption <- within(ConsumptionFor2days, DateTime <- paste(ConsumptionFor2days$Date, ConsumptionFor2days$Time, sep=" "))

FinalConsumption2days <- subset(NewConsumption, select = Global_active_power:DateTime)

# convert the Date and Time variables to Date/Time classes 
FinalConsumption2days$DateTime <- strptime(FinalConsumption2days$DateTime, format = "%d/%m/%Y %H:%M:%S" )

# convert into numeric class
FinalConsumption2days$Global_active_power <- as.numeric(levels(FinalConsumption2days$Global_active_power))[as.integer(FinalConsumption2days$Global_active_power)]
FinalConsumption2days$Voltage <- as.numeric(levels(FinalConsumption2days$Voltage))[as.integer(FinalConsumption2days$Voltage)]
FinalConsumption2days$Global_reactive_power <- as.numeric(levels(FinalConsumption2days$Global_reactive_power))[as.integer(FinalConsumption2days$Global_reactive_power)]
FinalConsumption2days$Sub_metering_1 <- as.numeric(levels(FinalConsumption2days$Sub_metering_1))[as.integer(FinalConsumption2days$Sub_metering_1)]
FinalConsumption2days$Sub_metering_2 <- as.numeric(levels(FinalConsumption2days$Sub_metering_2))[as.integer(FinalConsumption2days$Sub_metering_2)]
FinalConsumption2days$Sub_metering_3 <- as.numeric(levels(FinalConsumption2days$Sub_metering_3))[as.integer(FinalConsumption2days$Sub_metering_3)]

# create the plot
par(mfrow = c(2,2))
plot(FinalConsumption2days$DateTime,FinalConsumption2days$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(FinalConsumption2days$DateTime,FinalConsumption2days$Voltage, type = "l", xlab = "", ylab = "Voltage")
plot(FinalConsumption2days$DateTime, FinalConsumption2days$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(x = FinalConsumption2days$DateTime, y = FinalConsumption2days$Sub_metering_1, type="s", col="black")
points(x = FinalConsumption2days$DateTime, y = FinalConsumption2days$Sub_metering_2, type="s", col="red")
points(x = FinalConsumption2days$DateTime, y = FinalConsumption2days$Sub_metering_3, type="s", col="blue")
legend("topright", col = c("black", "red", "blue"),
       lwd=1, lty=c(1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(FinalConsumption2days$DateTime,FinalConsumption2days$Global_reactive_power, type = "s", xlab = "", ylab = "Global_reactive_power")