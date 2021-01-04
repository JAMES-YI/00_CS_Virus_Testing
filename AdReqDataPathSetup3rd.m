function dataPath = AdReqDataPathSetup3rd(dataPath,Params)
% This file is to set up the data path for loading pooling test results
% from the second stage.
% 
% Updated by JYI, 12/29/2020
% - build on top of dataSecStgPathSetup.m
% - only the third stage data will be loaded for decoding in MHV1
% - ToDo: only the third stage data will be loaded for decoding in
% COVID-case
% - ToDo: only the third stage data will be loaded for decoding in
% MVH1_2 case
% 
%% 

MatInfo = Params.MatInfo;
ctValType = Params.ctValType;
virusID = Params.virusID; 

switch virusID
    case 'MHV1'

        if strcmp(ctValType,'primary')
            switch MatInfo

                case '3 by 7'

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '4 by 15'

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '5 by 31'

                    dataPath.runInd = {3};
                    dataPath.sheetID = {'Sheet1'};
                    dataPath.Rg = {'F11:H25'};
            end

        elseif strcmp(ctValType,'secondary')
            switch MatInfo

                case '3 by 7'

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '4 by 15'

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '5 by 31'

                    dataPath.runInd = {3};
                    dataPath.sheetID = {'Sheet1'};
                    dataPath.Rg = {'F11:I25'};
            end

        end
        
    case 'COVID-19'
        if strcmp(ctValType,'primary')
            switch MatInfo

                case '3 by 7'
                    % if no extra retests

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '16 by 40'

                    dataPath.runInd = {1,2};
                    dataPath.sheetID = {'Sheet1','Sheet1'};
                    dataPath.Rg = {'C4:E6','C10:E12'};
            end

        elseif strcmp(ctValType,'secondary')
            switch MatInfo

                case '3 by 7'

                    dataPath.runInd = {};
                    dataPath.sheetID = {};
                    dataPath.Rg = {};

                case '16 by 40'

                    dataPath.runInd = {1,2};
                    dataPath.sheetID = {'Sheet1','Sheet1'};
                    dataPath.Rg = {'C4:F4','C10:F10'};
            end

        end
end

end