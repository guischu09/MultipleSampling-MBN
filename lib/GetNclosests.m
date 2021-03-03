function [output_updated] = GetNclosests(output,setup)

%% Compute N most similar networks to the real criteria representation network
[corrMat_index, corr_index,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] ...
    = ComputeNClosestsNetworks(output.DATA_r,output.DATA_pval,output.DATA_r_corrected, ...
    output.DATA_pval_corrected,setup);

%% Get the N most similar networks to the representative network :
Nclasses = size(output.DATA_r,3);
Ndim = size(output.DATA_r_corrected,1);

if isfield(setup,'ComputeNclosests')
    if setup.ComputeNclosests
        % Allocate Memory
        DATA_r_corrected_NClosests = zeros(Ndim,setup.NClosests,Nclasses);
        
        for u = 1:Nclasses
            for v = 1:setup.NClosests
                DATA_r_corrected_NClosests(:,v,u) = output.DATA_r_corrected(:,corrMat_index(v,u),u);
            end
        end
        
    end
end

%% Get dataset associated with the representative matrix:
% Allocate Memory
ModifiedDATA_Representative = cell(Nclasses,1);

% Iterate over classes
for u = 1:Nclasses
    ModifiedDATA_Representative{u} = output.ModifiedDATA{corr_index(u),u,1};
end

%% Set output

output_updated = output;
output_updated.corr_index = corr_index;
output_updated.r_vector = r_vector;
output_updated.pval_vector = pval_vector;
output_updated.r_RepresentativeMatrix = r_RepresentativeMatrix;
output_updated.pval_RepresentativeMatrix = pval_RepresentativeMatrix;
output_updated.ModifiedDATA_Representative = ModifiedDATA_Representative;
output_updated.DATA_r_corrected_NClosests = DATA_r_corrected_NClosests;

end

