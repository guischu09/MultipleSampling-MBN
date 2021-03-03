clear all
close all
clc

%% Set dependencies:
addpath(genpath('lib'))

%% Main parameters
[ setup, button] = SetupHelper();
if strcmp(button,'cancel') || isempty(button)
    return
end

%% Input :
InputPath = fullfile(pwd,'Input');
% Atlas Data
atlasFile = fullfile(InputPath,'RatT1.mnc');
% atlas_filename = '';

% Coordinates Data
coordsFile = fullfile(InputPath,'RatCoords.csv');
% CoordsFilename = '';
% Labels
labelFile = fullfile(InputPath, 'RatLabels.csv');

% PET data
dataFile = fullfile(InputPath, 'RatPET_data.csv');


%% Read data:
Labels = labels_import(labelFile);
DATA = data_import(dataFile,setup);

%% Construct a MBN network using the MS approach:
[output,setup] = BuildNetwork(DATA,setup);

%% Compute Normal Network Corrected for Multiple Comparison:
[output.NormalNetworks] = BuildConventionalNetwork(output.DATA,setup);

%% Save Networks and plot
PlotNets(output,setup,Labels,atlasFile,coordsFile,true)

