classdef SecStgDataLoader
% This file defines a data loader class for second 
% stage preprocessing.
% 
% Properties
% 
% Methods
% 
% Created by JYI, 09/04/2020.
%
%% 
properties(SetAccess=private)
    % attributes
    % - dataPath, a structure containing
    %   - fID, data file name
    %   - sheetID, sheet name; cell array of same size as runInd
    %   - Rg, region; cell array of same size as runInd
    
    runInd; % cell array
    fID; 
    sheetID;
    Rg;
    poolCtVal; % cell array of size (trialNum,1)
    poolStatus; % cell array of size (trialNum,1)
    MixMat; % cell array of size (trialNum,1)
    Params;
    
    
end

methods
    
    function SSDataLoader = SecStgDataLoader(dataPath,Params)
        % Constructor
        
        SSDataLoader.runInd = dataPath.runInd;
        SSDataLoader.fID = dataPath.fID;
        SSDataLoader.sheetID = dataPath.sheetID;
        SSDataLoader.Rg = dataPath.Rg;
        SSDataLoader.Params = Params;
        
    end
    
    function [SSDataLoader,dataTxt] = loadData(SSDataLoader,Params)
        
        % Load data
        trialNum = Params.trialNum;
        dataTxt = cell(trialNum,1);
        runIndLoc = SSDataLoader.runInd;
        trialNumNew = length(runIndLoc);
        
        for iTrial=1:trialNumNew
            
            if strcmp(Params.ctValType,'primary')
                [Nmrc,TxtTmp] = xlsread(SSDataLoader.fID,SSDataLoader.sheetID{iTrial},...
                                     SSDataLoader.Rg{iTrial});
                SSDataLoader.poolStatus{runIndLoc{iTrial}} = Nmrc(:,1);
                SSDataLoader.poolCtVal{runIndLoc{iTrial}} = Nmrc(:,2);
                dataTxt{runIndLoc{iTrial}} = TxtTmp; 
                % - dataTxt is a cell array; the number of elements is equal to the number of trials;
                % - each element dataTxtTmp of dataTxt is a cell array; the
                %   number of elements in dataTxtTmp is equal to the number of
                %   extra pool tests performed in the second stage
                % - runIndLoc{iTrial}is the trial index
                
            elseif strcmp(Params.ctValType,'secondary')
                [Nmrc,TxtTmp] = xlsread(SSDataLoader.fID,SSDataLoader.sheetID{iTrial},...
                     SSDataLoader.Rg{iTrial});
                Nmrc = Nmrc(:,[1,3]);
                SSDataLoader.poolStatus{runIndLoc{iTrial}} = Nmrc(:,1);
                SSDataLoader.poolCtVal{runIndLoc{iTrial}} = Nmrc(:,2);
                dataTxt{runIndLoc{iTrial}} = TxtTmp; 
            end
                
        end
        
    end
    
    function SSDataLoader = MixMatGen(SSDataLoader,dataTxt,Params)
        % Generate mixing matrix
        
        trialNum = Params.trialNum;
        sampNum = Params.sampNum;
        
        runIndLoc = SSDataLoader.runInd;
        trialNumNew = length(runIndLoc);
        SSDataLoader.MixMat = cell(trialNum,1);
        
        for iTrial=1:trialNumNew
            
            dataTxtTmp = dataTxt{runIndLoc{iTrial}};
            dataTxtSplit = cellfun(@(S) sscanf(S, '%f,').', dataTxtTmp, 'Uniform', 0);
            poolNumNew = length(dataTxtSplit);
            SSDataLoader.MixMat{runIndLoc{iTrial}} = zeros(poolNumNew,sampNum);
            
            for iPool=1:poolNumNew
                SSDataLoader.MixMat{runIndLoc{iTrial}}(iPool,dataTxtSplit{iPool}) = 1;
            end
        end
        
    end
    
end

end