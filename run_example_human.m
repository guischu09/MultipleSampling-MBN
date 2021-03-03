clear all
close all
clc

%% Set dependencies:
addpath(genpath('lib'))

%% Main parameters
setup = ParamConfig_human();

%% Input :
InputPath = fullfile(pwd,'Input');
% Atlas Data
atlasFile = fullfile(InputPath,'HumanT1.mnc');
% atlas_filename = fullfile(InputPath,'MNI152_T1_1mm_brain.nii.gz');
% Coordinates Data
coordsFile = fullfile(InputPath,'HumanCoords.csv');
% Labels
labelFile = fullfile(InputPath, 'HumanLabels.csv');
% PET data
dataFile = fullfile(InputPath, 'HumanPET_data.csv');

%% Read data:
Labels = labels_import(labelFile);
DATA = data_import(dataFile,setup);

%% Construct a MBN network using the MS approach:
[output,setup] = BuildNetwork(DATA,setup);

%% Compute Convetional Network Corrected for Multiple Comparison:
[output.NormalNetworks] = BuildConventionalNetwork(output.DATA,setup);

%% Save Networks and plot
PlotNets(output,setup,Labels,atlasFile,coordsFile,true)

