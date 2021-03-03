function [GE,kden] = ComputeGraph_in(vec)


%% Extract Info
[Lvec] = length(vec);
proper_dim = sqrt(Lvec);


%% Compute GTM

% Reshape network as a matrix
network = reshape(vec(:),proper_dim,proper_dim);

% Remove links between nodes with themselves to compute the meas
network = network - eye(proper_dim);

% #Integrative Global Measure - Global Efficiency Computation:
GE = efficiency_bin(network,0);

% Measures of centrality: Density
kden = density_und(network);


end