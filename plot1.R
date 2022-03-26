## Plot for question 1

## Loading required packages
library(dplyr)

# Reading and preparing the dataset
NEI <- readRDS("summarySCC_PM25.rds")

NEIdp <- tibble::as_tibble(NEI)

# The table with emissions per year
EmissionsForYear = summarize(group_by(NEIdp, year), sum(Emissions))

# Renaming columns of the dataset
colnames(EmissionsForYear) <- c("Year", "Emissions")

# Adding a new column with emissions in million (for the y axis)
EmissionsForYear$EmissionsInMillions = EmissionsForYear$Emissions / 1000000

# The Plot (png file)
png('plot1.png')
barplot(EmissionsForYear$EmissionsInMillions, names.arg=EmissionsForYear$Year, col="blue", xlab='Years', ylab='Emissions (PM 2.5) in millions', main =  'Emissions (PM 2.5) per year')
dev.off()
