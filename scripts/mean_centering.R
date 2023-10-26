
meancenter_perpatient <- function(data, patient_number, labels) {
  data_mc <- matrix(nrow = 0,ncol = 461)
  colnames(data_mc) <- colnames(data)
  patient <- unique(patient_number)
  labelmc <- vector()
  all_index <- vector()
  
  for (i in 1:length(patient)) {
    index <- which(patient_number == patient[i])
    tempppp <- scale(data[index, ], center = TRUE, scale = FALSE)
    data_mc <- rbind(data_mc, tempppp)
    tempppl <- labels[index]
    labelmc <- c(labelmc, tempppl)
    all_index <- c(all_index, index)
    
  }
  
  return(list(labelmc = labelmc, data_mc = data_mc, all_index = all_index))
}
