function [output] = ComputeMS(DATA,setup)

%% Get data info:
% Number of volumes of interest
[Nvois] = size(DATA{1,1},2);
% Number of classes/groups
Nclasses = size(DATA,1);
% Number of unique values in MBN network
Nnonrep = Nvois*(Nvois-1)/2;
% Length of Nsamplings vector
Nsub_vec = length(setup.Nsamplings_vector);

%% Allocate Memory
degreeDistribution = zeros(Nnonrep,Nclasses,Nsub_vec);
weightsDistribution = zeros(setup.nbins,Nclasses,Nsub_vec);

%% Compute MRS:
cont = 1;

% Iterate over all samplings in Nsub_vec
for u = 1:Nsub_vec
    % Get number of samplings from input setup
    Nsampling = setup.Nsamplings_vector(u);
    
    % Run MS scheme
    [Pmap,~,degreeDistribution(:,:,cont),weightsDistribution(:,:,cont),DATA_r, ...
        DATA_r_corrected,DATA_pval,DATA_pval_corrected,ModifiedDATA] ...
        = MultipleSamplingScheme(DATA,setup,Nsampling);
end

%% Probability map correction

% Generate binary map
BinaryMap = Pmap>=setup.ptresh;

% Apply Treshold with Probability Map to all generated matrices:
for n = 1:Nclasses
    tempBinaryMapGroup = BinaryMap(:,:,n);
    DATA_r_corrected(:,:,n) = bsxfun(@times,DATA_r_corrected(:,:,n),tempBinaryMapGroup(:));
end


%% Set Output

output.DATA_r = DATA_r;
output.DATA_r_corrected = DATA_r_corrected;
output.DATA_pval = DATA_pval;
output.DATA_pval_corrected = DATA_pval_corrected;
output.DATA = DATA;
output.ModifiedDATA = ModifiedDATA;
output.BinaryMap = BinaryMap;
output.Pmap = Pmap;


end



