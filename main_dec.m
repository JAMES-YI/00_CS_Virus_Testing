% This file is to decode pooled sample results to obtain individual sample
% results.
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
% 
%% System Configuration
% StatusLet: B for A3_7, G for A4_15, L for A5_31
% CtValLet: C for A3_7, H for A4_15, M for A5_31

clc; clear;  

% Manual setup

Params.posNumPrior = 0; % 1 (only one is positive) or 0 (not specify the number of positives)
Params.logStatus = 'off'; % 'on' or 'off'
Params.ctValType = 'all'; % 'primary' (use only the first group of data) or 'secondary' (use only the duplicate data) or 'all' (use both the first and duplicate data)
Params.solver = 'EXHAUSTIVE'; % 'EXHAUSTIVE', 'OBO_MM', 'MISMATCHRATIO_SUCC'
Params.virusID = 'MHV1_2'; % 'MHV1', or 'COVID-19', or 'MHV1_2'
Params.tmStamp = datestr(now,'yyyymmddHHMM');
Params.dfNameExhaustiveData = sprintf('ExhaustiveData%s.mat',Params.tmStamp);
% Params.excelID = sprintf('Data/16x40 Results Exp 1_updated_prep_%s.xlsx',Params.tmStamp); 
Params.MatSize = [5,31];
Params.exhaustMaxIterSucc = 1; % 100 iterations is too big and numerical issues can occur; 
Params.MaxIterSucc = 100; % default 100; large value does not bring much benefits; for both the successive mismatch ratio minimization and the successive exhaustive LSQ;
Params.mismatchratio_norm = 'L2'; % 'L1' or 'L2' or 'L2L1'
Params.CtValDev = 1; % required for OBO_MM decoding method only; 2 for MHV1l; 0.5 for COVID-19; C:\Users\jiryi.IOWA\Dropbox\CS_Virus_Testing\Codesnoise magnitude in ct value observation; better to keep it below 3
Params.load2ndStage = 0; % 1 if load second stage data, and 0 if not
Params.radius = 1; % only used in decoding methods based on grid search;
Params.exhaustMode = 'NORMALIZED'; % 'REGULAR', 'NORMALIZED', 'SUCCESSIVE', 'MINPOS'; 
Params.earlyTolCtVal = 1.5; % should not be too big and recommended to be (0,2]; suggested value 1.5
Params.vloadMin = 1e-5; % minimal virus load achievable by positive samples

%% 
switch Params.virusID
    case 'MHV1'
        Params.poolNum = Params.MatSize(1); 
        Params.sampNum = Params.MatSize(2); 
        % Params.dilution = 4; % fold of dilution
        dataPath.fID = 'Data/MHV1 Pooled Testing Exp 1 Results 082820.xlsx';
        
    case 'COVID-19'
         
        Params.poolNum = Params.MatSize(1); 
        Params.sampNum = Params.MatSize(2); 
        % Params.dilution = 10; % fold of dilution; the dilution for each pool can be different
        dataPath.fID = 'Data/16x40 Results Exp 1_updated_prep.xlsx';
        
    case 'MHV1_2'
        Params.poolNum = Params.MatSize(1); 
        Params.sampNum = Params.MatSize(2); 
        % Params.dilution = 4; % fold of dilution
        dataPath.fID = 'Data/MHV1 Pooled Testing 1percent Experiment 2 Results_prep.xlsx';
        
end

Params.MatInfo = sprintf('%d by %d',Params.poolNum,Params.sampNum);

dataPath.sheet = 'Sheet1'; 
dataPath.InitInd = 3;

% Automatic setup
[dataPath,trialNum] = dataPathSetup(dataPath,Params);
Params.trialNum = trialNum;

%% Loading data in first stage test

poolset = poolTest(Params);
poolset = poolset.dataLoader(dataPath,trialNum);

%% Concatenate data from the same stage but different groups
poolset = poolset.updMixMat(dataPath);
poolset = poolset.updpoolStatus(dataPath);

%% Loading data in the second stage test

if Params.load2ndStage==1
    
    [poolset, Params] = dataSecStgConfig(poolset,Params);
    
end
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
switch Params.virusID
    
    case 'MHV1'
        
        Params.optExcelID = 'a';
        
    case 'COVID-19'
        
    case 'MHV1_2'
        
        write_results_mhv1_2(Params,poolset);
        
end

%% Reports

% resrep_setup(poolset,Params);

% fprintf('%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d&%d\n',poolset.MixMat)

