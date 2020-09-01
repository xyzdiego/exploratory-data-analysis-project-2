source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subsetting
BaltCityEmis <- NEI %>% filter(fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>% summarise(Emissions = sum(Emissions))
BaltCityEmis$city <- "Baltimore City, MD"
LosAngelesEmis <- NEI %>% filter(fips == "06037" & type == "ON-ROAD") %>%
    group_by(year) %>% summarise(Emissions = sum(Emissions))
LosAngelesEmis$city <- "Los Angeles County, CA"
both <- rbind(BaltCityEmis, LosAngelesEmis)

# Generating the plot 6
png("./data/plot6.png", width=800, height=600, units="px") #PNG generating image

# Create a plot1 with ggplot function
both %>% ggplot(aes(factor(year), Emissions, fill = city)) + 
    geom_bar(stat = "identity") +
    facet_grid(.~city, scales = "free") +
    theme_bw() +
    labs(x = "year",
         y = expression("total PM"[2.5]*" emissions in tons"),
         title = "Motor vehicle emission variation in Baltimore and Los Angeles in tons",
         caption = "Made by Diego Benitez") +
    theme(plot.title = element_text(hjust = 0.5, size =  16, face = "bold"),
          plot.caption = element_text(hjust = 1, face = "italic", 
                                      color = "gray70", size = 7))

# Close the png function
dev.off()