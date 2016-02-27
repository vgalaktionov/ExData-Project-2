require(ggplot2)
# Reading in data
if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset for Baltimore
baltimore <- NEI[NEI$fips == "24510",]

by_yearandtype <- aggregate(Emissions ~ year + type, data = baltimore, sum)

# Lineplot, colored by type 
png("plot3.png")
ggplot(by_yearandtype, aes(factor(year), Emissions, fill = year)) + geom_bar(stat = "identity") + facet_grid(.~type) + guides(fill=FALSE) + labs(title = "Emissions in Baltimore by Year and Type", x = "Year", y = "PM2.5 Emissions in Tons")
dev.off()
