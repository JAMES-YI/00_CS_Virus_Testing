classdef poolTest
% This file defines a poolTest class.
%
% Properties 
% - poolStatus, status of each pool test; either positve (1) or negative (0); 
% - poolCtVal, ct value of each pool;
% - poolNum, number of pool tests;
% - poolVload;
% - MixMat, mixing matrix;
% - trialNum, number of trials;
% - sampStatus, status of each individual sample; Pos for positive, and Neg for negative; 
% - sampNum, number of individual samples; 
% - sampPos, index set of samples which are positive; 
% - sampNeg, index set of samples which are negative; 
% - sampVload, virus load of each individual sample;
% 
% Methods
% - poolTest()
% - dataLoader()
% - status_dec()
% - vload_dec()
% 
% Created by JYI, 08/25/2020
% 
% Updated by JYI, 12/03/2020
% - compute the status of samples, i.e., index set of must-positive sample,
%   indet set of must-negative sample, index set of potential positive sample
%
%% Properties

%properties(SetAccess=private)

properties(SetAccess=public)
    
    % Updated on 12/03/2020 by JYI, 12/03/2020
    % - add new properties 
    %   sampCsMPos; % cell array; index set of samples which are decoded as positive; subset of the union of sampMPos and sampPos
    %   sampCsPos; % cell array; index set of samples; subset of the union of sampMPos and sampPos 
    %   sampCsMNeg; % cell array; index set of samples which must be negative; the same as sampMNeg; 
    
    poolStatus; % cell array; number of cells is equal to number of trials
    poolCtVal; % cell array; number of cells is equal to number of trials
    poolNum; 
    poolVload; % cell array; number of cells is equal to number of trials
    
    MixMat;
    trialNum;
    
    sampStatus; 
    sampNum;  
    
    % Group testing results
    sampMPos; % index of positive samples
    sampPos; % cell array; number of cells is equal to number of trials; index of potentially positive samples
    sampMNeg; % cell array; number of cells is equal to number of trials; index of negative samples
    
    % Compressed sensing based decoding results
    sampVload; % cell array; number of cells is equal to number of trials
    sampCsMPos; % cell array; index set of samples which are decoded as positive; subset of the union of sampMPos and sampPos
    sampCsPos; % cell array; index set of samples; subset of the union of sampMPos and sampPos 
    sampCsMNeg; % cell array; index set of samples which must be negative; the same as sampMNeg; 
    
    VloadLb;
    VloadUb; 
    CtValLb; 
    CtValUb; 
    sampObommMPos;
    sampObommPos; 
    sampObommMNeg; 
    
end

%% Methods

methods
  
    function poolset = poolTest(Params)
        
        % Constructor
        % - MatInfo, specification of mixing matrix; specify the matrix,
        %   sampNum, poolNum
        % 
        % Modified by JYI, 10/27/2020
        % - incorporate sensing matrix for COVID-19 constructed from
        %   bipartite graph
        % 
        % Specify mixing matrix
        % Updated by JYI, 12/30/2020
        % - change 'MHV1' to 'MHV-1'
        % - combine 'MHV1' and 'MHV1_2' into 'MHV-1'
        
        virusID = Params.virusID;
        MatInfo = Params.MatInfo;
        
        switch virusID
            case 'MHV-1'
                poolset.CtValLb = 12;
                poolset.CtValUb = 34;
                switch MatInfo

                    case '3 by 7'
                        poolset.MixMat = [1,0,0,1,0,1,1;...
                                          0,1,0,1,1,1,0;...
                                          0,0,1,0,1,1,1];
                        [poolset.poolNum,poolset.sampNum] = size(poolset.MixMat);

                    case '4 by 15'
                        poolset.MixMat = [1,0,0,0,1,0,0,1,1,0,1,0,1,1,1;...
                                          0,1,0,0,1,1,0,1,0,1,1,1,1,0,0;...
                                          0,0,1,0,0,1,1,0,1,0,1,1,1,1,0;...
                                          0,0,0,1,0,0,1,1,0,1,0,1,1,1,1];
                        [poolset.poolNum,poolset.sampNum] = size(poolset.MixMat);

                    case '5 by 31'
                        poolset.MixMat = [1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0;...
                                          0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1;...
                                          0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0;...
                                          0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0;...
                                          0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1];
                        [poolset.poolNum,poolset.sampNum] = size(poolset.MixMat);

                end
                
            case 'COVID-19'
                
                switch MatInfo
                    case '16 by 40'
                        load('Data/Bipartite_A_16by40_BestBetaK_row22.mat')
                        poolset.MixMat = A;
                        [poolset.poolNum,poolset.sampNum] = size(poolset.MixMat);
                        
                end
        end
        
        
        % Specify the virus upper bound
