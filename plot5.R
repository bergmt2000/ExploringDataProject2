#Plot 5
#Question: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)

setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510" & type == "ON-ROAD")

###################################################################################
#What is a vehicle? Vague Description in assignment. Im goint with type = "ON-ROAD"
#Howerver, the following method yields the same trend of decresing over time
#grep method for vehicle...data are similar to type of "ON-ROAD"
#motor_vehicle_indexes <- grep("vehicle", SCC$Short.Name, ignore.case = TRUE)
#motor_vehicle_scc_codes <- SCC[motor_vehicle_indexes, "SCC"]
#reduce baltimore with the "vehicle" matches found in Grep
#baltimore <- subset(baltimore, SCC %in% motor_vehicle_scc_codes)
###################################################################################

aggregateBalt <- aggregate(Emissions ~ year, baltimore, sum)

#year had to be a factor due to some weird rounding thing that ggplot did, no big deal
png("plot5.png", width = 600, height = 600, units = "px")
g <-  ggplot(aggregateBalt, aes(x = as.factor(year), y = Emissions,  fill=year))

print(g + geom_bar(stat = "identity")
        + labs(title="Total Vehicle Related Emissions Measured in Baltimore, MD - Metric Tons of PM25") 
        + labs(x="Year", y="Vehicle Emissions of PM25 (Metric Tons)")
)

dev.off()

#Answer: Vehicle emissions for Baltimore have decreased over time


#Source examples for plotting - http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/