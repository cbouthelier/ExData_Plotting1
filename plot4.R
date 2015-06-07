#modifying System Locale to english
Sys.setlocale("LC_TIME", "English")
#setting up the download & reading the data
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",na.strings = "?",header=TRUE)
unlink(temp)
#Creating a new with Date/Time based on the Date & Time columns of the data set
data["datetime"]<-NA
data$datetime <- strptime(paste(as.character(data[,1]),data[,2]),"%d/%m/%Y %H:%M:%S")
dat<-data[data$datetime>=as.POSIXlt("2007-02-01") & data$datetime<as.POSIXlt("2007-02-03") & !is.na(data$datetime),]
#ploting the values into a PNG file 
png(file = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
#Creating a table to plot 4 plots on a 2x2 scheme
par(mfcol = c(2, 2))
#Top left plot
par(mar=c(4,4,4,4))
with(dat, plot(datetime,Global_active_power, type="l",ylab = "Global Active Power (Killowatts)"))
#Lower left plot
par(mar=c(2,4,4,4))
with(dat, plot(datetime,Sub_metering_1, type = "n",ylab = "Energy sub metering"))
with(dat, points(datetime, Sub_metering_1,type="l", col = "black"))
with(dat, points(datetime, Sub_metering_2, type="l",col = "blue"))
with(dat, points(datetime, Sub_metering_3, type="l",col = "red"))
legend("topright", lty=1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#Top right Plot
par(mar=c(4,4,4,4))
with(dat, plot(datetime,Voltage, type="l",ylab = "Voltage"))
#Lower right plot
par(mar=c(4,4,4,4))
with(dat, plot(datetime,Global_reactive_power, type="l"))
dev.off()