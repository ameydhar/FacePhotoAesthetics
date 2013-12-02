function [locations] = facedetect(img)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 27 Nov 2013

warning('off');

haar_xml_path = 'C:\OpenCV2.4.7\sources\data\haarcascades\haarcascade_frontalface_alt.xml';

% Load a face detector and an image
detector = cv.CascadeClassifier(haar_xml_path);

% Preprocess
gr = cv.cvtColor(img, 'RGB2GRAY');
gr = cv.equalizeHist(gr);

% Detect faces
locations = detector.detect(gr, 'ScaleFactor',  1.3, ...
                            'MinNeighbors', 2, ...
                            'MinSize',      [30, 30]);
                        
for i = 1:size(locations)
    locations{1, i}(1, 1) = locations{1, i}(1, 1) + 1;
    locations{1, i}(1, 2) = locations{1, i}(1, 2) + 1;
    locations{1, i}(1, 3) = locations{1, i}(1, 3) - 1;
    locations{1, i}(1, 4) = locations{1, i}(1, 4) - 1;
end

% Draw results
% for i = 1:numel(locations)
%     img = cv.rectangle(img, locations{1,i});
% end
% imshow(img);

end