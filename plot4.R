## Plot for question 4
# Loading required packages
library(dplyr)
library(ggplot2)


# Reading and preparing the dataset
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merging the tables together
NEISCC <- merge(NEI, SCC, by="SCC")
NEISCCdp <- tibble::as_tibble(NEISCC)

# Searching for "coal" and create boolean column
NEISCCdp <- mutate(NEISCCdp, coal = grepl("coal", NEISCCdp$Short.Name, ignore.case=TRUE)) 

# Renaming dataset columns
EmissionsCoalYear <- summarize(group_by(filter(NEISCCdp, coal==TRUE),year),sum(Emissions))
colnames(EmissionsCoalYear) <- c("Year", "Emissions") 

# Converting year column to string
EmissionsCoalYear$Year <- as.character(EmissionsCoalYear$Year)

# Adding a new column with emissions in thousands (for the y axis)
EmissionsCoalYear$EmissionsInTousands = EmissionsCoalYear$Emissions/1000

# Plot 4
png('plot4.png')
g <- ggplot(EmissionsCoalYear, aes(Year, EmissionsInTousands))
g+geom_bar(stat='identity')+labs(title="Emissions from coal combustion-related sources", x="Years",y="Emissions (PM 2.5) in thousands")
dev.off()
