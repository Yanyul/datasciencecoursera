#set working directory and download dataset
setwd <- "D:\\DATA\\coursera\\Data Scientist\\datasciencecoursera\\Exploratory Data Analysis\\Assignment1"
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "electric.zip")
unzip(zipfile = "electric.zip")



# Reading data

electric <- read.table("household_power_consumption.txt", header=T,sep=";")


#subset

subdata <- subset(electric,electric$Date=="1/2/2007" | power$Date =="2/2/2007")

datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactivepower <- as.numeric(subdata$Global_active_power)
submetering1 <- as.numeric(subdata$Sub_metering_1)
submetering2 <- as.numeric(subdata$Sub_metering_2)
submetering3 <- as.numeric(subdata$Sub_metering_3)

#make and save graph

png(filename = "plot3.png", width = 600, height = 600)

plot(datetime, submetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, submetering2, type="l", col="red")
lines(datetime, submetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()