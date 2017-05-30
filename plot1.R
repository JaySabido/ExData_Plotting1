## Exploratory Data Analysis Course Project 1 by Jay Sabido

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "powerdata.zip")     # even though the URL of the source file is https, no method = "curl"in the arguments since I am using a Windows machine
dateDownloaded <- Sys.time()
unzip("powerdata.zip", exdir = getwd())

# read the data from the unzipped downloaded text file
power_cons <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", na.strings=c("NA", "-", "?"))
power_cons$Date <- as.Date(power_cons$Date, "%d/%m/%Y")     # convert the Date column to class date

# Subset data for 2 days only: 02-01-2007 and 02-02-2007
target_data <- power_cons[power_cons$Date == "2007-02-01" | power_cons$Date == "2007-02-02",]
# Thanks so much to Leonard Greski (mentor) for the tip on the above approach

#Convert the Time column to Date-Time format
target_data$Time <- strptime(paste(target_data$Date, target_data$Time), "%Y-%m-%d %H:%M:%S")
# Thanks so much to Stephanie Clark (mentor) for the tip on the above approach

# plot #1
png(filename = "plot1.png", width = 480, height = 480)
par(mfrow = c(1,1))
hist(target_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

# copy the histogram to a PNG file
# dev.copy(png, file = "plot1.png")


