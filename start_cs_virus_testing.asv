% This file will set up the parameters for compressed sensing based virus
% testing, and perform testing.
%
% Created by JYI, 12/31/2020
% 
clc; clear; 
%%
config.virusID = 'COVID-19'; % 'MHV-1', or 'COVID-19'
config.trialInd = 1; % index of the independent experiments to consider; each independent experiment contains
% results from the {stage 1, stage 2, ...} if adaptive request decoding is
% performed; trialInd (which is actually the number of experiments) 
% and the trialNum (which is actually the number of runs) are completely different;
% totally 2 independent trial experiments are conducted for
% MHV-1; totally 1 independent trial experiment is done for COVID-19
config.stageNum = 2; % fit to adaptive request decoding scheme; 
% use the results from the first n stages for decoding; 
% maximal value for MHV-1 is 3 in trail 1; maximal value for MHV-1 is 2 in
% trial 2;
% maximal value for COVID-19 is 2 in trial 1;

MatSizeList = [16,40]; % each row is a matrix size
solverList = {'MISMATCHRATIO_SUCC'}; % {'EXHAUSTIVE', 'OBO_MM', 'MISMATCHRATIO_SUCC'};

%% Decoding and generate full report
for iSize=1:size(MatSizeList,1)
    for iSolver=1:length(solverList)
        config.MatSize = MatSizeList(iSize,:); % size of participation matrix in {0,1}^{n,N}; [3,7], [4,15], or [5,31] for MHV-1;
        % [16,40] for COVID-19
        config.solver = solverList{iSolver}; % 'EXHAUSTIVE', 'OBO_MM', 'MISMATCHRATIO_SUCC'
        
        poolset = main_dec(config);
    end
end

