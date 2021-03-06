library(data.table)
library(dplyr)
data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(data$DateTime, format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data_subset <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data_subset$DateTime, data_subset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

