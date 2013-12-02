function [color_feat] = color_correlation_feature(img, boxes)
% By Arihant Kochhar
% Last modified: 29 Nov 2013

% Find histogram for the foreground region
num_faces = size(boxes,2);

% Separating the image into R,G,B color spaces
img_Fullred = img(:,:,1);
img_Fullgreen = img(:,:, 2);
img_Fullblue = img(:,:, 3);

Foreground_RHist = zeros(256,1);
Foreground_GHist = zeros(256,1);
Foreground_BHist = zeros(256,1);
face_area = 0;

for i = 1 : num_faces
    pos = boxes{1,i};
    
    img_red = img(pos(1,2):pos(1,2)+pos(1,4)-1,pos(1,1):pos(1,1)+pos(1,3)-1,1);
    img_green = img(pos(1,2):pos(1,2)+pos(1,4)-1,pos(1,1):pos(1,1)+pos(1,3)-1,2);
    img_blue = img(pos(1,2):pos(1,2)+pos(1,4)-1,pos(1,1):pos(1,1)+pos(1,3)-1,3);
    
    % Find histograms in each color space
    [red_ForeHist,~] = imhist(img_red);
    [green_ForeHist, ~] = imhist(img_green);
    [blue_ForeHist,] = imhist(img_blue);
    
    % Find the final histogram for the foreground region
    Foreground_RHist = Foreground_RHist + red_ForeHist;
    Foreground_GHist = Foreground_GHist + green_ForeHist;
    Foreground_BHist = Foreground_BHist + blue_ForeHist;
    
    % Fill the foreground with uniform intensity of zero in full image
    for j = pos(1,2) : pos(1,2)+pos(1,4)
        for k = pos(1,1) : pos(1,1)+pos(1,3)
            img_Fullred(j,k) = 0;
            img_Fullgreen(j,k) = 0;
            img_Fullblue(j,k) = 0;
        end
    end
    
    face_area = face_area+ pos(1,3)*pos(1,4);
end

% Find image histogram for the background region
[red_FullHist,~] = imhist(img_Fullred);
[green_FullHist, ~] = imhist(img_Fullgreen);
[blue_FullHist, ~] = imhist(img_Fullblue);

temp_red = red_FullHist(1,1);
temp_green = green_FullHist(1,1);
temp_blue = blue_FullHist(1,1);

temp_red = temp_red - face_area;
temp_green = temp_green - face_area;
temp_blue = temp_blue - face_area;

red_FullHist(1,1) = temp_red;
green_FullHist(1,1) = temp_green;
blue_FullHist(1,1) = temp_blue;

% Find color correlation in three color spaces between foregound and background
[Red_HistCorr] = corr2(red_FullHist, Foreground_RHist);
[Green_HistCorr] = corr2(green_FullHist, Foreground_GHist);
[Blue_HistCorr] = corr2(blue_FullHist, Foreground_BHist);

color_feat = [Red_HistCorr Green_HistCorr Blue_HistCorr];

end