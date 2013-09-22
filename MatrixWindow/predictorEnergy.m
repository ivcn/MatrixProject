function varargout = predictorEnergy(varargin)
% PREDICTORENERGY MATLAB code for predictorEnergy.fig
%      PREDICTORENERGY, by itself, creates a new PREDICTORENERGY or raises the existing
%      singleton*.
%
%      H = PREDICTORENERGY returns the handle to a new PREDICTORENERGY or the handle to
%      the existing singleton*.
%
%      PREDICTORENERGY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREDICTORENERGY.M with the given input arguments.
%
%      PREDICTORENERGY('Property','Value',...) creates a new PREDICTORENERGY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before predictorEnergy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to predictorEnergy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help predictorEnergy

% Last Modified by GUIDE v2.5 21-May-2013 16:10:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @predictorEnergy_OpeningFcn, ...
                   'gui_OutputFcn',  @predictorEnergy_OutputFcn, ...
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


% --- Executes just before predictorEnergy is made visible.
function predictorEnergy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to predictorEnergy (see VARARGIN)

% Choose default command line output for predictorEnergy
handles.output = hObject;
handles.outer_handles = varargin{1};
handles.flagData=handles.radiobutton1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes predictorEnergy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = predictorEnergy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mina = str2double(get(handles.edit2,'String'));
maxa = str2double(get(handles.edit3,'String'));
window = str2double(get(handles.edit4,'String'));
pow = str2double(get(handles.edit1,'String'));
st = eval(get(handles.outer_handles.ukrupt, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
sf = eval(get(handles.outer_handles.ukrupf, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
ol = eval(get(handles.outer_handles.obrl, 'String')) ; % - сколько €чеек обрезаем слева
or = eval(get(handles.outer_handles.obrr, 'String')) ; % - сколько €чеек обрезаем справа
ot = eval(get(handles.outer_handles.obrt, 'String')) ; % - сколько €чеек обрезаем сверху
ob = eval(get(handles.outer_handles.obrb, 'String')) ; % - сколько €чеек обрезаем снизу
% 
nx = floor((91-ol-or)/sf); % сколько €чеек берем по оси x(выдел€етс€ центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько €чеек берем по оси y(выдел€етс€ центр часть матрицы)


signal = handles.outer_handles.wrow{4};
s = zeros(1,size(signal,2));
sizeT = size(s,2);
if handles.flagData==handles.radiobutton1
    %суммарный р€д
    s = sum(signal,1);
    datastr = 'integral';
elseif handles.flagData == handles.radiobutton2
    x = str2double(get(handles.edit6,'String'));
    y = str2double(get(handles.edit7,'String'));
    n=(x-1)*nx+y;
    s = signal(n,:);
    datastr = strcat('1-point',32,num2str(x),32,num2str(y));
elseif handles.flagData==handles.radiobutton3
    r1=str2double(get(handles.edit8,'String'));
    r2=str2double(get(handles.edit9,'String'));
    c1=str2double(get(handles.edit10,'String'));
    c2=str2double(get(handles.edit11,'String'));
    s = zeros(1, size(signal,2));
    for r = r1:r2
        for c = c1:c2
            n=(r1-1)*nx+c1;
            s = s + signal(n,:);
        end
    end
    datastr = strcat('interval series', num2str(r1), '-', num2str(r2), 32,num2str(c1), '-', num2str(c2));
end
handles.s=s;
% x=1:size(s,2);
% days = x./144+1;
% figure();
% plot(days,s,'k');
% title('»сходный сигнал');

flagTrend = get(handles.checkbox2,'Value');
flagPressure = get(handles.checkbox1,'Value');
flagDispersion = get(handles.checkbox3,'Value');
flagHurst = get(handles.checkbox4,'Value');
pressureStr = '';

if(flagPressure == true)
    %учет давлени€
    p0=994;
    beta = str2double(get(handles.edit5,'String'));
    [filename pathname] = uigetfile('*.txt');
    pressure_data = dlmread(strcat(pathname,filename));
    pressure = pressure_data(:,2)';
    for t =1:size(s,2)
        s(t) = s(t)-beta*s(1)*(pressure(t)-p0);
    end
    handles.swp = s;
    pressureStr=strcat('pres',num2str(beta));
end
guidata(hObject,handles);

%расчет индексов
pos_index=1;
step = 1;
index = zeros(1,(sizeT-window)/step);
h_index = zeros(1,(sizeT-window)/step);
d_index = zeros(1,(sizeT-window)/step);
trendStr = '';
for pos = 1:step:sizeT-window
    windowData = s(pos:pos+window);
    if(flagTrend == true)
        trend = ChebRazl(windowData,pow,0);
        windowData = windowData-trend;
        trendStr=strcat('cheb:',num2str(pow));
    end
    e = AnalyzW(windowData,mina,maxa,1,0);
    index(pos_index) = sum(e);
    if(flagDispersion == true)
        d_index(pos_index) = std(windowData);
    end
    if ( flagHurst == true )
        h_index(pos_index) = estimate_hurst_exponent(windowData);
    end
    pos_index=pos_index+1;
    
    progress = floor(pos_index./size(index,2)*100);
    if(rem(progress,10)==0)
        progress
    end
end

date_s = get(handles.outer_handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
dni = get(handles.outer_handles.dni, 'String');

pos = 1:size(index,2);
pos = pos+window;
days = (pos./144)+1;
figure();
plot(days,index,'k');
title(strcat('Energy index',32,'date:',date_s,32,'d:',dni,32,datastr,32,pressureStr,32,trendStr,32,'a:',num2str(mina),'-',num2str(maxa),32,'win',num2str(window)));
if(flagDispersion == true)
    figure();
    plot(days,d_index,'k');
    title(strcat('Dispersion',32,'date:',date_s,32,'d:',dni,32,datastr,32,pressureStr,32,trendStr,32,'a:',num2str(mina),'-',num2str(maxa),32,'win',num2str(window)));
end
if( flagHurst == true)
    figure();
    plot(days,h_index,'k');
    title(strcat('Hurst index',32,'date:',date_s,32,'d:',dni,32,datastr,32,pressureStr,32,trendStr,32,'a:',num2str(mina),'-',num2str(maxa),32,'win',num2str(window)));
end


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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function radiobutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uipanel4.
function uipanel4_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel4 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.flagData = eventdata.NewValue;
guidata(hObject,handles);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = handles.s;
x=1:size(s,2);
days = x./144+1;
figure();
plot(days,s,'k');
title('»сходный сигнал');

flagPressure = get(handles.checkbox1,'Value');
if(flagPressure == true)
    s = handles.swp;
    figure();
    plot(days,s,'k');
    title('ѕосле поправки');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
