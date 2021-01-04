function ResDataExporter(Params,poolset)
% This function is to write out results for MHV-1 to excel.
%
% Build on top of write_results_mhv1_2.m
% - filename management for results
%   MHV-1_Trial-1_Stage-1_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-1_Stage-2_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-1_Stage-3_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-2_Stage-1_Decoded_JYI_202012291244.xlsx
%   MHV-1_Trial-2_Stage-2_Decoded_JYI_202012291244.xlsx
%   COVID-19_Trial-1_Stage-1_Decoded_JYI_202012291244.xlsx
%   COVID-19_Trial-1_Stage-2_Decoded_JYI_202012291244.xlsx
% 
% Created by JYI, 12/29/2002
%
% 
% ToDo
% - reduce redundancy of codes
% - export data for COVID-19

%% 

switch Params.virusID
    case 'MHV-1'
        if ~isfile(Params.optExcelID)

            template = sprintf('Data/MHV-1_Trial-%d_Decoded_JYI_Template.xlsx',Params.trialInd);
            copyfile(template,Params.optExcelID);

        end

        Params.sheetID = 'Sheet1';
        switch Params.MatInfo

            case '3 by 7'

                % write group testing decoding results
                indStart = 3;
                indEnd = 9;

                for iTrial=1:Params.trialNum
                    statusRg = sprintf('F%d:F%d',indStart,indEnd);
                    xlswrite(Params.optExcelID,poolset.sampStatus{iTrial},...
                        Params.sheetID,statusRg);

                    % write index set of potential positives
                    if isempty(poolset.sampPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampPos{iTrial});
                    end
                    posRg = sprintf('F%d',indEnd+1);
                    xlswrite(Params.optExcelID,cellstr(indPosStr),...
                        Params.sheetID,posRg);
                end

                switch Params.solver

                    case 'EXHAUSTIVE'

                        for iTrial=1:Params.trialNum
                            vloadRg = sprintf('J%d:J%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('J%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);
                        end

                    case 'OBO_MM'

                        for iTrial=1:Params.trialNum
                            vloadLbRg = sprintf('G%d:G%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadLb{iTrial},...
                                Params.sheetID,vloadLbRg);

                            vloadUbRg = sprintf('H%d:H%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadUb{iTrial},...
                                Params.sheetID,vloadUbRg);

                            % write index set of potential positives
                            if isempty(poolset.sampObommPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampObommPos{iTrial});
                            end
                            posRg = sprintf('G%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);
                        end

                    case 'MISMATCHRATIO_SUCC'

                        for iTrial=1:Params.trialNum
                            vloadRg = sprintf('I%d:I%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('I%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);
                        end

                end

            case '4 by 15'

                indInitial = 3;
                indDelta = 17;

                % write groupt testing decoding results
                for iTrial=1:Params.trialNum
                    indStart = indInitial+(iTrial-1)*indDelta;
                    indEnd = iTrial*indDelta;
                    statusRg = sprintf('Q%d:Q%d',indStart,indEnd);
                    xlswrite(Params.optExcelID,poolset.sampStatus{iTrial},...
                            Params.sheetID,statusRg);

                    % write index set of potential positives
                    if isempty(poolset.sampPos{iTrial})
                        indPosStr = 'NA';
                    else
                        indPosStr = sprintf('%d,',poolset.sampPos{iTrial});
                    end
                    posRg = sprintf('Q%d',indEnd+1);
                    xlswrite(Params.optExcelID,cellstr(indPosStr),...
                        Params.sheetID,posRg);

                end

                switch Params.solver

                    case 'EXHAUSTIVE'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('U%d:U%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('U%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                    case 'OBO_MM'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadLbRg = sprintf('R%d:R%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadLb{iTrial},...
                                    Params.sheetID,vloadLbRg);

                            vloadUbRg = sprintf('S%d:S%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadUb{iTrial},...
                                    Params.sheetID,vloadUbRg);


                            % write index set of potential positives
                            if isempty(poolset.sampObommPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampObommPos{iTrial});
                            end
                            posRg = sprintf('R%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);


                        end

                    case 'MISMATCHRATIO_SUCC'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('T%d:T%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('T%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                end

            case '5 by 31'

                indInitial = 3;
                indDelta = 33;

                % write groupt testing decoding results
                for iTrial=1:Params.trialNum
                    indStart = indInitial+(iTrial-1)*indDelta;
                    indEnd = iTrial*indDelta;
                    statusRg = sprintf('AB%d:AB%d',indStart,indEnd);
                    xlswrite(Params.optExcelID,poolset.sampStatus{iTrial},...
                            Params.sheetID,statusRg);

                    % write index set of potential positives
                    if isempty(poolset.sampPos{iTrial})
                        indPosStr = 'NA';
                    else
                        indPosStr = sprintf('%d,',poolset.sampPos{iTrial});
                    end
                    posRg = sprintf('AB%d:AB%d',indEnd+1,indEnd+1);
                    xlswrite(Params.optExcelID,cellstr(indPosStr),...
                        Params.sheetID,posRg);
                end

                switch Params.solver

                    case 'EXHAUSTIVE'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('AF%d:AF%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('AF%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                    case 'OBO_MM'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadLbRg = sprintf('AC%d:ac%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadLb{iTrial},...
                                    Params.sheetID,vloadLbRg);

                            vloadUbRg = sprintf('AD%d:AD%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadUb{iTrial},...
                                    Params.sheetID,vloadUbRg);

                            % write index set of potential positives
                            if isempty(poolset.sampObommPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampObommPos{iTrial});
                            end
                            posRg = sprintf('AD%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                    case 'MISMATCHRATIO_SUCC'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('AE%d:AE%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('AE%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                end

        end
        
        fprintf('Data has been saved in %s.\n',Params.optExcelID);

    
    %%
    case 'COVID-19'
        if ~isfile(Params.optExcelID)

            template = sprintf('Data/COVID-19_Trial-%d_Decoded_JYI_Template.xlsx',Params.trialInd);
            copyfile(template,Params.optExcelID);

        end

        Params.sheetID = 'Sheet1';
        switch Params.MatInfo
            
            %% COVID-19: 16 by 40
            case '16 by 40'

                indInitial = 3;
                indDelta = 42;

                % write groupt testing decoding results
                for iTrial=1:Params.trialNum
                    indStart = indInitial+(iTrial-1)*indDelta;
                    indEnd = iTrial*indDelta;
                    statusRg = sprintf('S%d:S%d',indStart,indEnd);
                    xlswrite(Params.optExcelID,poolset.sampStatus{iTrial},...
                            Params.sheetID,statusRg);

                    % write index set of potential positives
                    if isempty(poolset.sampPos{iTrial})
                        indPosStr = 'NA';
                    else
                        indPosStr = sprintf('%d,',poolset.sampPos{iTrial});
                    end
                    posRg = sprintf('S%d',indEnd+1);
                    xlswrite(Params.optExcelID,cellstr(indPosStr),...
                        Params.sheetID,posRg);

                end

                switch Params.solver

                    case 'EXHAUSTIVE'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('W%d:W%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('W%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                    case 'OBO_MM'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadLbRg = sprintf('T%d:T%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadLb{iTrial},...
                                    Params.sheetID,vloadLbRg);

                            vloadUbRg = sprintf('U%d:U%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.VloadUb{iTrial},...
                                    Params.sheetID,vloadUbRg);


                            % write index set of potential positives
                            if isempty(poolset.sampObommPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampObommPos{iTrial});
                            end
                            posRg = sprintf('T%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);


                        end

                    case 'MISMATCHRATIO_SUCC'

                        % 
                        for iTrial=1:Params.trialNum
                            indStart = indInitial+(iTrial-1)*indDelta;
                            indEnd = iTrial*indDelta;
                            vloadRg = sprintf('V%d:V%d',indStart,indEnd);
                            xlswrite(Params.optExcelID,poolset.sampVload{iTrial},...
                                    Params.sheetID,vloadRg);

                            % write index set of potential positives
                            if isempty(poolset.sampCsPos{iTrial})
                                indPosStr = 'NA';
                            else
                                indPosStr = sprintf('%d,',poolset.sampCsPos{iTrial});
                            end
                            posRg = sprintf('V%d',indEnd+1);
                            xlswrite(Params.optExcelID,cellstr(indPosStr),...
                                    Params.sheetID,posRg);

                        end

                end
                
        end
        
        
end


fprintf('Data has been saved in %s.\n',Params.optExcelID);
end