
function [corrMat_index,corr_index,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = ComputeNClosestsNetworks(DATA_r,DATA_pval,DATA_r_corrected,DATA_pval_corrected,setup)

%% data info:
[Nrow,~,Nclass] = size(DATA_r);

%% Allocate Memory:
RealMeanCorr = zeros(Nrow,Nclass);
corr_index = zeros(1,Nclass);
r_vector = zeros(Nrow,Nclass);
pval_vector = zeros(Nrow,Nclass);
dim = sqrt(Nrow);
r_RepresentativeMatrix = zeros(dim,dim,Nclass);
pval_RepresentativeMatrix = zeros(dim,dim,Nclass);
corrMat_index = zeros(setup.NClosests,Nclass);

%% Run code

if isfield(setup,'criteria_representation')
    
    switch setup.criteria_representation
        
        case 'mean'
            
            for u = 1:Nclass
                RealMeanCorr(:,u) = mean(DATA_r(:,:,u),2,'omitnan');
                
                diff = DATA_r(:,:,u)-RealMeanCorr(:,u);
                dist = sqrt(sum(diff.^2,1));
                
                dsorted = sort(dist);
                idxs = ismember(dist,dsorted(1:setup.NClosests));
                temp = find(idxs);                
                corrMat_index(:,u) = temp(1:setup.NClosests);
                
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
                
                dsorted = sort(dist);
                idxs = ismember(dist,dsorted(1:setup.NClosests));
                corrMat_index(:,u) = find(idxs);
                
                corr_index(u) = find(dist == min(dist),1);
                
                r_vector = DATA_r_corrected(:,corr_index(u),u);
                pval_vector = DATA_pval_corrected(:,corr_index(u),u);
                
                r_RepresentativeMatrix(:,:,u) = reshape(r_vector,dim,dim);
                pval_RepresentativeMatrix(:,:,u) = reshape(pval_vector,dim,dim);
                
            end
            
        case 'mode'
            
            [argmax,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = DensityMatrix(DATA_r,DATA_r_corrected,DATA_pval_corrected);
            corr_index = argmax;
            
            
            
    end
else
    % Default: Density
    [argmax,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = DensityMatrix(DATA_r,DATA_r_corrected,DATA_pval_corrected);
    corr_index = argmax;
    
end




end




