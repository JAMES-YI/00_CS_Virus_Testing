function poolset = main_dec(config)

% This file is to decode pooled sample results to obtain individual sample
% results.
% 
% - config contains the following fileds
%   config.MatSize
%   config.solver
%   config.virusID
%   config.stageNum
%   config.trialInd
%
% Params.solver can be any one of the following. Each one of them requires
% the dilution parameter
% - 'LSQ_ANA', 
% - 'L1_MIN', 
% - 'LSQ_ITER', 
% - 'OBO_MM', the following parameters are required
%   CtValDev, deviation in ct value
% - 'LOGRATIO_GRID', the following parameters are required
%   radius 
% - 'LOGRATIO_PGD', 
% - 'MISMATCHRATIO_GRID', the following parameters are required
%   radius
% - 'MISMATCHRATIO_SUCC', the following parameters are required
%   mismatchratio_norm
% - 'MISMATCH', the following parameters are required
%   mismatchratio_norm
% - 'EXHAUSTIVE', the following parameters are required
%   exhaustMaxIterSucc, exhaustMode
% 
% Creted by JYI, 20200823
% Updated by JYI, 20201004
% - add funcitonality for loading both the primary and secondary data
%   from the second stage
% - use new standard curve data for interpolation of ct value and virus
% load
% 
% Updated by JYI, 10/26/2020
% - incorporate decoding for COVID-19 using bipartite graph of size 16 by
%   40
% - adaptive dilution factor, i.e., each pool has its own dilution factor
%   (1) matrix scaling
%   (2) in adaptive request scenario
%   (3) only for COVID-19 virus case
% - for MHV1, the dilution factor is always 4
% 
% - MatSize for MHV1: [3,7], [4,15], or [5,31]
%           for COVID-19: [16,40]
%           for MHV1_2: [3,7], [4,15], or [5,31]
% - Due to the wide range of the data, it's strongly suggested to perform
%  certain normalization tricks
% - Params.MaxIterSucc
%   (1) recommend 10; large value does not bring much benefits; 
%   (2) for both the successive mismatch ratio minimization and the successive exhaustive LSQ;
% - Postprocessing of results returned in 'EXHAUSTIVE' decoding and stored
%   in file
%      Params.dfNameExhaustiveData
% - results file name format
%   16x40 Results Exp 1_updated_prep_SOLVER_JYI_dilution_10_20201028.xlsx
% - exhaustMode
%   (1) 'REGULAR': evaluate over every possible sparsity, and every possible support for each sparsity; essentially a combinatorial problem; 
%       for each possible case, solve a LSQ; the solution achieving the
%       smallest objective function value will be used; 
%   (2) 'NORMALIZED': the basic idea is the same as 'REGULAR'; however, we normalize the virus load difference in the LSQ optimization by the pool virus load
%   (3) 'SUCCESSIVE': the basic idea is the same as 'NORMALIZED'; however, the normalization is performed successively;
%   (4) 'MINPOS': the basic idea is the same as 'SUCCESSIVE'; however, we
%       minimize the virus load residual over only the positive pools; the
%       virus load of the negative pools is used as constraint
% 
% UpdateD by JYI, 11/06/2020
% - incorporate retest data for COVID-19 decoding 
%
% Updated by JYI, 11/20/2020
% - incorporate test data for MHV1 virus decoding; the new data should be
%   used as independent from previous MHV1 virus decoding data; the new
%   data is needed probably due to errors in the previous MHV1 virus test
%   data; correspondence by 'MHV1_2'
% - write results to excel file
%
% ToDo
% - documentation of architecture of the system
% - architecture optimization
% - factorization and packing
% - filename management for raw data
%   VIRUSNAME_Trial-#_Stage-#_DataType_CreaterInitial_Datastamp.fileextension
%   MHV-1_Trial-1_Stage-1_Encoded_KWALDSTEIN_202012291244.xlsx
%   MHV-1_Trial-1_Stage-2_Encoded_KWALDSTEIN_202012291244.xlsx
%   MHV-1_Trial-1_Stage-3_Encoded_KWALDSTEIN_202012291244.xlsx
%   MHV-1_Trial-2_Stage-1_Encoded_KWALDSTEIN_202012291244.xlsx
%   MHV-1_Trial-2_Stage-2_Encoded_KWALDSTEIN_202012291244.xlsx
%   COVID-19_Trial-1_Stage-1_Encoded_KWALDSTEIN_202012291244.xlsx
%   COVID-19_Trial-1_Stage-2_Encoded_KWALDSTEIN_202012291244.xlsx
% - filename management for results
%   MHV-1_Trial-1_Stage-1_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-1_Stage-2_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-1_Stage-3_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-2_Stage-1_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-2_Stage-2_Decoded_JYI_202012291244.xlsx
%   COVID-19_Trial-1_Stage-1_Decoded_JYI_202012291244.xlsx
%   COVID-19_Trial-1_Stage-2_Decoded_JYI_202012291244.xlsx

