
# import data
if(T){
        ## This first line will likely take a few seconds. Be patient!
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
}

# choose SCC
SCC_Motor <- SCC[grep("Motor", SCC$Short.Name),]
NEI_Motor <- merge(NEI, SCC_Motor, by = "SCC", all = F)
NEI_Motor <- NEI_Motor[NEI_Motor$fips == "24510", ]
# sum up emissions by year
attach(NEI_Motor)
NEI_Motor_total <- aggregate(Emissions, by = list(year), FUN = sum)
names(NEI_Motor_total) <- c("Year", "Emissions")
detach(NEI_Motor)

# plot
png("plot5.png", width = 480, height = 480, unit = "px")
atx <- seq(1999, 2008, 3)
plot(NEI_Motor_total, type = "l", xaxt = "n", main = "Emissions from Motor Vehicle Sources from 1999–2008\nin Baltimore City")
axis(1, at = atx)
points(NEI_Motor_total, col = "red")
dev.off()