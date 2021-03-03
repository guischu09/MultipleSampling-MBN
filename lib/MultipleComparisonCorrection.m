function [r_corrected_Data,pval_corrected_Data] = MultipleComparisonCorrection (r_Data,pval_Data,setup)

if isfield(setup,'correction_type')
    
    switch setup.correction_type
        
        case 'FDR'
            [qval] = mafdr(pval_Data(:),'BHFDR', 'true');
            logic_vec = qval<setup.alpha;
            r_corrected_Data = reshape(r_Data(:) .* logic_vec,size(r_Data,1),size(r_Data,2)) + eye(size(r_Data,1));
            r_corrected_Data(r_corrected_Data<setup.thresh) = 0;
            pval_corrected_Data = reshape(qval,size(r_Data,1),size(r_Data,2)) - eye(size(r_Data,1));
            
        case 'Bonferroni'
            [qval, ~] = bonf_holm(pval_Data(:),setup.alpha);
            logic_vec = qval < setup.alpha;
            r_corrected_Data = reshape(r_Data(:) .* logic_vec,size(r_Data,1),size(r_Data,2))+ eye(size(r_Data,1));
            r_corrected_Data(r_corrected_Data<setup.thresh) = 0;
            pval_corrected_Data = reshape(qval,size(r_Data,1),size(r_Data,2)) - eye(size(r_Data,1));
    end
else
    % Default FDR
    [qval] = mafdr(pval_Data(:),'BHFDR', 'true');
    logic_vec = qval<setup.alpha;
    r_corrected_Data = reshape(r_Data(:) .* logic_vec,size(r_Data,1),size(r_Data,2)) + eye(size(r_Data,1));
    r_corrected_Data(r_corrected_Data<setup.thresh) = 0;
    pval_corrected_Data = reshape(qval,size(r_Data,1),size(r_Data,2)) - eye(size(r_Data,1));
    
end

end