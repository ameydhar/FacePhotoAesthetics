function [predicted_labels, cce] = svm_classification(libsvm_path, train_labels, train_instance, test_labels, test_instance)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

addpath(libsvm_path);

num_test = size(test_instance, 1);

mod = svmtrain(train_labels, train_instance,'-t 2');
[predicted_labels, ~, ~] = svmpredict(test_labels, test_instance, mod);

ss = zeros(9, 1);
cce = zeros(9, 1);

for i = 1:num_test
    val = predicted_labels(i, 1) - test_labels(i, 1) + 5;
    ss(val,1) = ss(val, 1) + 1;
end

for i = 1:9
    cce(i,1) = ss(i, 1)/num_test;
end

end