function vload = grid_rf_search(data,Params)
% This function solves
%     min_x sum_i |log(y_i) - log((Ax)_i)|
%     s.t.  x>= 0 
% via a refined interval boud for virus load
% - the i is from the index set of all positive pools
% - group testing results are required; positive samples must have been
% identified via group testing; 
% - pilot virus load for each sample must have been computed via
% grid_search.m
% 
% input arguments
% - data
% - Params
% 
% Created by JYI, 09/09/2020
% Updated by JYI, 09/16/2020
% - add grid search for solving the following optimization
%     min sum_i |y_i - (Ax)_i|/(Ax)_i
%     s.t.(Ax)_j = 0,
%         x>=0
%     OR simply
%     min sum_i |y_i - (Ax)_i|/(Ax)_i
%     s.t. x>=0
%     where i is from the index set of positive pools, and 
%     j is from the index set of negative pools

%
%% 

sampMPos = data.sampMPos;
poolVload = data.poolVload;
MixMat = data.MixMat/Params.dilution; 
sampNum = data.sampNum;
rfUbVload = data.rfUbVload; % with correspondence to sampMPos;
rfLbVload = data.rfLbVload;
incrmt = Params.incrmt; 
solver = Params.solver;


precs = 0;
kpInd = find(poolVload>0);
poolVloadSub = poolVload(kpInd,1);
MixMatSub = MixMat(kpInd,sampMPos)+precs;
sampMPosNum = length(sampMPos);
vload = zeros(sampNum,1);

% Choose the formula
switch solver
    case 'LOGRATIO_GRID'
        objFunc = @(x) norm(log(poolVloadSub+precs)-log(MixMatSub*x),1);
    case 'MISMATCHRATIO_GRID'
        objFunc = @(x) norm((poolVloadSub - MixMatSub*x) ./ (MixMatSub*x),1);
        
end

objVal = Inf;

switch sampMPosNum
    
    case 1
        
        for x1=rfLbVload:incrmt:rfUbVload
            objTmp = objFunc(x1);
            if objTmp<objVal
                objVal = objTmp;
                xOpt = x1;
                fprintf('(x1) = (%.3f)\n',x1);
            end
        end
        
        vload(sampMPos,1) = xOpt;
        
    case 2
        
        for x1=rfLbVload(1):incrmt:rfUbVload(1)
            for x2=rfLbVload(2):incrmt:rfUbVload(2)
                if objFunc([x1;x2])<objVal
                    objVal = objFunc([x1;x2]);
                    xOpt = [x1;x2];
                    fprintf('(x1,x2) = (%.3f,%.3f)\n',...
                        x1,x2);
                end
            end
        end
        
        vload(sampMPos,1) = xOpt;
        
    case 3
        
        for x1=rfLbVload(1):incrmt:rfUbVload(1)
            for x2=rfLbVload(2):incrmt:rfUbVload(2)
                for x3=rfLbVload(3):incrmt:rfUbVload(3)
                    if objFunc([x1;x2;x3])<objVal
                        objVal = objFunc([x1;x2;x3]);
                        xOpt = [x1;x2;x3];
                        fprintf('(x1,x2,x3) = (%.3f,%.3f,%.3f)\n',...
                        x1,x2,x3);
                    end
                end
            end
            
        end
        
        vload(sampMPos,1) = xOpt;
        
        
    case 4
        
        for x1=rfLbVload(1):incrmt:rfUbVload(1)
            for x2=rfLbVload(2):incrmt:rfUbVload(2)
                for x3=rfLbVload(3):incrmt:rfUbVload(3)
                    for x4=rfLbVload(4):incrmt:rfUbVload(4)
                        if objFunc([x1;x2;x3;x4])<objVal
                            objVal = objFunc([x1;x2;x3;x4]);
                            xOpt = [x1;x2;x3;x4];
                            fprintf('(x1,x2,x3,x4) = (%.3f,%.3f,%.3f,%.3f)\n',...
                        x1,x2,x3,x4);
                        end
                    end
                end
            end
        end
        
        vload(sampMPos,1) = xOpt;
        
    case 5
        
        for x1=rfLbVload(1):incrmt:rfUbVload(1)
            for x2=rfLbVload(2):incrmt:rfUbVload(2)
                for x3=rfLbVload(3):incrmt:rfUbVload(3)
                    for x4=rfLbVload(4):incrmt:rfUbVload(4)
                        for x5=rfLbVload(5):incrmt:rfUbVload(5)
                            if objFunc([x1;x2;x3;x4;x5])<objVal
                                objVal = objFunc([x1;x2;x3;x4;x5]);
                                xOpt = [x1;x2;x3;x4;x5];
                                fprintf('(x1,x2,x3,x4,x5) = (%.3f,%.3f,%.3f,%.3f,%.3f)\n',...
                                        x1,x2,x3,x4,x5);
                            end
                        end
                    end
                end
            end
        end
        
        vload(sampMPos,1) = xOpt;
        
    case 6
        
         for x1=rfLbVload(1):incrmt:rfUbVload(1)
            for x2=rfLbVload(2):incrmt:rfUbVload(2)
                for x3=rfLbVload(3):incrmt:rfUbVload(3)
                    for x4=rfLbVload(4):incrmt:rfUbVload(4)
                        for x5=rfLbVload(5):incrmt:rfUbVload(5)
                            for x6=rfLbVload(6):incrmt:rfUbVload(6)
                                if objFunc([x1;x2;x3;x4;x5;x6])<objVal
                                    objVal = objFunc([x1;x2;x3;x4;x5;x6]);
                                    xOpt = [x1;x2;x3;x4;x5;x6];
                                    fprintf('(x1,x2,x3,x4,x5,x6) = (%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\n',...
                                        x1,x2,x3,x4,x5,x6);
                                end
                            end
                        end
                    end
                end
            end
        end
        
        vload(sampMPos,1) = xOpt;
        
    case 7
        
    case 8
        
        
    case 9
        
    case 10
        
    case 11
        
    case 12
        
    case 13
        
    case 14
        
    case 15
        
    case 16
        
    case 17
        
        
    case 18
        
    case 19
        
    case 20
end



end