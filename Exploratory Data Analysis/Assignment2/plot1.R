
#Emissions of PM2.5:


#Download file

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm.zip")
unzip(zipfile = "pm.zip")

#store data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#import package
library(dplyr)

#compute total pm2.5 of each year
totalemission <- NEI %>%
  group_by(year) %>%
  summarise(
    total = sum(Emissions)
  )


#make and save graph

png(filename = "plot1.png", width = 480, height = 480)

with(totalemission, plot(year, total/1000, type = "l", main = "Total PM2.5 Emmision in the US from 1999-2008 ", xlab = "Year", ylab = "Total Emission (k tons)"))
points(totalemission$year, totalemission$total/1000,  pch = 20, col = "red")

dev.off()