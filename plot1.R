fileName <- "electricPowerCOnsumption.zip"
if(!file.exists(fileName)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", fileName)
        unzip(fileName)
        }

        epc <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

library(dplyr)
library(lubridate)

epc <- tibble(epc)
epc$Date <- dmy(epc$Date)
epc$Time <- hms(epc$Time)
epc$Global_active_power <- as.numeric(epc$Global_active_power)

epc <- epc[epc$Date==ymd("2007-02-01") | epc$Date ==ymd("2007-02-02"),]

png("plot1.png")
hist(epc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()