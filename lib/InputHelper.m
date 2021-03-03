function [atlasFile,coordsFile,labelFile,dataFile, breakAll] = InputHelper()

% Atlas Data
[baseName1,folder1] = uigetfile('*.mnc','Select an atlas file for the 3D brain plot.');
atlasFile = fullfile(folder1, baseName1);

% Coordinates Data
[baseName2,folder2] = uigetfile('*.csv','Select a file with your ROIs coordinates.');
coordsFile = fullfile(folder2, baseName2);

% Labels
[baseName3,folder3] = uigetfile('*.csv','Select a file with your ROIs Label names.');
labelFile = fullfile(folder3, baseName3);

% PET data
[baseName4,folder4] = uigetfile('*.csv','Select a file with your PET measures.');
dataFile=fullfile(folder4, baseName4);

if ~exist(atlasFile,'file') || ~exist(coordsFile,'file') 
    atlasFile = '';
    coordsFile = '';
end

if ~exist(dataFile,'file') || ~exist(labelFile,'file')
    disp('Stoping execution - input PET data file not defined.') 
    breakAll = true;
else
    breakAll = false;
end
    
end
