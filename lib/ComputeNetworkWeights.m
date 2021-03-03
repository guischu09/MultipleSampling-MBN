

function [coeff, pvalue] = ComputeNetworkWeights(data,setup)

if isfield(setup,'weights')
    
    switch setup.weights
        
        case 'PearsonCorrelation'
            
            [coeff, pvalue] = corr(data,'Type','Pearson');
            
        case 'SpearmanCorrelation'
            
            [coeff, pvalue] = corr(data,'Type','Spearman');
            
        case 'KendallCorrelation'
            
            [coeff, pvalue] = corr(data,'Type','Kendall');
            
        %case 'PartialCorrelation'
            
            %[coeff, pvalue] = partialcorr(data);
            
        %case 'MutualInformation'
            
            
    end
    
else
    % Default: Pearson correlation
    [coeff, pvalue] = corr(data,'Type','Pearson');
    
end

end



