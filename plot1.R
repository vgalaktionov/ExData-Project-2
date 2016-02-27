# Reading in data
if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Calculating totals
total_byyear <- aggregate(Emissions ~ year, data = NEI, sum)

# Barplot with proper labels and colors
png("plot1.png")
barplot(total_byyear$Emissions, names.arg = total_byyear$year, col = rainbow_hcl(4),
        xlab = "Year", ylab = "PM2.5 Emissions in Tons", main = "Total Emissions by Year in the US")
dev.off()
