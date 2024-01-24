
function [R,p,wcov,wstd] = weightedcorrs(Y, w)

%	Weighted correlation coefficients, covariance, and standard deviations
%
% 	SYNTAX
% 		R = weightedcorrs(Y)					% returns unweighted correlation matrix (same as corrcoef(Y))
% 		R = weightedcorrs(Y,w)					% returns weighted correlation matrix of Y weighted by w
% 		[~,p] = weightedcorrs(Y,w)				% returns p-values of the weighted correlation coefficients
% 		[~,~,wcov] = weightedcorrs(Y,w)			% returns weighted covariance of Y weighted by w normalized to number of observations (T)
% 		[~,~,~,wstd] = weightedcorrs(Y,w)		% returns weighted standard deviations of Y weighted by w normalized to T
% 		[~,~,wcov,wstd] = weightedcorrs(Y)		% returns unweighted covariance and standard deviations normalized to T-1 (same as std(Y) and cov(Y))
% 		[~,~,wcov,wstd] = weightedcorrs(Y,0)	% returns unweighted covariance and standard deviations normalized to T-1 (same as std(Y,0) and cov(Y,0))
% 		[~,~,wcov,wstd] = weightedcorrs(Y,1)	% returns unweighted covariance and standard deviations normalized to T (same as std(Y,1) and cov(Y,1)
%
%   weightedcorrs returns a symmetric matrix R of weighted Pearson correlation
%   coefficients calculated from an input T-by-N matrix Y whose rows are
%   observations and whose columns are variables and an input T-by-1 vector
%   w of weights for the observations. This function may be a valid
%   alternative to CORRCOEF if observations are not all equally relevant
%   and need to be weighted according to some theoretical hypothesis or
%   knowledge.
%
%   Input of w is optional. 
%   If w=0, 1, or is omitted, then the function assigns w = ones(size(Y,1),1)
%   If w=0 or omitted, the covariance and standard deviations are unweighted and normalizd to T-1
%   If w=1, the covariance and standard deviations are unweighted and normlizd to T
%   Otherwise, if w is an input vector of weights, then T for output of standard deviations and covariance. 
%   If w=0 or if the input vector of w = ones(size(Y,1),1), then no difference exists between
%   weightedcorrs(Y, w) and corrcoef(Y) (see Example 4).
%
%   REFERENCE: the mathematical formulas in matrix notation, together with
%   the code, is also available in
%   F. Pozzi, T. Di Matteo, T. Aste,
%   "Exponential smoothing weighted correlations",
%   The European Physical Journal B, Volume 85, Issue 6, 2012.
%   DOI:10.1140/epjb/e2012-20697-x. 

% ________________________________________________________________________
% 
% 
%   Adapted from weightedcorrs.m (Pozzi et al., 2012).
%   Modified by Greg Pelletier 24-Jan-2024 to output p-values of 
%   correlation coefficients, weighted covariance matrix, and 
%   weighted standard deviations, and allow optional input of 
%   weighting factors for use with unweighted analysis 
%   or normalization to T-1
%
% ________________________________________________________________________

% % ======================================================================
% % EXAMPLE USE COMPARED WITH MATLAB FUNCTIONS
% % ======================================================================
% % - - -
% % EXAMPLE USE of weightedcorrs.m with weighting
% % (same as matlab std with weighting)
% load hospital
% X = [hospital.Weight hospital.BloodPressure];
% w = hospital.Age;
% [wrho,p,wcov,wstd] = weightedcorrs(X,w)   
% % wrho =
   % % 1.0000e+00   1.5541e-01   2.3071e-01
   % % 1.5541e-01   1.0000e+00   5.1037e-01
   % % 2.3071e-01   5.1037e-01   1.0000e+00
% % p =
            % % 0   1.2259e-01   2.0924e-02
   % % 1.2259e-01            0   5.8129e-08
   % % 2.0924e-02   5.8129e-08            0
% % wcov =
   % % 6.8362e+02   2.7490e+01   4.1788e+01
   % % 2.7490e+01   4.5767e+01   2.3918e+01
   % % 4.1788e+01   2.3918e+01   4.7989e+01
% % wstd =
   % % 2.6146e+01   6.7651e+00   6.9274e+00
% % check compared with matlab std for weighted std
% wstd_ = std(X,w)
% wstd_ =
% %    2.6146e+01   6.7651e+00   6.9274e+00
% % - - -
% % EXAMPLE USE of weightedcorrs.m without weighting 
% % (same as matlab corrcoef, cov, std unweighted)
% load hospital
% X = [hospital.Weight hospital.BloodPressure];
% [wrho,p,wcov,wstd] = weightedcorrs(X)   
% % wrho =
   % % 1.0000e+00   1.5579e-01   2.2269e-01
   % % 1.5579e-01   1.0000e+00   5.1184e-01
   % % 2.2269e-01   5.1184e-01   1.0000e+00
% % p =
            % % 0   1.2168e-01   2.5953e-02
   % % 1.2168e-01            0   5.2460e-08
   % % 2.5953e-02   5.2460e-08            0
% % wcov =
   % % 7.0604e+02   2.7788e+01   4.1020e+01
   % % 2.7788e+01   4.5062e+01   2.3819e+01
   % % 4.1020e+01   2.3819e+01   4.8059e+01
% % wstd =
   % % 2.6571e+01   6.7128e+00   6.9325e+00
% % check compared with matlab corrcoef for unweighted correlation
% [R,p] = corrcoef(X)
% % R =
   % % 1.0000e+00   1.5579e-01   2.2269e-01
   % % 1.5579e-01   1.0000e+00   5.1184e-01
   % % 2.2269e-01   5.1184e-01   1.0000e+00
% % p =
   % % 1.0000e+00   1.2168e-01   2.5953e-02
   % % 1.2168e-01   1.0000e+00   5.2460e-08
   % % 2.5953e-02   5.2460e-08   1.0000e+00
% % check compared with matlab cov for unweighted covariance
% covx = cov(X)
% % covx =
   % % 7.0604e+02   2.7788e+01   4.1020e+01
   % % 2.7788e+01   4.5062e+01   2.3819e+01
   % % 4.1020e+01   2.3819e+01   4.8059e+01
% % check compared with matlab std for unweighted std
% stdx = std(X)
% % stdx =
   % % 2.6571e+01   6.7128e+00   6.9325e+00

%
% - - -
% start of calculations
% - - -
%

if nargin==1 | w==0
	w = ones(size(Y,1),1);
	df_eq_T = false;
elseif w==1
	w = ones(size(Y,1),1);
	df_eq_T = true;
else
	df_eq_T = true;
end

% Check input
ctrl = isvector(w) & isreal(w) & ~any(isnan(w)) & ~any(isinf(w)) & all(w >= 0) & (sum(w) > 0);
if ctrl
  w = w(:) / sum(w);                                                          % w is column vector
else
  error('Check w: it needs be a vector of real non-negative numbers with no infinite or nan values!')
end
ctrl = isreal(Y) & ~any(isnan(Y)) & ~any(isinf(Y)) & (size(size(Y), 2) == 2);
if ~ctrl
  error('Check Y: it needs be a 2D matrix of real numbers with no infinite or nan values!')
end
ctrl = length(w) == size(Y, 1);
if ~ctrl
  error('size(Y, 1) has to be equal to length(w)!')
end

[T, N] = size(Y);                                                             % T: number of observations; N: number of variables
temp = Y - repmat(w' * Y, T, 1);                                              % Remove mean (which is, also, weighted)
temp = temp' * (temp .* repmat(w, 1, N));                                     % Covariance Matrix (which is weighted) (df=T)

wstd = sqrt(diag(temp))';													  % weighted standard deviations (df=T)
% standard deviations adjusted to df=T-1 if w=0 or missing
if ~df_eq_T
	wstd = wstd .* sqrt(T / (T-1));											  % adjust to df=T-1 if w=0 or missing
end

temp = 0.5 * (temp + temp');                                                  % Must be exactly symmetric
R = diag(temp);                                                               % weighted variances (df=T)
R = temp ./ sqrt(R * R');                                                     % Matrix of Weighted Correlation Coefficients

% weighted covariance matrix (df=T-1 if w=0 or missing, otherwise df=T)
D = diag(wstd);																  % diagonal matrix of weighted standard deviations 
wcov = D*R*D;															  	  % weighted covariance matrix 

% p-values of the correlation coefficients
t = R.*sqrt((T-2)./(1-R.^2));
s = tcdf(t,T-2);
p = 2 * min(s,1-s);															  % p-values of the correlation coefficients


%
% - - -
% end of calculations
% - - -
%

