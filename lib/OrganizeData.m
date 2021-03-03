function [DATA] = OrganizeData(filename)

% Read file
o = importdata(filename);

% Get data
data = o.data;

% Get groups
Groups = o.textdata(2:end,1);

% Get unique groups
[group,~,~] = unique(Groups,'stable');

% Allocate Memory
DATA = cell(length(group),2);

% Organize Data
for g = 1:length(group)
    
    logic_idx = strcmp(Groups,group{g});
    
    DATA{g,1} = data(logic_idx,:);    
    DATA{g,2} = group{g};
    
    
end