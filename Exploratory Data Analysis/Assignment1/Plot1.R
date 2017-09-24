#set working directory and download dataset
setwd <- "D:\\DATA\\coursera\\Data Scientist\\datasciencecoursera\\Exploratory Data Analysis\\Assignment1"
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "electric.zip")
unzip(zipfile = "electric.zip")



# Reading data

electric <- read.table("household_power_consumption.txt", header=T,sep=";")


#subset

subdata <- subset(electric,electric$Date=="1/2/2007" | power$Date =="2/2/2007")



globalactivepower <- as.numeric(subdata$Global_active_power)

#make and save graph

png(filename = "plot1.png", width = 600, height = 600)

hist(globalactivepower,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

dev.off()