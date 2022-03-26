## Plot of question 2

#loading required packages
library(dplyr)

# Reading and preparing the dataset
NEI <- readRDS("summarySCC_PM25.rds")
NEIdp <- tibble::as_tibble(NEI)
# Baltimora table with emissions per year 
BaltimoraEmissionsForYear = summarize(group_by(filter(NEIdp, fips=="24510"), year), sum(Emissions))
# Renaming columns
colnames(BaltimoraEmissionsForYear) <- c("Year", "Emissions")

# Plot 2
png('plot2.png')
barplot(BaltimoraEmissionsForYear$Emissions, names.arg=EmissionsForYear$Year, col="red", xlab='Years', ylab='Emissions (PM 2.5)', main =  'Baltimore City: Emissions (PM 2.5) per year')
dev.off()
