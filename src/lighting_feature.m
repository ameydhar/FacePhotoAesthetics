function [lighting_feat, fg_avg_luminance, bg_luminance] = lighting_feature(hsv_img, locations)

luminance = hsv_img(:, :, 3);
bg_luminance = sum(sum(luminance))/(size(luminance, 1) * size(luminance, 2));

num_faces = size(locations, 2);
fg_luminance = zeros(1, num_faces);
fg_avg_luminance = 0;

for i = 1:num_faces
    foreground = hsv_img(locations{1, i}(1, 2):locations{1, i}(1, 2) + locations{1, i}(1, 4) - 1, ...
        locations{1, i}(1, 1):locations{1, i}(1, 1) + locations{1, i}(1, 3) - 1, 3);
    fg_luminance(1, i) = sum(sum(foreground))/(size(foreground, 1) * size(foreground, 2));
    fg_avg_luminance = fg_avg_luminance + fg_luminance(1, i);
end

fg_avg_luminance = fg_avg_luminance/num_faces;
lighting_feat = abs(log(fg_avg_luminance/bg_luminance));

end