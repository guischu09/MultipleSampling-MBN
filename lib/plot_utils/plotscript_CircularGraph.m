
function plotscript_CircularGraph(net_csv,colormap_csv,labels_csv,outfile,OutputFormat)

if nargin < 5
    OutputFormat = 'png';
    outfile = strcat(pwd, '/sample_mbn_circle_plot.',OutputFormat);
elseif nargs < 6
    OutputFormat = 'png';
    outfile = strcat(outfile,'.',OutputFormat);
else
    outfile = strcat(outfile,'.',OutputFormat);
end

network = importdata(net_csv);
network = network.data;

Labels = labels_import(labels_csv);

circularGraph(network,'colormap',colormap_csv,'Label',strrep(Labels,'_','-'));



try
    frame_h = get(handle(gcf),'JavaFrame');
    set(frame_h,'Maximized',1)
    saveas(gcf,outfile)
catch error
    
end

if exist('error','var')
    saveas(gcf,outfile)
end
close all