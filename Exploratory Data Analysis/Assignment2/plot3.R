
#Emissions of PM2.5:


#Download file

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm.zip")
unzip(zipfile = "pm.zip")

#store data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#library package
library(dplyr)
library(ggplot2)

#getting data
Baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(total = sum(Emissions))

#make and save graph

png(filename = "plot3.png", width = 480, height = 480)

g <- ggplot(Baltimore, aes(x = year, y = total/1000))
g + geom_line() + facet_grid(type~.) + labs(title = "pm 2.5 Emission in Baltimore on different types", x = "Year", y = "Total Emission(k tons)")

dev.off()