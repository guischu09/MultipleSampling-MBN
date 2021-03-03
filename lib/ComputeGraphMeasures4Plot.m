
function [GTM_data,DataHeader,GTM_data2,DataHeader2] = ComputeGraphMeasures4Plot(output,setup)

%% Lib path
addpath(genpath('2017_01_15_BCT'))

cont = 1;
DataHeader = {'Global_Efficiency','Assortativity_Coefficient','Average_Degree','Density','Average_Clustering_Coefficient', 'Small_Worldness', 'Classes'};
DataHeader2 = cell(size(output.DATA,1),1);

for n = 1:size(output.DATA,1)
    
    cont2 = 1;
    
    class = output.DATA{n,2};
    DataHeader2{n} = class;
    
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
        GTM_data = cell(rangeK*size(output.DATA,1),6);
        GTM_data2 = cell(rangeK*6 + 2*6,size(output.DATA,1));
    end
    
    %% Compute GTM
    
    for k = 1:rangeK
        
        % Reshape network as a matrix
        network = reshape(nets(:,k),proper_dim,proper_dim);
        
        % Remove links between nodes with themselves to compute the meas
        network = network - eye(proper_dim);
        
        % #Integrative Global Measure - Global Efficiency Computation:
        GE = efficiency_bin(network,0);
        
        % Global Measure of Resilience:
        AssortativityCoeff = assortativity_wei(network,0);
        
        % Measures of centrality: Degrees
        [deg] = mean(degrees_und(network));
        
        % Measures of centrality: Density
        kden = density_und(network);
        
        % Segregative Local Measure: clustering coefficient
        C = mean(clustering_coef_bu(network));
        
        % Small Worldness:
        [S] = ComputeSmallWorldness(network);
        
        % Vector Containing Measures
        %     featVector(:,k) = [GE,AssortativityCoeff,deg,kden,C,S]';
        
        GTM_data{cont,1} = GE;
        GTM_data{cont,2} = AssortativityCoeff;
        GTM_data{cont,3} = deg;
        GTM_data{cont,4} = kden;
        GTM_data{cont,5} = C;
        GTM_data{cont,6} = S;
        GTM_data{cont,7} = class;
        
            
        GTM_data2{cont2 +1,n} = GE;
        GTM_data2{cont2 + rangeK + 2,n} = AssortativityCoeff;
        GTM_data2{cont2 + 2*rangeK + 3,n} = deg;
        GTM_data2{cont2 + 3*rangeK + 4,n} = kden;
        GTM_data2{cont2 + 4*rangeK + 5,n} = C;
        GTM_data2{cont2 + 5*rangeK + 6,n} = S;
        
        
        
        if cont == 1
            
            GTM_data2{cont,n} = 'Global_Efficiency';
            GTM_data2{cont + rangeK + 1,n} = 'Assortativity_Coefficient';
            GTM_data2{cont + 2*rangeK + 2,n} = 'Average_Degree';
            GTM_data2{cont + 3*rangeK + 3,n} = 'Density';
            GTM_data2{cont + 4*rangeK + 4,n} = 'Average_Clustering_Coefficient';
            GTM_data2{cont + 5*rangeK + 5,n} = 'Small_Worldness';
            
        end
        
        cont2 = cont2 + 1;
        cont = cont + 1;
        
    end
end

end