#Plot 2
#Question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

#Assumes files are in home directory of the user
setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset on baltimore (by fips)
baltimore <- subset(NEI, fips=="24510")

#Totals (sum) emissions for all sources grouped by year
agg_total_year <- aggregate(Emissions ~ year, baltimore, sum)

#take down by a few orders of magnitude for plotting
agg_total_year$Emissions <- agg_total_year$Emissions / 1000

#plot of results, metric tons of PM25 from 1999 - 2008 for Baltimore
png("plot2.png")

barplot(names.arg = agg_total_year$year, height = agg_total_year$Emissions , 
        xlab = "Year", 
        ylab = "Metric Tons Per Year of PPM25 ( Thousands )",
        main = "Baltimore, MD - Total PM2.5 Emissions (Years 1999 - 2008)",
        col = agg_total_year$year
        )

dev.off()

#Answer: Overall, decreased.  Was some undulation, but overall it is down.