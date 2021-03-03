
function [GTM_data,DataHeader,GTM_data2,DataHeader2] = ComputeAllGraphMeasures(output,setup)

%% Lib path
addpath(genpath('2017_01_15_BCT'))

cont = 1;
DataHeader = {'Characteristic_PathLength_bin', ...
    'Global_Efficiency_bin','Average_eccentricity_bin', ....
    'radius_bin','diameter_bin', ...
    'Characteristic_PathLength_wei', ...
    'Global_Efficiency_wei','Average_eccentricity_wei', ....
    'radius_wei','diameter_wei', ...
    'Assortativity_Coefficient_bin','Assortativity_Coefficient_wei', ...
    'Average_Degree','Density','Average_Strength','Average_Clustering_Coefficient_bin', ...
    'Average_Clustering_Coefficient_wei','Small_Worldness', ...,
    'Hierarchy','Synchronization','Average_RichClub', 'Classes'};

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
        
        % Binary distance matrix
        D_bin = distance_bin(network~= 0);
        
        % Weighted distance matrix
        D_wei = distance_wei(network);
        
        %Some binary measures
        [charPath_bin,GE_bin,ecc_bin,radius_bin,diameter_bin] = charpath(D_bin);
        avg_ecc_bin = mean(ecc_bin);
        
        %Some weighted measures:
        [charPath_wei,GE_wei,ecc_wei,radius_wei,diameter_wei] = charpath(D_wei);
        avg_ecc_wei = mean(ecc_wei);
        
        % Weighted binary
        AssortativityCoeff_bin = assortativity_bin(network,0);        
        % Weighted
        AssortativityCoeff_wei = assortativity_wei(network,0);
        
        % Measures of centrality: Degrees
        [deg] = mean(degrees_und(network));
        
        % Measures of centrality: Density
        kden = density_und(network);
        
        % Average strength
        strength = mean(strengths_und(network));
        
        % Segregative Local Measure: clustering coefficient
        C_bin = mean(clustering_coef_bu(network~= 0));
        
        C_wei = mean(clustering_coef_wu(network));
        
        % Small Worldness:
        [S] = ComputeSmallWorldness(network);
        
        Hierarchy = gretna_hierarchy(network,100);
        Hierarchy = Hierarchy.rand;
        
        sync = gretna_synchronization(network, 100);
        sync = mean(sync.rand);
        
        r_club_bin = mean(rich_club_bu(network ~= 0),'omitnan');
%         
       
                                
        GTM_data{cont,1} = charPath_bin;
        GTM_data{cont,2} = GE_bin;
        GTM_data{cont,3} = avg_ecc_bin;
        GTM_data{cont,4} = radius_bin;
        GTM_data{cont,5} = diameter_bin;
        GTM_data{cont,6} = charPath_wei;
        GTM_data{cont,7} = GE_wei;
        GTM_data{cont,8} = avg_ecc_wei;
        GTM_data{cont,9} = radius_wei;
        GTM_data{cont,10} = diameter_wei;
        GTM_data{cont,11} = AssortativityCoeff_bin;
        GTM_data{cont,12} = AssortativityCoeff_wei;
        GTM_data{cont,13} = deg;
        GTM_data{cont,14} = kden;
        GTM_data{cont,15} = strength;
        GTM_data{cont,16} = C_bin;
        GTM_data{cont,17} = C_wei;
        GTM_data{cont,18} = S;
        GTM_data{cont,19} = Hierarchy;
        GTM_data{cont,20} = sync;
        GTM_data{cont,21} = r_club_bin;
        GTM_data{cont,22} = class;
        
        GTM_data2{cont2 +1,1} = charPath_bin;
        GTM_data2{cont2 + rangeK + 2, n} = GE_bin;
        GTM_data2{cont2 + 2*rangeK + 3, n} = avg_ecc_bin;
        GTM_data2{cont2 + 3*rangeK + 4, n} = radius_bin;
        GTM_data2{cont2 + 4*rangeK+5,n} = diameter_bin;
        GTM_data2{cont2 + 5*rangeK+6,n} = charPath_wei;
        GTM_data2{cont2 + 6*rangeK+7,n} = GE_wei;
        GTM_data2{cont2 + 7*rangeK+8,n} = avg_ecc_wei;
        GTM_data2{cont2 + 8*rangeK+9,n} = radius_wei;
        GTM_data2{cont2 + 9*rangeK+10,n} = diameter_wei;
        GTM_data2{cont2 + 10*rangeK+11,n} = AssortativityCoeff_bin;
        GTM_data2{cont2 + 11*rangeK+12,n} = AssortativityCoeff_wei;
        GTM_data2{cont2 + 12*rangeK+13,n} = deg;
        GTM_data2{cont2 + 13*rangeK+14,n} = kden;
        GTM_data2{cont2 + 14*rangeK+15,n} = strength;
        GTM_data2{cont2 + 15*rangeK+16,n} = C_bin;
        GTM_data2{cont2 + 16*rangeK+17,n} = C_wei;
        GTM_data2{cont2 + 17*rangeK+18,n} = S;
        GTM_data2{cont2 + 18*rangeK+19,n} = Hierarchy;
        GTM_data2{cont2 + 19*rangeK+20,n} = sync;
        GTM_data2{cont2 + 20*rangeK+21,n} = r_club_bin;
        GTM_data2{cont2 + 21*rangeK+22,n} = class;
        
        
        if cont == 1
            
            GTM_data2{cont +1,1} = 'Characteristic_PathLength_bin';
            GTM_data2{cont + rangeK + 2, n} = 'Global_Efficiency_bin';
            GTM_data2{cont + 2*rangeK + 3, n} = 'Average_eccentricity_bin';
            GTM_data2{cont + 3*rangeK + 4, n} = 'radius_bin';
            GTM_data2{cont + 4*rangeK+5,n} = 'diameter_bin';
            GTM_data2{cont + 5*rangeK+6,n} = 'Characteristic_PathLength_wei';
            GTM_data2{cont + 6*rangeK+7,n} = 'Global_Efficiency_wei';
            GTM_data2{cont + 7*rangeK+8,n} = 'Average_eccentricity_wei';
            GTM_data2{cont + 8*rangeK+9,n} = 'radius_wei';
            GTM_data2{cont + 9*rangeK+10,n} = 'diameter_wei';
            GTM_data2{cont + 10*rangeK+11,n} = 'Assortativity_Coefficient_bin';
            GTM_data2{cont + 11*rangeK+12,n} = 'Assortativity_Coefficient_wei';
            GTM_data2{cont + 12*rangeK+13,n} = 'Average_Degree';
            GTM_data2{cont + 13*rangeK+14,n} = 'Density';
            GTM_data2{cont + 14*rangeK+15,n} = 'Average_Strength';
            GTM_data2{cont + 15*rangeK+16,n} = 'Average_Clustering_Coefficient_bin';
            GTM_data2{cont + 16*rangeK+17,n} = 'Average_Clustering_Coefficient_wei';
            GTM_data2{cont + 17*rangeK+18,n} = 'Small_Worldness';
            GTM_data2{cont + 18*rangeK+19,n} = 'Hierarchy';
            GTM_data2{cont + 19*rangeK+20,n} = 'Synchronization';
            GTM_data2{cont + 20*rangeK+21,n} = 'Average_RichClub';
            
            
        end
        
        cont2 = cont2 + 1;
        cont = cont + 1;
        
    end
end

end