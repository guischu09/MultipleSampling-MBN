function PlotNets(output,setup,Labels,atlas_filename,CoordsFilename,clobber)


%% Create/delete Directories:

% Output folder: where raw (i.e. csv files) will be saved
outputFd = fullfile(pwd,'output');

if ~exist(outputFd,'dir')
    mkdir(outputFd)
else
    if clobber
        rmdir(outputFd,'s')
        mkdir(outputFd)
    end
end

prefix = strcat(setup.balanced,'_',setup.correction_type,'=',num2str(setup.alpha));
SubDir = fullfile(outputFd,prefix);

if ~exist(SubDir ,'dir')
    mkdir(SubDir)
end

% Results folder: where 'publishable' like plots will be saved
ResultsFd = fullfile(pwd,'Results');

if ~exist(ResultsFd,'dir')
    mkdir(ResultsFd)
else
    if clobber
        rmdir(ResultsFd,'s')
        mkdir(ResultsFd)
    end
end

SubDir2 = fullfile(ResultsFd,prefix);

if ~exist(SubDir2,'dir')
    mkdir(SubDir2)
end

%% Compute Global Graph Measures:

disp('Computing global graph measures ... ')

[GTM_data,DataHeader,GTM_data2,DataHeader2] = ComputeGraphMeasures4Plot(output,setup);

% Save measures in .csv
GTM_table = cell2table(GTM_data,'VariableNames',DataHeader);
GraphMeasuresFile = fullfile(SubDir,strcat('GraphMeasures_python.csv'));
writetable(GTM_table,GraphMeasuresFile)

% Save measures in .csv
GTM_table2 = cell2table(GTM_data2,'VariableNames',DataHeader2);
GraphMeasuresFile2 = fullfile(SubDir,strcat('GraphMeasures_prism.csv'));
writetable(GTM_table2,GraphMeasuresFile2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Compute many more Graph Measures:
% [GTM_data,DataHeader,GTM_data2,DataHeader2] = ComputeAllGraphMeasures(output,setup);
% 
% % Save measures in .csv
% GTM_table = cell2table(GTM_data,'VariableNames',DataHeader);
% GraphMeasuresFile = fullfile(SubDir,strcat('all_GraphMeasures_python.csv'));
% writetable(GTM_table,GraphMeasuresFile)
% 
% % Save measures in .csv
% GTM_table2 = cell2table(GTM_data2,'VariableNames',DataHeader2);
% GraphMeasuresFile2 = fullfile(SubDir,strcat('all_GraphMeasures_prism.csv'));
% writetable(GTM_table2,GraphMeasuresFile2)

%% Plot

% Plot boxplot with seaborn lib in python
pyFilename= fullfile(pwd,'lib','plot_GraphMeasures.py');

for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};
    
    [command2] = BoxplotPyCommand(pyFilename,GraphMeasuresFile, ...
        strcat('.',OutputFormat), SubDir2);
    o = system(command2);
end


%% Compute Local Graph Measures

[GTM_data,DataHeader] = ComputeLocalGraphMeasures(output,setup,Labels);
Groups = output.DATA(:,2);
for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
    OutFormat = setup.OUTPUT_FOMAT_VEC{forMat};
    PlotLocal_GraphMeasures(Labels,Groups,GTM_data,OutFormat)
end

% Save measures in .csv
GTM_table = cell2table(GTM_data,'VariableNames',DataHeader);
GraphMeasuresFile = fullfile(SubDir,strcat('LocalGraphMeasures.csv'));
writetable(GTM_table,GraphMeasuresFile)

disp(['Done! Check graph measures at: ' outputFd])

disp('Plotting networks ... ')

