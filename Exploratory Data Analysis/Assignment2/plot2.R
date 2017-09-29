
#Emissions of PM2.5:


#Download file

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm.zip")
unzip(zipfile = "pm.zip")

#store data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#library package
library(dplyr)

#select useful data
Baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(total = sum(Emissions))


#make and save graph

png(filename = "plot2.png", width = 480, height = 480)

with(Baltimore, plot(year, total/1000, main = "Total PM2.5 Emission in Baltimore from 1999-2008", xlab = "Year", ylab = "Total Emission(k tons)", type = "l"))
points(Baltimore$year, Baltimore$total/1000, pch = 20, col = "red")

dev.off()