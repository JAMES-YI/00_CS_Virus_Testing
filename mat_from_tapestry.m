% This file will generate the mixing matrix from
% [1] Ghosh et al. Tapestry: a single-round smart 
% pooling technique for COVID-19 testing. medRxiv, 2020.

% Created by JYI, 10/14/2020
%
%% 16 by 40

IndOneCol = {[4,9,10],...
             [1,2,12],...
             [4,11,13],...
             [6,10,16],...
             [2,4,15],...
             [3,5,16],...
             [12,13,16],...
             [3,7,10],...
             [3,15,16],...
             [5,7,11],...
             [2,8],...
             [3,6,13],...
             [1,8,13],...
             [1,5,14],...
             [4,12,14],...
             [9,11,12],...
             [2,5,11],...
             [1,6],...
             [8,10,15],...
             [6,12,15],...
             [4,5,13],...
             [8,9,16],...
             [3,8,12],...
             [2,6,14],...
             [4,7,11],...
             [10,13,14],...
             [2,7,13],...
             [9,13,15],...
             [4,12,16],...
             [3,14],...
             [5,9,10],...
             [3,4,9],...
             [11,14,16],...
             [1,11,15],...
             [1,2,15],...
             [5,6,8],...
             [6,10,11],...
             [7,9,14],...
             [1,7,16],...
             [7,11,15]};
A16b40 = zeros(16,40);
for i=1:40
    ind = IndOneCol{i};
    A16b40(ind,i) = 1;
end

imshow(A16b40);

%% 24 by 60
IndOneRow = {[9,28,38,46,54,55],...
             [10,27,30,36,41,49,54],...
             [2,5,25,34,37,47,56],...
             [4,17,22,29,33,47,57],...
             [8,25,32,40,43,59],...
             [9,16,33,36,40,53,60],...
             [2,16,24,45,48,50,51],...
             [6,11,37,42,45,55],...
             [1,21,29,35,40,41,55],...
             [9,17,18,20,37,49,58],...
             [10,20,23,29,39,56,58],...
             [3,13,14,16,23,31,34],...
             [21,23,27,33,44,46,59],...
             [1,5,6,10,18,24,57],...
             [5,7,14,26,48,52],...
             [12,13,18,19,26,27,43,],...
             [22,26,28,35,44,53],...
             [3,19,21,39,45,47,49],...
             [15,20,22,41,43,51,60],...
             [8,12,20,30,38,50],...
             [2,13,15,39,52,57,59],...
             [7,17,24,25,30,31,42,],...
             [4,11,19,34,50,52,60],...
             [4,31,32,35,36,46,51]};
A24b60 = zeros(24,60);
for i=1:24
    try
       ind = IndOneRow{i};
       A24b60(i,ind) = 1;
    catch
        i
    end
end

imshow(A24b60);

%% save data

typestryData.A16b40 = A16b40;
typestryData.A24b60 = A24b60;
save('typestryData.mat','typestryData');