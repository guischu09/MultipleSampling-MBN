
function plot_circle_background(setup, output, SubDir)


if strcmp(setup.WhichPlot,'Heat&Circle')
    
    switch setup.plotMatrix
        
        case 'Conventional'
            
            for c = 1:size(output.DATA,1)
                
                cmapName = strcat(output.DATA{c,2}, '_ConventionalMatrix_heatmap_colors.csv');
                colormap_file = fullfile(SubDir,cmapName);
                
                network = output.NormalNetworks(:,:,c);
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                    
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};
                    circularGraph(network,'colormap',colormap_file,'Label',strrep(Labels,'_','-'));
                    
                    out_circ = strcat(output.DATA{c,2}, '_Conventional', '_circle_plot.',OutputFormat);
                    outputFilename = fullfile(SubDir2,out_circ);
                    %                 figure('units','normalized','outerposition',[0 0 1 1])
                    
                    try
                        frame_h = get(handle(gcf),'JavaFrame');
                        set(frame_h,'Maximized',1)
                        saveas(gcf,outputFilename)
                    catch error
                        
                    end
                    
                    if exist('error','var')
                        saveas(gcf,outputFilename)
                    end
                    close all
                    
                end
                
            end
            
        case 'MS_Scheme'
            
            for c = 1:size(output.DATA,1)
                
                cmapName = strcat(output.DATA{c,2}, '_RepresentativeMatrix_heatmap_colors.csv');
                colormap_file = fullfile(SubDir,cmapName);
                
                network = output.r_RepresentativeMatrix(:,:,c);
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                    
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};
                    circularGraph(network,'colormap',colormap_file,'Label',strrep(Labels,'_','-'));
                    
                    out_circ = strcat(output.DATA{c,2}, '_Representative', '_circle_plot.',OutputFormat);
                    outputFilename = fullfile(SubDir2,out_circ);
                    
                    try
                        frame_h = get(handle(gcf),'JavaFrame');
                        set(frame_h,'Maximized',1);
                        saveas(gcf,outputFilename);
                    catch error
                        
                    end
                    
                    if exist('error','var')
                        saveas(gcf,outputFilename)
                    end
                    close all
                    
                end
                
            end
            
    end
end
