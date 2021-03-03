
function [Pmap,NonNormalizedEdgesHist,degreeDistribution,weightsDistribution,DATA_r,DATA_r_corrected,DATA_pval,DATA_pval_corrected,PermData_network] = MultipleSamplingScheme(DATA,setup,Nsampling)

%% Get data info:
% Number of volumes of interest
[Nvois] = size(DATA{1,1},2);
% Number of classes/groups
Nclasses = size(DATA,1);
% Number of unique values in MBN network
Nnonrep = Nvois*(Nvois-1)/2;

%% Allocate Memory

DATA_r = zeros(Nvois^2,Nsampling,Nclasses);
DATA_pval = zeros(Nvois^2,Nsampling,Nclasses);

DATA_r_corrected = zeros(Nvois^2,Nsampling,Nclasses);
DATA_pval_corrected = zeros(Nvois^2,Nsampling,Nclasses);

degreeDistribution = zeros(Nnonrep,Nclasses);
NonNormalizedEdgesHist= zeros(Nnonrep,Nclasses);
weightsDistribution = zeros(setup.nbins,Nclasses);

ProbMatGroup = zeros(Nvois,Nvois,Nclasses) + Nsampling*eye(Nvois);
Pmap = zeros(Nvois,Nvois,Nclasses) + Nsampling*eye(Nvois);

PermData_network = cell(Nsampling,Nclasses,2);

%% Find bins of histogram
[edge_combination1,edge_combination2] = FindBinsDegreeDistribution(Nnonrep,Nvois);

%% Perform Random Sampling

TotalWait = Nclasses * Nsampling;
Waitcount = 1;

for n = 1:Nclasses
    % Get info
    [nrows] = size(DATA{n,1},1);

    for k = 1:Nsampling
        
        textwaitbar(Waitcount,TotalWait,'Computing MBNs')
        Waitcount = Waitcount + 1;
        
        % Check is subsampling or bootstrap will be computed
        if isfield(setup,'randomType')
            switch setup.randomType
                
                case 'Bootstrap'
                    % Bootstrap Indices (i.e. random select repeated indices within some interval)
                    NewRows = randi(nrows,[nrows,1]);
                    
                case 'Subsampling'
                    %generate a random value between [min_remov max_remov]
                    prop = setup.min_remov + (setup.max_remov-setup.min_remov).*rand(1);
                    % generate the number of rows to remove
                    NumRemove = round(prop*nrows);
                    %generate the rows that will be used for sample the new data
                    NewRows = randperm(nrows,nrows-NumRemove);
            end
            
        else
            % Default: Bootstrap
            NewRows = randi(nrows,[nrows,1]);

        end
        
        %generate the data using the NewRows
        GenData = DATA{n,1}(sort(NewRows),:);
        
        %compute network weights
        [measure, pvalue] = ComputeNetworkWeights(GenData,setup);
        
        % Accumulate the computed non corrected r values for later use:
        DATA_r(:,k,n) = measure(:);
        DATA_pval(:,k,n) = pvalue(:);
        
        % Correct r values for multiple comparison:
        [r_corrected,pval_corrected] = MultipleComparisonCorrection(measure,pvalue,setup);
        
        % accummulate FDR corrected r values
        DATA_r_corrected(:,k,n) = r_corrected(:);
        DATA_pval_corrected(:,k,n) = pval_corrected(:);
        
        % accumulate generated data for later use
        PermData_network{k,n,1} = GenData;
        PermData_network{k,n,2} = DATA{n,2};
        
        % Count connections
        [~,vicinity_graph,~] = count_connections(r_corrected);
        
        % Find Connecting Edges:
        [s,t] = find_connecting_edges(vicinity_graph);
        edges= [s, t];
        
        % Construct Probability Matrix
        if length(s) ~= 1
            for ee = 1:length(s)                
                ProbMatGroup(s(ee),t(ee),n) = 1 + ProbMatGroup(s(ee),t(ee),n);
            end
        end        

        % Count and accumulate edges
        degreeDistribution(:,n) = ismember(edge_combination1,edges,'rows') + ismember(edge_combination2,edges,'rows') + degreeDistribution(:,n);
    end
    
    % Reorganize and normalize probability matrix
    Pmap(:,:,n) = triu(ProbMatGroup(:,:,n),1) + transpose(triu(ProbMatGroup(:,:,n),1)) + Nsampling*eye(Nvois);
    Pmap(:,:,n) = Pmap(:,:,n)./Nsampling;
    
    % Compute and Normalize Weights Histogram
    x = DATA_r_corrected(:,:,n);
    x(x==0)=[];
    weightsDistribution(:,n) = histcounts(x(:),setup.nbins,'Normalization','probability');    
    
    % Normalize Edges Histogram
    NonNormalizedEdgesHist(:,n) = degreeDistribution(:,n);
    degreeDistribution(:,n) = degreeDistribution(:,n)/sum(degreeDistribution(:,n));
    
end

end

