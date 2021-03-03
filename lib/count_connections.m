
function [counts,vicinity_graph,DataMatrix] = count_connections (DataMatrix)

[row,col] = size(DataMatrix);
connections = zeros(1,row);
vicinity_graph = cell(1,row);

for u = 1:row
    connections(u)= length(find(DataMatrix(u,:)))-1;
    
    [idc] = find(DataMatrix(u,:));
    
    logic_vec = idc ~= u;
    
    vicinity_graph{u} = idc(logic_vec);
end

counts = connections;