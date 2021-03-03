function [edge_combination1,edge_combination2] = FindBinsDegreeDistribution(Nnonrep,Nnodes)

%% Allocate memory

edge_combination1 = zeros(Nnonrep,2);
edge_combination2 = zeros(Nnonrep,2);


%% Define bins

cont2 = 1;
for n = 1:Nnodes
    cont_aux = n + 1;
    while cont_aux <= Nnodes
        edge_combination1(cont2,:) = [n cont_aux];
        edge_combination2(cont2,:) = [cont_aux n];
        cont_aux = cont_aux + 1;
        cont2 = cont2 + 1;
    end
end

end