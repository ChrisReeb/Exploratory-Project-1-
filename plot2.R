fileName <- "electricPowerCOnsumption.zip"
if(!file.exists(fileName)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", fileName)
        unzip(fileName)
}

epc <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

library(dplyr)
library(lubridate)


epc$Date <- dmy(epc$Date)
epc <- epc[epc$Date==ymd("2007-02-01") | epc$Date ==ymd("2007-02-02"),]

epc <- tibble(epc)
epc$Time <- hms(epc$Time)
epc$Global_active_power <- as.numeric(epc$Global_active_power)

epc <- epc %>% mutate(weekday = wday(epc$Date, label = TRUE)) %>%
        mutate(dateTime = Date + Time)

png("plot2.png")
with(epc, plot(dateTime, Global_active_power, type = "l", main = "",xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()