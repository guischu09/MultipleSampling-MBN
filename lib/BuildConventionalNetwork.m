

function [NormalNetworks] = BuildConventionalNetwork(DATA,setup)

    Ngroups = size(DATA,1);    
    [Nrows, Ncols] = size(DATA{1,1});
    NormalNetworks = zeros(Ncols,Ncols,Ngroups);
    
    for u = 1:Ngroups
        
        [r_Data, pval_Data] = corr(DATA{u,1});
        [r_matrix,~] = MultipleComparisonCorrection(r_Data,pval_Data,setup);
        
        r_matrix(r_matrix<setup.thresh) = 0;
        NormalNetworks(:,:,u) = r_matrix;
        
    end

end