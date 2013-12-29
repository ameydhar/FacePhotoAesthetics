function [predicted_labels, res] = svm_regression(libsvm_path, train_labels, std_train, test_labels, std_test)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

addpath(libsvm_path);

mod = svmtrain(train_labels, std_train, '-s 3 -t 2');

[predicted_labels, mean_err, ~] = svmpredict(test_labels, std_test, mod);

res = mean_err(2, 1);

end