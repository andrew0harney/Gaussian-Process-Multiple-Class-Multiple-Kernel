Gaussian-Process-Multiple-Class-Multiple-Kernel
===============================================

Matlab implementation of MC-MKL for Gaussian Processes

The methods contained in this project are intended to be useful for Gaussian process classification/probability estimation. It also contains some handy functions for dealing with probability distributions.

MCMC with marginal liklihood estimates based on importance sampling around the laplace is implemented. The Laplace function is an adaptation of the pseudo-code provided in Rasmussen's book to the gerneral multi-class multi-kernel case.

-------------------------------------------------

Notes:

- The code does not implement the most efficient representation or processing of the (MC-MKL) covariance matrix
as described in the accompanying paper (to follow in later commit)


---------------------------------------------------

Please also refer to to the accompanying license before using any of this code.
