source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subsetting
coalCombustion <- (grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE) & 
                       grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE))
combustionSCC <- SCC[coalCombustion, ]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC, ]

# Generating the plot 4
png("./data/plot4.png", width=800, height=600, units="px") #PNG generating image

# Create a plot1 with ggplot function
combustionNEI %>% ggplot(aes(factor(year), Emissions/1000, fill = year)) +
    geom_bar(stat = "identity") + 
    theme_bw() +
    labs(x = "year",
         y = expression("total PM"[2.5]*" emissions in kilotons"),
         title = expression("Emissions from coal combustion-related sources in kilotons"),
         caption = "Made by Diego Benitez") +
    theme(plot.title = element_text(hjust = 0.5, size =  16, face = "bold"),
          plot.caption = element_text(hjust = 1, face = "italic", 
                                      color = "gray70", size = 7))

# Close the png function
dev.off()