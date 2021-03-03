
function [Weights] = ComputeWeights(DATA_r)

Weights = zeros(size(DATA_r,2),size(DATA_r,3));

for c = 1:size(DATA_r,3)
    [~, ~, u] = unique(transpose(DATA_r(:,:,c)), 'rows','stable');
    contagem = histc(u, 1:max(u));
    Weights(:,c) = contagem(u);
end


end