function [NewDATA] = GenerateOverSampledDataSet(filename)

%% Read Data:
[DATA] = OrganizeData(filename);
NewDATA = DATA;

%% Basic Setup:
adasyn_beta                     = [];   %let ADASYN choose default
adasyn_kDensity                 = [];   %let ADASYN choose default
adasyn_kSMOTE                   = [];   %let ADASYN choose default
adasyn_featuresAreNormalized    = false;    %false lets ADASYN handle normalization


Nclass = size(DATA,1);
NrunsADASYN = Nclass - 1;

temp_size = zeros(Nclass,1);
adasyn_labels =[];

label = [0,1];
for u = 1:Nclass
    temp_size(u) = size(DATA{u,1},1);
end
    
[values,idx] = sort(temp_size,'descend');

for n = 1:NrunsADASYN
    MajorData = DATA{idx(1),1};
    MinorData = DATA{idx(n+1),1};
    adasyn_features = [MajorData;MinorData];   
    
    MajorLabels = repmat(1,temp_size(idx(1)),1);
    MajorLabel = DATA{idx(1),2};
    
    MinorLabels = repmat(2,temp_size(idx(n+1)),1);    
    adasyn_labels = [MajorLabels;MinorLabels] - 1;            
    MinorLabel = DATA{idx(n+1),2};
    
    [adasyn_featuresSyn, adasyn_labelsSyn] = ADASYN(adasyn_features, adasyn_labels, adasyn_beta, adasyn_kDensity, adasyn_kSMOTE, adasyn_featuresAreNormalized);
    
    NewDATA{idx(n+1),1} = [MinorData; adasyn_featuresSyn];
    
end