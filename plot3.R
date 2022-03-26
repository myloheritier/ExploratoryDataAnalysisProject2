## Plot of question 3

#loading required packages
library(dplyr)
library(ggplot2)

# Reading and preparing the dataset
NEI <- readRDS("summarySCC_PM25.rds")
NEIdp <- tibble::as_tibble(NEI)

# The dataset of Baltimore emissions per year and type
BaltimoraEmissionsTypeYears = summarize(group_by(filter(NEIdp, fips=="24510"),type,year),sum(Emissions))
# renaming columns
colnames(BaltimoraEmissionsTypeYears) <- c("Type","Year", "Emissions")
# conversion of year to string
BaltimoraEmissionsTypeYears$Year <- as.character(BaltimoraEmissionsTypeYears$Year)

# Plot 3
png('plot3.png')
qplot(Year,data=BaltimoraEmissionsTypeYears, geom="bar", weight=Emissions, facets=.~Type, fill=Year, main='Baltimore City: Emissions (PM 2.5) per year and type', xlab='', ylab = 'Emissions (PM 2.5)')
dev.off()
