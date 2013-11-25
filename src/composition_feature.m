function [composition_feat] = composition_feature(img, locations)

img_width = size(img, 1);
img_height = size(img, 2);

num_faces = size(locations, 2);
face_widths = zeros(1, num_faces);
face_heights = zeros(1, num_faces);
face_mid_points = cell(1, num_faces);

for i = 1:num_faces
    face_widths(1, i) = locations{1, i}(1, 3);
    face_heights(1, i) = locations{1, i}(1, 4);
    face_mid_points{1, i}(1) = locations{1, i}(1, 1) + locations{1, i}(1, 3);
    face_mid_points{1, i}(2) = locations{1, i}(1, 2) + locations{1, i}(1, 4);
end

composition_feat = golden_dist(num_faces, face_mid_points, img_width, img_height);

end


function [composition_feat] = golden_dist(num_faces, face_mid_points, img_width, img_height)

midx = zeros(1, num_faces);
midy = zeros(1, num_faces);
dist = zeros(4, num_faces);

for i = 1:num_faces
    midx(1, i) = face_mid_points{1, i}(1);
    midy(1, i) = face_mid_points{1, i}(2);
end

for i = 1:num_faces
    dist(1, i) = sqrt(power((midx(1, i)-(img_width/3)), 2)/power(img_width, 2) + power((midy(1, i)-(img_height/3)), 2)/power(img_height, 2));
    dist(2, i) = sqrt(power((midx(1, i)-(2*img_width/3)), 2)/power(img_width, 2) + power((midy(1, i)-(img_height/3)), 2)/power(img_height, 2));
    dist(3, i) = sqrt(power((midx(1, i)-(img_width/3)), 2)/power(img_width, 2) + power((midy(1, i)-(2*img_height/3)), 2)/power(img_height, 2));
    dist(4, i) = sqrt(power((midx(1, i)-(2*img_width/3)), 2)/power(img_width, 2) + power((midy(1, i)-(2*img_height/3)), 2)/power(img_height, 2));
end

composition_feat = min(dist);

end