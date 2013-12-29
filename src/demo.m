function [output_regression] = demo(img_path)
% Test the system on images using our pre-computed features

% By Amey Dharwadker
% Last modified: 1 Dec 2013

mexopencv_path = 'C:\OpenCV2.4.7\mexopencv';
libsvm_path = 'C:\libsvm-3.17\matlab';

addpath(libsvm_path);
addpath(mexopencv_path);

test_img = imread(img_path);

filen = '..\utils\data_labels.xlsx';
train_labels = xlsread(filen,'B:B');
num_samples = size(train_labels, 1);

train_labels = quantize_labels(train_labels, num_samples);

feature = zeros(num_samples, 8);
std_train = zeros(num_samples, 8);

% Load pre-generated features
load '..\utils\features.mat';

avrg = mean(feature);
std_dev = std(feature);

for i = 1:size(feature, 1)
    std_train(i,:) = (feature(i, :) - avrg)./std_dev;
end

generated_feature = gen_features(test_img);

std_test = (generated_feature - avrg)./std_dev;
test_labels = 1;

mod = svmtrain(train_labels, std_train, '-s 3 -t 2');

[output_regression, ~, ~] = svmpredict(test_labels, std_test, mod);

end


function [labels] = quantize_labels(labels, num_samples)
for i = 1 : num_samples
    if rem(labels(i, 1), 2) == 0
        labels(i, 1) = labels(i, 1)/2;
    else
        labels(i, 1) = (labels(i, 1)+1)/2;
    end
end
end