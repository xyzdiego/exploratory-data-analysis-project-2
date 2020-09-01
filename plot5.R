source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subsetting
BaltCity <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]

# Generating the plot 5
png("./data/plot5.png", width=800, height=600, units="px") #PNG generating image

# Create a plot1 with ggplot function
BaltCity %>% group_by(year) %>% summarise(Emissions = sum(Emissions)) %>%
    ggplot(aes(factor(year), Emissions, fill = year)) +
    geom_bar(stat = "identity") +
    theme_bw() +
    labs(x = "year",
         y = expression("total PM"[2.5]*" emissions in tons"),
         title = "Emissions from motor vehicle sources in Baltimore City",
         caption = "Made by Diego Benitez") +
    theme(plot.title = element_text(hjust = 0.5, size =  16, face = "bold"),
          plot.caption = element_text(hjust = 1, face = "italic", 
                                      color = "gray70", size = 7))

# Close the png function
dev.off()