for u = 1:size(output.DATA,1)
    
    %% Save CSV Corr Matrix File
    
    if isfield(setup,'plotMatrix')
        
        switch setup.plotMatrix
            
            case 'MS_Scheme'
                
                r_table = array2table(output.r_RepresentativeMatrix(:,:,u),'RowNames',Labels,'VariableNames',Labels);
                inMat = output.r_RepresentativeMatrix;
                out_f = strcat(output.DATA{u,2}, '_RepresentativeMatrix.csv');
                outputFilename = fullfile(SubDir,out_f);
                writetable(r_table,outputFilename,'WriteRowNames',true)
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                    
                    if setup.interactive                    
                        pythonFilename1 = fullfile(pwd,'lib','interactscript_mayavi.py'); 
                    else
                        pythonFilename1 = fullfile(pwd,'lib','plotscript_mayavi.py');
                    end
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};
                    
                    command1 = python_plot_mayavi(pythonFilename1,inMat,atlas_filename,CoordsFilename,OutputFormat, SubDir2, setup.brain_type, outputFilename,'jet',setup);
                    
                    o = system(command1);
                    
                end
                
            case 'Conventional'
                
                r_table = array2table(output.NormalNetworks(:,:,u),'RowNames',Labels,'VariableNames',Labels);
                inMat = output.NormalNetworks;
                out_f = strcat(output.DATA{u,2}, '_ConventionalMatrix.csv');
                outputFilename = fullfile(SubDir,out_f);
                writetable(r_table,outputFilename,'WriteRowNames',true)
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                     if setup.interactive                    
                        pythonFilename1 = fullfile(pwd,'lib','interactscript_mayavi.py'); 
                    else
                        pythonFilename1 = fullfile(pwd,'lib','plotscript_mayavi.py');
                    end
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};                    
                                        
                    command1 = python_plot_mayavi(pythonFilename1,inMat,atlas_filename,CoordsFilename,OutputFormat, SubDir2, setup.brain_type, outputFilename,'jet',setup);
                    o = system(command1);
                    
                end
                
                
            case 'Both'
                
                r_table = array2table(output.r_RepresentativeMatrix(:,:,u),'RowNames',Labels,'VariableNames',Labels);                
                inMat = output.r_RepresentativeMatrix;
                out_f = strcat(output.DATA{u,2}, '_RepresentativeMatrix.csv');
                outputFilename = fullfile(SubDir,out_f);
                writetable(r_table,outputFilename,'WriteRowNames',true)
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                     if setup.interactive                    
                        pythonFilename1 = fullfile(pwd,'lib','interactscript_mayavi.py'); 
                    else
                        pythonFilename1 = fullfile(pwd,'lib','plotscript_mayavi.py');
                    end
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};                    
                    
                    
                    command1 = python_plot_mayavi(pythonFilename1,inMat,atlas_filename,CoordsFilename,OutputFormat, SubDir2, setup.brain_type, outputFilename,'jet',setup);
                    o = system(command1);
                    
                end
                
                r_table = array2table(output.NormalNetworks(:,:,u),'RowNames',Labels,'VariableNames',Labels);                
                inMat = output.NormalNetworks;
                out_f = strcat(output.DATA{u,2}, '_ConventionalMatrix.csv');
                outputFilename = fullfile(SubDir,out_f);
                writetable(r_table,outputFilename,'WriteRowNames',true)
                
                for forMat = 1:length(setup.OUTPUT_FOMAT_VEC)
                     if setup.interactive                    
                        pythonFilename1 = fullfile(pwd,'lib','interactscript_mayavi.py'); 
                    else
                        pythonFilename1 = fullfile(pwd,'lib','plotscript_mayavi.py');
                    end
                    OutputFormat = setup.OUTPUT_FOMAT_VEC{forMat};

                    
                    command1 = python_plot_mayavi(pythonFilename1,inMat,atlas_filename,CoordsFilename,OutputFormat, SubDir2, setup.brain_type, outputFilename,'jet',setup);
                    o = system(command1);
                    
                end
                
        end
    end
    
end


%% Plot Connectome ring using the code from: https://github.com/paul-kassebaum-mathworks/circularGraph

parfeval(@plot_circle_background,0,setup,output,SubDir)



%% Save setup information:
SaveAnalysisSetup(SubDir,SubDir2,setup)

disp(['Done! Check plots at: ' ResultsFd])


end
