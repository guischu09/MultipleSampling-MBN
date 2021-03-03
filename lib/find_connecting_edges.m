function [s,t] = find_connecting_edges(vicinity_graph)

Nnodes = length(vicinity_graph);
E = zeros(Nnodes^2,2);

cont = 1;

for i = 1:Nnodes
    for j = 1:length(vicinity_graph{i})
        
        E(cont,:) = [i,vicinity_graph{i}(j)];
        cont = cont + 1;
        
    end
end

if exist('E','var')
    E = sort(E,2);
    E = unique(E,'rows','stable');
    E = E(1:end-1,:);
    s = E(:,1); t = E(:,2);
    
else
    E = [0 0];
    s = E(:,1); t = E(:,2);
end

end