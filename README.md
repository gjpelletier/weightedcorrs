# weightedcorrs
Python function to calculate weighted correlation coefficients, covariance, and standard deviations

SYNTAX

- results = weightedcorrs(X)
- results = weightedcorrs(X,w)

weightedcorrs returns a results dictionary that contains four outputs: R, p, wcov, and wstd.

results['R'] is the output of the weighted Pearson correlation coefficients calculated from an input T-by-N matrix X whose rows are observations and whose columns are variables and an input T-by-1 vector w of weights for the observations. This function may be a valid alternative to np.corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

results['p'] is the output of the p-values of the Pearson correlation coefficients

results['wcov'] is the output of the weighted covariance matrix

results['wstd'] is the output of the weighted standard deviations

Input of w is optional. If w=0, 1, or is omitted, then the function assigns w = np.ones(np.shape(X)[0]). If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to T-1. If w=1, then the covariance and standard deviations are unweighted and normlizd to T. Otherwise, if w is an input vector of weights, then results are normalized to T for output of standard deviations and covariance. If w=0 or omitted, or if the input vector of w = np.ones(np.shape(X)[0]), then no difference exists between weightedcorrs(X, w) and np.corrcoef(X,rowvar=False).

REFERENCE: the mathematical formulas in matrix notation, together with the original matlab code (weightedcorrs.m), is also available in F. Pozzi, T. Di Matteo, T. Aste, "Exponential smoothing weighted correlations", The European Physical Journal B, Volume 85, Issue 6, 2012. DOI:10.1140/epjb/e2012-20697-x. (https://www.researchgate.net/publication/257866466_Exponential_smoothing_weighted_correlations)

Adapted from weightedcorrs.m (Pozzi et al. 2012). Modified by Greg Pelletier 22-Jan-2024 to also output weighted covariance matrix and calculate weighted standard deviations, and allow optional input of weighting factors for use with unweighted analysis or normalization to T-1


