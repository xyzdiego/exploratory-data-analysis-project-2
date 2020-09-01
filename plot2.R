source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting the info for Baltimore
BaltimoreNEI <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
    summarise(Emissions = sum(Emissions))

# Output table for Baltimore emissions per year
BaltimoreNEI %>% kable()

# Create a palette for the plot
colores <- c("slategray4", "springgreen4", "turquoise4", "slateblue4")

# Generating the plot 2
png("./data/plot2.png", width=480, height=480, units="px") #PNG generating image

# Create a plot1 with the text comments function
p2 <- barplot(height = BaltimoreNEI$Emissions/1000, 
              names.arg = BaltimoreNEI$year,
              main = expression('Total PM'[2.5]*
                                    ' emissions in Baltimore City-MD in kilotons'),
              xlab = "year",
              ylab = expression('Total PM'[2.5]*' emission in kilotons'),
              ylim = c(0, 4),
              col = colores)
text(x = p2, y = round(BaltimoreNEI$Emissions/1000, 2), pos =3, cex = 0.75, 
     col = "gray20", label = round(BaltimoreNEI$Emissions/1000, 2))

# Close the png function
dev.off()
