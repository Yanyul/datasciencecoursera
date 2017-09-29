
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
coal <- SCC[(grepl("Coal", SCC$EI.Sector) & grepl("Fuel Comb", SCC$EI.Sector)), "SCC"] #return SCC
Agg <- NEI %>%
  filter(SCC %in% coal) %>%
  group_by(year) %>%
  summarise(total = sum(Emissions))


#make and save graph

png(filename = "plot4.png", width = 480, height = 480)

g <- ggplot(Agg, aes(x = year, y = total/1000))
g + geom_line() +geom_point()+ labs(title = "Coal related PM2.5 Emission in the US", x = "Year", y = "Total Emission (k tons)") +geom_label(aes(label = paste0(year, ':\n', round(total/1000))))

dev.off()