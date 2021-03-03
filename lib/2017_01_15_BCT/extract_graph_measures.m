

function [featVector] = extract_graph_measures(network)

%% Lib path
addpath(genpath('2017_01_15_BCT'))
%%

%Global Efficiency Computation:
GE = efficiency_bin(network,0);

%Mean Local Efficiency Computation:
mLE = mean(efficiency_bin(network,1));

% Degrees
[deg] = mean(degrees_und(network));

% Mean Strenght
[str] = mean(strengths_und(network));

% Density
kden = density_und(network);

% clustering coefficient
C = mean(clustering_coef_bu(network));

% transitivity
% T = transitivity_wu(network);

% Diffusion Efficiency
% [GEdiff] = diffusion_efficiency(network);

% featVector = [GE,mLE,deg,str,kden,C,T,GEdiff];
featVector = [GE,mLE,deg,str,kden,C];


end