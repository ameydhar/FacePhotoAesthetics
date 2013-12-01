function [predicted_labels, res] = svm_regression(libsvm_path, train_labels, std_train, test_labels, std_test)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

addpath(libsvm_path);

num_test = size(std_test,1);

mod = svmtrain(train_labels, std_train, '-s 3 -t 2');
[predicted_labels, ~, ~] = svmpredict(test_labels, std_test, mod);

ss = 0;
for i = 1:num_test
    ss = ss + ((predicted_labels(i, 1) - train_labels(i, 1))*(predicted_labels(i, 1) - train_labels(i, 1)));
end

res = (1/(num_test - 1))*ss;

end