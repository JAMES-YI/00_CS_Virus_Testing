function [MNeg,MPos,Pos] = pool_dec(A,poolVal,posNum)
% This function is to decode the infection status via qualitative pooling
% results.
%
% - A, mixing matrix
% - poolVal, qualitative values of pool tests; binary vector; 1 if
%   positive, and 0 if negative; 
% - posNum, number of positive samples. Either 0 (number of positives is not specified) or 1 (only one positive).
% 
% ideas for decoding without knowing the number of positive samples
% - for a pool with negative, then all the samples participating in this
%   pool must all be negative
% - for a pool with positive, then all the samples participating in this
%   pool can be positive
% - do the above for each pool to get a set of samples which must be
%   negative (denoted by MNeg), and a set of samples which can be positive
%   (denoted by Pos)
% - remove the must-be-negative samples from Pos
% - special 1: if there is a positive pool, and there is only one sample participating
%   in this pool, then the sample must be positive
% - special 2: if there are positive pools, and the Pos has only one
% element, then the sample must be positive

% Created by JYI, 08/24/2020
% Updated by JYI, 09/15/2020
% - This function will no longer be used due to its incapability of 
%   handling errors occuring in pooling results
% - 
%% 

[poolNum,sampNum] = size(A); 
poolPos = find(poolVal==1); poolNeg = find(poolVal==0); 

%% Decoding pool results

% Get participants in each pool

for i=1:poolNum
    
    parpInd{i} = find(A(i,:)==1); 
   
end

% Get negative index set from all the negative pools

MNeg = [];

for i = poolNeg'
    
    MNeg = union(MNeg,parpInd{i}); 
    
end

% Get potential positive index set from all the positive pools

for i = poolPos'
    
    parpInd{i} = setdiff(parpInd{i},MNeg);
    
end

%% Report results

if posNum==0 % The number of positives not specified
    
    % get all potential positive sample
    if length(poolPos)==1 % only one positive pool
        
        Pos = parpInd{poolPos(1)};
        
    else
        
        Pos = [];
        for i = poolPos'

            Pos = union(Pos,parpInd{i});

        end
        
    end
    
    % verify existence of must-positive sample
    
    if length(Pos)==1
        
        MPos = Pos;
        Pos = [];
        
    else
        MPos = [];

        for i = poolPos'

            tmpInd = find(A(i,:)==1);

            if length(tmpInd)==1
                % only one sample participate in a pool, and the pool is
                % positive

                if ~ismember(tmpInd,MPos)
                    MPos = [MPos,tmpInd];
                end

                rmvInd = find(Pos==tmpInd);
                Pos(rmvInd) = [];

            end

        end
    end
    
    
elseif posNum==1
    % Single positive
    Pos = parpInd{poolPos(1)};
    
    if length(poolPos)>1
        for i = poolPos(2:end)'

            Pos = intersect(Pos,parpInd{i});

        end
    end
    
    MNeg = 1:sampNum;
    MNeg = MNeg([1:Pos-1,Pos+1:end]);
    MPos = Pos;
    Pos = [];
    
end

% if length(poolPos)==1 && length(MNeg)==sampNum
%     % if there is a positve, but all samples are decoded as negative
%     Pos = find(A(poolPos,:)==1);
%     MPos = [];
%     MNeg = setdiff(MNeg,Pos);
%     
% end


    
   
end