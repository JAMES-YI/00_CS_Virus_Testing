classdef vload2ct
% This file defines a vload2ct class.
% 
% Properties
% 
% Methods
% 
% Created by JYI, 08/25/2020
% Updated by JYI, 10/05/2020
% - use new standard curve data for interpolation from
%   standard curve 2 in Data/MHV1 Pooled Testing Exp 1 Decoded Results with Actual_with_new_standard_curve.xlsx
% 
% ToDos
% - incorporate standard curve data for Covid-19 virus from 
%   curve in Data/16x40 Results Exp 1_prep.xlsx
%
% Modified by JYI, 11/03/2020
% - incorporate standard curve data for COVID-19 virus from 
%   curve in Data/16x40 Results Exp 1_prep.xlsx 
% 
% Modified by JYI, 11/20/2020
% - incorporate standard curve data for MHV1_2 virus from 
%   MHV1 Pooled Testing 1percent Experiment 2 Results_prep.xlsx
% - the new data should be used independently rather than combined with
%   previous data from MHV1
% 
%% Properties

properties(SetAccess=private)
    
    %ctVal = [11.6855, 15.015, 18.578, 22.1035, 25.4205, 28.8295, 32.383, 35.08];
    %vload = [2200, 220, 22, 2.2, 0.22, 0.022, 0.0022, 0.00022]; 

    
%     ctVal = [10.84, 13.677, 16.996, 20.717, 24.165, 27.607, 30.911, 35.473];
%     vload = [2200, 220, 22, 2.2, 0.22, 0.022, 0.0022, 0.00022]; 
    
    ctVal;
    vload;
    virusID; 
    func_fit = 0;
    Params;

end

%% Methods

methods
    
    function convertor = vload2ct(virusID,Params)
        % Constructor
        % virusID: 'MHV1', or 'COVID-19', or 'MHV1_2'
        
        convertor.virusID = virusID;
        convertor.Params = Params;
        convertor = setStdCurveData(convertor);

    end
    
    function convertor = setStdCurveData(convertor)
        % This file loads the standard curve data for interpolation over ct value
        % and virus load.
        %
        % Created by JYI, 10/05/2020
        %
        % Modified by JYI, 10/23/2020
        % - add extra data for interpolation as suggested by Xu
        %   ctRg3 = 'AK19:AK26'
        %   vlRg3 = 'AI19:AI26'
        % - remove data for interpolation as suggested by Xu
        %   ctRg2 = 'AO19:AO32';
        %   vlRg2 = 'AQ19:AQ32';
        %
        % Updated by JYI, 11/03/2020
        % - incoporate standard curve data for COVID-19
        % 
        % Updated by JYI, 12/31/2020
        % - combine 'MHV1' and 'MHV1_2' into 'MHV-1'
        %%
        
        switch convertor.virusID
            case 'MHV-1'
                
                if convertor.Params.trialInd==1
                    
                    fID = sprintf('Data/MHV-1_Trial-1_Stage-%d_StdCurve_KWALDSTEIN_202010042110.xlsx',...
                        convertor.Params.stageNum);
                    stID = 'Sheet1';
                    ctRg1 = 'AL19:AL26';
                    %ctRg2 = 'AO19:AO32';
                    vlRg1 = 'AI19:AI26';
                    %vlRg2 = 'AQ19:AQ32';

                    ctRg3 = 'AK19:AK26';
                    vlRg3 = 'AI19:AI26';
                    
                elseif convertor.Params.trialInd==2
                    
                    fID = sprintf('Data/MHV-1_Trial-2_Stage-%d_StdCurve_KWALDSTEIN_202011201614.xlsx',...
                        convertor.Params.stageNum);
                    stID = 'Sheet1';
                    ctRg1 = 'Q2:Q9';
                    %ctRg2 = 'AO19:AO32';
                    vlRg1 = 'O2:O9';
                    %vlRg2 = 'AQ19:AQ32';

                    ctRg3 = 'R2:R9';
                    vlRg3 = 'O2:O9';
                    
                end

                ctVal1 = xlsread(fID,stID,ctRg1);
                % ctVal2 = xlsread(fID,stID,ctRg2);
                ctVal3 = xlsread(fID,stID,ctRg3);
                convertor.ctVal = [ctVal1; ctVal3]';
                % convertor.ctVal = [ctVal1; ctVal2; ctVal3]';

                vload1 = xlsread(fID,stID,vlRg1);
                % vload2 = xlsread(fID,stID,vlRg2);
                vload3 = xlsread(fID,stID,vlRg3);
                convertor.vload = [vload1; vload3]';
                % convertor.vload = [vload1; vload2; vload3]';
                
            case 'COVID-19'
                fID = sprintf('Data/COVID-19_Trial-1_Stage-%d_StdCurve_KWALDSTEIN_202010281100.xlsx',...
                        convertor.Params.stageNum);
                stID = 'Sheet1';
                
                ctRg1 = 'E24:E35';
                ctRg2 = 'F24:F35';
                vlRg1 = 'D24:D35';
                vlRg2 = 'D24:D35';
                
                ctVal1 = xlsread(fID,stID,ctRg1);
                ctVal2 = xlsread(fID,stID,ctRg2);
                convertor.ctVal = [ctVal1; ctVal2]';
                
                vload1 = xlsread(fID,stID,vlRg1);
                vload2 = xlsread(fID,stID,vlRg2);
                convertor.vload = [vload1; vload2]';
                
%             case 'MHV1_2'
%                 fID = 'Data/MHV1 Pooled Testing 1percent Experiment 2 Results_prep.xlsx';
%                 stID = 'Sheet1';
%                 ctRg1 = 'Q2:Q9';
%                 %ctRg2 = 'AO19:AO32';
%                 vlRg1 = 'O2:O9';
%                 %vlRg2 = 'AQ19:AQ32';
% 
%                 ctRg3 = 'R2:R9';
%                 vlRg3 = 'O2:O9';
% 
%                 ctVal1 = xlsread(fID,stID,ctRg1);
%                 % ctVal2 = xlsread(fID,stID,ctRg2);
%                 ctVal3 = xlsread(fID,stID,ctRg3);
%                 convertor.ctVal = [ctVal1; ctVal3]';
%                 % convertor.ctVal = [ctVal1; ctVal2; ctVal3]';
% 
%                 vload1 = xlsread(fID,stID,vlRg1);
%                 % vload2 = xlsread(fID,stID,vlRg2);
%                 vload3 = xlsread(fID,stID,vlRg3);
%                 convertor.vload = [vload1; vload3]';
%                 % convertor.vload = [vload1; vload2; vload3]';
        end
    
    end
    
    function convertor = datafit(convertor)
        % Fit over data
        % - fit() only accepts column vector x, and column vector y
        
        convertor.func_fit = fit(log10(convertor.vload)',convertor.ctVal','poly1');
        
    end
    
    function ctVal = ctVal_prd(convertor,vload)
        % Predict the virus load for given ct values
        % - truncate ctVal into range [10,50]
        
        ctVal = convertor.func_fit(log10(vload));
        ctVal = max(10,min(ctVal,40));
        ind40 = find(ctVal==40);
        ctVal(ind40) = 50;
    end
    
    function a = TBD(a)
        a = 0;
    end
    
end

end