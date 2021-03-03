function SW = ComputeSmallWorldness(ADJ)

n = size(ADJ,1);  % number of nodes
k = sum(ADJ);  % degree distribution of undirected network
m = sum(k)/2;
K = mean(k); % mean degree of network

%% computing small-world-ness using the analytical approximations for the E-R graph

[expectedC,expectedL] = ER_Expected_L_C(K,n);  % L_rand and C_rand

[SW,~,~] = small_world_ness(ADJ,expectedL,expectedC,1);  % Using WS clustering coefficient


% [Lrand,CrandWS] = NullModel_L_C(n,m,Num_ER_repeats,FLAG_Cws);


end