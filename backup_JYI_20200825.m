% This file contains code trunks which are incorporated into the system,
% and is for backup purpose only.
%
% Created by JYI, 08/25/2020
% 
%% 
% fID = 'MHV1 Pooled Testing Exp 1 Results 082120.xlsx';

% % Mixing matrix of size 3 by 7 
% A3_7 = [1,0,0,1,0,1,1;
%      0,1,0,1,1,1,0;
%      0,0,1,0,1,1,1];
%  
% runN3_7 = 1;
% pool3_7 = xlsread(fID,'Sheet1','C3:C5');
% pool3_7Qual = xlsread(fID,'Sheet1','B3:B5');
% 
% [Pos,Neg] = pool_test(A3_7,pool3_7Qual);

% % Mixing matrix of size 4 by 15
% A4_15 = [1,0,0,0,1,0,0,1,1,0,1,0,1,1,1;
%      0,1,0,0,1,1,0,1,0,1,1,1,1,0,0;
%      0,0,1,0,0,1,1,0,1,0,1,1,1,1,0;
%      0,0,0,1,0,0,1,1,0,1,0,1,1,1,1];
%  
% runN4_15 = 5; 
% for i=1:runN4_15
%     
%     StartInd = 3+6*(i-1); EndInd = StartInd+3;
%     Range = sprintf('H%d:H%d',StartInd,EndInd);
%     pool4_15{i} = xlsread(fID,'Sheet1',Range);
% 
%     RangeQual = sprintf('G%d:G%d',StartInd,EndInd);
%     pool4_15Qual{i} = xlsread(fID,'Sheet1',RangeQual);
%     
% end
% 
% for i=1:runN4_15
%     
%     [Pos,Neg] = pool_test(A4_15,pool4_15Qual{i});
%     Pos4_15{i} = Pos;
%     Neg4_15{i} = Neg;
%     
% end

% Mixing matrix of size 5 by 31
% A5_31 = [1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0;
%      0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1;
%      0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0;
%      0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0;
%      0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1];
% 
% runN5_31 = 7;
% for i=1:runN5_31
%     
%     StartInd = 3+7*(i-1); EndInd = StartInd+4;
%     Range = sprintf('M%d:M%d',StartInd,EndInd);
%     pool5_31{i} = xlsread(fID,'Sheet1',Range);
% 
%     RangeQual = sprintf('L%d:L%d',StartInd,EndInd);
%     pool5_31Qual{i} = xlsread(fID,'Sheet1',RangeQual); 
%     
% end
% 
% for i=1:runN5_31
%     
%     [Pos,Neg] = pool_test(A5_31,pool5_31Qual{i});
%     Pos5_31{i} = Pos;
%     Neg5_31{i} = Neg;
%     
% end

%% Decoding
% A = A3_7; poolVal = pool3_7;
% [poolNum,sampNum] = size(A);
% cvx_begin quiet
%     variable sampVal(sampNum)
%     minimize(norm(sampVal,1));
%     subject to 
%         A*sampVal == poolVal;
% cvx_end
%%
% fID = 'Data/MHV1 Re-Test Results.xlsx';
% [num,txt] = xlsread(fID,'Sheet1','F10:I14');
% cell_dat = {'13,15,21'; '42,40,47,11,30'; '15,51,23'; '67,76'};
% cell_dat_split = cellfun(@(S) sscanf(S, '%f,').', cell_dat, 'Uniform', 0);
% 
% 
% dataPath.runInd = {2,4,5};
% dataPath.fID = 'Data/MHV1 Re-Test Results.xlsx';
% dataPath.sheetID = {'Sheet1','Sheet1','Sheet1'};
% dataPath.Rg = {'A4:C4','A7:C7','A10:C10'};

%% 
% function vload = LOGRATIO_MIN(varargin)
% % This function is to perform decoding via solving
% %     min_x sum_i |log(y_i) - log((Ax)_i)|
% %     s.t.  x>= 0 
% % 
% % Created by JYI, 09/08/2020.
% %
% %% 
% 
% % decoding configuration 
% if nargin ~= 2
%     
%    MixMatLoc = binornd(1,0.5,5,31);
%    poolVloadLoc = max(randn(5,1)*10^3,0);
% 
% end
% 
% sampNumLoc = size(MixMatLoc,2);
% 
% % decoding
% cvx_begin quiet
%     variable vload(sampNumLoc,1)
%     minimize(norm(log(poolVloadLoc)-log(MixMatLoc*vload),1))
%     subject to
%         -vload <= 0
% cvx_end
% 
% end

%% 
% function vload = LOGRATIO_GRID(data,Params)
% % This function is to perform decoding via solving
% %     min_x sum_i |log(y_i) - log((Ax)_i)|
% %     s.t.  x>= 0 
% % via gradient 
% % Created by JYI, 09/08/2020.
% %
% %% 
% 
% % decoding configuration 
% 
% 
% sampNumLoc = size(MixMatLoc,2);
% 
% % decoding
% cvx_begin quiet
%     variable vload(sampNumLoc,1)
%     minimize(norm(log(poolVloadLoc)-log(MixMatLoc*vload),1))
%     subject to
%         -vload <= 0
% cvx_end
% 
% end
%
%% 
% function [s,varargout] = returnVariableNumOutputs(x)
%     nout = max(nargout,1) - 1;
%     s = size(x);
%     for k = 1:nout
%         varargout{k} = s(k);
%     end
% end

%%
close all; clc;
poolset = poolset.vload_dec(Params);







