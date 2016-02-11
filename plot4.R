#Plot 4
#Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#Assumes files are in home directory of the user
setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Grep out the coal SCC values
coal_indexes <- grep("coal", SCC$Short.Name, ignore.case = TRUE )
coal_scc_codes <- SCC[coal_indexes, "SCC"]

#Subset the Coal-Related Sources
coalDf <- subset(NEI, NEI$SCC %in% coal_scc_codes)

#Totals (sum) emissions for all sources grouped by year for coal-related PM25
agg_total_year <- aggregate(Emissions ~ year, coalDf, sum)

#take down by a few orders of magnitude for plotting
agg_total_year$Emissions <- agg_total_year$Emissions / 1000

png("plot4.png")
barplot(names.arg = agg_total_year$year, height = agg_total_year$Emissions , 
        xlab = "Year", 
        ylab = "PM25 Metric Tons Per Year ( In Thousands )",
        main = "Total Coal Combustion Related Sources in the United States",
        col = agg_total_year$year)

dev.off()

#Answer: Yes, Coal Related Pollution has declined