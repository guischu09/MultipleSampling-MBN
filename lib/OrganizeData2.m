
function [M] = OrganizeData2(DATA_r)

[lenVec,Nsamples,Nclasses] = size(DATA_r);
dim = sqrt(lenVec);
M = zeros(dim,dim,Nsamples,Nclasses);

for u = 1:Nsamples
    for v = 1:Nclasses
        M(:,:,u,v) = reshape(DATA_r(:,u,v),dim,dim);        
    end
end
end
