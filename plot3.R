#Plot 3
#Question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#          which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#          Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.


library(ggplot2)

#Assumes files are in home directory of the user
setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")

#Show Emissions per year for each type
aggregateBalt <- aggregate(Emissions ~ year + type, baltimore, sum)


png("plot3.png")

g <-  ggplot(aggregateBalt, aes(year, Emissions, color = type))
print( g + geom_line(size = 2)
        + labs(title="Total Pollution Measured for Baltimore, MD - Metric Tons of PM25") 
        + labs(x="Year", y="Emissions of PM25 (Metric Tons)")
        #+ theme_bw("Times")
 )
dev.off()

#Answer:
## Types with decreases: NONPOINT, NON-ROAD, ON-ROAD
## Types with increases: POINT