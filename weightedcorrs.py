# -*- coding: utf-8 -*-

import sys
import numpy as np
import numpy.matlib
import scipy.stats

__version__ = "1.0.1"

def weightedcorrs(X,w=0):

  """weightedcorrs.py

  #weightedcorrs.py - Python function to calculate weighted correlation coefficients, covariance, and standard deviations

  SYNTAX

  - results = weightedcorrs(X)
  - results = weightedcorrs(X,w)

  weightedcorrs returns a results dictionary that contains four outputs: R, p, wcov, wstd, and wmean.

  **results['R']** is the output of the weighted Pearson correlation coefficients calculated from an input nobs-by-nvar matrix X whose rows are observations and whose columns are variables and an input nobs-by-1 vector w of weights for the observations. This function may be a valid alternative to np.corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

  **results['p']** is the output of the p-values of the Pearson correlation coefficients

  **results['wcov']** is the output of the weighted covariance matrix

  **results['wstd']** is the output of the weighted standard deviations

  **results['wmean']** is the output of the weighted means

  Input of w is optional.
  If w=0, 1, or is omitted, then the function assigns w = np.ones(nobs).
  If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to nobs-1.
  If w=1, then the covariance and standard deviations are unweighted and normlizd to nobs.
  Otherwise, if w is an input vector of weights, then results are normalized to nobs for output of standard deviations and covariance.
  If w=0 or omitted, or if the input vector of w = np.ones(nobs), then no difference exists between
  weightedcorrs(X, w) and np.corrcoef(X,rowvar=False).
  ___

  REFERENCE: the mathematical formulas in matrix notation, together with the original matlab code (weightedcorrs.m), is also available in F. Pozzi, T. Di Matteo, T. Aste, "Exponential smoothing weighted correlations", The European Physical Journal B, Volume 85, Issue 6, 2012. DOI:10.1140/epjb/e2012-20697-x. (https://www.researchgate.net/publication/257866466_Exponential_smoothing_weighted_correlations)
  ___

  Adapted from weightedcorrs.m (Pozzi et al. 2012). Modified by Greg Pelletier 22-Jan-2024 to also output weighted covariance matrix and calculate weighted standard deviations, and allow optional input of weighting factors for use with unweighted analysis or normalization to T-1

  """

  import sys
  import numpy as np
  import numpy.matlib
  import scipy.stats

  nobs,nvar = np.shape(X)   # nobs: number of observations; nvar: number of variables

  if np.size(w) == 1:
    if w==0:
      df_eq_nobs = False
    elif w==1:
      df_eq_nobs = True
    else:
      print('Error in weightcorrs: w needs be either unspecified, 0, 1, or a vector of real non-negative numbers with no infinite or nan values!','\n')
      sys.exit()
    w = np.ones(nobs)
  else:
    df_eq_nobs = True

  if not(np.shape(X)[0] == np.size(w)):
    print('Error in weightcorrs: np.shape(X)[0] has to be equal to np.size(w) (number of observations)!','\n')
    sys.exit()

  ctrl = w.ndim==1 and np.isreal(w).all() and (not np.isnan(w).any()) and (not np.isinf(w).any()) and np.all((w>=0)) and (np.sum(w)>0)
  if not ctrl:
    print('Error in weightcorrs: w needs be a vector of real non-negative numbers with no infinite or nan values!','\n')
    sys.exit()

  ctrl = np.isreal(X).all() and (not np.isnan(w).any()) and (not np.isinf(w).any()) and X.ndim==2
  if not ctrl:
    print('Error in weightcorrs: X needs be a 2D array of real non-negative numbers with no infinite or nan values!','\n')
    sys.exit()

  w = w / np.sum(w)
  wmean = w @ X                                       # weighted means of X
  temp = X - np.matlib.repmat(w @ X,nobs,1)           # center X by removing weighted mean
  temp = temp.T @ (temp * (np.matlib.repmat(w, nvar, 1)).T)    # weighted covariance
  wstd = np.sqrt(np.diag(temp))
  if df_eq_nobs == False:
    wstd = wstd * np.sqrt(nobs/(nobs-1));							# normalize to nobs-1 if w=0 or missing
  temp = 0.5 * (temp + temp.T)                        # must be exactly symmetric
  R = np.diag(temp)                                   # weighted variances normalized to nobs
  R = R.reshape(-1, 1)                                # reshape to vector column
  R = temp / np.sqrt(R @ R.T)                         # weighted correlation matrix
  D = np.diag(wstd)
  wcov = D @ R @ D															  	  # weighted covariance matrix

  dist = scipy.stats.beta(nobs/2 - 1, nobs/2 - 1, loc=-1, scale=2)
  p = 2*dist.cdf(-abs(R))                             # p-values of the correlation coefficients

  # put the outputs into the results dictionary
  results = {
    'R': R,
    'p': p,
    'wcov': wcov,
    'wstd': wstd,
    'wmean': wmean
    }

  return results