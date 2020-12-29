% % Getting data
% MixMat = handles.mmsize_popup.UserData; 
% poolStatus = handles.epr_finish.UserData;
% 
% [~,nSamp] = size(MixMat); 
% trialNum = length(poolStatus); 
% posNumPrior = 0;
% 
% %% Status decoding
% 
% switch posNumPrior
% 
%     case 0
%         fprintf('Decoding pool results without knowing the number of positives individual samples...\n');
%     
%     case 1
%         fprintf('Decoding pool results with 1 positive individual sample...\n');
%     
% end
% 
% for i = 1:trialNum
% 
%     [MNeg,MPos,Pos] = pool_dec(MixMat,poolStatus{i},posNumPrior);
% %     sampMPos{i} = MPos;
% %     sampMNeg{i} = MNeg;
% %     sampPos{i} = Pos;
%     
%     tmpStatus = zeros(nSamp,1);
%     if ~isempty(MPos)
%         tmpStatus(MPos,:) = ones(length(MPos),1);
%     end
%     
%     if ~isempty(Pos)
%         tmpStatus(Pos,:) = (-3)*ones(length(Pos),1);
%     end
%     
%     sampStatus{i} = tmpStatus;
% end
% 
% handles.srd_start.UserData = sampStatus;
% 
% %% Report results
% 
% curGP = handles.epr_previous.UserData;
% srdData = sampStatus{curGP};
% 
% for iSamp=1:nSamp
%     rowNameSrd{iSamp} = sprintf('Sample %d',iSamp);
% end
% 
% colNameSrd = {'Status (0/1/-3)'};
% colEditableSrd = false;
% fgrndColor = 'k';
% 
% set(handles.srd_table,...
%     'Data',num2cell(srdData),...
%     'ColumnName',colNameSrd,'RowName',rowNameSrd,...
%     'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);

%% 
% curGP = handles.epr_previous.UserData;
% try
%     curGP = curGP-1;
% 
%     % Update epr table
%     poolStatus_selectObj = findobj('Tag','epr_finish');
%     poolStatus = poolStatus_selectObj.UserData; 
% 
%     colEditableEpr = false;
%     fgrndColor = 'k';
%     curEprData = poolStatus{curGP};
%     handles.epr_previous.UserData = curGP;
% 
%     set(handles.epr_table,...
%         'Data',num2cell(curEprData),...
%         'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
%     
%     % Update srd table
% catch
%     msgbox('This is already the first group!');
% end

%%
% Update current group index
% curGP = handles.epr_previous.UserData;
% try
%     curGP = curGP-1;
% 
%     % Update epr table
%     poolStatus_selectObj = findobj('Tag','epr_finish');
%     poolStatus = poolStatus_selectObj.UserData; 
% 
%     colEditableEpr = false;
%     fgrndColor = 'k';
%     curEprData = poolStatus{curGP};
%     handles.epr_previous.UserData = curGP;
% 
%     set(handles.epr_table,...
%         'Data',num2cell(curEprData),...
%         'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
%     
%     % Update srd table
%     sampStatus_selectObj = findobj('Tag','srd_start');
%     sampStatus = sampStatus_selectObj.UserData; 
% 
%     colEditableSrd = false;
%     fgrndColor = 'k';
%     curSrdData = sampStatus{curGP};
% 
%     set(handles.srd_table,...
%         'Data',num2cell(curSrdData),...
%         'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
%     
% catch
%     msgbox('This is already the first group!');
% end

%% 
% curGP = handles.epr_previous.UserData;
% try
%     curGP = curGP+1;
% 
%     % Update epr table
%     poolStatus_selectObj = findobj('Tag','epr_finish');
%     poolStatus = poolStatus_selectObj.UserData; 
% 
%     colEditableEpr = false;
%     fgrndColor = 'k';
%     curEprData = poolStatus{curGP};
%     handles.epr_previous.UserData = curGP;
% 
%     set(handles.epr_table,...
%         'Data',num2cell(curEprData),...
%         'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
%     
%     % Update srd table
%     sampStatus_selectObj = findobj('Tag','srd_start');
%     sampStatus = sampStatus_selectObj.UserData; 
% 
%     colEditableSrd = false;
%     fgrndColor = 'k';
%     curSrdData = sampStatus{curGP};
% 
%     set(handles.srd_table,...
%         'Data',num2cell(curSrdData),...
%         'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
%     
% catch
%     msgbox('This is already the last group!');
% end

%%
% curGP = handles.epr_previous.UserData;
% try
%     curGP = curGP+1;
% 
%     % Update epr table
%     poolStatus_selectObj = findobj('Tag','epr_finish');
%     poolStatus = poolStatus_selectObj.UserData; 
% 
%     colEditableEpr = false;
%     fgrndColor = 'k';
%     curEprData = poolStatus{curGP};
%     handles.epr_previous.UserData = curGP;
% 
%     set(handles.epr_table,...
%         'Data',num2cell(curEprData),...
%         'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
% catch
%     msgbox('This is already the last group!');
% end

%% 
% A = binornd(1,0.5,[4,5]);
% [m,n] = size(A);
% for i=1:m
%     rowNames{i,1} = sprintf('Pool %d',i);
% end
% for i=1:n
%     colNames{1,i} = sprintf('Sample%d',i);
% end
% 
% fig = uifigure;
% uit = uitable(fig);
% colEditable = false(1,n);
% fgrndColor = 'k';
% set(uit,...
%     'Data',num2cell(A),...
%     'ColumnName',colNames,'RowName',rowNames,...
%     'ColumnEditable',colEditable,'ForegroundColor',fgrndColor);
% uit.Position = [10 10 540 400];

%%
% A = table({'1,2','3,4';'5,6','7,8'});
% % [m,n] = size(A);
% % for i=1:m
% %     rowNames{i,1} = sprintf('Pool %d',i);
% % end
% % for i=1:n
% %     colNames{1,i} = sprintf('Sample%d',i);
% % end
% 
% fig = uifigure;
% uit = uitable(fig);
% fgrndColor = 'k';
% set(uit,'Data',{'1,2','3,4';'5,6','7,8'},...
%     'ForegroundColor',fgrndColor);
% uit.Position = [10 10 540 400];
% 
% rowNames = {'Pool 1';'Pool 2'};
% colNames = {'Sample_Index_Set','Sample_Index_Set'};
% 
% colEditable = false(1,n);
% fgrndColor = 'k';
% set(uit,...
%     'ColumnName',colNames,'RowName',rowNames,...
%     'ColumnEditable',colEditable,'ForegroundColor',fgrndColor);

%%

% A = randn(30,100);
% x = randn(100,1); x = max(x,0);
% y = A*x;
% posInd = find(x>0);
% 
% [m,n] = size(A);
% 
% cvx_begin quiet
% 
%     variable x_est(n,1)
%     minimize(norm(y-A*x_est,1))
%     subject to 
%         -vload_sub <= 0
% 
% cvx_end

%% plot function sum_i |y_i - (Ax)_i|/(Ax)_i

% scalar x
A = randn(5,1);
y = randn(5,1); 
x = -3:0.01:3;
f_x = sum(abs(y - A*x) ./ (A*x));
figure; 
plot(x,f_x,'-');


% x in R^2
A = randn(1,2);
y = randn(1,1);
[X1,X2] = meshgrid(-3:0.01:3,-3:0.01:3);
f_x = abs(y - A(1)*X1 - A(2)*X2) ./ (A(1)*X1 + A(2)*X2);
figure;
surf(X1,X2,f_x);