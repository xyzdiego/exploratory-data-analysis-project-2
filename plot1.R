source("./data/downloadFile.R")

# Read the National Emissions Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
# Read source code classication data
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Output table for Total emissions per year
NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions)) %>% kable()

# Generating the plot 1 (p1)
png("./data/plot1.png", width=480, height=480, units="px") #PNG generating image

# Subsseting info
total <- NEI %>% group_by(year) %>% summarise(emissions = sum(Emissions)) 

# Create a palette for the plot
colores <- c("slategray4", "springgreen4", "turquoise4", "slateblue4")

# Create a plot1 with the text comments function
p1 <- barplot(height = total$emissions/1000, 
              names.arg = total$year,
              main = expression('Total PM'[2.5]*
                                    ' emissions at various years in kilotons'),
              xlab = "year",
              ylab = expression('Total PM'[2.5]*' emission in kilotons'),
              ylim = c(0, 8000), 
              col = colores)
text(x = p1, y = round(total$emissions/1000, 2), pos =3, cex = 0.75, col = "gray20",
     label = round(total$emissions/1000, 2))

# Close the png function
dev.off()