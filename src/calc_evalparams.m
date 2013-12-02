function [eval_params_classification] = calc_evalparams(cce_classification)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

output_classification = cce_classification;
output_classification = cell2mat(output_classification);
output_classification = output_classification';
eval_params_classification = mean(output_classification);

end