
# import data
if(T){
        ## This first line will likely take a few seconds. Be patient!
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
}

# choose Baltimore City, Maryland (fips == "24510")
NEI_Bal <- NEI[NEI$fips == "24510", ]
# sum up emissions by year
attach(NEI_Bal)
NEI_total <- aggregate(Emissions, by = list(year), FUN = sum)
names(NEI_total) <- c("Year", "Emissions")
detach(NEI_Bal)

# plot
png("plot2.png", width = 480, height = 480, unit = "px")
atx <- seq(1999, 2008, 3)
plot(NEI_total, type = "l", xaxt = "n", main = "Total PM2.5 Emission for Each of the Years\n(Baltimore City, Maryland)")
axis(1, at = atx)
points(NEI_total, col = "red")
dev.off()