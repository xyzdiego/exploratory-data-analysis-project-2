source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting the info for Baltimore
BaltimoreNEI <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>%
    summarise(Emissions = sum(Emissions))

# Output table for Baltimore emissions per year
BaltimoreNEI %>% kable()

# Generating the plot 3
png("./data/plot3.png", width=800, height=600, units="px") #PNG generating image

# Create a plot1 with ggplot function
BaltimoreNEI %>% ggplot(aes(factor(year), Emissions, fill = type,
                            label = round(Emissions, 2))) +
    geom_bar(stat = "identity") +
    facet_grid(.~type) + 
    geom_label(aes(fill = type), color = "gray90", fontface = "bold", size = 3) +
    theme_bw() +
    labs(x = "year",
         y = expression("total PM"[2.5]*" emission in tons"),
         title = expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                            "City by various source types", sep="")),
         caption = "Made by Diego Benitez") +
    theme(plot.title = element_text(hjust = 0.5, size =  14, face = "bold"),
          plot.caption = element_text(hjust = 1, face = "italic", 
                                      color = "gray70", size = 7),
          legend.position = "none")

# Close the png function
dev.off()