%         convertor = ct2vload();
%         convertor = convertor.datafit();
%         poolset.VloadUb = convertor.vload_prd(poolset.CtValLb);
        
    end
    
    %% 
    function poolset = dataLoader(poolset,dataPath,trialNum)
        
        % Load pool tests status and ct values
        % ToDo
        % - Optimize data import and export
        
        fID = dataPath.fID; 
        sheet = dataPath.sheet; 
        StatusLet = dataPath.StatusLet; 
        CtValLet = dataPath.CtValLet; 
        InitInd = dataPath.InitInd;

        poolset.trialNum = trialNum; 
        
        for i=1:poolset.trialNum
    
            StartInd = InitInd + (poolset.poolNum+2)*(i-1); 
            EndInd = StartInd + (poolset.poolNum-1);
            
            StatusRange = sprintf('%s%d:%s%d',StatusLet,StartInd,...
                                              StatusLet,EndInd);
            poolset.poolStatus{i} = xlsread(fID,sheet,StatusRange);
            
            valGrpNum = length(CtValLet);
            poolset.poolCtVal{i} = [];
            
            for grpNum=1:valGrpNum
                CtValRange = sprintf('%s%d:%s%d',CtValLet{grpNum},StartInd,...
                                                 CtValLet{grpNum},EndInd);
                poolset.poolCtVal{i} = [poolset.poolCtVal{i}; xlsread(fID,sheet,CtValRange)];
            end

        end
        
    end
    
    %% Update the mixing matrix by replicating the mixing matrix mutliples times 
    % according to the number of groups of test, and then concatenate the
    % mixing matrices
    function poolset = updMixMat(poolset,dataPath)
        
        grpNum = length(dataPath.CtValLet);
        
        if grpNum~=1
            
            poolset.MixMat = repmat(poolset.MixMat,[grpNum,1]);
