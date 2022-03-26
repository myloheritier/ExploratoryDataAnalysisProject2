## Plot of question 2

#loading required packages
library(dplyr)
library(ggplot2)

# Reading and preparing the dataset
NEI <- readRDS("summarySCC_PM25.rds")
NEIdp <- tibble::as_tibble(NEI)

# Baltimore dataset with Motor Vehicle emissions per year 
BaltimoraEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='24510', type=='ON-ROAD'), year), sum(Emissions)) 

# Adding name of place 
BaltimoraEmissionsVehicle = mutate(BaltimoraEmissionsVehicle, Place = 'Baltimore City')

# LA county table with Motor Vehicle emissions per year 
LAEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='06037', type=='ON-ROAD'), year), sum(Emissions))

# Adding the name of place 
LAEmissionsVehicle = mutate(LAEmissionsVehicle, Place = 'Los Angeles County')

# Puting tables together
BaltimoreLA <- rbind(BaltimoraEmissionsVehicle,LAEmissionsVehicle)

#Renaming columns
colnames(BaltimoreLA) <- c('Year', 'Emissions', 'Place')

# Converting year to string
BaltimoreLA$Year <- as.character(BaltimoreLA$Year)

# Plot 6
png('plot6.png')
qplot(Year,data=BaltimoreLA, geom="bar", weight=Emissions, facets=.~Place, fill=Year, main='Baltimore City/Los Angeles County: Emissions of motor vehicle', xlab='', ylab = 'Emissions (PM 2.5)')
dev.off()
