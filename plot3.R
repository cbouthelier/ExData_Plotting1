#modifying System Locale to english
Sys.setlocale("LC_TIME", "English")
#setting up the download & reading the data
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",na.strings = "?",header=TRUE)
unlink(temp)
#Creating a new column with Date/Time based on the Date & Time columns of the data set
data["datetime"]<-NA
data$datetime <- strptime(paste(as.character(data[,1]),data[,2]),"%d/%m/%Y %H:%M:%S")
dat<-data[data$datetime>=as.POSIXlt("2007-02-01") & data$datetime<as.POSIXlt("2007-02-03") & !is.na(data$datetime),]
#ploting the values into a PNG file 
#creating an empty plot
png(file = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mar=c(2,4,4,4))
with(dat, plot(datetime,Sub_metering_1, type = "n",ylab = "Energy sub metering"))
with(dat, points(datetime, Sub_metering_1,type="l", col = "black"))
with(dat, points(datetime, Sub_metering_2, type="l",col = "red"))
with(dat, points(datetime, Sub_metering_3, type="l",col = "blue"))
legend("topright", lty=1, col = c("black","red", "blue"), bty="n",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()