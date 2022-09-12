function [input, control] = InputHelper(setup)
control = 1;
% Select data (SUVr) file
[file,path] = uigetfile({'*.csv'}, ...
    'Select a file containing your PET measures (e.g. SUV/SUVr)', ...
    fullfile(pwd,'input'));

if isequal(file,0)
   control = 0;
   input = [];
   return   
end

data_file = fullfile(path,file);

% Select Labels file
[file,path] = uigetfile({'*.csv'}, ...
    'Select a file containing the volumes of interest labels', ...
    fullfile(pwd,'input'));

if isequal(file,0)
   control = 0;
   input = [];
   return   
end

label_file = fullfile(path,file);

if setup.Plot3D

    % Select Structural image file
    [file,path] = uigetfile({'*.mnc'}, ...
        'Select a structural image file', ...
        fullfile(pwd,'input'));

    if isequal(file,0)
       control = 0;
       input = [];
       return   
    end

    atlas_file = fullfile(path,file);

    % Select Coordinates File
    [file,path] = uigetfile({'*.csv'}, ...
        'Select a file containing the volumes of interest coordinates', ...
        fullfile(pwd,'input'));

    if isequal(file,0)
       control = 0;
       input = [];
       return   
    end

    coords_file = fullfile(path,file);
else
    atlas_file = '';
    coords_file = '';
end


input.data_file = data_file;
input.label_file = label_file;
input.atlas_file = atlas_file;
input.coords_file = coords_file;

end