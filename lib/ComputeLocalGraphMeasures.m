
function [GTM_data,DataHeader] = ComputeLocalGraphMeasures(output,setup,Labels)

%% Lib path
addpath(genpath('2017_01_15_BCT'))

cont = 1;
DataHeader = {'Degree','Strength','Local_Efficiency','Betweenness_Centrality','Flow_coefficient', 'ROIs', 'Classes'};

for n = 1:size(output.DATA,1)
    
    class = output.DATA{n,2};    
    
    if isfield(setup,'ComputeNclosests')
        if setup.ComputeNclosests && ~strcmp(setup.criteria_representation,'mode')
            nets = output.DATA_r_corrected_NClosests(:,:,n);
        else
            nets = output.DATA_r_corrected(:,:,n);
        end
    else
        nets = output.DATA_r_corrected(:,:,n);
    end
        
    %% Extract Info
    [Lvec,rangeK] = size(nets);
    proper_dim = sqrt(Lvec);
    
    %% Allocate Memory
   
    if n == 1
        GTM_data = cell(rangeK*size(output.DATA,1)*length(Labels),7);
        TotalWait = size(GTM_data,1);
    end
    
    %% Compute GTM
        
    for k = 1:rangeK
        
        % Reshape network as a matrix
        network = reshape(nets(:,k),proper_dim,proper_dim);
        
        % Remove links between nodes with themselves to compute the meas
        network = network - eye(proper_dim);
        
        % Degree:        
        [deg] = degrees_und(network)';
        
        % Strength
        [str] = strengths_und(network)';
        
        % Local Efficiency
        LE = efficiency_bin(network,1);
        
        % Betweeness Centrality
        BC = betweenness_wei(network)';
        
        % Flow 
        [fc,~,~] = flow_coef_bd(network);
            
        for qq = 1:length(deg)
            
            textwaitbar(cont,TotalWait,'Computing local graph measures')
            
            GTM_data{cont,1} = deg(qq);
            GTM_data{cont,2} = str(qq);
            GTM_data{cont,3} = LE(qq);
            GTM_data{cont,4} = BC(qq);
            GTM_data{cont,5} = fc(qq);
            GTM_data{cont,6} = Labels{qq};
            GTM_data{cont,7} = class;
            
            cont = cont + 1;
            
        end
        

        
    end
end

end