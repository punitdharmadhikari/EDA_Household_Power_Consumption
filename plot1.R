## -----------------------------------------------
## Exploratory Data Analysis Week 1 Project
## -----------------------------------------------
## plot1.R creates a histogram based on the 
## Global Active Power data provided
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

## Save as png and plot graph
png(filename="plot1.png")
hist(as.numeric(as.character(EPC_Feb$Global_active_power)), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()