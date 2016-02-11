##############
# Plot 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
##############

library(ggplot2)

setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
baltimore$city <- as.factor("Baltimore")
LA        <- subset(NEI, fips == "06037" & type == "ON-ROAD")
LA$city <- as.factor("Los Angeles")

agg_totals_baltimore <- aggregate(Emissions ~ year + city, baltimore, sum)
agg_totals_LA        <- aggregate(Emissions ~ year + city, LA, sum)

#rowbind the 2 subsets for plotting with facets by city
LA_BALT <- rbind(agg_totals_baltimore, agg_totals_LA)

g <-  ggplot(LA_BALT, aes(x = as.factor(year), y = Emissions,  fill=year))

##quick line graph
#qplot(year,Emissions, data = LA_BALT, color = year, geom=c("line"), facets = .~city)

#Plot of LA vs. Baltimore
png("plot6.png", width = 600, height = 600, units = "px")
g <-  ggplot(LA_BALT, aes(x = as.factor(year), y = Emissions,  fill=year))
print( g + geom_bar(stat = "identity") + facet_grid(.~city)
       + labs(title="Vehicle Related Emissions - Comparing Baltimore with Los Angeles") 
       + labs(x="Year", y="Vehicle Emissions of PM25 (Metric Tons)")
)
dev.off()

#Answer: LA 
