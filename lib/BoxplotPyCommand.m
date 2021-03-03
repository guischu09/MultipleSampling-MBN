
function [command] = BoxplotPyCommand(pythonFilename,input_data,OutputFormat,outputDir)

% Make Command:
command = ['python ' pythonFilename ' --input_data ' input_data ' --out_format ' OutputFormat ' --out_fd ' outputDir];


end

