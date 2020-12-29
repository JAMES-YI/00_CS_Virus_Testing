function [poolset, Params] = dataSecStgConfig(poolset,Params)
% This file is to set up the configuration for loading adaptive testing
% results for decoding.
%
% Created by JYI, 11/06/2020
%
%% 
switch Params.virusID
    case 'MHV1'
        dataSecStgPath.fID = 'Data/MHV1 Re-Test Results.xlsx';

        if strcmp(Params.ctValType,'primary')
            dataSecStgPath = dataSecStgPathSetup(dataSecStgPath,Params);

            % fID = 'Data/MHV1 Re-Test Results.xlsx';
            % [num,txt] = xlsread(fID,'Sheet1','F10:I14');
            % cell_dat = {'13,15,21'; '42,40,47,11,30'; '15,51,23'; '67,76'};
            % cell_dat_split = cellfun(@(S) sscanf(S, '%f,').', cell_dat, 'Uniform', 0);

            SSDataLoader = SecStgDataLoader(dataSecStgPath,Params);
            [SSDataLoader,dataTxt] = SSDataLoader.loadData(Params);
            SSDataLoader = SSDataLoader.MixMatGen(dataTxt,Params);

            % Concatenate data from first stage and second stage

            poolset = poolset.data_stg_concat(SSDataLoader);

        elseif strcmp(Params.ctValType,'secondary')

            dataSecStgPath = dataSecStgPathSetup(dataSecStgPath,Params);

            % fID = 'Data/MHV1 Re-Test Results.xlsx';
            % [num,txt] = xlsread(fID,'Sheet1','F10:I14');
            % cell_dat = {'13,15,21'; '42,40,47,11,30'; '15,51,23'; '67,76'};
            % cell_dat_split = cellfun(@(S) sscanf(S, '%f,').', cell_dat, 'Uniform', 0);

            SSDataLoader = SecStgDataLoader(dataSecStgPath,Params);
            [SSDataLoader,dataTxt] = SSDataLoader.loadData(Params);
            SSDataLoader = SSDataLoader.MixMatGen(dataTxt,Params);

            % Concatenate data from first stage and second stage

            poolset = poolset.data_stg_concat(SSDataLoader);

        elseif strcmp(Params.ctValType,'all')
            [poolset,Params] = dataSecStgLoadAll(poolset,Params,dataSecStgPath);
        end

    case 'COVID-19'

        dataSecStgPath.fID = 'Data/16x40 Exp 1 Retest Results_prep.xlsx';

        if strcmp(Params.ctValType,'primary')
            dataSecStgPath = dataSecStgPathSetup(dataSecStgPath,Params);

            % fID = 'Data/MHV1 Re-Test Results.xlsx';
            % [num,txt] = xlsread(fID,'Sheet1','F10:I14');
            % cell_dat = {'13,15,21'; '42,40,47,11,30'; '15,51,23'; '67,76'};
            % cell_dat_split = cellfun(@(S) sscanf(S, '%f,').', cell_dat, 'Uniform', 0);

            SSDataLoader = SecStgDataLoader(dataSecStgPath,Params);
            [SSDataLoader,dataTxt] = SSDataLoader.loadData(Params);
            SSDataLoader = SSDataLoader.MixMatGen(dataTxt,Params);

            % Concatenate data from first stage and second stage

            poolset = poolset.data_stg_concat(SSDataLoader);

        elseif strcmp(Params.ctValType,'secondary')

            dataSecStgPath = dataSecStgPathSetup(dataSecStgPath,Params);

            % fID = 'Data/MHV1 Re-Test Results.xlsx';
            % [num,txt] = xlsread(fID,'Sheet1','F10:I14');
            % cell_dat = {'13,15,21'; '42,40,47,11,30'; '15,51,23'; '67,76'};
            % cell_dat_split = cellfun(@(S) sscanf(S, '%f,').', cell_dat, 'Uniform', 0);

            SSDataLoader = SecStgDataLoader(dataSecStgPath,Params);
            [SSDataLoader,dataTxt] = SSDataLoader.loadData(Params);
            SSDataLoader = SSDataLoader.MixMatGen(dataTxt,Params);

            % Concatenate data from first stage and second stage

            poolset = poolset.data_stg_concat(SSDataLoader);

        elseif strcmp(Params.ctValType,'all')
            [poolset,Params] = dataSecStgLoadAll(poolset,Params,dataSecStgPath);
        end


end

end