%             for i=1:poolset.trialNum
%                 poolset.poolStatus{i} = repmat(poolset.poolStatus{i},[grpNum,1]);
%             end
            
        end
        
    end
    
    %% Update the pooling status vector by concatenating multiple groups of results
    function poolset = updpoolStatus(poolset,dataPath)
        
        grpNum = length(dataPath.CtValLet);
        
        if grpNum~=1
            
            for i=1:poolset.trialNum
                poolset.poolStatus{i} = repmat(poolset.poolStatus{i},[grpNum,1]);
            end
            
        end
        
    end
    
    %% 
    function poolset = status_dec(poolset,Params,posNumPrior)
        
        % Decode quanlitative results
        % - posNumPrior, prior info of positive samples; either 1 or
        % unknown;
        %
        % Modified by JYI, 10/23/2020
        % - fix bugs when only one stage testing data is used for decoding
        %
        
       
        for i = 1:poolset.trialNum
            
            if iscell(poolset.MixMat)
                [MNeg,MPos,Pos] = pool_dec(poolset.MixMat{i},poolset.poolStatus{i},posNumPrior);
            else
                [MNeg,MPos,Pos] = pool_dec(poolset.MixMat,poolset.poolStatus{i},posNumPrior);
            end
            
            poolset.sampMPos{i} = MPos;
            poolset.sampMNeg{i} = MNeg;
            poolset.sampPos{i} = Pos;
            
            poolset.sampCsMNeg{i} = MNeg;
            poolset.sampCsPos{i} = union(MPos,Pos);
            
            tmpStatus = repmat('N',[poolset.sampNum,1]);
            
            if ~isempty(MPos)
                tmpStatus(MPos,:) = repmat('P',[length(MPos),1]);
            end
            
            if ~isempty(Pos)
                tmpStatus(Pos,:) = repmat('U',[length(Pos),1]);
            end
            
            poolset.sampStatus{i} = tmpStatus;

        end
        
    end
    
    %% 
    function poolset = CtVal2Vload(poolset,Params)
        % Convert ct value to virus load
        % - virus load will be restricted in [0, virus load corresponding
        % to CtValLb]
        % - the observed ct value will be converted to virus load via
        % ct2vload class which is defined in ct2vload.m
        
        convertor = ct2vload(Params.virusID,Params);
        convertor = convertor.datafit();
        
        for i=1:poolset.trialNum
            poolset.poolVload{i} = convertor.vload_prd(poolset.poolCtVal{i});
        end
        
    end
    
    %% 
    function [poolset,varargout] = vload_dec(poolset,Params)
        
        % Decode quantitative results 
        % - when using logarithmic ratio grid search, a gridEngine object
        %   will also be returned
        %
        % Modified by JYI, 10/23/2020
        % - fix bugs when only one stage test data is used
        % - adaptive dilution for mixing matrix scaling, i.e., dilution
        %   factor for each pool is determined by the number of individual
        %   samples participating in it
        % - whenever you change the computational setup for the optimizers,
        %   the following needs to be revised correspondingly one by one:
        %   'LSQ_ANA', 'LOGRATIO_GRID', 'MISMATCHRATIO_GRID', 'OBO_MM'
        %   
        % Modified by JYI, 11/22/2020
        % - different dilution factor for COVID-19 and HMV1
        %   for MHV1, the dilution factor is always 4 for every pool; for COVID-19, the
        %   dilution factor is the same as the number of participants in
        %   each pool, and different pools can have different dilution
        %   factors
        
%         convertor = ct2vload();
%         convertor = convertor.datafit();
%         % Convert ct values to virus loads
%             poolset.poolVload{i} = convertor.vload_prd(poolset.poolCtVal{i});
        poolset = CtVal2Vload(poolset,Params);
        solver = Params.solver;
        CtValDev = Params.CtValDev;
        outExtra = max(nargout,1) - 1;
        virusID = Params.virusID;
        
        for i=1:poolset.trialNum
            
            fprintf('Trial %d/%d\n',i,poolset.trialNum);
            if iscell(poolset.MixMat)
                data.MixMat = poolset.MixMat{i};
            else
                data.MixMat = poolset.MixMat;
            end
            
            % Dilution factor computation
            % - for MHV1 virus (including MHV1_2 and MHV1), the dilution
            %   for pools with multiple samples is 4 while the dilution for
            %   pools containing only one sample is 1
            %
            % Updated by JYI, 12/31/2020
            % - combine 'MHV1' and 'MHV1_2' into 'MHV-1'
            
            switch virusID
                case 'MHV-1'
                    dilution = 4*ones(size(data.MixMat,1),1);
                    indOnes = find(sum(data.MixMat,2)==1); % find individual tests
                    dilution(indOnes) = 1;
                case 'COVID-19'
                    dilution = sum(data.MixMat,2);
