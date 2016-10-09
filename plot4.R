#plot4.R:
#This R-script creates a 4 plots in a 2x2 frame as required by the exercise
#
#
# Download file and unzip in local directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fnameZip <- "household_power_consumption.zip"
download.file(fileUrl, destfile=fnameZip, method="curl")
unzip(fileZip)

fnameMeter <- "household_power_consumption.txt"
dfInput <- read.table(fnameMeter, header=TRUE, sep=";", na.strings="?")

#Add a column posixDate based on Date/Time columns
#dfDate <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
dfInput <- data.frame(dfInput, posixDate = strptime(paste(dfInput$Date,dfInput$Time), "%d/%m/%Y %H:%M:%S"))

#Subset data between Feb01 and Feb02 2007
date2007Feb01 <- strptime(x="01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S" )
date2007Feb03 <- strptime(x="03/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S" )
df <- subset(dfInput, (posixDate >= date2007Feb01) & (posixDate < date2007Feb03))


# plot directly to png file since copy from screen seems to mess things up
png(filename = "plot4.png" )
par(mfrow=c(2,2))

plot(df$posixDate, df$Global_active_power, type= "l", ylab= "Global Active Power", xlab="")

plot(df$posixDate,df$Voltage,type="l", xlab="datetime", ylab="Voltage")

plot(df$posixDate, df$Sub_metering_1, col = "black", type = "l", xlab="", ylab="Energy sub metering")
lines(df$posixDate, df$Sub_metering_2, col="red", type="l")
lines(df$posixDate, df$Sub_metering_3, col="blue", type="l")
legend("topright",col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") , 
       pch=c(45,45,45), lwd=1, seg.len =2, bty="n")

plot(df$posixDate,df$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
