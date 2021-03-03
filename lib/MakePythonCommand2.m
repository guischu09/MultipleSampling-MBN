
function [command] = MakePythonCommand2(pythonFilename,inputDir,outputDir,OutputFormat)


% 1 Argument - InputFolder
mainpath = pwd;
% fd = [mainpath '/boxplot/'] ;
fd = [mainpath '/' inputDir '/'];
% 2 Argument - Define format of output :
out_format = OutputFormat;

% 3 Argument
% out_fd = [mainpath '/boxplot/'];
out_fd = [mainpath '/' outputDir '/'];

% Make Command:

command = ['python ' pythonFilename ' --fd ' fd ' --out_format ' out_format ' --out_fd ' out_fd];


end

