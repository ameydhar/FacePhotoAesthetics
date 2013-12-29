function [eval_params_classification, eval_params_regression] = calc_evalparams(cce_classification, cce_regression)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

output_classification = cce_classification;
output_classification = cell2mat(output_classification);
output_classification = output_classification';
eval_params_classification = mean(output_classification);

output_regression = cce_regression;
output_regression = cell2mat(output_regression);
output_regression = output_regression';
eval_params_regression = mean(output_regression);

end