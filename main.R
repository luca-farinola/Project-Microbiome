
#Main File

# set correct working directory 
setwd("C:/Users/lukfa/OneDrive/Desktop/Project-Microbiome")

source("scripts/libraries.R")

# file importing 
asv <- read.csv("files/finASV.csv", header = TRUE, row.names = 1)
samp <- read.csv("files/finSAMP.csv", header=TRUE, stringsAsFactors = TRUE, row.names = 1)
taxa <- read.csv("files/finTAXA.csv", header = TRUE, row.names = 1)




