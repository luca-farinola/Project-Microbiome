 <h3 align="center">DIseAse-MOdule-Detection-DIAMOND-algorithm-in-Parkinson-Disease</h3>

  <p align="center">
    Project for Scientific Programming
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project   

### Data Preprocessing

* Filtering: (filter_and_normalize.R)
  * Sub 5% prevalence filtering (i.e., an ASV should be present in at least 5% of samples)
  * Sub 0.01% abundance filtering (the abundance across all samples of a given ASV should be at least 0.01%)

* Normalization: Performed PQN normalizzation  (filter_and_normalize.R)
* Inverse Hyperbolic Transformation: function in R asinh()
* Mean Centering: per patient mean centering to remove variation  (mean_centering.R)
* Unsupervised Random Forest (using randomForest version 4.7.1.1)

### Visualization

Explain the visualization techniques used, namely PCA and MDS:

* PCA by SvD (Principal Component Analysis by singular Value Decomposition): (using limpca version 0.99.1)
* MDS (Multidimensional Scaling): From proximity

## Next step 

verify the influence of more variables through ASCA (limpca) 


!! to download limpca package --> remotes::install_github(“ManonMartin/limpca”, dependencies = TRUE)
