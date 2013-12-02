function [cce_classification, predicted_labels_classification, cce_regression, predicted_labels_regression, true_labels] = predict_scores(feature, libsvm_path)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

% Load the data and sort according to the scores
filen = '..\utils\data_labels.xlsx';
filenames = xlsread(filen,'A:A');
labels = xlsread(filen,'B:B');
[sorted_labels, ix] = sort(labels(:,1));
sorted_names = filenames(ix, 1);

num_samples = size(feature, 1);

labels = quantize_labels(labels, num_samples);

sorted_labels = quantize_labels(sorted_labels, num_samples);

num_scores = size(unique(labels),1);

% Form different matrices for different classes and store them in a cell
diff_class = cell(num_scores, 1);

for i = 1 : num_scores;
    temp = [];
    for j = 1 : num_samples
        if sorted_labels(j,1) == i
            temp = horzcat(temp, sorted_names(j,1));
        end
    end
    diff_class{i,1} = temp;
end

% Select two images for testing and rest for training
num_iter = 80;
test_names = cell(num_iter,num_scores);
train_names = cell(num_iter,num_scores);

for i = 1 : num_iter
    for j = 1 : num_scores
        tst = [];
        trn = [];
        sz = size(diff_class{j,1},2);
        l = randperm(sz);
        p=[];
        for k = 1 : sz
            p(1,k) = diff_class{j,1}(1,l(1,k));
        end
        tst = horzcat(tst, p(1,1:2));
        trn = horzcat(trn, p(1,3:end));
        
        test_names{i,j} = tst;
        train_names{i,j} = trn;
    end
    
end

% Standardize features
tr = cell(1,num_scores);
te = cell(1,num_scores);

training = cell(1,num_iter);
testing = cell(1, num_iter);

for i = 1 : num_iter
    tr = train_names(i,:);
    tr = cell2mat(tr);
    tempp = [];
    temppl = [];
    for j = 1 : size(tr,2)
        img_name = tr(1, j);
        [rr, ~] = find(filenames == img_name);
        tempp = [tempp; feature(rr,:)];
        temppl = [temppl;labels(rr,:)];
    end
    training{1,i} = tempp;
    training_labels{1,i} = temppl;
    
    te = test_names(i,:);
    te = cell2mat(te);
    tempt = [];
    temptel = [];
    for j = 1 : size(te,2)
        img_name = te(1, j);
        [rr, ~] = find(filenames == img_name);
        tempt = [tempt; feature(rr,:)];
        temptel = [temptel; labels(rr,:)];
    end
    testing{1, i} = tempt;
    testing_labels{1,i} = temptel;
end

std_train = cell(1,num_iter);
std_test = cell(1,num_iter);

for i = 1 : num_iter
    Utrain = training{1,i};
    Utest = testing{1,i};
    
    avrg = mean(Utrain);
    std_dev = std(Utrain);
    
    for j = 1 : size(Utrain,1)
        Strain(j,:) = (Utrain(j,:)-avrg)./std_dev;
    end
    
    for j = 1 : size(Utest,1)
        Stest(j,:) = (Utest(j,:)-avrg)./std_dev;
    end
    
    std_train{1,i} = Strain;
    std_test{1,i} = Stest;
end

% SVM Classification
predicted_labels_classification = cell(1,num_iter);
cce_classification = cell(1,num_iter);

predicted_labels_regression = cell(1,num_iter);
cce_regression = cell(1,num_iter);
true_labels = cell(1, num_iter);

for i = 1 : num_iter
    [pred_labels_classification, cce_out_classification] = svm_classification(libsvm_path, training_labels{1,i}, std_train{1,i}, testing_labels{1,i}, std_test{1,i});
    cce_classification{1,i} = cce_out_classification;
    predicted_labels_classification{1,i} = pred_labels_classification;
    
    [pred_labels_regression, cce_out_regression] = svm_regression(libsvm_path, training_labels{1,i}, std_train{1,i}, testing_labels{1,i}, std_test{1,i});
    cce_regression{1,i} = cce_out_regression;
    predicted_labels_regression{1,i} = pred_labels_regression;
    true_labels = testing_labels{1, i};
end

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