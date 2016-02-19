#This is the CEO file 

# Clean up environment
rm(list = ls())

#Set working directory to a folder where you have all files included
setwd("C:/Users/Adam Alagiah/Dropbox/TwitterProject/Adam")

#Sourcing Twitter to bring in the required data
#When asked "Using direct authentication", type 2 in the console and press enter
source("twittersetup.R")

#Sourcing libraries
source("Packages.R")

#Organize the data into frames and variables
source("Dataframes.R")
source("trendingchart.R")

#Produces the report
docfile = "reportmothafuckaaa.rmd"
rmarkdown::render(docfile,quiet=TRUE)
