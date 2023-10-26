
#Main File

# set correct working directory 
setwd("C:/Users/lukfa/OneDrive/Desktop/Project-Microbiome")

#import used functions from scripts 
source("scripts/libraries.R")
source("scripts/filter_and_normalize.R")

# file importing 
asv <- read.csv("files/finASV.csv", header = TRUE, row.names = 1)
samp <- read.csv("files/finSAMP.csv", header=TRUE, stringsAsFactors = TRUE, row.names = 1)
taxa <- read.csv("files/finTAXA.csv", header = TRUE, row.names = 1)

filter_and_normalize <- process_data(asv, taxa, samp)
data <- filter_and_normalize$data
metadata <- filter_and_normalize$metadata

# Principal component analysis on processed data 

ResPCA_before <- pcaBySvd(as.matrix(data))

pcaScorePlot(
  ResPCA_before,
  axes = c(1, 3),
  title = "PCA processed data",design = metadata,
  color = "patient", shape = "patient_type"
)




