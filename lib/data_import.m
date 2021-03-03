
function DATA = data_import(filename,setup)

switch setup.balanced
    
    case 'BalanceDown'
        
        [fd,file,~] = fileparts(filename);
        DownMatpath = [fd '/' file '_' setup.balanced '.mat'];
        
        if ~exist(DownMatpath,'file')
            [DATA] = GenerateDownSampledBalancedDataSet(filename);
            save(DownMatpath,'DATA')
        else
            load(DownMatpath,'DATA')
        end
        
    case 'NotBalanced'
        
        [DATA] = OrganizeData(filename);
        
    case 'ADASYN'
        
        [fd,file,~] = fileparts(filename);
        OverMatpath = [fd '/' file '_' setup.balanced '.mat'];
        
        if ~exist(OverMatpath,'file')
            [DATA] = GenerateOverSampledDataSet(filename);
            save(OverMatpath,'DATA')
        else
            load(OverMatpath,'DATA')
        end
end