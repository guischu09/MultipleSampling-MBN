

function [DownBalancedDataSet] = GenerateDownSampledBalancedDataSet(filename)

[DATA] = OrganizeData(filename);
Nsamples = zeros(size(DATA,1),1);

for u = 1:size(DATA,1)
    
    Nsamples(u) = size(DATA{u,1},1);
    
end

BalancedNsamples = min(Nsamples);
BalancedDATA = cell(size(DATA,1),2);

for n = 1:size(DATA,1)
    
    BalancedDATA{n,2} = DATA{n,2};
    
    NewRows = randperm(size(DATA{n,1},1),BalancedNsamples);
    
    %generate the data using the NewRows
    BalancedDATA{n,1} = DATA{n,1}(sort(NewRows),:);
    
end

DownBalancedDataSet = BalancedDATA;

end