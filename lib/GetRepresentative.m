function [output_updated] = GetRepresentative(output,setup)

%% Compute group representative network

[corr_index,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] ...
    = ComputeRepresentativeNetwork(output.DATA_r,output.DATA_pval,output.DATA_r_corrected, ...
    output.DATA_pval_corrected,setup);

%% Get dataset associated with the representative matrix:
% Get info
Nclasses = size(output.DATA_r,3);

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


end

