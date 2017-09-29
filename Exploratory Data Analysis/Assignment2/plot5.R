
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

#find SCC that contains Coals (regular expression)
motor <- SCC[grepl("Vehicles", SCC$EI.Sector), "SCC"]

motor_Bal <- NEI %>%
  filter((SCC %in% motor)&(fips == "24510")) %>%
  group_by(year) %>%
  summarise(total = sum(Emissions))



#make and save graph

png(filename = "plot5.png", width = 480, height = 480)

g <- ggplot(motor_Bal, aes(y = total/1000, x = year))
g + geom_line() + labs(title = "Motor Vehicles related PM2.5 Emission in the Baltimore", x = "Year", y = "Total Emission (k tons)") + 
  geom_point()

dev.off()