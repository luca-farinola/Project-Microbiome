
#Main File

# set correct working directory 
setwd("C:/Users/lukfa/OneDrive/Desktop/Project-Microbiome")

#import used functions from scripts 
source("scripts/libraries.R")
source("scripts/filter_and_normalize.R")
source("scripts/mean_centering.R")

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

# perform per patient mean centering 

X <- meancenter_perpatient(data,metadata$patient,metadata$patient_type)

mean_centered <- X$data_mc

# Principal component analysis on mean centered data 

ResPCA_after <- pcaBySvd(as.matrix(mean_centered))

pcaScorePlot(
  ResPCA_after,
  axes = c(1, 3),
  title = "PCA mean centered data",design = metadata,
  color = "patient", shape = "patient_type"
)

#Unsupervised Random Forest 

iris.urf <- randomForest(mean_centered)
a <- MDSplot(iris.urf,metadata$patient_type,k=5,palette=NULL)

MDS <- a$points 

# 3D plots (time_points and patient type)

# Color according to patient type 

patient_type_mapping <- c("HC" = "green","NCWS" = "red")
patient_type_labels <- patient_type_mapping[metadata$patient_type]

# Color according to Time Point 

time_point_mapping <- c("T0" = "blue","T5" = "yellow")
time_point_labels <- time_point_mapping[metadata$time_point]





