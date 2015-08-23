
# import data
if(T){
        ## This first line will likely take a few seconds. Be patient!
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
}

# choose Coal-related SCC
SCC_Coal <- SCC[grep("Coal", SCC$Short.Name), ]
NEI_Coal <- merge(NEI, SCC_Coal, by = "SCC", all = F)
# sum up emissions by year
attach(NEI_Coal)
NEI_Coal_total <- aggregate(Emissions, by = list(year), FUN = sum)
names(NEI_Coal_total) <- c("Year", "Emissions")
detach(NEI_Coal)

# plot
png("plot4.png", width = 480, height = 480, unit = "px")
atx <- seq(1999, 2008, 3)
plot(NEI_Coal_total, type = "l", xaxt = "n", main = "Emissions from Coal Combustion-related Sources\nfrom 1999–2008")
axis(1, at = atx)
points(NEI_Coal_total, col = "red")
dev.off()