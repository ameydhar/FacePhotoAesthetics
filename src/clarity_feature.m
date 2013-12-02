function [clarity_contrast_feat] = clarity_feature(img, boxes)
% By Arihant Kochhar
% Last modified: 29 Nov 2013

img = rgb2gray(img);
tr_img = fft(img);

% Find maximum FFT coefficient
max_coefficient_column = max(tr_img);
max_coeff = max(max_coefficient_column);

% Set threshold
beta = 0.2;
thres = beta*max_coeff;

% Find area of high frequency components in original image
count = 0;
for i = 1 : size(tr_img,1)
    for j = 1 : size(tr_img, 2)
        if abs(tr_img(i,j))>thres
            count = count+1;
        end
    end
end

area_originalimg = size(img,1)*size(img,2);

denum = count/area_originalimg;

count1 = 0;
area_foreground = 0;

% Find area of high frequency components in foreground
for i = 1 : size(boxes,2)
    pos = boxes{1,i};
    foreground = img(pos(1,2) : pos(1,2)+pos(1,4)-1, pos(1,1) : pos(1,1)+pos(1,3)-1);
    tr_foreground = fft(foreground);
    max1 = max(tr_foreground);
    max2 = max(max1);
    thres1 = beta*max2;
    for j = 1 : size(tr_foreground,1)
        for k = 1 : size(tr_foreground,2)
            if abs(tr_foreground(j,k)) > thres1
                count1 = count1+1;
            end
        end
    end
    area_foreground = area_foreground+pos(1,3)*pos(1,4);
end

numer = count1/area_foreground;

clarity_contrast_feat = numer/denum;

end