%% System Configuration
% StatusLet: B for A3_7, G for A4_15, L for A5_31
% CtValLet: C for A3_7, H for A4_15, M for A5_31
% - you may need to setup the following parameters
%   Params.MatSize
%   Params.solver
%   Params.virusID
%   Params.stageNum
%   Params.trialInd

 
Params.posNumPrior = 0; % 1 (only one is positive) or 0 (not specify the number of positives); default 0

% Parameters associated with I/O and data
Params.logStatus = 'off'; % 'on' or 'off'; default 'off'
Params.tmStamp = datestr(now,'yyyymmddHHMM');
Params.dfNameExhaustiveData = sprintf('ExhaustiveData%s.mat',Params.tmStamp);
Params.ctValType = 'all'; % 'primary' (use only the first group of data) or 
% 'secondary' (use only the duplicate data) or 'all' (use both the first
% and duplicate data); default 'all'
Params.MatSize = config.MatSize; % size of participation matrix in {0,1}^{n,N}; [3,7], [4,15], or [5,31] for MHV-1;
% [16,40] for COVID-19
Params.userID = 'JYI';
Params.vloadMin = 1e-6; % minimal virus load achievable by positive samples; recommended to be 1e-7

% Parameters assocated with exhaustive LSQ optimization


% Parameters associated with optimizer
Params.solver = config.solver; % 'EXHAUSTIVE', 'OBO_MM', 'MISMATCHRATIO_SUCC'
Params.MaxIterSucc = 100; % for 'MISMATCHRATIO_SUCC' only; default 100; large value does not bring much benefits; 
Params.mismatchratio_norm = 'L2'; % for 'MISMATCHRATIO_SUCC' only; 'L1' or 'L2' or 'L2L1'
% - 'EXHAUSTIVE' solver
Params.exhaustMode = 'NORMALIZED'; % for 'EXHAUSTIVE' solver only; 'REGULAR', 'NORMALIZED', 'SUCCESSIVE', or 'MINPOS'; default 'NORMALIZED' 
Params.earlyTolCtVal = 1.5; % for 'EXHAUSTIVE' solver only; should not be too big or too small; recommended to be (0.5,2]; default 1.5
Params.exhaustMaxIterSucc = 1; % for 'EXHAUSTIVE' solver in 'SUCCESSIVE' mode only; 
% 100 iterations is too big and numerical issues can occur; default 1

% - 'OBO_MM' solver
Params.CtValDev = 1.5; % required for OBO_MM decoding method only; 
% better to keep it below 2; suggested value 1.5 for MHV-l and COVID-19; noise magnitude in ct value observation; 
% - solvers based on grid search
Params.radius = 1; % only used in decoding methods based on grid search;

