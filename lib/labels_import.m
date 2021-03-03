function [Labels] = labels_import(labelFile)

Labels = importdata(labelFile);
Labels = matlab.lang.makeValidName(Labels);

end