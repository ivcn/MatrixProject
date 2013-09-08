function varargout = DWT3_GUI(varargin)
% DWT3_GUI MATLAB code for DWT3_GUI.fig
%      DWT3_GUI, by itself, creates a new DWT3_GUI or raises the existing
%      singleton*.
%
%      H = DWT3_GUI returns the handle to a new DWT3_GUI or the handle to
%      the existing singleton*.
%
%      DWT3_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DWT3_GUI.M with the given input arguments.
%
%      DWT3_GUI('Property','Value',...) creates a new DWT3_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DWT3_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DWT3_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DWT3_GUI

% Last Modified by GUIDE v2.5 29-Oct-2011 12:59:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DWT3_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DWT3_GUI_OutputFcn, ...
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


% --- Executes just before DWT3_GUI is made visible.
function DWT3_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DWT3_GUI (see VARARGIN)

% Choose default command line output for DWT3_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DWT3_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DWT3_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OPEN_Callback(hObject, eventdata, handles)
% hObject    handle to OPEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiopen();
[filename, pathname] = uigetfile( {'*.mat'});
load([pathname filename], 'AA');
%load([pathname filename], 'mat_wt','mat_en','mat_intens');
handles.signal=AA;%mat_intens(:,:,:,4);
handles.t_size=size(handles.signal,3);
handles.im_pos=1;%position of current image
set(handles.editImPos,'String',int2str(handles.im_pos));
guidata(hObject, handles);
im=handles.signal(:,:,handles.im_pos);
axes(handles.source);
imagesc(im);
% --------------------------------------------------------------------
function ACTIONS_Callback(hObject, eventdata, handles)
% hObject    handle to ACTIONS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function DWT3_Callback(hObject, eventdata, handles)
% hObject    handle to DWT3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wname='db20';
level=2;
WT_signal=wavedec3(handles.signal,level,wname);
handles.A=cell(1,level);
%D=cell(1,level);
% for k=1:level
%     handles.A{k} = waverec3(WT_signal,'aaa',k);
%     %D{k} = waverec3(WT_signal,'a',k);%детализация. пока не нужна
% end
% handles.smoothSignal=handles.A{2};
handles.smoothSignal= waverec3(WT_signal,'aaa');
guidata(hObject, handles);
UpdateGraphic(hObject, handles);

%--------------------------------------
function UpdateGraphic(hObject,handles)
set(handles.editImPos,'String',int2str(handles.im_pos));
total_min = handles.im_pos*10;
total_hours = total_min / 60;
if(total_hours>24)
    days = 1+floor(total_hours/24);
    hours = floor(rem(total_hours,24));
    min = rem(total_min,60);
else
    days = 1;
    hours = floor(total_min/60);
    min = floor(rem(total_min,60));
end
set(handles.edtTime,'String',strcat(num2str(hours),' ч.  ',num2str(min),' мин.'));
set(handles.edtDay,'String',num2str(days));
%//----------------------------
lims=[0,600];
im=handles.signal(:,:,handles.im_pos);
axes(handles.source);
imagesc(im,lims);
%title('source image');

axes(handles.approx1);
%imagesc(handles.A{1}(:,:,handles.im_pos),lims);
imagesc(handles.smoothSignal(:,:,handles.im_pos),lims);
%title('Approx 1 level');
im=handles.signal(:,:,handles.im_pos);

axes(handles.approx2);
%imagesc(handles.A{3}(:,:,handles.im_pos),lims);
%imagesc(deviation_mat(im,handles.smoothSignal(:,:,handles.im_pos)),[-3,3]);

axes(handles.approx3);
imagesc(handles.A{3}(:,:,handles.im_pos),lims);
axes(handles.approx4);
imagesc(handles.A{4}(:,:,handles.im_pos),lims);
axes(handles.approx5);
imagesc(handles.A{5}(:,:,handles.im_pos),lims);
guidata(hObject, handles);
%---------------------------------------


% --- Executes on button press in btnForward.
function btnForward_Callback(hObject, eventdata, handles)
% hObject    handle to btnForward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.im_pos<size(handles.signal,3))
handles.im_pos=handles.im_pos+1;
guidata(hObject, handles);
UpdateGraphic(hObject,handles);
end
%----------------------------------------


% --- Executes on button press in btnBack.
function btnBack_Callback(hObject, eventdata, handles)
% hObject    handle to btnBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.im_pos>1)
handles.im_pos=handles.im_pos-1;
guidata(hObject, handles);
UpdateGraphic(hObject, handles);
end
%-----------------------------------------



function editImPos_Callback(hObject, eventdata, handles)
% hObject    handle to editImPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos = str2double(get(hObject,'String'));
handles.im_pos = pos;
UpdateGraphic(hObject,handles);
% Hints: get(hObject,'String') returns contents of editImPos as text
%        str2double(get(hObject,'String')) returns contents of editImPos as a double


% --- Executes during object creation, after setting all properties.
function editImPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editImPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtTime_Callback(hObject, eventdata, handles)
% hObject    handle to edtTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.im_pos;
time_min = 10*i;
set(hObject,'String',double2str(time_min/60)+' ч '+double2str(rem(time_min,60))+' мин.');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edtTime as text
%        str2double(get(hObject,'String')) returns contents of edtTime as a double


% --- Executes during object creation, after setting all properties.
function edtTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togbtnDataCursor.
function togbtnDataCursor_Callback(hObject, eventdata, handles)
% hObject    handle to togbtnDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm_obj=datacursormode(handles.figure1);
state=get(dcm_obj,'Enable');
if strcmp(state,'on')
    datacursormode off
else
datacursormode on;
end

% Hint: get(hObject,'Value') returns toggle state of togbtnDataCursor


% --- Executes during object creation, after setting all properties.
function togbtnDataCursor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to togbtnDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function edtDay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtDay_Callback(hObject, eventdata, handles)
% hObject    handle to edtDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
day = str2double(get(hObject,'String'));
handles.im_pos= (day-1)*24*6;
UpdateGraphic(hObject,handles);
% Hints: get(hObject,'String') returns contents of edtDay as text
%        str2double(get(hObject,'String')) returns contents of edtDay as a double



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function SAVE_dwt3_Callback(hObject, eventdata, handles)
% hObject    handle to SAVE_dwt3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S=handles.signal;
D=handles.A;
uisave({'S','D'});


% --------------------------------------------------------------------
function WAVELET_2D_Callback(hObject, eventdata, handles)
% hObject    handle to WAVELET_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.smoothSignal = DWT2_Smoothing(handles.signal);
UpdateGraphic(hObject, handles);
%----------------------------------------------------------------------
