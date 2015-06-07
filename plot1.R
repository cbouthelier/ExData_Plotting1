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
par(mar=c(4,4,4,4))
with(dat, hist(Global_active_power, main = "Global Active Power",col="Red",xlab = "Global Active Power (Killowatts)"))
dev.off()
