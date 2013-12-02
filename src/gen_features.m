function [feature] = gen_features(img)
% By Amey Dharwadker, Arihant Kochhar
% Last modified: 30 Nov 2013

[locations] = facedetect(img);
[composition_feat] = composition_feature(img, locations);
[lighting_feat] = lighting_feature(img, locations);
[clarity_contrast_feat] = clarity_feature(img, locations);
[color_feat] = color_correlation_feature(img, locations);
[simplicity_feat] = background_simplicity_feature(img, locations);
[mst_feat] = mst_feature(locations);

feature = [composition_feat, lighting_feat, clarity_contrast_feat, color_feat, simplicity_feat, mst_feat];

end