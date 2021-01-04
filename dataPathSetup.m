function [dataPath,Params] = dataPathSetup(dataPath,Params)
% This function is to set up the data path for reading data from
% xlsx files.
% 
% input argument
% - MatInfo
% - ctValType
% - dataPath
% - Params
% output argument
% - dataPath
%
% Created by JYI, 08/28/2020
% 
% Updated by JYI, 10/27/2020
% - incorporate data from COVID-19 using bipartite matrix of size 16 by 40
%
% Updated by JYI, 11/20/2020
% - incorporate new data from MHV1; the new data from MHV1 should be used
%   independently rather than combined with the previous MHV1 test data;
% 
% Updated by JYI, 12/30/2020
% - change MHV1 to MHV-1
% - combine MHV1 and MHV1_2 into MHV-1
% - initialize the index and the sheet name
% - updata Params
% 
%% 
virusID = Params.virusID;
MatInfo = Params.MatInfo;
ctValType = Params.ctValType;

dataPath.sheet = 'Sheet1'; 
dataPath.InitInd = 3;

switch virusID
    
    %% MHV-1
    case 'MHV-1'
        switch MatInfo

            %% sensing matrix 3 by 7
            case '3 by 7'
                dataPath.StatusLet = 'B'; 

                if strcmp(ctValType,'primary')
                    dataPath.CtValLet = {'C'};
                elseif strcmp(ctValType,'secondary')
                    dataPath.CtValLet = {'D'};
                elseif strcmp(ctValType,'all')
                    dataPath.CtValLet = {'C','D'};
                else
                    error('Error in selecting ct value type! Choose either primary or secondary');
                end

                trialNum = 1;

            case '4 by 15'
                dataPath.StatusLet = 'G'; 

                if strcmp(ctValType,'primary')
                    dataPath.CtValLet = {'H'};
                elseif strcmp(ctValType,'secondary')
                    dataPath.CtValLet = {'I'};
                elseif strcmp(ctValType,'all')
                    dataPath.CtValLet = {'H','I'};
                else
                    error('Error in selecting ct value type! Choose either primary or secondary');
                end

                trialNum = 5;

            case '5 by 31'

                dataPath.StatusLet = 'L'; 

                if strcmp(ctValType,'primary')
                    dataPath.CtValLet = {'M'};
                elseif strcmp(ctValType,'secondary')
                    dataPath.CtValLet = {'N'};
                elseif strcmp(ctValType,'all')
                    dataPath.CtValLet = {'M','N'};
                else
                    error('Error in selecting ct value type! Choose either primary or secondary');
                end

                trialNum = 7;
        end
        
        %% COVID-19
    case 'COVID-19'
        
        switch MatInfo
            
            case '16 by 40'
                dataPath.StatusLet = 'L'; 

                if strcmp(ctValType,'primary')
                    dataPath.CtValLet = {'M'};
                elseif strcmp(ctValType,'secondary')
                    dataPath.CtValLet = {'N'};
                elseif strcmp(ctValType,'all')
                    dataPath.CtValLet = {'M','N'};
                else
                    error('Error in selecting ct value type! Choose either primary or secondary');
                end

                trialNum = 2;
        end
        
end

Params.trialNum = trialNum;
end