
function [reg_mat1,reg_mat2,reg_mat3,tau] = RegularizeMatrices(M1,M2,M3)

tau = 2;

reg_mat1 = M1;
reg_mat2 = M2;
reg_mat3 = M3;

[~,flag1] = chol(M1);
[~,flag2] = chol(M2);
[~,flag3] = chol(M3);

while flag1 ~= 0 || flag2 ~= 0 || flag3 ~= 0
    
    reg_mat1 = M1 + tau*eye(size(M1,1));
    reg_mat2 = M2 + tau*eye(size(M2,1));
    reg_mat3 = M3 + tau*eye(size(M3,1));
    
    
    [~,flag1] = chol(reg_mat1);
    [~,flag2] = chol(reg_mat2);
    [~,flag3] = chol(reg_mat3);
        
    if flag1 ~= 0 || flag2 ~= 0 || flag3 ~= 0
        tau = tau + 0.1;
    end
end
