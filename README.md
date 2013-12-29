FacePhotoAesthetics
===================

A Thing of Beauty is a Joy Forever : Predicting Visual Aesthetics in Face Photos  
Biometrics (Fall 2013) course project.

Team: Amey Dharwadker (aap2174), Arihant Kochhar (ak3536)

Quick Start
----------

1. Clone the repo

        $ git clone git@github.com:ameydhar/FacePhotoAesthetics.git   
        $ cd FacePhotoAesthetics
 
2. Install MATLAB mex functions for OpenCV library from: http://www.cs.sunysb.edu/~kyamagu/mexopencv 

3. Download the dataset at this level from: https://www.dropbox.com/sh/w4pe4pt0kkdxx8k/dh10-EbmfA/dataset?dl=1

Full Evaluation
----------

This procedure would run the full version of the code to generate features and get statistics over the entire dataset.

1. Navigate to the 'src' directory in MATLAB

        >> cd src;

2. Change the mexOpenCV and LibSVM paths in lines 10 and 11 in the 'process.m' file

3. Type the following in the MATLAB command window

        >> [feature, output_classification, output_regression, predicted_labels_regression, true_labels] = process();
        
Demo
----------

This procedure would assign a visual asethetic score to an individual face photo test image.

1. Navigate to the 'src' directory in MATLAB

        >> cd src;

2. Change the mexOpenCV and LibSVM paths in lines 7 and 8 in the 'demo.m' file

3. Type the following in the MATLAB command window

        >> img_path = '..\test_data\87.jpg';
        >> score = demo(img_path)
