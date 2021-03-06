library(data.table)
library(dplyr)
data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(data$DateTime, format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data_subset <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset$Global_reactive_power <- as.numeric(data_subset$Global_reactive_power)
data_subset$Voltage <- as.numeric(data_subset$Voltage)
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol =c(2,2))
plot(data_subset$DateTime, data_subset$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(x =c(data_subset$DateTime,data_subset$DateTime,data_subset$DateTime), y= c(data_subset$Sub_metering_1,data_subset$Sub_metering_2,data_subset$Sub_metering_3), type = "n",xlab = "", ylab = "Energy sub metering")
with(data_subset, lines(data_subset$DateTime, data_subset$Sub_metering_1))
with(data_subset, lines(data_subset$DateTime, data_subset$Sub_metering_2, col = "red"))              
with(data_subset, lines(data_subset$DateTime, data_subset$Sub_metering_3, col = "blue"))                     
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .5)
plot(data_subset$DateTime, data_subset$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(data_subset$DateTime, data_subset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
     