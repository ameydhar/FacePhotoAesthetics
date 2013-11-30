function [simplicity_feat] = background_simplicity_feature(img, boxes)
% By Arihant Kochhar
% Last modified: 29 Nov 2013

[row, column, ~] = size(img);

%Find image histogram for the foreground region
num_faces = size(boxes,2);
ss = 0;

% Foreground is transformed to white
for i = 1 : num_faces
    y_face = boxes{1,i}(1,2);
    x_face = boxes{1,i}(1,1);
    width = boxes{1,i}(1,3);
    hgt = boxes{1,i}(1,4);
    ss = ss + width*hgt;
    for j = y_face : y_face+hgt-1
        for k = x_face : x_face+width-1
            img(j,k,:) = 255;
        end
    end                                 
end  

% Quantize image in 16 colors each for R,G,B plane
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

quanta = 16;

img_r = double(img_r)/quanta;
img_g = double(img_g)/quanta;
img_b = double(img_b)/quanta;

q_img_r = uint8(floor(img_r)*quanta);
q_img_g = uint8(floor(img_g)*quanta);
q_img_b = uint8(floor(img_b)*quanta);

% Find the image histogram
rgb_hist = zeros(16,16,16);

for i = 1 : row
    for j = 1 : column
        r = q_img_r(i,j);
        g = q_img_g(i,j);
        b = q_img_b(i,j);
        rgb_hist((r/16) + 1,(g/16) + 1,(b/16) + 1) = rgb_hist((r/16) + 1,(g/16) + 1,(b/16) + 1)+1;
    end
end

rgb_hist(16,16,16) = rgb_hist(16,16,16) - ss;

Hmax = max(max(max(rgb_hist(:,:,:))));
gamma = 0.01;
thres = gamma * Hmax;

temp = (rgb_hist >= thres);

numer = sum(sum(sum(temp)));
 
simplicity_feat = (numer/4096)*100;

end