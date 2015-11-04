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

png(file = "plot1.png", width=480, height=480)

with(data, hist(Global_active_power, col="red", main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)"))

dev.off()