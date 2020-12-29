function stp = stp_rule(data,stpType)
% This function will return a step size according to the 
% the input specification for project negative subgradient method.
% 
% stpType, 'CONST_STEP', 'CONST_DIST', 'SQ_SUMMABLE'
%          'NONSUM_DIMINISH'
% 
% Reference
% [1] S. Boyd, L. Xiao, A. Mutapcic. Subgradient methods. Stanford
%     EE392o lecture notes, 2003.
% Created by JYI, 09/10/2020
%
%% 

switch stpType
    
    case 'CONST_STEP' 
        
        stp = data.gam;
        
    case 'CONST_DIST'
        
        stp = data.gam / norm(data.grad,2);
        
    case 'SQ_SUMMABLE'
        
        stp = data.a/(data.b + data.iIter);
        
    case 'NONSUM_DIMINISH'
        
        stp = data.a / sqrt(data.iIter);

end

end