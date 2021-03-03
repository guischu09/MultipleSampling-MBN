function [argmax,r_vector,pval_vector,r_RepresentativeMatrix,pval_RepresentativeMatrix] = DensityMatrix(DATA_r,DATA_r_corrected,DATA_pval_corrected)
%% get info
[Nrow,Nsamples,Nclasses] = size(DATA_r);

%% Allocate Memory

argmax = zeros(Nclasses,1);
r_vector = zeros(Nrow,Nclasses);
pval_vector = zeros(Nrow,Nclasses);
dim = sqrt(Nrow);
r_RepresentativeMatrix = zeros(dim,dim,Nclasses);
pval_RepresentativeMatrix = zeros(dim,dim,Nclasses);


[Data] = OrganizeData2(DATA_r);
P = zeros(Nsamples,1);
gaussian_mixture = zeros(size(Data,3),1);


[weights] = ComputeWeights(DATA_r);

for u = 1:Nclasses
    for q = 1:Nsamples
        MeanMat = Data(:,:,q,u);
        for j = 1:Nsamples
            EvalMat = Data(:,:,j,u);
            P(j) = GaussianMatrixDistribution(EvalMat,MeanMat);
        end
        gaussian_mixture = P.*weights(q,u) + gaussian_mixture;
    end
    
    posterior = gaussian_mixture;
    
    %Normalize Posterior:
    posterior = posterior/sum(posterior);
    
    % Maximum aposteriori:
    [~, argmax(u)] = max(posterior);
    
    r_temp = reshape(DATA_r_corrected(:,argmax(u),u),dim,dim);
    pval_temp= reshape(DATA_pval_corrected(:,argmax(u),u),dim,dim);
           
    r_RepresentativeMatrix(:,:,u) = r_temp;
    pval_RepresentativeMatrix(:,:,u) = pval_temp;

    r_vector(:,u) = r_temp(:);
    pval_vector(:,u) = pval_temp(:);      
    
end