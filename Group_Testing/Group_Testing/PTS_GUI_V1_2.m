function varargout = PTS_GUI_V1_2(varargin)
%PTS_GUI_V1_2 MATLAB code file for PTS_GUI_V1_2.fig
%      PTS_GUI_V1_2, by itself, creates a new PTS_GUI_V1_2 or raises the existing
%      singleton*.
%
%      H = PTS_GUI_V1_2 returns the handle to a new PTS_GUI_V1_2 or the handle to
%      the existing singleton*.
%
%      PTS_GUI_V1_2('Property','Value',...) creates a new PTS_GUI_V1_2 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PTS_GUI_V1_2_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PTS_GUI_V1_2('CALLBACK') and PTS_GUI_V1_2('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PTS_GUI_V1_2.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PTS_GUI_V1_2

% Last Modified by GUIDE v2.5 13-Sep-2020 19:29:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PTS_GUI_V1_2_OpeningFcn, ...
                   'gui_OutputFcn',  @PTS_GUI_V1_2_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PTS_GUI_V1_2 is made visible.
function PTS_GUI_V1_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PTS_GUI_V1_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PTS_GUI_V1_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PTS_GUI_V1_2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in mmsize_popup.
function mmsize_popup_Callback(hObject, eventdata, handles)
% hObject    handle to mmsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mmsize_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mmsize_popup
clc; 
matrix_manu = get(handles.mmsize_popup,'String');

% Generate pooling matrix
switch matrix_manu{get(handles.mmsize_popup,'Value')}
    
    case 'Not Specified'
        
        % set default data to be empty
        handles.mmsize_popup.UserData = [];
        handles.epr_finish.UserData = [];
        handles.srd_save.UserData = [];
        
    case '5 by 10'
        
        MixMat = poolMatrixGen(5,10);
        
    case '6 by 15'
        
        MixMat = poolMatrixGen(6,15);
        
    case '7 by 21'
        
        MixMat = poolMatrixGen(7,21);
        
    case '8 by 28'
        
        MixMat = poolMatrixGen(8,28);
        
    case '9 by 36'
        
        MixMat = poolMatrixGen(9,36);
        
    case '10 by 45'
        
        MixMat = poolMatrixGen(10,45);
        
    case '11 by 55'
        
        MixMat = poolMatrixGen(11,55);
        
    case '12 by 66'
        
        MixMat = poolMatrixGen(12,66);
        
    case '13 by 78'
        
        MixMat = poolMatrixGen(13,78);
        
    case '14 by 91'
        
        MixMat = poolMatrixGen(14,91);
        
    case '15 by 105'
        
        MixMat = poolMatrixGen(15,105);
        
    case '16 by 120'
        
        MixMat = poolMatrixGen(16,120);
        
    case '17 by 136'
        
        MixMat = poolMatrixGen(17,136);
        
    case '18 by 153'
        
        MixMat = poolMatrixGen(18,153);
        
    case '19 by 171'
        
        MixMat = poolMatrixGen(19,171);
        
    case '20 by 190'
        
        MixMat = poolMatrixGen(20,190);
        
    case '21 by 210'
        
        MixMat = poolMatrixGen(21,210);
        
    case '22 by 231'
        
        MixMat = poolMatrixGen(22,231);
        
    case '23 by 253'
        
        MixMat = poolMatrixGen(23,253);
        
    case '24 by 276'
        
        MixMat = poolMatrixGen(24,276);
        
    case '25 by 300'
        
        MixMat = poolMatrixGen(25,300);
        
    case '26 by 325'
        
        MixMat = poolMatrixGen(26,325);
        
    case '27 by 351'
        
        MixMat = poolMatrixGen(27,351);
        
    case '28 by 378'
        
        MixMat = poolMatrixGen(28,378);
        
    case '29 by 406'
        
        MixMat = poolMatrixGen(29,406);
        
    case '30 by 435'
        
        MixMat = poolMatrixGen(30,435);
    
end

% Set default mmd table, epr table, srd table
set(handles.mmd_table,'Data',num2cell([]),...
    'ColumnName',{'1','2'},'RowName',{'1','2','3','4'},...
    'ColumnEditable',[false,false]);
set(handles.epr_table,'Data',num2cell([]),...
    'ColumnName',{'1','2'},'RowName',{'1','2','3','4'},...
    'ColumnEditable',[false,false]);
set(handles.srd_table,'Data',num2cell([]),...
    'ColumnName',{'1','2'},'RowName',{'1','2','3','4'},...
    'ColumnEditable',[false,false]);

% Save pooling matrix
if exist('MixMat')
    
    set(handles.mmsize_popup,'UserData',MixMat);
    % Reset @file name
%     [nPool,nSamp] = size(MixMat);
%     fName = sprintf('Group_Testing_%d_by_%d_%s.xls',...
%         nPool,nSamp,datestr(now,'yyyymmddHHMM'));
%     handles.mmGen.UserData = fName;
    
    

else
    msgbox('Please select the size of mixing matrix!');
    % setappdata(0,'poolMatrix',poolMatrix);
end


%%

% --- Executes during object creation, after setting all properties.
function mmsize_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mmsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mmGen.
function mmGen_Callback(hObject, eventdata, handles)
% hObject    handle to mmGen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Display mixing matrix

try 
    mat_selectObj = findobj('Tag','mmsize_popup');
    Mat = mat_selectObj.UserData; 

    cellMat = num2cell(Mat);
    [nPool,nSamp] = size(Mat); 

    for i=1:nPool
        rowName{i} = sprintf('Pool %d',i);
    end

    for i=1:nSamp
        colName{i} = sprintf('Sample %d',i);
    end

    colEditable = false(1,nSamp);

    set(handles.mmd_table,'Data',cellMat,...
        'ColumnName',colName,'RowName',rowName,'ColumnEditable',colEditable);

catch
    msgbox('The size of mixing matrix is not specified.');
    
end

% Reset pooling results
handles.epr_finish.UserData = [];


% Reset decoding results
handles.srd_save.UserData = [];

% Reset group counter
cnter = sprintf('Group %d/%d',0,0);
handles.epr_counter.String = cnter;

% Reset file name for saving data
fName = sprintf('Group_Testing_%d_by_%d_%s.xls',...
    nPool,nSamp,datestr(now,'yyyymmddHHMM'));
handles.mmGen.UserData = fName;
%% Initialize pooling results entering table

% handles.output = hObject;

% Update handles structure
% guidata(hObject, handles);

[nPools,~] = size(Mat);
for iPool=1:nPools
    rowNameEpr{iPool} = sprintf('Pool %d',iPool);
end

colNameEpr = {'Status (0/1/-3)'};
colEditableEpr = false;
fgrndColor = 'k';

defaultEprData = Inf*ones(nPools,1);
set(handles.epr_table,...
    'Data',num2cell(defaultEprData),...
    'ColumnName',colNameEpr,'RowName',rowNameEpr,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);

% --- Executes on button press in epr_start.
function epr_start_Callback(hObject, eventdata, handles)
% hObject    handle to epr_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mat_selectObj = findobj('Tag','mmsize_popup');
Mat = mat_selectObj.UserData; 

[nPools,~] = size(Mat);
for iPool=1:nPools
    rowNameEpr{iPool} = sprintf('Pool %d',iPool);
end

colNameEpr = {'Status (0/1/-3)'};
colEditableEpr = true;
fgrndColor = 'g';
defaultEprData = Inf*ones(nPools,1);

try
    set(handles.epr_table,...
        'Data',num2cell(defaultEprData),...
        'ColumnName',colNameEpr,'RowName',rowNameEpr,...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
catch
    msgbox('Please generate the mixing matrix first!');
end

% --- Executes on button press in epr_finish.
function epr_finish_Callback(hObject, eventdata, handles)
% hObject    handle to epr_finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Acquire data
tabFnsh = handles.epr_table;
tabData = get(tabFnsh,'Data');
poolStatusTmp = cell2mat(tabData); % either the newly entered results or the revised results

%% Store pooling results data
if isempty(handles.epr_revise.UserData) % no revision operation
    if isempty(handles.epr_finish.UserData)
        poolStatus{1} = poolStatusTmp;

        gpInd = 1;
        handles.epr_previous.UserData = gpInd;

    else
        poolStatus = handles.epr_finish.UserData;
        poolStatus{end+1} = poolStatusTmp;

        gpInd = handles.epr_previous.UserData+1;
        handles.epr_previous.UserData = gpInd;

    end
else
    % revision operation is performed
    gpInd = handles.epr_revise.UserData;
    poolStatus = handles.epr_finish.UserData;
    poolStatus{gpInd} = poolStatusTmp; % only update the pooling results, but not update the group index
end

handles.epr_finish.UserData = poolStatus; % contains all the groups of data 

%% Update counter
nGP = length(poolStatus);
cnter = sprintf('Group %d/%d',gpInd,nGP);
handles.epr_counter.String = cnter;

%% Decoding sample status
% - only pools with 1 or 0 will be used for decoding

MixMat = handles.mmsize_popup.UserData; 
[nPool,nSamp] = size(MixMat);
N3Ind = find(poolStatusTmp==-3);
poolStatusTmpSure = poolStatusTmp(setdiff(1:nPool,N3Ind),1); % remove -3 pools
 
Params.posNum = 0;

switch Params.posNum

    case 0
        fprintf('Decoding pool results without knowing the number of positives individual samples...\n');
    
    case 1
        fprintf('Decoding pool results with 1 positive individual sample...\n');
    
end

[~,MPos,Pos] = pool_dec_spb(MixMat(setdiff(1:nPool,N3Ind),:),poolStatusTmpSure,Params);

tmpStatus = zeros(nSamp,1);
if ~isempty(MPos)
    tmpStatus(MPos,:) = ones(length(MPos),1);
end

if ~isempty(Pos)
    tmpStatus(Pos,:) = (-3)*ones(length(Pos),1);
end

%% Store sample decoding results
if isempty(handles.epr_revise.UserData) % no revision is performed
    if isempty(handles.srd_save.UserData)
        sampStatus{1} = tmpStatus;

    else
        sampStatus = handles.srd_save.UserData;
        sampStatus{end+1} = tmpStatus;

    end
else
    sampStatus = handles.srd_save.UserData;
    sampStatus{gpInd} = tmpStatus;
    
end

handles.srd_save.UserData = sampStatus;

% Set epr_revise default data to be empty
handles.epr_revise.UserData = [];

%% Epr table & Srd table setup

% Epr table
colEditableEpr = false;
fgrndColor = 'k';
set(handles.epr_table,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);

% Srd table
srdData = tmpStatus;

for iSamp=1:nSamp
    rowNameSrd{iSamp} = sprintf('Sample %d',iSamp);
end

colNameSrd = {'Status (0/1/-3)'};
colEditableSrd = false;
fgrndColor = 'k';

set(handles.srd_table,...
    'Data',num2cell(srdData),...
    'ColumnName',colNameSrd,'RowName',rowNameSrd,...
    'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);

% --- Executes on button press in epr_previous.
function epr_previous_Callback(hObject, eventdata, handles)
% hObject    handle to epr_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update current group index
curGP = handles.epr_previous.UserData;
try
    curGP = curGP-1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','epr_finish');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.epr_previous.UserData = curGP;

    set(handles.epr_table,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
    
    % Update srd table
    sampStatus = handles.srd_save.UserData; 

    colEditableSrd = false;
    fgrndColor = 'k';
    curSrdData = sampStatus{curGP};

    set(handles.srd_table,...
        'Data',num2cell(curSrdData),...
        'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
    
    % Update counter
    nGP = length(poolStatus);
    cnter = sprintf('Group %d/%d',curGP,nGP);
    handles.epr_counter.String = cnter;
    
catch
    msgbox('This is already the first group!');
end

% --- Executes on button press in epr_next.
function epr_next_Callback(hObject, eventdata, handles)
% hObject    handle to epr_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

curGP = handles.epr_previous.UserData;
try
    curGP = curGP+1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','epr_finish');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.epr_previous.UserData = curGP;

    set(handles.epr_table,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
    
    % Update srd table
    sampStatus_selectObj = findobj('Tag','srd_save');
    sampStatus = sampStatus_selectObj.UserData; 

    colEditableSrd = false;
    fgrndColor = 'k';
    curSrdData = sampStatus{curGP};

    set(handles.srd_table,...
        'Data',num2cell(curSrdData),...
        'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
    
    % Update counter
    nGP = length(poolStatus);
    cnter = sprintf('Group %d/%d',curGP,nGP);
    handles.epr_counter.String = cnter;
    
catch
    msgbox('This is already the last group!');
end

% --- Executes on button press in srd_previous.
function srd_previous_Callback(hObject, eventdata, handles)
% hObject    handle to srd_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in srd_next.
function srd_next_Callback(hObject, eventdata, handles)
% hObject    handle to srd_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in srd_save.
function srd_save_Callback(hObject, eventdata, handles)
% hObject    handle to srd_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

warning('off','all');
if isempty(handles.mmsize_popup.UserData)
    msgbox('Please generate the mixing matrix first!');
elseif isempty(handles.epr_finish.UserData)
    msgbox('Please enter pooling results first!');
elseif isempty(handles.srd_save.UserData)
    msgbox('Please decode the pooling results first!');
else
    poolStatus = handles.epr_finish.UserData;
    sampStatus = handles.srd_save.UserData;
    MixMat = handles.mmsize_popup.UserData;
    [nPool,nSamp] = size(MixMat);
    poolInd = (1:nPool)'; sampInd = (1:nSamp)';
    poolColNames = {'Pool_Index','Pool_Status_1_0_N3'};
    sampColNames = {'Sample_Index','Sample_Status_1_0_N3'};
    fName = handles.mmGen.UserData;
    trialNum = length(sampStatus);
    
    for i=1:nPool
        rowNames{i,1} = sprintf('Pool %d',i);
    end

    colNames = {'Pool_Sample','Sample'};

    mixmatT = table(rowNames,MixMat,'VariableName',colNames);
    writetable(mixmatT,fName,...
        'Sheet','MixMat','Range','A1',...
        'WriteVariableNames',true);
    
    for i=1:trialNum
        sheetName = sprintf('Group %d',i);
        
        poolT = table(poolInd,poolStatus{trialNum},...
            'VariableName',poolColNames);
        writetable(poolT,fName,...
            'Sheet',sheetName,'Range','B1',...
            'WriteVariableNames',true);

        sampT = table(sampInd,sampStatus{trialNum},...
            'VariableName',sampColNames);
        writetable(sampT,fName,'Sheet',sheetName,'Range','E1',...
            'WriteVariableNames',true);
    end

    msgCont = sprintf('Data has been saved in %s in %s.',fName,pwd);
    msgbox(msgCont);
end


% --- Executes on button press in srd_start.
function srd_start_Callback(hObject, eventdata, handles)
% hObject    handle to srd_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in mmd_table.
function mmd_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to mmd_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in epr_table.
function epr_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to epr_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in srd_table.
function srd_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to srd_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mmd_read.
function mmd_read_Callback(hObject, eventdata, handles)
% hObject    handle to mmd_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.mmsize_popup.UserData)
    msgbox('Please generate a mixing matrix first!');
    
else
    MixMat = handles.mmsize_popup.UserData;
    [nPool,nSamp] = size(MixMat);
    for i=1:nPool
        rowNames{i,1} = sprintf('Pool %d',i);
    end
    for i=1:nSamp
        colNames{1,i} = sprintf('Sample%d',i);
    end

    fig = uifigure;
    uit = uitable(fig);
    colEditable = false(1,nSamp);
    fgrndColor = 'k';
    set(uit,'Data',num2cell(MixMat),...
        'ColumnName',colNames,'RowName',rowNames,...
        'ColumnEditable',colEditable,'ForegroundColor',fgrndColor);
    uit.Position = [10 10 540 400];
end



% --- Executes during object creation, after setting all properties.
function text13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in mmd_participation.
function mmd_participation_Callback(hObject, eventdata, handles)
% hObject    handle to mmd_participation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.mmsize_popup.UserData)
    msgbox('Please generate a mixing matrix first!')
else
    
    MixMat = handles.mmsize_popup.UserData; 
    [nPool,~] = size(MixMat);
    for i=1:nPool
        sampIndTmp = find(MixMat(i,:));
        sampIndTmpStr = sprintf('%d,',sampIndTmp);
        Ptcp{i,1} = sampIndTmpStr(1:end-1);
        rowNames{i,1} = sprintf('Pool %d',i);
    end
    
    fig = uifigure;
    uit = uitable(fig);
    set(uit,'Data',Ptcp);
    uit.Position = [10 10 540 400];

    colNames = {'Sample_Index_Set'};
    colEditable = false(1,1);
    fgrndColor = 'k';
    set(uit,...
        'ColumnName',colNames,'RowName',rowNames,...
        'ColumnEditable',colEditable,'ForegroundColor',fgrndColor);
end


% --- Executes on button press in epr_revise.
function epr_revise_Callback(hObject, eventdata, handles)
% hObject    handle to epr_revise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

revGp = handles.epr_previous.UserData;
handles.epr_revise.UserData = revGp;

% Setup editability of epr_table
colEditableEpr = true;
fgrndColor = 'g';

set(handles.epr_table,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
msgbox('Click Finish after revision.');




% --- Executes on button press in epr_delete.
function epr_delete_Callback(hObject, eventdata, handles)
% hObject    handle to epr_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%
% - after delete current group of pooling results, display the next group
% of results

poolStatus = handles.epr_finish.UserData;
sampStatus = handles.srd_save.UserData;
gpInd = handles.epr_previous.UserData;

nGP = length(poolStatus);
poolStatus(gpInd) = [];
sampStatus(gpInd) = [];
handles.epr_finish.UserData = poolStatus;
handles.srd_save.UserData = sampStatus;

if gpInd<nGP
    % Display next group
    % Epr table
    eprData = poolStatus{gpInd};
    set(handles.epr_table,'Data',num2cell(eprData));

    % Srd table
    srdData = sampStatus{gpInd};
    set(handles.srd_table,'Data',num2cell(srdData));
    
    % Update counter
    cnter = sprintf('Group %d/%d',gpInd,nGP-1);
    handles.epr_counter.String = cnter;
else
    if gpInd>1
        % Display previous group
        % Epr table
        eprData = poolStatus{gpInd};
        set(handles.epr_table,'Data',num2cell(eprData));

        % Srd table
        srdData = sampStatus{gpInd};
        set(handles.srd_table,'Data',num2cell(srdData));
        
        % Update counter
        cnter = sprintf('Group %d/%d',gpInd-1,nGP-1);
        handles.epr_counter.String = cnter;
    else
        % Use default data when no data is available
        set(handles.epr_table,'Data',num2cell([]),...
            'ColumnName',{'1','2'},'RowName',{'1','2','3','4'},...
            'ColumnEditable',[false,false]);
        set(handles.srd_table,'Data',num2cell([]),...
            'ColumnName',{'1','2'},'RowName',{'1','2','3','4'},...
            'ColumnEditable',[false,false]);
        handles.epr_counter.String = 'Group 0/0';
    end
end
        



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to epr_counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epr_counter as text
%        str2double(get(hObject,'String')) returns contents of epr_counter as a double


% --- Executes during object creation, after setting all properties.
function epr_counter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epr_counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
