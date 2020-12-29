classdef ct2vload
% 
% This file defines a class named ct2vload which convers ct values to virus load (ng/ul)
% via interpolation.
%
% - data for interpolation 
%   ct value, [11.6855, 15.015, 18.578, 22.1035, 25.4205, 28.8295, 32.383, 35.08]
%   virus load, [2200, 220, 22, 2.2, 0.22, 0.022, 0.0022, 0.00022]
% 
% - properties
%     ctVal and vload: for data fitting
%         
% - methods
%     ct2vload(): constructor
%     datafit(): fitting virus load and ct number
%     vload_prd(): predict the virus load
%
% Created by JYI, 08/25/2020
% Updated by JYI, 10/04/2020
% - use new standard curve data for interpolation from
%   standard curve 2 in Data/MHV1 Pooled Testing Exp 1 Decoded Results with Actual_with_new_standard_curve.xlsx
% 
% Updated by JYI, 10/26/2020
% - incorporate standard curve data for interpolation from 
%   Curve in Data/16x40 Results Exp 1_prep.xlsx
% - do not use the above data, but use the following
%   Curve in Data/16x40 Results Exp 1_updated_prep.xlsx
%
% Updated by JYI, 11/20/2020
% - incorporate standard curve data for interpolation from 
%   MHV1 Pooled Testing 1percent Experiment 2 Results_prep.xlsx
% - the new data should be used independently rather than combined with
%   data from previous MHV1 experiments
% 
% 
%% Properties
properties(SetAccess=private)
    
   % ctVal = [11.6855, 15.015, 18.578, 22.1035, 25.4205, 28.8295, 32.383, 35.08];
   % vload = [2200, 220, 22, 2.2, 0.22, 0.022, 0.0022, 0.00022]; 
   
   % ctVal = [10.84, 13.677, 16.996, 20.717, 24.165, 27.607, 30.911, 35.473];
   % vload = [2200, 220, 22, 2.2, 0.22, 0.022, 0.0022, 0.00022];
    
    ctVal;
    vload;
    virusID;
    func_fit = 0;

end


%% Methods

methods
    
    function convertor = ct2vload(virusID)
        % Constructor
        % - virusID: 'MHV1', or 'COVID-19'
        %
        
        convertor.virusID = virusID;
        convertor = setStdCurveData(convertor);
        
    end
    
    function convertor = setStdCurveData(convertor)
        % This file loads the standard curve data for interpolation over ct value
        % and virus load.
        %
        % Created by JYI, 10/05/2020
        % 
        % Modified by JYI, 10/23/2020
        % - add extra data for interpolation; this is suggested by Xu
        %   ctRg3 = 'AK19:AK26'
        %   vlRg3 = 'AI19:AI26'
        % - remove data from the experiments; suggested by Xu
        %   ctRg2 = 'AO19:AO32';
        %   vlRg2 = 'AQ19:AQ32';
        %%
        
        switch convertor.virusID
            case 'MHV1'
                fID = 'Data/MHV1 Pooled Testing Exp 1 Decoded Results with Actual_with_new_standard_curve.xlsx';
                stID = 'Sheet1';
                ctRg1 = 'AL19:AL26';
                % ctRg2 = 'AO19:AO32';
                vlRg1 = 'AI19:AI26';
                % vlRg2 = 'AQ19:AQ32';

                ctRg3 = 'AK19:AK26';
                vlRg3 = 'AI19:AI26';


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
                fID = 'Data/16x40 Results Exp 1_updated_prep.xlsx';
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
                
            case 'MHV1_2'
                
                fID = 'Data/MHV1 Pooled Testing 1percent Experiment 2 Results_prep.xlsx';
                stID = 'Sheet1';
                ctRg1 = 'Q2:Q9';
                % ctRg2 = 'AO19:AO32';
                vlRg1 = 'O2:O9';
                % vlRg2 = 'AQ19:AQ32';

                ctRg3 = 'R2:R9';
                vlRg3 = 'O2:O9';


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
                
        end
    end
    
    function convertor = datafit(convertor)
        % Fit over data
        % - fit() only accepts column vector x, and column vector y
        
        convertor.func_fit = fit(convertor.ctVal',log10(convertor.vload)','poly1');
        
    end
    
    function vload = vload_prd(convertor,ctVal)
        % Predict the virus load for given ct values
        % - truncation is performed so that the virus load is within a
        % certain range [1.0407e-5,2.3157e+3]
        % - truncation is removed by JYI on 09/01/2020
        % - if ct Value greater than 50, set the virus load to be 0;
        %   
        
        samInd = find(ctVal<=50);
        ctSam = ctVal(samInd);
        vload = zeros(size(ctVal)); 
        

        vloadSam = 10.^(convertor.func_fit(ctSam));
        vload(samInd) = vloadSam;
        
        %         vloadLower = convertor.func_fit(40);
        %         vloadUpper = convertor.func_fit(10);
%         vload = max(min(vloadUpper,vload),vloadLower);
        
        
    end
    
end



end


