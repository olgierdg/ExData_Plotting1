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

png(file = "plot3.png", width=480, height=480)

plot(times, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(times, data$Sub_metering_1)
lines(times, data$Sub_metering_2, col = "red")
lines(times, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), lty = "solid")

dev.off()