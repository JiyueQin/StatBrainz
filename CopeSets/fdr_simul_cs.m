function [ lower_set, upper_set ] = fdr_simul_cs( data, mask, thresh_vec, alpha_quant )
% FDR_COPE_SETS( data, thresh, alpha_quant )
%--------------------------------------------------------------------------
% ARGUMENTS
% Mandatory
%  data    an array of size [dim, nsubj] giving the observed data where dim
%          is the size of the domain and nsubj is the number of subjects
%  thresh  the threshold at which to generate the cope set
% Optional
%  alpha_quant  a number between 0 and 1 giving the alpha quantile the
%               default is 0.05
%--------------------------------------------------------------------------
% OUTPUT
%  lower_set:    a 0/1 array of size dim where 1 indicates the locations of
%                the lower cope set
%  upper_set:    a 0/1 array of size dim where 1 indicates the locations of
%                the upper cope set
%--------------------------------------------------------------------------
% EXAMPLES
% dim = [100, 100]; D = length(dim);
% mu = repmat(linspace(1, 3), dim(2), 1);
% nsubj = 30;
% FWHM = 3;
% mask = ones(dim);
% c = 2;
% 
% lat_data = wfield( dim, nsubj, 'L', 1);
% f = convfield(lat_data, FWHM);
% noise = f.field;
% data = noise + mu;
% 
% [lower_fdr, upper_fdr] = fdr_cope_sets( data, c );
%--------------------------------------------------------------------------
% AUTHOR: Samuel Davenport
%--------------------------------------------------------------------------

%%  Add/check optional values
%--------------------------------------------------------------------------
if ~exist( 'alpha_quant', 'var' )
   % Default value
   alpha_quant = 0.05;
end

if ~isequal(size(thresh),[1,1])
   error('Thresh must be a single number') 
end

%%  Main Function Loop
%--------------------------------------------------------------------------
s_data = size(data);
nsubj = s_data(end);
data_vec = vec_data(data, mask);
nthresholds = length(thresh_vec);
pvals = [sum(mask(:)), nthresholds];
for I = 1:nthresholds
    data_tstat_thresh = mvtstat(data_vec - thresh_vec(I));
    pvals(:,I) = 2*(1 - tcdf(abs(data_tstat_thresh), nsubj - 1));
end

pvals_vec = pvals(:);
pval_rejection_ind = fdrBH( pvals_vec, alpha_quant );
maxp = max(pvals_vec(pval_rejection_ind));

rejection_ind = pvals <= maxp+eps;

for 
tstat_positive = data_tstat > 0;
tstat_negative = data_tstat < 0;
if thresh > 0 
    tstat_negative = tstat_negative + (data_std < eps);
else
    tstat_positive = tstat_positive + (data_std < eps);
end

lower_set = logical(1 - tstat_negative.*rejection_ind);
upper_set = tstat_positive.*rejection_ind;
% lower_set = logical(1 - tstat_negative.*rejection_ind);
% upper_set = tstat_positive.*rejection_ind;

end