%                 case 'MHV1_2'
%                     dilution = 4*ones(size(data.MixMat,1),1);
%                     indOnes = find(sum(data.MixMat,2)==1); % find individual tests
%                     dilution(indOnes) = 1;
            end
            
            Params.dilution = dilution;
            data.MixMat = data.MixMat ./ dilution;
            
            switch solver
                
                case 'L1_MIN'
                    
                    % Decode virus load
                    
                    data.poolVload = poolset.poolVload{i};
                    data.sampNum = pooset.sampNum;
                    vload = poolset.L1_MIN(data,Params);
                    
                case 'LSQ_ANA'
                    % Based on LSQ, but we solve for the solution via
                    % analytic form
                    
                    vload = zeros(poolset.sampNum,1);
                    if Params.load2ndStage==1
                        Asub = poolset.MixMat{i}(:,poolset.sampPos{i});
                    else
                        Asub = poolset.MixMat(:,poolset.sampPos{i});
                    end
                    
                    switch virusID
                        case 'MHV1'
                            dilution = 4;
                        case 'COVID-19'
                            dilution = sum(Asub,2);
                        case 'MHV1_2'
                            dilution = 4;

                    end
                    
                    Asub = Asub ./ dilution;
                    
                    b = poolset.poolVload{i};
                    vload_sub = linsolve(Asub'*Asub,Asub'*b);
                    vload(poolset.sampPos{i}) = vload_sub;
                    
                case 'LSQ_ITER'
                    
                    % Solve least square for finding the solution
                    data.sampNum = poolset.sampNum; 
                    data.sampPos = poolset.sampPos{i};
                    data.poolVload = poolset.poolVload{i}; 
                    
                    vload = poolset.LSQ_ITER(data,Params);
                
                case 'LOGRATIO_GRID'
                    % Require results from group testing
                    % - virus load range [1.0407e-5,2.3157e+3]
                    % TBD: dilution
                    
                    gEngine = gridEngine(poolset,Params); % perform grid search to get pilot virus load
                    varargout{1} = gEngine;
                    vload = gEngine.pilotVload{i}; 
                    
                case 'LOGRATIO_PGD'
                    
                    % fprintf('Solving logarithmic ratio minimization via PGD...\n')
                    
                    data.sampNum = poolset.sampNum; 
                    data.sampMPos = poolset.sampMPos{i};
                    data.poolVload = poolset.poolVload{i};
                    vload = logratio_pgd(data,Params);
                    
                    % fprintf('Finished logarithmic ratio minimization via PGD\n');
                
                case 'MISMATCHRATIO_GRID'
                    
                    % Require results from group testing
                    % - virus load range [1.0407e-5,2.3157e+3]
                    % TBD: dilution
                    
                    gEngine = gridEngine(poolset,Params); % perform grid search to get pilot virus load
                    varargout{1} = gEngine;
                    vload = gEngine.pilotVload{i}; 
                  
                case 'MISMATCHRATIO_PGD'
                    
                    data.sampNum = poolset.sampNum; 
                    data.sampMPos = poolset.sampMPos{i};
                    data.poolVload = poolset.poolVload{i};
                    vload = mismatchratio_pgd(data,Params);
                    
                case 'MISMATCHRATIO_SUCC'
                    
                    data.sampNum = poolset.sampNum; 
                    data.sampMPos = poolset.sampMPos{i};
                    data.poolVload = poolset.poolVload{i};
                    vload = mismatchratio_succ(data,Params);
                    
                case 'MISMATCH'
                    
                    data.sampNum = poolset.sampNum; 
                    data.sampMPos = poolset.sampMPos{i};
                    data.poolVload = poolset.poolVload{i};
                    vload = mismatch(data,Params);
                    
                case 'EXHAUSTIVE'
                    % Modified by JYI, 11/02/2020
                    % - allow the use of group testing results
                    
                    fprintf('Performing exhaustive decoding...\n');
                    
%                     data.sampPos = poolset.sampPos{i};
                    data.sampNum = poolset.sampNum; 
                    data.poolCtVal = poolset.poolCtVal{i};
