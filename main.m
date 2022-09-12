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
[input, control] = InputHelper(setup);
if isequal(control,0)
   return
end

%% Load input data:
Labels = labels_import(input.label_file);
DATA = data_import(input.data_file,setup);
Atlas = input.atlas_file;
Coords = input.coords_file;

%% Construct a MBN network using the MS approach:
[output,setup] = BuildNetwork(DATA,setup);

%% Compute Normal Network Corrected for Multiple Comparison:
[output.NormalNetworks] = BuildConventionalNetwork(output.DATA,setup);

%% Save Networks and plot
PlotNets(output,setup,Labels,Atlas,Coords,true)

