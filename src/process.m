function [feature, output_classification, output_regression, predicted_labels_regression, true_labels] = process()
% Run the full system to generate features and get the statistics over the entire dataset

% By Amey Dharwadker, Arihant Kochhar
% Last modified: 1 Dec 2013

clear; clc;
warning('off');

mexopencv_path = 'C:\OpenCV2.4.7\mexopencv';
libsvm_path = 'C:\libsvm-3.17\matlab';
input_dir = '..\dataset\';

addpath(mexopencv_path);

filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);

feature = zeros(num_images, 8);

% for i = 1:num_images
%     filename = fullfile(input_dir, filenames(i).name);    
%     img = imread(filename);
%     
%     generated_features = gen_features(img);
%     
%     feature(i, :) = generated_features;
% end
% 
% % Save the generated features
% save ..\utils\features feature;

load '..\utils\features';

[cce_classification, ~, cce_regression, predicted_labels_regression, true_labels] = predict_scores(feature, libsvm_path);

[output_classification, output_regression] = calc_evalparams(cce_classification, cce_regression);

end