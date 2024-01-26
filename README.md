# weightedcorrs
Python, Jupyter notebook, and MATLAB function to calculate weighted correlation coefficients, covariance, and standard deviations

# Installation for MATLAB

Download weightedcorrs.m from this github repository (https://github.com/gjpelletier/weightedcorrs) or MATLAB File Exchange and add it to your working directory or session search path.<br>

# Installation for Google Colab, Jupyter Notebooks, and Python

First install weightedcorrs as follows with pip or !pip in your notebook or terminal:<br>
```
pip install git+https://github.com/gjpelletier/weightedcorrs.git
```

Next import the weightedcorrs function as follows in your notebook or python code:<br>
```
from weightedcorrs import weightedcorrs
```

As an alternative, you can also download weightedcorrs.py from this github repository (https://github.com/gjpelletier/weightedcorrs) and add it to your own project.<br>

# Syntax for MATLAB

SYNTAX:

-	[R,p,wcov,wstd,wmean] = weightedcorrs(X,w)   

List of outputs:

- 'R' is the output of the weighted Pearson correlation coefficients calculated from an input nobs-by-nvar matrix X whose rows are observations and whose columns are variables and an input nobs-by-1 vector w of weights for the observations. This function may be a valid alternative to MATLAB's corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

- 'p' is the output of the p-values of the Pearson correlation coefficients

- 'wcov' is the output of the weighted covariance matrix

- 'wstd' is the output of the weighted standard deviations

- 'wmean' is the output of the weighted means

Input of w is optional. If w=0, 1, or is omitted, then the function assigns w = np.ones(nobs). If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to nobs-1, and the means are unweighted. If w=1, then the covariance and standard deviations are unweighted and normlizd to nobs, and the means are unweighted. Otherwise, if w is an input vector of weights, then results are normalized to nobs for output of standard deviations and covariance, and the means are weighted by w. If w=0 or omitted, or if the input vector of w = ones(nobs,1), then there is no difference between weightedcorrs(X, w) and corrcoef(X).

# Syntax for Google Colab, Jupyter Notebooks, and Python

SYNTAX:

- results = weightedcorrs(X,w)

weightedcorrs returns a results dictionary that contains the following outputs: R, p, wcov, wstd, and wmean.

- results['R'] is the output of the weighted Pearson correlation coefficients calculated from an input nobs-by-nvar matrix X whose rows are observations (nobs) and whose columns are variables (nvar), and an input nobs-by-1 vector w of weights for the observations. This function may be a valid alternative to np.corrcoef if observations are not all equally relevant and need to be weighted according to some theoretical hypothesis or knowledge.

- results['p'] is the output of the p-values of the Pearson correlation coefficients

- results['wcov'] is the output of the weighted covariance matrix

- results['wstd'] is the output of the weighted standard deviations

- results['wmean'] is the output of the weighted means

Input of w is optional. If w=0, 1, or is omitted, then the function assigns w = np.ones(nobs). If w=0 or omitted, then the covariance and standard deviations are unweighted and normalizd to nobs-1, and the means are unweighted. If w=1, then the covariance and standard deviations are unweighted and normlizd to nobs, and the means are unweighted. Otherwise, if w is an input vector of weights, then results are normalized to nobs for output of standard deviations and covariance, and the means are weighted by w. If w=0 or omitted, or if the input vector of w = np.ones(nobs), then there is no difference between weightedcorrs(X, w) and np.corrcoef(X,rowvar=False).

# Example for MATLAB

```
load hospital
X = [hospital.Weight hospital.BloodPressure];
w = hospital.Age;
[wrho,p,wcov,wstd,wmean] = weightedcorrs(X,w)   
```
wrho =<br>
   1.0000e+00   1.5541e-01   2.3071e-01<br>
   1.5541e-01   1.0000e+00   5.1037e-01<br>
   2.3071e-01   5.1037e-01   1.0000e+00<br>
p =<br>
            0   1.2259e-01   2.0924e-02<br>
   1.2259e-01            0   5.8129e-08<br>
   2.0924e-02   5.8129e-08            0<br>
wcov =<br>
   6.8362e+02   2.7490e+01   4.1788e+01<br>
   2.7490e+01   4.5767e+01   2.3918e+01<br>
   4.1788e+01   2.3918e+01   4.7989e+01<br>
wstd =<br>
   2.6146e+01   6.7651e+00   6.9274e+00<br>
wmean =<br>
   1.5445e+02   1.2295e+02   8.3064e+01<br>

# Example for Google Colab or Jupyter Notebook

The first step is to install weightedcorrs from github as follows:<br>
```!pip install git+https://github.com/gjpelletier/weightedcorrs.git```

Next we need to import the weightedcorrs function and numpy as follows:<br>
```
from weightedcorrs import weightedcorrs
import numpy as np
```

Now we are ready to show an example of doing an analysis of some data using weightedcorrs. We will use a data set from the MATLAB example data packages called 'hospital'. The X array will be a three column array, where the first column is the patient's weight, the second column is the systolic blood pressure, and the third column is the diastolic blood pressure.

Note that weightedcorrs requires the first index of X to be rows of observations, and the second index to be columns of random variables.<br>
```
# First we assign the X array with the first index as random variables
# and second index as observations (therefore we will need to transpose X after this):
X = [np.array([176., 163., 131., 133., 119., 142., 142., 180., 183., 132., 128.,
        137., 174., 202., 129., 181., 191., 131., 179., 172., 133., 117.,
        137., 146., 123., 189., 143., 114., 166., 186., 126., 137., 138.,
        187., 193., 137., 192., 118., 180., 128., 164., 183., 169., 194.,
        172., 135., 182., 121., 158., 179., 170., 136., 135., 147., 186.,
        124., 134., 170., 180., 130., 130., 127., 141., 111., 134., 189.,
        137., 136., 130., 137., 186., 127., 176., 127., 115., 178., 131.,
        183., 194., 126., 186., 188., 189., 120., 132., 182., 120., 123.,
        141., 129., 184., 181., 124., 174., 134., 171., 188., 186., 172.,
        177.]),
 np.array([124., 109., 125., 117., 122., 121., 130., 115., 115., 118., 114.,
        115., 127., 130., 114., 130., 124., 123., 119., 125., 121., 123.,
        114., 128., 129., 114., 113., 125., 120., 127., 134., 121., 115.,
        127., 121., 127., 136., 117., 124., 120., 128., 116., 132., 137.,
        117., 116., 119., 123., 116., 124., 129., 130., 132., 117., 129.,
        118., 120., 138., 117., 113., 122., 115., 120., 117., 123., 123.,
        119., 110., 121., 138., 125., 122., 120., 117., 125., 124., 121.,
        118., 120., 118., 118., 122., 134., 131., 113., 125., 135., 128.,
        123., 122., 138., 124., 130., 123., 129., 128., 124., 119., 136.,
        114.]),
 np.array([93., 77., 83., 75., 80., 70., 88., 82., 78., 86., 77., 68., 74.,
        95., 79., 92., 95., 79., 77., 76., 75., 79., 88., 90., 96., 77.,
        80., 76., 83., 89., 92., 83., 80., 84., 92., 83., 90., 85., 90.,
        74., 92., 80., 89., 96., 89., 77., 81., 76., 83., 78., 95., 91.,
        91., 86., 89., 79., 74., 82., 76., 81., 77., 73., 85., 76., 80.,
        80., 79., 82., 79., 82., 75., 91., 74., 78., 85., 84., 75., 78.,
        81., 79., 85., 79., 82., 80., 80., 92., 92., 96., 87., 81., 90.,
        77., 91., 79., 73., 99., 92., 74., 93., 86.])]

# Next we transpose X so that the first index is rows of observations (nobs),
# and the second index is columns of random variables (nvar)
X = np.transpose(X)
```

Next we will define the weighting factors to use for the analysis. In this example we will use the patients Age from the hospital data set as the weighting factors w.<br>
```
w = np.array([38., 43., 38., 40., 49., 46., 33., 40., 28., 31., 45., 42., 25.,
       39., 36., 48., 32., 27., 37., 50., 48., 39., 41., 44., 28., 25.,
       39., 25., 36., 30., 45., 40., 25., 47., 44., 48., 44., 35., 33.,
       38., 39., 44., 44., 37., 45., 37., 30., 39., 42., 42., 49., 44.,
       43., 47., 50., 38., 41., 45., 36., 38., 29., 28., 30., 28., 29.,
       36., 45., 32., 31., 48., 25., 40., 39., 41., 33., 31., 35., 32.,
       42., 48., 34., 39., 28., 29., 32., 39., 37., 49., 31., 37., 38.,
       45., 30., 48., 48., 25., 44., 49., 45., 48.])
```

Now we are ready to show the example of using weightedcorrs to calculate the weighted correlation coefficients, weighted covariance, and weighted standard deviations as follows:<br>
```
output = weightedcorrs(X,w)

R = output['R']
p = output['p']
wcov = output['wcov']
wstd = output['wstd']
wmean = output['wmean']

print('weighted correlation coefficient matrix of X: ','\n',R,'\n')
print('p-values of the correlation coefficients: ','\n',p,'\n')
print('weighted covariance matrix: ','\n',wcov,'\n')
print('weighted standard deviations: ','\n',wstd,'\n')
print('weighted means: ','\n',wmean)
```
weighted correlation coefficient matrix of X:<br>  
 [[1.         0.1554138  0.23071152]<br>
 [0.1554138  1.         0.51036961]<br>
 [0.23071152 0.51036961 1.        ]] <br>

p-values of the correlation coefficients:<br>
 [[0.00000000e+00 1.22589252e-01 2.09237757e-02]<br>
 [1.22589252e-01 0.00000000e+00 5.81286900e-08]<br>
 [2.09237757e-02 5.81286900e-08 0.00000000e+00]] <br>

weighted covariance matrix:<br>
 [[683.62291955  27.48984917  41.78750454]<br>
 [ 27.48984917  45.76662876  23.91817879]<br>
 [ 41.78750454  23.91817879  47.9885557 ]] <br>

weighted standard deviations:<br> 
 [26.14618365  6.76510375  6.92737726]<br> 

weighted means:<br> 
 [154.45297806 122.94801463  83.06426332]<br>

# Reference: 

The mathematical formulas in matrix notation, together with
MATLAB code, is also available in
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
