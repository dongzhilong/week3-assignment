
# import data
if(T){
        ## This first line will likely take a few seconds. Be patient!
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
}

# choose SCC
NEI_temp <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
SCC_Motor <- SCC[grep("Motor", SCC$Short.Name),]
NEI_Motor <- merge(NEI_temp, SCC_Motor, by = "SCC", all = F)

# sum up emissions by year
attach(NEI_Motor)
NEI_Motor_total <- aggregate(Emissions, by = list(fips, year), FUN = sum)
names(NEI_Motor_total) <- c("Fips", "Year", "Emissions")
NEI_Motor_total$City[NEI_Motor_total$Fips == "24510"] <- "Baltimore"
NEI_Motor_total$City[NEI_Motor_total$Fips == "06037"] <- "Los Angeles"
detach(NEI_Motor)

# plot
library(ggplot2)
qplot(Year, Emissions, data = NEI_Motor_total, geom = c("point", "smooth"), colour = City)
ggsave("plot6.png", width = 7, height = 7, dpi = 72)