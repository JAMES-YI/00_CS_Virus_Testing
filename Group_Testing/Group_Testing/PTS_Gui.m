function varargout = PTS_Gui(varargin)
% PTS_GUI MATLAB code for PTS_Gui.fig
%      PTS_GUI, by itself, creates a new PTS_GUI or raises the existing
%      singleton*.
%
%      H = PTS_GUI returns the handle to a new PTS_GUI or the handle to
%      the existing singleton*.
%
%      PTS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PTS_GUI.M with the given input arguments.
%
%      PTS_GUI('Property','Value',...) creates a new PTS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PTS_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PTS_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PTS_Gui
%
% Created by JYI, 09/11/2020
%
%
% 
% Last Modified by GUIDE v2.5 12-Sep-2020 12:30:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PTS_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @PTS_Gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before PTS_Gui is made visible.
function PTS_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PTS_Gui (see VARARGIN)

% Choose default command line output for PTS_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PTS_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PTS_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function mixmat_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mixmat_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in mixmat_tab.
function mixmat_tab_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to mixmat_tab (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in epr_tab.
function epr_tab_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to epr_tab (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in mixmatsize_popup.
function mixmatsize_popup_Callback(hObject, eventdata, handles)
% hObject    handle to mixmatsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mixmatsize_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mixmatsize_popup
%
%%


%%
matrix_manu = get(handles.mixmatsize_popup,'String');

% Generate pooling matrix
switch matrix_manu{get(handles.mixmatsize_popup,'Value')}
    
    case 'Not Specified'
        
        msgMixMatSize = msgbox('Please select the size of mixing matrix.');
    
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

% Save pooling matrix
try
    set(handles.mixmatsize_popup,'UserData',MixMat);
catch
    error('Mixing matrix size is not specified.');
    % setappdata(0,'poolMatrix',poolMatrix);
end

% Reset pooling results
handles.poolresfinish_push.UserData = [];


% Reset decoding results
handles.srd_start.UserData = [];

% --- Executes during object creation, after setting all properties.
function mixmatsize_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mixmatsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mixmatgen_push.
function mixmatgen_push_Callback(hObject, eventdata, handles)
% hObject    handle to mixmatgen_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%% Display mixing matrix
try 
    mat_selectObj = findobj('Tag','mixmatsize_popup');
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

    set(handles.mixmat_tab,'Data',cellMat,...
        'ColumnName',colName,'RowName',rowName,'ColumnEditable',colEditable);

catch
    error('The size of mixing matrix is not specified.');
    
end
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
set(handles.epr_tab,...
    'Data',num2cell(defaultEprData),...
    'ColumnName',colNameEpr,'RowName',rowNameEpr,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);

% --- Executes on button press in mmd_next_push.
function mmd_next_push_Callback(hObject, eventdata, handles)
% hObject    handle to mmd_next_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in poolresstartnew_push.
function poolresstartnew_push_Callback(hObject, eventdata, handles)
% hObject    handle to poolresstartnew_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%%
mat_selectObj = findobj('Tag','mixmatsize_popup');
Mat = mat_selectObj.UserData; 

[nPools,~] = size(Mat);
for iPool=1:nPools
    rowNameEpr{iPool} = sprintf('Pool %d',iPool);
end

colNameEpr = {'Status (0/1/-3)'};
colEditableEpr = true;
fgrndColor = 'g';
defaultEprData = Inf*ones(nPools,1);

set(handles.epr_tab,...
    'Data',num2cell(defaultEprData),...
    'ColumnName',colNameEpr,'RowName',rowNameEpr,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);

%%


% --- Executes on button press in poolresfinish_push.
function poolresfinish_push_Callback(hObject, eventdata, handles)
% hObject    handle to poolresfinish_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%%
% - for each poolStatus{i}, the first column is the index of pool, and the
%   second column is the corresponding status

tabFnsh = handles.epr_tab;
tabData = get(tabFnsh,'Data');

% Store data
if isempty(handles.poolresfinish_push.UserData)
    poolStatus{1} = cell2mat(tabData);
    handles.poolresreviewprevious_push.UserData = 1;
    
else
    poolStatus = handles.poolresfinish_push.UserData;
    poolStatus{end+1} = cell2mat(tabData);
    
    gpInd = handles.poolresreviewprevious_push.UserData;
    handles.poolresreviewprevious_push.UserData = gpInd+1;
end

handles.poolresfinish_push.UserData = poolStatus; 

% Forbid modification of entered data
colEditableEpr = false;
fgrndColor = 'k';
set(handles.epr_tab,...
    'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
% setappdata(0,'poolData',poolData);
    
% --- Executes on button press in poolresreviewprevious_push.
function poolresreviewprevious_push_Callback(hObject, eventdata, handles)
% hObject    handle to poolresreviewprevious_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%%

% Update current group index
curGP = handles.poolresreviewprevious_push.UserData;
try
    curGP = curGP-1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','poolresfinish_push');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.poolresreviewprevious_push.UserData = curGP;

    set(handles.epr_tab,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
catch
    msgbox('This is already the first group!');
end

% --- Executes on button press in poolresreviewnext_push.
function poolresreviewnext_push_Callback(hObject, eventdata, handles)
% hObject    handle to poolresreviewnext_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%% 
curGP = handles.poolresreviewprevious_push.UserData;
try
    curGP = curGP+1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','poolresfinish_push');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.poolresreviewprevious_push.UserData = curGP;

    set(handles.epr_tab,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
catch
    msgbox('This is already the last group!');
end


% --- Executes on button press in poolresnext_push.
function poolresnext_push_Callback(hObject, eventdata, handles)
% hObject    handle to poolresnext_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sampresreviewprevious_push.
function sampresreviewprevious_push_Callback(hObject, eventdata, handles)
% hObject    handle to sampresreviewprevious_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%%
% Update current group index
curGP = handles.poolresreviewprevious_push.UserData;
try
    curGP = curGP-1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','poolresfinish_push');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.poolresreviewprevious_push.UserData = curGP;

    set(handles.epr_tab,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
    
    % Update srd table
    sampStatus_selectObj = findobj('Tag','srd_start');
    sampStatus = sampStatus_selectObj.UserData; 

    colEditableSrd = false;
    fgrndColor = 'k';
    curSrdData = sampStatus{curGP};

    set(handles.srd_tab,...
        'Data',num2cell(curSrdData),...
        'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
    
catch
    msgbox('This is already the first group!');
end



% --- Executes on button press in sampresreviewnext_push.
function sampresreviewnext_push_Callback(hObject, eventdata, handles)
% hObject    handle to sampresreviewnext_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%%
curGP = handles.poolresreviewprevious_push.UserData;
try
    curGP = curGP+1;

    % Update epr table
    poolStatus_selectObj = findobj('Tag','poolresfinish_push');
    poolStatus = poolStatus_selectObj.UserData; 

    colEditableEpr = false;
    fgrndColor = 'k';
    curEprData = poolStatus{curGP};
    handles.poolresreviewprevious_push.UserData = curGP;

    set(handles.epr_tab,...
        'Data',num2cell(curEprData),...
        'ColumnEditable',colEditableEpr,'ForegroundColor',fgrndColor);
    
    % Update srd table
    sampStatus_selectObj = findobj('Tag','srd_start');
    sampStatus = sampStatus_selectObj.UserData; 

    colEditableSrd = false;
    fgrndColor = 'k';
    curSrdData = sampStatus{curGP};

    set(handles.srd_tab,...
        'Data',num2cell(curSrdData),...
        'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);
    
catch
    msgbox('This is already the last group!');
end

% --- Executes on button press in sampressave_push.
function sampressave_push_Callback(hObject, eventdata, handles)
% hObject    handle to sampressave_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%% 

%% 
poolStatus = 0;

poolStatus = handles.poolresfinish_push.UserData;
sampStatus = handles.srd_start.UserData;
MixMat = handles.mixmatsize_popup.UserData;
[nPool,nSamp] = size(MixMat);
poolInd = (1:nPool)'; sampInd = (1:nSamp)';
poolColNames = {'Pool Index','Pool Status (1/0/-3)'};
fName = sprintf('Group_Testing_%s.xls',datestr(now,'yyyymmddHHMM'));

for i=1:trialNum
    poolT = table(poolInd,poolStatus{trialNum},...
        'VariableName',poolColNames);
    writetable(poolT,fName,...
        'Sheet',i,'Range','A10',...
        'WriteVariableNames',True)
end

% --- Executes on button press in srd_start.
function srd_start_Callback(hObject, eventdata, handles)
% hObject    handle to srd_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%%

%% 

% Getting data
MixMat = handles.mixmatsize_popup.UserData; 
poolStatus = handles.poolresfinish_push.UserData;

[~,nSamp] = size(MixMat); 
trialNum = length(poolStatus); 
posNumPrior = 0;

%% Status decoding

switch posNumPrior

    case 0
        fprintf('Decoding pool results without knowing the number of positives individual samples...\n');
    
    case 1
        fprintf('Decoding pool results with 1 positive individual sample...\n');
    
end

for i = 1:trialNum

    [MNeg,MPos,Pos] = pool_dec(MixMat,poolStatus{i},posNumPrior);
    sampMPos{i} = MPos;
    sampMNeg{i} = MNeg;
    sampPos{i} = Pos;
    
    tmpStatus = zeros(nSamp,1);
    if ~isempty(MPos)
        tmpStatus(MPos,:) = ones(length(MPos),1);
    end
    
    if ~isempty(Pos)
        tmpStatus(Pos,:) = (-3)*ones(length(Pos),1);
    end
    
    sampStatus{i} = tmpStatus;
end

handles.srd_start.UserData = sampStatus;

%% Report results

curGP = handles.poolresreviewprevious_push.UserData;
srdData = sampStatus{curGP};

for iSamp=1:nSamp
    rowNameSrd{iSamp} = sprintf('Sample %d',iSamp);
end

colNameSrd = {'Status (0/1/-3)'};
colEditableSrd = false;
fgrndColor = 'k';

set(handles.srd_tab,...
    'Data',num2cell(srdData),...
    'ColumnName',colNameSrd,'RowName',rowNameSrd,...
    'ColumnEditable',colEditableSrd,'ForegroundColor',fgrndColor);


%% 
% if ~isempty(MNeg)
%     MNegNum = length(MNeg);
%     MNegMat = [reshape(MNeg,[MNegNum,1]),zeros(MNegNum,1),Inf*ones(MNegNum,1)];
% else
%     MNegMat = Inf*ones(1,3);
% end
% 
% if ~isempty(MPos)
%     
%     MPosNum = length(MPos);
%     MPosMat = [reshape(MPos,[MPosNum,1]),ones(MPosNum,1),Inf*ones(MPosNum,1)];
% else
%     MPosMat = Inf*ones(1,3);
% end
% 
% if ~isempty(Pos)
%     
%     PosNum = length(Pos);
%     PosMat = [reshape(Pos,[PosNum,1]),2*ones(PosNum,1),Inf*ones(PosNum,1)];
%     
% else
%     
%     PosMat = Inf*ones(1,3);
%     
% end
% 
% cellMNegMat = num2cell(MNegMat);
% cellMPosMat = num2cell(MPosMat);
% cellPosMat = num2cell(PosMat);
% 
% set(handles.NegTab,...
%     'Data',cellMNegMat,...
%     'ColumnName',colName);
% set(handles.PosTab,...
%     'Data',cellMPosMat,...
%     'ColumnName',colName);
% set(handles.PotPosTab,...
%     'Data',cellPosMat,...
%     'ColumnName',colName);

% Write to file
    
    
    


% --- Executes when entered data in editable cell(s) in srd_tab.
function srd_tab_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to srd_tab (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function mixmatsize_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mixmatsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
