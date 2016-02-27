require(ggplot2)

# Reading in data
if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Merge with labels, then subset for coal
merged <- merge(NEI, SCC, by = "SCC")

coalindex <- grep("coal", merged$EI.Sector, ignore.case = TRUE)

by_coal <- aggregate(Emissions ~ year, data = merged[coalindex,], sum)

# Barplot with colors
png("plot4.png")
ggplot(by_coal, aes(factor(year), Emissions, fill = year)) + geom_bar(stat = "identity") + guides(fill=FALSE) + labs(title = "Emissions from Coal Combustion Related Sources in the US by Year", x = "Year", y = "PM2.5 Emissions in Tons")
dev.off()
