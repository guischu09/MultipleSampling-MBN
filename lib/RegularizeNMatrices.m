
function [reg_mats_cell,tau] = RegularizeNMatrices(mats_cell)

tau = 0;
Nmats = length(mats_cell);
flag = zeros(Nmats,1);
dim = size(mats_cell{1},1);

for u = 1:Nmats
    [~,flag(u)] = chol(mats_cell{u});        
end

while any(flag)

    for v = 1:Nmats
        mats_cell{v} = mats_cell{v} + tau*eye(dim);
        [~,flag(v)] = chol(mats_cell{v});        
    end
        
    if any(flag)
        tau = tau + 0.1;
    end
end

reg_mats_cell = cell(Nmats,1);

for u = 1:Nmats
    reg_mats_cell{u} = mats_cell{u};
end

