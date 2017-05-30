## Exploratory Data Analysis Course Project 1 by Jay Sabido

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "powerdata.zip")     # even though the URL of the source file is https, no method = "curl"in the arguments since I am using a Windows machine
dateDownloaded <- Sys.time()
unzip("powerdata.zip", exdir = getwd())

# read the data from the unzipped downloaded text file
power_cons <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", na.strings=c("NA", "-", "?"))
# reference for the above approach using na.strings from Martin Johnsson's blog as he discussed in https://martinsbioblogg.wordpress.com/2014/03/06/using-r-common-errors-in-table-import/

power_cons$Date <- as.Date(power_cons$Date, "%d/%m/%Y")     # convert the Date column to class date

# Subset data for 2 days only: 02-01-2007 and 02-02-2007
target_data <- power_cons[power_cons$Date == "2007-02-01" | power_cons$Date == "2007-02-02",]
# Thanks so much to Leonard Greski (mentor) for the tip on the above approach

#Convert the Time column to Date-Time format
target_data$Time <- strptime(paste(target_data$Date, target_data$Time), "%Y-%m-%d %H:%M:%S")
# Thanks so much to Stephanie Clark (mentor) for the tip on the above approach


# plot #3
png(filename = "plot3.png", width = 480, height = 480)
par(mfrow = c(1,1))
with(target_data, plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(target_data, points(Time, Sub_metering_1, type = "l"))
with(target_data, points(Time, Sub_metering_2, type = "l", col = "red"))
with(target_data, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

