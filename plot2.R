# Reading in data
if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Calculating totals for Baltimore
total_baltimore <- aggregate(Emissions ~ year, data = NEI[NEI$fips == "24510",], sum)

# Barplot with proper labels and colors
png("plot2.png")
barplot(total_baltimore$Emissions, names.arg = total_byyear$year, col = rainbow_hcl(4),
        xlab = "Year", ylab = "PM2.5 Emissions in Tons", main = "Total Emissions by Year in Baltimore")
dev.off()
