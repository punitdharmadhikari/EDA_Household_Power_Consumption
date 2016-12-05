## -----------------------------------------------
## Exploratory Data Analysis Week 1 Project
## -----------------------------------------------
## plot3.R creates a plot of Energy submetering
## between Thu and Sat. Also adds 2 lines to the 
## plot and a legend.
## -----------------------------------------------
## Written by Punit Dharmadhikari
## 4 Dec 2016
## -----------------------------------------------


## Downloading file from the internet and unzipping
url = "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
destfile = "household_power_consumption.zip"
download.file(url, destfile)
unzip(destfile)

## Read in the file using headers and store in a variable
EPC <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Convert to a Date/Time format
EPC$DateTime <- paste(EPC$Date, EPC$Time)
EPC$DateTime <- strptime(EPC$DateTime, "%d/%m/%Y %H:%M:%S")

## Extract data needed for February
start_date <- which(EPC$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end_date <- which(EPC$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
EPC_Feb <- EPC[start_date:end_date, ]

## Convert to numeric values
EPC_Feb$Global_active_power <- as.numeric(as.character(EPC_Feb$Global_active_power))
EPC_Feb$Sub_metering_1 <- as.numeric(as.character(EPC_Feb$Sub_metering_1))
EPC_Feb$Sub_metering_2 <- as.numeric(as.character(EPC_Feb$Sub_metering_2))

## Save as png and plot graph
png(filename="plot3.png")
plot(EPC_Feb$DateTime, EPC_Feb$Sub_metering_1, type="l", ylab ="Energy sub metering", xlab="")
lines(EPC_Feb$DateTime, EPC_Feb$Sub_metering_2, type="l", col="red")
lines(EPC_Feb$DateTime, EPC_Feb$Sub_metering_3, type="l", col="blue") ## No need to convert Sub_metering_3 to numeric as it is already numeric
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))
dev.off()