%                     data.sampMPos = poolset.sampMPos{i};
                    
                    data.suppSet = setdiff(1:poolset.sampNum,poolset.sampMNeg{1,i});
                    data.poolStatus = poolset.poolStatus{i};
                    data.poolVload = poolset.poolVload{i};
                    [vload,otptData] = exhaustive(data,Params);
                    
                    % prepare data for saving
                    
                    saveDataExhaust{i} = otptData;
            end
            
            if ~strcmp(solver,'OBO_MM')
                % - Update sample virus load decoded from algorithms other
                %   than OBO-MM
                % Updated by JYI, 12/03/2020
                % - construct three index sets
                %   sampCsMPos; % cell array; index set of samples which are decoded as positive; subset of the union of sampMPos and sampPos
                %   sampCsPos; % cell array; index set of samples; subset of the union of sampMPos and sampPos 
                %   sampCsMNeg; % cell array; index set of samples which must be negative; the same as sampMNeg;
                %   results from group testing are required
                poolset.sampVload{i} = vload;
                
                poolset.sampCsMPos{i} = find(vload>Params.vloadMin);
                poolset.sampCsPos{i} = setdiff(poolset.sampCsPos{i},poolset.sampCsMPos{i});
            end
            
        end
        
        % save exhasutive search data
        if strcmp(solver,'EXHAUSTIVE')
            save(Params.dfNameExhaustiveData,'saveDataExhaust');
        end
        
        % obo_mm decoding
        if strcmp(solver,'OBO_MM')
            % - Solve one-by-one minimization-maximization to get
            %   virus load bound
            % 
            % Modified by JYI, 11/22/2020
            % - dilution factor
            % 
            % Modified by JYI, 12/04/2020
            % - compute index sets of must-positive samples, must-negative
            %   samples, and potential positive samples; results from group
            %   testing are not used as priors;
            
            [xLb,xUb] = obo_mm(poolset,Params);
            
            poolset = poolset.set_vloadBd(xLb,xUb);
            poolset = poolset.set_sampStatus(xLb,xUb,Params);
            
            
        elseif strcmp(solver,'LOGRATIO_GRID')
            % Modified by JYI, 11/22/2020
            % - TBD: dilution factor

            gEngine = gridEngine(poolset,Params); % perform grid search to get pilot virus load
            varargout{1} = gEngine;
            poolset.sampVload = gEngine.pilotVload;
        end
  
    end
    
    function poolset = set_sampStatus(poolset,vloadLb,vloadUb,Params)
        % Created by JYI, 12/03/2020
        % - compute index set of potentially positive samples according to
        %   estimated upper and lower bound of the sample virus load;
        %   results from group testing are not used as priors; 
        % - if the upper bound of the virus load is less than the
        %   threshold, then claim the corresponding sample to be negative; 
        %   if the lower bound of the virus load is greater than the
        %   threshold, then claim the corresponding sample to be positive;
        %   all the other samples are claimed to be potentially positives;
        
        for i=1:poolset.trialNum
            
            poolset.VloadLb{i} = vloadLb{i};
            poolset.VloadUb{i} = vloadUb{i};
            
            poolset.sampObommMPos{i} = find(vloadLb{i}>Params.vloadMin);
            poolset.sampObommMNeg{i} = find(vloadUb{i}<Params.vloadMin);
            dtmd = union(poolset.sampObommMPos{i},poolset.sampObommMNeg{i});
            poolset.sampObommPos{i} = setdiff(1:poolset.sampNum,dtmd);
            
        end
    end
    
    %%
    function res_display(poolset,mode)
        % Display the results
        % - mode, either 'full' or 'pos'
        
        trialNumLoc = poolset.trialNum;
        
        switch mode
            case 'pos'
                
                for i=1:trialNumLoc

                    posInd = poolset.sampPos{i};
                    sampVloadLoc = poolset.sampVload{i};
                    fprintf('Trial %d/%d\n',i,trialNumLoc);
                    fprintf('pos ind\t virus load (ng/ul)\n');

                    for sampIter=posInd'
                        fprintf('%d\t%8.4e\n',sampIter,sampVloadLoc(sampIter));
                    end

                end
                
            case 'full'
                
                for i=1:trialNumLoc
                    fprintf('Trial %d/%d\n',i,trialNumLoc);
                    fprintf('pos ind\t virus load (ng/ul)\n');
                    fprintf('%d\t%8.2e\n',...
                            [1:poolset.sampNum;poolset.sampVload{i}']);
                    fprintf('Sample Status'); poolset.sampStatus{i}
                end
                
        end
        
        
    end
    
    %% 
    function poolset = set_vloadBd(poolset,vloadLb,vloadUb)
        % reset the virus load lower bound and upper bound
        
        for i=1:poolset.trialNum
            
            poolset.VloadLb{i} = vloadLb{i};
            poolset.VloadUb{i} = vloadUb{i};
            
        end
        
        
    end
 
    %%
    function poolset = data_stg_concat(poolset,SSDataLoader)
        % Concatenate pooling data from different testing stages
        % - SSDataLoader, an object of SecStgDataLoader class
        
        % MixMat concatenation
        MixMatBase = poolset.MixMat;
        trialNumLoc = poolset.trialNum;
        poolset.MixMat = cell(trialNumLoc,1);
        runIndMat = cell2mat(SSDataLoader.runInd);
        
        
        for iTrial=1:trialNumLoc
            
            if ~iscell(MixMatBase)
                if ismember(iTrial,runIndMat)
                    poolset.MixMat{iTrial} = [MixMatBase; SSDataLoader.MixMat{iTrial}];
                    poolset.poolStatus{iTrial} = [poolset.poolStatus{iTrial}; SSDataLoader.poolStatus{iTrial}];
                    poolset.poolCtVal{iTrial} = [poolset.poolCtVal{iTrial}; SSDataLoader.poolCtVal{iTrial}];
                else
                    % no updates if no extra pooling tests are performed
                    poolset.MixMat{iTrial} = MixMatBase;
                end
            else
                if ismember(iTrial,runIndMat)
                    poolset.MixMat{iTrial} = [MixMatBase{iTrial}; SSDataLoader.MixMat{iTrial}];
                    poolset.poolStatus{iTrial} = [poolset.poolStatus{iTrial}; SSDataLoader.poolStatus{iTrial}];
                    poolset.poolCtVal{iTrial} = [poolset.poolCtVal{iTrial}; SSDataLoader.poolCtVal{iTrial}];
                else
                    % no updates if no extra pooling tests are performed
                    poolset.MixMat{iTrial} = MixMatBase{iTrial};
                end
            end
        end
        
        % poolStatus concatenation
        
        % poolCtVal concatenation
    end
    
    %% 
    function poolset = updsampVload(poolset,gEngine)
        % update the virus load via the virus load from gridEngine object
        
        poolset.sampVload = gEngine.pilotVload;
    end
    %%
    function poolset = TBD(poolset)
        % Empty function for development of future functionalities
    end
    
%     function poolset = vload_dec(poolset)
%         
%         % Decode virus load
%         
%         cvx_begin quiet
%         
%             variable vload(poolset.sampNum);
%             minimize(norm(vload,1));
%             subject to
%                 poolset.MixMat*vload == poolset.poolVload;
% 
%         cvx_end
%         
%         poolset.sampVload = vload;
%         
%     end
    
end

%% Static methods
methods(Static)
    
    %%
    function vload = L1_MIN(data,Params)
        % Perform L1 minimization decoding virus load
        % input arguments
        % - data, structure associated with single run; containing mixing matrix, and virus loads for each
        % pool; 
        % - Params, structure; 
        %
        % 
        %% 

        MixMatLoc = data.MixMat;
        poolVloadLoc = data.poolVload;
        sampNumLoc = data.sampNum;
        
        cvx_begin quiet

            variable vload(sampNumLoc);
            minimize(norm(vload,1));
            subject to
                MixMatLoc*vload == poolVloadLoc;
                -vload <= 0;

        cvx_end
    end
    
    %% 
    function vload = LSQ_ITER(data,Params)
        % Perform least square for decoding virus load
        %
        % input arguments
        % - data
        % - Params
        %
        % 
        %
        %% 

        sampNumLoc = data.sampNum; 
        sampPosLoc = data.sampPos;
        poolVloadLoc = data.poolVload; 
        MixMatLoc = data.MixMat;

        vload = zeros(poolset.sampNum,1);
        Asub = MixMatLoc;
        b = poolVloadLoc; 

        cvx_begin quiet

            variable vload_sub(length(sampPosLoc),1)
            minimize(norm(Asub*vload_sub-b,2))
            subject to 
                -vload_sub <= 0

        cvx_end

        vload(sampPosLoc) = vload_sub;

    end
    
    function a = TBDStatic()
        a = 0;
    end
    
end
    
    
end