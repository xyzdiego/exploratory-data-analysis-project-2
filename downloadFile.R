######################################
#          Coursera Project          #
#  Exploratory Data Analysis Course  #
#                                    #
#       Proeject elaborated by:      #
#        Diego Andres Benítez        #
######################################

# Download the file source
if(!file.exists("./data")){dir.create("./data")}
getData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(getData, "./data/NEI-data.zip", method = "curl")
unzip("./data/NEI-data.zip", exdir = "./data")
list.files("./data")

# Charge the libraries
library(dplyr)
library(ggplot2)
library(knitr)
