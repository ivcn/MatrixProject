function varargout = nonstationarityWindow2D(varargin)
% NONSTATIONARITYWINDOW2D MATLAB code for nonstationarityWindow2D.fig
%      NONSTATIONARITYWINDOW2D, by itself, creates a new NONSTATIONARITYWINDOW2D or raises the existing
%      singleton*.
%
%      H = NONSTATIONARITYWINDOW2D returns the handle to a new NONSTATIONARITYWINDOW2D or the handle to
%      the existing singleton*.
%
%      NONSTATIONARITYWINDOW2D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NONSTATIONARITYWINDOW2D.M with the given input arguments.
%
%      NONSTATIONARITYWINDOW2D('Property','Value',...) creates a new NONSTATIONARITYWINDOW2D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nonstationarityWindow2D_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nonstationarityWindow2D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nonstationarityWindow2D

% Last Modified by GUIDE v2.5 03-Jul-2013 13:13:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nonstationarityWindow2D_OpeningFcn, ...
                   'gui_OutputFcn',  @nonstationarityWindow2D_OutputFcn, ...
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


% --- Executes just before nonstationarityWindow2D is made visible.
function nonstationarityWindow2D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nonstationarityWindow2D (see VARARGIN)

% Choose default command line output for nonstationarityWindow2D
handles.output = hObject;

handles.outer_handles = varargin{1};
handles.current_matrix = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nonstationarityWindow2D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nonstationarityWindow2D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function updateWindow(hObject,handles)
im = handles.signal(:,:,handles.current_matrix);
axis(handles.canvas);
imagesc(im);
set(handles.edit6,'String',num2str(handles.current_matrix));
guidata(hObject, handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st = eval(get(handles.outer_handles.ukrupt, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
sf = eval(get(handles.outer_handles.ukrupf, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
ol = eval(get(handles.outer_handles.obrl, 'String')) ; % - сколько €чеек обрезаем слева
or = eval(get(handles.outer_handles.obrr, 'String')) ; % - сколько €чеек обрезаем справа
ot = eval(get(handles.outer_handles.obrt, 'String')) ; % - сколько €чеек обрезаем сверху
ob = eval(get(handles.outer_handles.obrb, 'String')) ; % - сколько €чеек обрезаем снизу
nx = floor((91-ol-or)/sf); % сколько €чеек берем по оси x(выдел€етс€ центр часть матрицы)
ny = floor((91-ot-ob)/st);

data = handles.outer_handles.wrow{4};

clear handles.outer_handles.wrow{4};

trendStr = '';
flagTrend = get(handles.checkbox2,'Value');
pow = str2double(get(handles.edit2,'String'));
if(flagTrend == true)
    for i=nx*ny
        trend = ChebRazl(data(i),pow,0);
        data(i) = data(i) - trend;
        trendStr=strcat('cheb:',num2str(pow));
        %handles.dwt = data;
    end
end

T = str2double(get(handles.edit3,'String'));
alpha = str2double(get(handles.edit4,'String'));
deltaT = str2double(get(handles.edit5,'String'));
test = [];%zeros(size(data,1),size(data,2)-T;
ind = 1:size(data,2);
ind = ind';
s = [ind data(1,:)'];
'please wait...'
[test1 test2] = nonstationarity(T,size(s,1),alpha,deltaT,0,1,2,0,s,-1,25,1);
nf =zeros(size(data,1),size(test2,2));
'calculation started'
tic;
for i=1:nx*ny
    s = [ind data(i,:)'];
    [m nf(i,:)] = nonstationarity(T,size(s,1),alpha,deltaT,0,1,2,0,s,-1,25,1);
    if(rem(i,10)==0)
        progress = floor(i*100/nx/ny);
        disp(strcat(num2str(progress),' percent'));
    end
end
toc;
disp('calculation completed')
%x = (1+0+T:deltaT:1+(length(nf)-1)*deltaT+0+T);
l1 = size(nf,2);
signal = zeros(ny,nx,l1);
for i = 1:l1
    A = zeros(nx,ny);
    for j = 1:nx*ny
        A(j)=nf(j,i);
    end
    % A
    A=flipud(A);
    A=rot90(A,-1);
    signal(:,:,i)=A;
end
handles.signal = signal;
guidata(hObject,handles);
updateWindow(hObject,handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnBackward.
function btnBackward_Callback(hObject, eventdata, handles)
% hObject    handle to btnBackward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.current_matrix >1)
    handles.current_matrix = handles.current_matrix - 1;
end
guidata(hObject,handles);
updateWindow(hObject,handles);




% --- Executes on button press in btnForward.
function btnForward_Callback(hObject, eventdata, handles)
% hObject    handle to btnForward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = handles.outer_handles.wrow{4};
if(handles.current_matrix < size(data,2) )
    handles.current_matrix = handles.current_matrix + 1;
end
guidata(hObject,handles);
updateWindow(hObject,handles);



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_matrix = str2double(get(hObject,'String'));
guidata(hObject,handles);
updateWindow(hObject,handles);
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
