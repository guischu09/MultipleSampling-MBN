
function [corr_index,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = ComputeRepresentativeNetwork(DATA_r,DATA_pval,DATA_r_corrected,DATA_pval_corrected,setup)

%% data info:
[Nrow,Nsamples,Nclass] = size(DATA_r);

%% Allocate Memory:
RealMeanCorr = zeros(Nrow,Nclass);
corr_index = zeros(1,Nclass);
r_vector = zeros(Nrow,Nclass);
pval_vector = zeros(Nrow,Nclass);
dim = sqrt(Nrow);
r_RepresentativeMatrix = zeros(dim,dim,Nclass);
pval_RepresentativeMatrix = zeros(dim,dim,Nclass);

%% Run code

if isfield(setup,'criteria_representation')
    
    switch setup.criteria_representation
        
        case 'mean'
            
            for u = 1:Nclass
                RealMeanCorr(:,u) = mean(DATA_r(:,:,u),2,'omitnan');
                
                diff = DATA_r(:,:,u)-RealMeanCorr(:,u);
                dist = sqrt(sum(diff.^2,1));
                corr_index(u) = find(dist == min(dist),1);
                
                r_vector = DATA_r_corrected(:,corr_index(u),u);
                pval_vector = DATA_pval_corrected(:,corr_index(u),u);
                
                r_RepresentativeMatrix(:,:,u) = reshape(r_vector,dim,dim);
                pval_RepresentativeMatrix(:,:,u) = reshape(pval_vector,dim,dim);
                
            end
            
        case 'median'
            
            for u = 1:Nclass
                RealMeanCorr(:,u) = median(DATA_r(:,:,u),2,'omitnan');
                
                diff = DATA_r(:,:,u)-RealMeanCorr(:,u);
                dist = sqrt(sum(diff.^2,1));
                corr_index(u) = find(dist == min(dist),1);
                
                r_vector = DATA_r_corrected(:,corr_index(u),u);
                pval_vector = DATA_pval_corrected(:,corr_index(u),u);
                
                r_RepresentativeMatrix(:,:,u) = reshape(r_vector,dim,dim);
                pval_RepresentativeMatrix(:,:,u) = reshape(pval_vector,dim,dim);
                
            end
            
        case 'mode'
            
            [argmax,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = DensityMatrix(DATA_r,DATA_r_corrected,DATA_pval_corrected);
            corr_index = argmax;
            
            
        case 'Geodesic'
            
            % Mean and geodesic
            Real_meas_mats = zeros(dim,dim,Nclass);
            
            for u = 1:Nclass
                RealMeanCorr(:,u) = mean(DATA_r(:,:,u),2,'omitnan');
                Real_meas_mats(:,:,u) = reshape(RealMeanCorr(:,u),dim,dim);
            end
            
            for u = 1:Nclass
                mats_cell{u} = Real_meas_mats(:,:,u);
            end
            
            % Compute Geodesic distances
            geo_dists = zeros(Nclass,Nsamples);
            
            for u = 1:Nclass
                for vv = 1:Nsamples
                    Q1 = reshape(DATA_r(:,vv,u),dim,dim);
                    
                    % Regularize matrices equally
                    [reg_mats_cell,tau] = RegularizeNMatrices({mats_cell{u},Q1});
                    geo_dists(u,vv) = f_dist_geodesic(reg_mats_cell{1},reg_mats_cell{2});
                end
            end
            
            min_dist = min(geo_dists,[],2);
            
            for u = 1:Nclass
                corr_index(u) = find(geo_dists(u,:) == min_dist(u),1);               
                
                r_vector = DATA_r_corrected(:,corr_index(u),u);
                pval_vector = DATA_pval_corrected(:,corr_index(u),u);
                
                r_RepresentativeMatrix(:,:,u) = reshape(r_vector,dim,dim);
                pval_RepresentativeMatrix(:,:,u) = reshape(pval_vector,dim,dim);
            end
            
    end
    
    
else
    % Default: Density
    [argmax,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = DensityMatrix(DATA_r,DATA_r_corrected,DATA_pval_corrected);
    corr_index = argmax;
    
end
end




