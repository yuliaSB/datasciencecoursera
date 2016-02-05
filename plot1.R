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

# create the histogram
hist(FinalConsumption2days$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)" )
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()





