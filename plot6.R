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

# Subset for Baltimore and LA
baltimore <- merged[merged$fips == "24510",]
la <- merged[merged$fips == "06037",]

# Subset for vehicle emissions
vehicleindex_baltimore <- grep("vehicle", baltimore$EI.Sector, ignore.case = TRUE)
by_vehicles_baltimore <- aggregate(Emissions ~ year, data = baltimore[vehicleindex_baltimore,], sum)
by_vehicles_baltimore$city <- "Baltimore"
vehicleindex_la <- grep("vehicle", la$EI.Sector, ignore.case = TRUE)
by_vehicles_la <- aggregate(Emissions ~ year, data = la[vehicleindex_la,], sum)
by_vehicles_la$city <- "LA"
by_vehicles <- rbind(by_vehicles_baltimore,by_vehicles_la)

# Barplots with colors by city
png("plot6.png")
ggplot(by_vehicles, aes(factor(year), Emissions, fill = year)) + geom_bar(stat = "identity") + guides(fill=FALSE) + facet_grid(.~city)+ labs(title = "Emissions from Motor Vehicles in Baltimore and LA by Year", x = "Year", y = "PM2.5 Emissions in Tons")
dev.off()
