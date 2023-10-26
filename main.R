
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

filter_and_normalize <- filter_and_normalize(asv, taxa, samp)
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
  axes = c(2, 3),  # i have tried different axes
  title = "PCA mean centered data",design = metadata,
  color = "patient", shape = "patient_type"
)

#probably still a great separation on timepoint 

pcaScorePlot(
  ResPCA_after,
  axes = c(1, 2), # i have tried different axes 
  title = "PCA mean centered data",design = metadata,
  color = "time_point"
)

# Unsupervised Random Forest

set.seed(123)

iris.urf <- randomForest(mean_centered)
MDSplot(iris.urf,metadata$patient_type,k=5,palette=NULL)

a <- MDSplot(iris.urf,metadata$patient_type,k=5,palette=NULL)
MDS <- a$points

patient_type_mapping <- c("HC" = "green","NCWS" = "red")
patient_type_labels <- patient_type_mapping[metadata$patient_type]

plot3d(MDS[,3:5], xlab="Component 3", ylab="Component 4", zlab="Component 5", type="n", box=F, axes=F)

decorate3d( xlab="Component 3", ylab="Component 4", zlab="Component 5", 
            box = TRUE, axes = TRUE, main = NULL, sub = NULL,
            top = TRUE, aspect = FALSE, expand = 1.03)

spheres3d(MDS[,3:5], radius=0.009, col= patient_type_labels)



















