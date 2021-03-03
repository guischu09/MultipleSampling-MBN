
function SaveAnalysisSetup(saveFd1,SaveFd2,setup)

fileID = fopen(fullfile(saveFd1,'AnalysisSetup.txt'),'w');

Fields = fieldnames(setup);

for f = 1:length(Fields)
    
    if isnumeric(setup.(Fields{f}))        
        PrintStatement = strcat(Fields{f},': ',num2str(setup.(Fields{f})));
        fprintf(fileID,['%s\n\n'],PrintStatement);
    end
        
    if isstr(setup.(Fields{f}))
        PrintStatement = strcat(Fields{f},': ', setup.(Fields{f}));
        fprintf(fileID,['%s\n\n'],PrintStatement);
    end
        
end

fclose(fileID);


fileID = fopen(fullfile(SaveFd2,'AnalysisSetup.txt'),'w');

Fields = fieldnames(setup);

for f = 1:length(Fields)
    
    if isnumeric(setup.(Fields{f}))        
        PrintStatement = strcat(Fields{f},': ',num2str(setup.(Fields{f})));
        fprintf(fileID,['%s\n\n'],PrintStatement);
    end
        
    if isstr(setup.(Fields{f}))
        PrintStatement = strcat(Fields{f},': ', setup.(Fields{f}));
        fprintf(fileID,['%s\n\n'],PrintStatement);
    end
        
end

fclose(fileID);