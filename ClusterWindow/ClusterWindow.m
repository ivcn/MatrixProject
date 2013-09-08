function varargout = ClusterWindow(varargin)
% CLUSTERWINDOW MATLAB code for ClusterWindow.fig
%      CLUSTERWINDOW, by itself, creates a new CLUSTERWINDOW or raises the existing
%      singleton*.
%
%      H = CLUSTERWINDOW returns the handle to a new CLUSTERWINDOW or the handle to
%      the existing singleton*.
%
%      CLUSTERWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLUSTERWINDOW.M with the given input arguments.
%
%      CLUSTERWINDOW('Property','Value',...) creates a new CLUSTERWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ClusterWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ClusterWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ClusterWindow

% Last Modified by GUIDE v2.5 19-Mar-2013 15:36:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClusterWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @ClusterWindow_OutputFcn, ...
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


% --- Executes just before ClusterWindow is made visible.
function ClusterWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ClusterWindow (see VARARGIN)

% Choose default command line output for ClusterWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ClusterWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ClusterWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_ClusterInterval_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ClusterInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ClusterInterval as text
%        str2double(get(hObject,'String')) returns contents of edit_ClusterInterval as a double
interval = str2double(get(hObject,'String'));
if( interval>0 && interval < handles.size_t )
    handles.clusterInterval = interval;
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_ClusterInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ClusterInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ClusterNumber_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ClusterNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ClusterNumber as text
%        str2double(get(hObject,'String')) returns contents of edit_ClusterNumber as a double
num = str2double(get(hObject,'String'));
if( num > 0)
    handles.clusterNumber = num;
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_ClusterNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ClusterNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbtn_Cluster.
function pbtn_Cluster_Callback(hObject, eventdata, handles)
% hObject    handle to pbtn_Cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numParts = ceil(handles.size_t/handles.clusterInterval);
clusteringResults = zeros(handles.size_row,handles.size_col,numParts);
tic;
for i = 1:numParts
    'part'
    i
    data = handles.signal(:,:,(i-1)*handles.clusterInterval+1:min(i*handles.clusterInterval,handles.size_t));
    %преобразуем данные в матрицу
    temp_matr = zeros(handles.size_row*handles.size_col, handles.size_t);
    for j = 1:size(data,3)
        temp_a = data(:,:,j);%получаем следующую матрицу
        %temp_a1 = temp_a(:);%векторизуем ее
        temp_matr(:,j) = temp_a(:);%кладем в соответствующий столбец матрицы
    end
    D = pdist(temp_matr);
    Z = linkage(D,'complete');
    idx = cluster(Z,'maxclust',handles.clusterNumber);
    %idx = kmeans(temp_matr,handles.clusterNumber);
    %теперь надо превратить полученный вектор в матрицу (матрицировать его)
    res_matr = zeros(handles.size_row,handles.size_col);
    for j=1:handles.size_row
        res_matr(j,:) = idx((j-1)*handles.size_col+1:j*handles.size_col);
    end
    clusteringResults(:,:,i) = res_matr;
end
%заменяем исходый сигнал на новый полученный
handles.signal = clusteringResults;
%handles.size_row=
%handles.size_col=
handles.size_t=numParts;
%если новый получившийся сигнал короче, и текущая позиция выходит за его
%пределы
toc;
'Clustering complete'
if(handles.position > handles.size_t)
    handles.position = handles.size_t;
end
handles.maxVal = max(max(max(handles.signal)));
handles.minVal = min(min(min(handles.signal)));
guidata(hObject,handles);
updateView(handles);

% --------------------------------------------------------------------
function menu_FILE_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_OPEN_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_OPEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.mat');
file = strcat(pathname,filename);
load(file,'newSig');
handles.signal = newSig;%mat_en{4};
handles.size_row = size(handles.signal,1);
handles.size_col = size(handles.signal,2);
handles.size_t = size(handles.signal,3);
handles.backupSignal = handles.signal;
handles.position = 1;
set(handles.edit_Position,'String',num2str(handles.position));
handles.maxVal = max(max(max(handles.signal)));
handles.minVal = min(min(min(handles.signal)));
guidata(hObject,handles);
updateView(handles);


% --- Executes during object creation, after setting all properties.
function pbtn_Cluster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pbtn_Cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function updateView(handles)
axis(handles.axes_VIEW);
imagesc(handles.signal(:,:,handles.position),[handles.minVal handles.maxVal]);


% --- Executes on button press in pbtn_Forward.
function pbtn_Forward_Callback(hObject, eventdata, handles)
% hObject    handle to pbtn_Forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if( handles.position+1 <= handles.size_t )
    handles. position = handles.position+1;
end
set(handles.edit_Position,'String',num2str(handles.position));
guidata(hObject,handles);
updateView(handles);

% --- Executes on button press in pbtn_Back.
function pbtn_Back_Callback(hObject, eventdata, handles)
% hObject    handle to pbtn_Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if( handles.position-1 >=1 )
    handles.position = handles.position-1;
end
set(handles.edit_Position,'String',num2str(handles.position));
guidata(hObject, handles);
updateView(handles);



function edit_Position_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos = str2double(get(hObject,'String'));
handles.position = pos;
guidata(hObject,handles);
updateWindow(handles);
% Hints: get(hObject,'String') returns contents of edit_Position as text
%        str2double(get(hObject,'String')) returns contents of edit_Position as a double


% --- Executes during object creation, after setting all properties.
function edit_Position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_GAUSS_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_GAUSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = gaussFilter(handles.signal);
handles.signal = result;
guidata(hObject,handles);
updateView(handles);


% --------------------------------------------------------------------
function menuItem_SAVE_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_SAVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (se GUIDATA)
[filename pathname] = uiputfile('*.mat');
% filename = 'CLUSTERING_RES';
% filename = strcat(filename,'_ClInterval_',get(handles.edit_ClusterInterval,'String'));
% filename = strcat(filename,'_ClNumber_',get(handles.edit_ClusterNumber,'String'));
cluster_data = handles.signal;
save(filename,'cluster_data');


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_PressureCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_PressureCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.signal = pressure_correction(handles.signal);
guidata(hObject,handles);
updateView(handles);


% --------------------------------------------------------------------
function menuItem_OPEN_INTENS_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_OPEN_INTENS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.mat');
file = strcat(pathname,filename);
load(file,'mat_intens');
handles.signal = mat_intens{4};
handles.size_row = size(handles.signal,1);
handles.size_col = size(handles.signal,2);
handles.size_t = size(handles.signal,3);
handles.backupSignal = handles.signal;
handles.position = 1;
set(handles.edit_Position,'String',num2str(handles.position));
handles.maxVal = max(max(max(handles.signal)));
handles.minVal = min(min(min(handles.signal)));
guidata(hObject,handles);
updateView(handles);


% --------------------------------------------------------------------
function menuItem_OPEN_WT_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_OPEN_WT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename pathname] = uigetfile('*.mat');
file = strcat(pathname,filename);
load(file,'mat_wt');
handles.signal = mat_wt{4};
handles.size_row = size(handles.signal,1);
handles.size_col = size(handles.signal,2);
handles.size_t = size(handles.signal,3);
handles.backupSignal = handles.signal;
handles.position = 1;
set(handles.edit_Position,'String',num2str(handles.position));
handles.maxVal = max(max(max(handles.signal)));
handles.minVal = min(min(min(handles.signal)));
guidata(hObject,handles);
updateView(handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure();
imagesc(handles.signal(:,:,handles.position),[handles.minVal handles.maxVal]);