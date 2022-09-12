function dG = f_dist_geodesic(Q1,Q2)
%% This function can be used to compute Geodesic Distance 
% betweeen two Symmetric Positive Definite (SPD) FCs

Q = Q1\Q2;
e = eig(Q);
dG = sqrt(sum(log(e).^2));

%% Alternate Method (computationally more intensive)
% This approach to compute geodesic distance was proposed by:
% Venkatesh, M., Jaja, J., & Pessoa, L. (2020). 
% Comparing functional connectivity matrices: A geometry-aware approach applied to participant identification. 
% NeuroImage, 207, 116398.


% % Compute Q1^-1/2
% [U,S,V] = svd(Q1);
% s = diag(S);
% 
% if nnz(s<0) > 0
%     disp('negative eigenvalues')
% end
% 
% S = diag(s.^(-1/2));
% Q1_inv_sqrt = U*S*V';
% 
% % Compute Q
% Q = Q1_inv_sqrt*Q2*Q1_inv_sqrt;
% Q = (Q+Q')/2; % Ensure symmetry
% 
% % Compute the geodesic distance
% [~,S,~] = svd(Q);
% s = diag(S);
% dG = sqrt(sum(log(s).^2));

