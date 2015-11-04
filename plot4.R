if(!file.exists("household_power_consumption.txt")){
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    download.file(fileUrl, destfile = "./household_power_consumption.zip")
    
    unzip("household_power_consumption.zip")
}

header <- read.table("household_power_consumption.txt", nrows = 1, 
                     header = FALSE, sep =';', stringsAsFactors = FALSE)


data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", skip = 66636, nrows = 2880, na.strings = "?")

colnames(data) <- unlist(header)


times <- as.POSIXct(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S", tz = "")
times <- as.POSIXct(times, format="%d")

Sys.setlocale("LC_TIME", "English")

png(file = "plot4.png", width=480, height=480)

par(mfrow = c(2,2))

plot(times, data$Global_active_power, type = "n", ylab = "Global Active Power", xlab = "")
lines(times, data$Global_active_power)

plot(times, data$Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(times, data$Voltage)

plot(times, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(times, data$Sub_metering_1)
lines(times, data$Sub_metering_2, col = "red")
lines(times, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), lty = "solid", bty = "n")

plot(times, data$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime")
lines(times, data$Global_reactive_power)

dev.off()