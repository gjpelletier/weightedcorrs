# weightedcorrs
Python, Jupyter notebook, and MATLAB function to calculate weighted correlation coefficients, covariance, and standard deviations

# Installation for MATLAB

Download weightedcorrs.m from github and add it to your working directory or session search path.<br>

# Installation for Google Colab, Jupyter Notebooks, and Python

First install weightedcorrs as follows with pip or !pip:,br>
```pip install git+https://github.com/gjpelletier/weightedcorrs.git```<br> 
Next import the weightedcorrs function as follows:<br>
```from weightedcorrs import weightedcorrs```<br>
As an alternative, you can also download weightedcorrs.py from github and add it to your own project.<br>

# Syntax for MATLAB

-	R = weightedcorrs(Y)                     returns unweighted correlation matrix (same as corrcoef(Y))
-	R = weightedcorrs(Y,w)                   returns weighted correlation matrix of Y weighted by w
-	[~,p] = weightedcorrs(Y,w)               returns p-values of the weighted correlation coefficients
-	[~,~,wcov] = weightedcorrs(Y,w)          returns weighted covariance of Y weighted by w normalized to number of observations (nobs)
-	[~,~,~,wstd] = weightedcorrs(Y,w)        returns weighted standard deviations of Y weighted by w normalized to nobs
-	[~,~,~,~,wmean] = weightedcorrs(Y,w)     returns weighted means of Y weighted by w
-	[~,~,wcov,wstd] = weightedcorrs(Y)       returns unweighted covariance and standard deviations normalized to nobs-1 (same as std(Y) and cov(Y))
-	[~,~,wcov,wstd] = weightedcorrs(Y,0)     returns unweighted covariance and standard deviations normalized to nobs-1 (same as std(Y,0) and cov(Y,0))
-	[~,~,wcov,wstd] = weightedcorrs(Y,1)     returns unweighted covariance and standard deviations normalized to nobs (same as std(Y,1) and cov(Y,1)

weightedcorrs returns a symmetric matrix R of weighted Pearson correlation
coefficients calculated from an input nobs-by-nvar matrix Y whose rows are
observations and whose columns are variables and an input nobs-by-1 vector
w of weights for the observations. This function may be a valid
alternative to CORRCOEF if observations are not all equally relevant
and need to be weighted according to some theoretical hypothesis or
knowledge.

Input of w is optional. 
If w=0, 1, or is omitted, then the function assigns w = ones(nobs,1)
If w=0 or omitted, the covariance and standard deviations are unweighted and normalizd to nobs-1
If w=1, the covariance and standard deviations are unweighted and normlizd to nobs
Otherwise, if w is an input vector of weights, then nobs for output of standard deviations and covariance. 
If w=0 or if the input vector of w = ones(nobs,1), then there is no difference between
weightedcorrs(Y, w) and corrcoef(Y).

# Syntax for Google Colab, Jupyter Notebooks, and Python

- results = weightedcorrs(X)
- results = weightedcorrs(X,w)

weightedcorrs returns a results dictionary that contains the following outputs: R, p, wcov, wstd, and wmean.

results['R'] is the output of the weighted Pearson correlation coefficients calculated from an input nobs-by-nvar matrix X whose rows are observations (nobs) and whose columns are variables (nvar), and an input nobs-by-1 vector w of weights for the observations. This function may be a valid alternative to np.corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

results['p'] is the output of the p-values of the Pearson correlation coefficients

results['wcov'] is the output of the weighted covariance matrix

results['wstd'] is the output of the weighted standard deviations

results['wmean'] is the output of the weighted means

Input of w is optional. If w=0, 1, or is omitted, then the function assigns w = np.ones(nobs). If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to nobs-1, and the means are unweighted. If w=1, then the covariance and standard deviations are unweighted and normlizd to nobs, and the means are unweighted. Otherwise, if w is an input vector of weights, then results are normalized to nobs for output of standard deviations and covariance, and the means are weighted by w. If w=0 or omitted, or if the input vector of w = np.ones(nobs), then no difference exists between weightedcorrs(X, w) and np.corrcoef(X,rowvar=False).

# Reference: 

The mathematical formulas in matrix notation, together with
the code, is also available in
F. Pozzi, T. Di Matteo, T. Aste,
"Exponential smoothing weighted correlations",
The European Physical Journal B, Volume 85, Issue 6, 2012.
DOI:10.1140/epjb/e2012-20697-x. 

Adapted from weightedcorrs.m (Pozzi et al., 2012).
Modified by Greg Pelletier 24-Jan-2024 to output p-values of 
correlation coefficients, weighted covariance matrix, and 
weighted standard deviations, and allow optional input of 
weighting factors for use with unweighted analysis 
or normalization to nobs-1
