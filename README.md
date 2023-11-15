# StatBrainz
The Statbrainz package contains Matlab code to perform statistical inference and visualization of brain imaging data. 
This includes functions to perform resampling and multiple testing. In particular methods for clustersize inference 
(including associated TDP bounds), and both single and simultaneous CoPE (coverage of probability sets) are provided. 
The package also provide code for reading and visualizing volumetric and surface brain imaging data.

In order to install either download the zip file or run
git clone https://github.com/sjdavenport/StatBrainz/ from the command line.

Then in order to use the package, once you're in matlab you'll first need to add all the functions to the matlab path. 
If you have installed the package in the directory: dir, then to do so you need to run: addpath(genpath('dir')) within matlab.
