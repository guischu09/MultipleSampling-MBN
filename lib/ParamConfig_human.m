function [setup] = ParamConfig_human()

setup.interactive = false;
setup.brain_type = 'human'; % 'rat' or 'human'
setup.alpha = 0.01;
setup.nbins = 100;
setup.weights = 'PearsonCorrelation';
setup.ptresh = 1-setup.alpha;
setup.thresh = 0.3;
setup.correction_type = 'FDR'; % Options: 'FDR', 'Bonferroni'
setup.Nsamplings_vector = [1000]; % Optimal = 9200
setup.criteria_representation = 'mean'; %Options: 'mean', 'median', 'mode'
setup.balanced = 'NotBalanced'; % Options: 'BalanceDown','NotBalanced', 'ADASYN'
setup.ComputeNclosests = true; %Options: true or false
setup.NClosests = 30; % Set number of
setup.randomType = 'Bootstrap'; %Options: 'Subsampling' , 'Bootstrap'
if strcmp(setup.randomType,'Subsampling')
    setup.max_remov = 0.3;
    setup.min_remov = 0.1;
end

% Additional options
setup.OUTPUT_FOMAT_VEC = {'svg'};
setup.plotMatrix = 'MS_Scheme'; %Options: 'Conventional', 'MS_Scheme', 'Both'
setup.WhichPlot = 'Heat&Circle';

end