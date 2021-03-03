function PlotLocal_GraphMeasures(Labels,Groups,Local_GTM_data,OutFormat)

OutLocalGTM = fullfile(pwd,'Results','Local_Graph_Measures');
if ~exist(OutLocalGTM,'dir')
    mkdir(OutLocalGTM)
end

Measures = {'Degree','Strength','Local-Efficiency','Betweeness-Centrality'};
Nmeasures = 4;

for r = 1:length(Labels)
    cont = 1;
        figure('Visible','Off')
%     figure('units','normalized','outerposition',[0 0 1 1])
    for meas = 1:Nmeasures
        
        % Select all indices belonging to a Label
        Roi_idx = strcmp(Local_GTM_data(:,6),Labels{r});
        
        GroupCell = Local_GTM_data(Roi_idx,7);
        
        MeasuresVec = cell2mat(Local_GTM_data(Roi_idx,meas));
        
        subplot(Nmeasures,1,cont)
        boxplot(MeasuresVec,GroupCell)        
        
        ylabel(Measures{meas})
        
        cont = cont + 1;
    end
    saveas(gcf,strcat(OutLocalGTM,'/Boxplot_',Labels{r},'.',OutFormat))
    
end

close all
end