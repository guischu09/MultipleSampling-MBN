
function [output,setup] = BuildNetwork(DATA,setup)

%% Run MS scheme:
[output] = ComputeMS(DATA,setup);

%% Compute Representative Network:

if isfield(setup,'ComputeNclosests')
    if setup.ComputeNclosests && ~strcmp(setup.criteria_representation,'mode')
        [output] = GetNclosests(output,setup);
    else
        if ~setup.ComputeNclosests
            [output] = GetRepresentative(output,setup);
        else            
            disp('N most similar networks options is not available for this criteria representation. Computing the most similar representation matrix, as if setup.ComputeNclosests = false.')
            setup.ComputeNclosests = false;
            [output] = GetRepresentative(output,setup);
        end
    end
    
else % Default Option
    [output] = GetRepresentative(output,setup);
end


end