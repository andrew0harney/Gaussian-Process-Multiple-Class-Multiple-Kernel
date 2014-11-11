Gaussian-Process-Multiple-Class-Multiple-Kernel
===============================================

Matlab implementation of MC-MKL for Gaussian Processes as decriped in hte accompanying paper (icpr14_mcmkl.pdf)

The methods contained in this project are intended to be useful for Gaussian process classification/probability estimation. It also contains some handy functions for dealing with probability distributions.

MCMC with marginal liklihood estimates based on importance sampling around the laplace is implemented. The Laplace function is an adaptation of the pseudo-code provided in Rasmussen's book to the general multi-class multi-kernel case (http://www.gaussianprocess.org/gpml/chapters/RW.pdf).

-------------------------------------------------

Notes:

- The code does not implement the most efficient representation or processing of the (MC-MKL) covariance matrix
as described in the accompanying paper.

- While some effort was made to keep this code general, it was ultimately written with a specific project in mind. However, I hope it may provide some use and it should still be straightforward to adapt. 


- Most of the code is written in log space to maintain numerical accuracy. A small amount of jitter is also added to the diagonals of covariance matrices to avoid singularity issues - so make sure you're happy with this setting!

---------------------------------------------------

Please also refer to the accompanying license before using any of this code.
