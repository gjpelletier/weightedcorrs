# weightedcorrs
Python, Jupyter notebook, and MATLAB function to calculate weighted correlation coefficients, covariance, and standard deviations

SYNTAX

- results = weightedcorrs(X)
- results = weightedcorrs(X,w)

weightedcorrs returns a results dictionary that contains the following outputs: R, p, wcov, wstd, and wmean.

results['R'] is the output of the weighted Pearson correlation coefficients calculated from an input nobs-by-nvar matrix X whose rows are observations (nobs) and whose columns are variables (nvar), and an input nobs-by-1 vector w of weights for the observations. This function may be a valid alternative to np.corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

results['p'] is the output of the p-values of the Pearson correlation coefficients

results['wcov'] is the output of the weighted covariance matrix

results['wstd'] is the output of the weighted standard deviations

results['wmean'] is the output of the weighted means

Input of w is optional. If w=0, 1, or is omitted, then the function assigns w = np.ones(nobs). If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to nobs-1, and the means are unweighted. If w=1, then the covariance and standard deviations are unweighted and normlizd to nobs, and the means are unweighted. Otherwise, if w is an input vector of weights, then results are normalized to nobs for output of standard deviations and covariance, and the means are weighted by w. If w=0 or omitted, or if the input vector of w = np.ones(nobs), then no difference exists between weightedcorrs(X, w) and np.corrcoef(X,rowvar=False).

REFERENCE: the mathematical formulas in matrix notation, together with the original matlab code (weightedcorrs.m), is also available in F. Pozzi, T. Di Matteo, T. Aste, "Exponential smoothing weighted correlations", The European Physical Journal B, Volume 85, Issue 6, 2012. DOI:10.1140/epjb/e2012-20697-x. (https://www.researchgate.net/publication/257866466_Exponential_smoothing_weighted_correlations)

Adapted from weightedcorrs.m (Pozzi et al. 2012). Modified by Greg Pelletier 22-Jan-2024 to also output p-values of the correlation coefficients, weighted covariance matrix, and weighted standard deviations, and allow optional input of weighting factors for use with unweighted analysis or normalization to nobs-1

#Installation

You can install weightedcorrs by running '''pip install git+https://github.com/matthijsz/weightedcorr.git''' in your notebook or terminal, or you can copy the code to your own project.


