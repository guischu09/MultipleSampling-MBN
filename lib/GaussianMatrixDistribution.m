
function [P] = GaussianMatrixDistribution(A,M)

n = size(A,2);

% NormalizingFactor = 1/(((2*pi)^(n/2))*(det(SIGMA)^(0.5)));
% If SIGMA is identity:
NormalizingFactor = 1/(((2*pi)^(n/2))*1^(0.5));

Diff= A-M;

% ArgExp = -0.5*transpose(Diff(:))*inv(SIGMA)*Diff(:);
% If SIGMA is identity:
ArgExp = -0.5*transpose(Diff(:))*Diff(:);

P = NormalizingFactor*exp(ArgExp);

