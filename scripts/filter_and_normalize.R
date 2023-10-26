filter_and_normalize <- function(asv, taxa, samp, threshold_prevalence = 0.05, threshold_abundance = 0.0001) {
  # Filter for 5%
  filter_fiveperc <- colSums(asv != 0) >= threshold_prevalence * nrow(asv)
  filtered_asv <- asv[, filter_fiveperc]
  
  # Filter abundance
  filter_abundance <- colSums(filtered_asv) >= threshold_abundance * sum(filtered_asv)
  double_filtered_asv <- filtered_asv[, filter_abundance]
  
  # Match the taxa
  microbes_postfiltering <- colnames(double_filtered_asv)
  filtered_taxa <- taxa[microbes_postfiltering,]
  
  # Normalization
  geometric_means <- apply(double_filtered_asv, 2, mean)
  ii <- which(geometric_means > 0.1 * max(geometric_means))
  rr <- double_filtered_asv[, ii] / as.matrix(geometric_means)[ii, ]
  w <- apply(rr, 1, median)
  pqn_normalized_data <- double_filtered_asv / (w %*% matrix(1, ncol = dim(double_filtered_asv)[2]))
  
  # Inverse Hyperbolic sine transformation
  IHs <- asinh(pqn_normalized_data)
  
  # Prepare the output data and metadata
  data <- IHs
  metadata <- samp
  data[] <- apply(data, 2, as.numeric)
  
  # Return the processed data and metadata
  return(list(data = data, metadata = metadata))
}


