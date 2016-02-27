require(ggplot2)

# Reading in data
if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Merge with labels
merged <- merge(NEI, SCC, by = "SCC")

# Subset for Baltimore
baltimore <- merged[merged$fips == "24510",]

# Subset for vehicle emissions
vehicleindex <- grep("vehicle", baltimore$EI.Sector, ignore.case = TRUE)
by_vehicles <- aggregate(Emissions ~ year, data = baltimore[vehicleindex,], sum)

# Barplot with colors
png("plot5.png")
ggplot(by_vehicles, aes(factor(year), Emissions, fill = year)) + geom_bar(stat = "identity") + guides(fill=FALSE) + labs(title = "Emissions from Motor Vehicles in Baltimore by Year", x = "Year", y = "PM2.5 Emissions in Tons")
dev.off()
