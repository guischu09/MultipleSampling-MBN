
function [command] = Heatmap_pycommand(pythonFilename, r_RepresentativeMatrix,atlas_filename,CoordsFilename,class,OutputFormat, OutputFolder, plot_type, outputFilename,colormap)

% 1 Argument
vmin = unique(sort(r_RepresentativeMatrix(:)));
vmin = vmin(2);

vmax = 1;

% 1 Argument
vmin = num2str(vmin);

% 2 Argument
vmax = num2str(vmax);

% 3 Argument
size_cte = num2str(1);

% 4 Argument
atlas = atlas_filename;

% 5 Argument:
coor = CoordsFilename;

% 6 Argument:
corr = outputFilename;

% 7 Argument - Define format of output :
out_format = OutputFormat;

[~,outSaveName,~] = fileparts(outputFilename);

% 8 Argument - Define filename output of 3DBrainPlot:
out_bp = [outSaveName '_brain'];

% 9 Argument
out_hm = [outSaveName '_heatmap'];

% 10 Argument
out_fd = OutputFolder;

% 11 Argument
cmap = colormap;

% 11 Argument
% plot_type;



% Make Command:

command = ['python ' pythonFilename ' --vmin ' vmin ' --vmax ' vmax ' --size_cte ' size_cte ...
    ' --atlas ' atlas ' --coor ' coor ' --corr ' corr ' --out_format ' out_format ...
    ' --out_bp ' out_bp ' --out_hm ' out_hm ' --out_fd ' out_fd ' --plot_type ' plot_type ' --cmap ' cmap];



end