% Parameters associated with virus
Params.virusID = config.virusID; % 'MHV-1', or 'COVID-19'
Params.trialInd = config.trialInd; % index of the independent experiments to consider; each independent experiment contains
% results from the {stage 1, stage 2, ...} if adaptive request decoding is
% performed; trialInd (which is actually the number of experiments) 
% and the trialNum (which is actually the number of runs) are completely different;
% totally 2 independent trial experiments are conducted for
% MHV-1; totally 1 independent trial experiment is done for COVID-19
Params.stageNum = config.stageNum; % fit to adaptive request decoding scheme; 
% use the results from the first n stages for decoding; 
% maximal value for MHV-1 is 3 in trail 1; maximal value for MHV-1 is 2 in
% trial 2;
% maximal value for COVID-19 is 2 in trial 1;

%% Automatical setup of parameters
% Parameters associated with writing results report
% ToDo: COVID-19 case

Params.optExcelID = sprintf('Data/%s_Trial-%d_Stage-%d_Decoded_%s.xlsx',...
                            Params.virusID,Params.trialInd,Params.stageNum,Params.userID); 

%% Load data from first stage or inital request

Params.poolNum = Params.MatSize(1); 
Params.sampNum = Params.MatSize(2); 

switch Params.virusID
    case 'MHV-1'
        % totally two trials for MHV-1
        % Params.dilution = 4; % fold of dilution
        
        if Params.trialInd==1
            dataPath.fID = 'Data/MHV-1_Trial-1_Stage-1_Encoded_KWALDSTEIN_202010042110.xlsx';
        elseif Params.trialInd==2
            dataPath.fID = 'Data/MHV-1_Trial-2_Stage-1_Encoded_KWALDSTEIN_202011201614.xlsx';
        else
            error('Params.trialInd can be at most 2 for MHV-1.');
        end
        
    case 'COVID-19'
         
        % Params.dilution = 10; % fold of dilution; the dilution for each pool can be different
        if Params.trialInd==1
            dataPath.fID = 'Data/COVID-19_Trial-1_Stage-1_Encoded_KWALDSTEIN_202010281100.xlsx';
        else
            error('Params.trialInd can be at most 2 for COVID-19.');
        end
        
end

Params.MatInfo = sprintf('%d by %d',Params.poolNum,Params.sampNum);
[dataPath,Params] = dataPathSetup(dataPath,Params);

% Loading data in first stage test
poolset = poolTest(Params);
poolset = poolset.dataLoader(dataPath,Params.trialNum);

% Concatenate data from the same stage but different groups if Params.ctValType = 'all'
poolset = poolset.updMixMat(dataPath);
poolset = poolset.updpoolStatus(dataPath);

%% Loading data in the subsquent stage test
% - MHV-1 2 stage 2
% 
% Modified by JYI, 12/29/2020
% - adaptive request decoding, stage by stage data loading and decoding
% - 
% 

% load the first Params.stageNum stage results
if Params.stageNum > 1
    subseqDataLoader = AdReqDataLoader(Params);

    for i=2:Params.stageNum

        dataPath = subseqDataLoader.config(i);
        poolset = subseqDataLoader.load(poolset,dataPath);

    end
end
   
    % load all the results from the first 3 stages
    % [poolset, Params] = dataSecStgConfig(poolset,Params);

%% Qualitative decoding 

poolset = poolset.status_dec(Params,Params.posNumPrior);

%% Quantitative decoding

if strcmp(Params.solver,'LOGRATIO_GRID') || strcmp(Params.solver,'MISMATCHRATIO_GRID')
    [poolset,gEngine] = poolset.vload_dec(Params);
    
    % refine grids
    gEngine = gEngine.intv_refine();
    gEngine = gEngine.vload_refine(Params);
    poolset = poolset.updsampVload(gEngine);
    
else
    poolset = poolset.vload_dec(Params);
end

%% Write results to excels
fprintf('Writing data to excel sheets...\n');
switch Params.virusID
    
    case 'MHV-1'
        
        ResDataExporter(Params,poolset);
        
    case 'COVID-19'
        
        ResDataExporter(Params,poolset);
     
end

%% Reports

% resrep_setup(poolset,Params);

% fprintf('%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d\n',poolset.MixMat)

end
