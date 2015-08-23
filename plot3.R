
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
NEI_Bal_total <- aggregate(Emissions, by = list(type ,year), FUN = sum)
names(NEI_Bal_total) <- c("Type", "Year", "Emissions")
detach(NEI_Bal)

# plot
library(ggplot2)
qplot(Year, Emissions, data = NEI_Bal_total, geom = c("point", "smooth"), colour = Type, main = "Four Sources Emissions from 1999–2008\n(Baltimore City)")
ggsave("plot3.png", width = 5, height = 5)