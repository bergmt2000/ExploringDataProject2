#Plot 1
#Question to Answer: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

#Assumes files are in home directory of the user
setwd("~")

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Totals (sum) emissions for all sources grouped by year
agg_total_year <- aggregate(Emissions ~ year, NEI, sum)

#take down by a few orders of magnitude for plotting y-axis with better/readable numbers
agg_total_year$Emissions <- agg_total_year$Emissions / 1000


#plot of results, metric tons of PM25 from 1999 - 2008
png("plot1.png")

barplot(names.arg = agg_total_year$year, height = agg_total_year$Emissions , 
        xlab = "Year", 
        ylab = "Metric Tons Per Year of PPM25 ( Thousands )",
        main = "United States - Total PM2.5 Emissions (Years 1999 - 2008)",
        col = agg_total_year$year)

dev.off()

#Answer: Decreased