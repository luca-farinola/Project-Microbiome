# List of required libraries
required_libraries <- c("knitr", "limpca", 
                        "dplyr", "purrr", "rgl","randomForest", "readxl")

# Function to check and install libraries
check_install_library <- function(library_name) {
  if (!requireNamespace(library_name, quietly = TRUE)) {
    install.packages(library_name, dependencies = TRUE)
    if (!requireNamespace(library_name, quietly = TRUE)) {
      stop(paste("Unable to install", library_name))
    }
  }
}

# Check and install libraries
invisible(sapply(required_libraries, check_install_library))

# Load libraries
library(limpca)
library(knitr)
library(dplyr)
library(purrr)
library(rgl)
library(randomForest)
