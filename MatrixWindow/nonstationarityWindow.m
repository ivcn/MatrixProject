function varargout = nonstationarityWindow(varargin)
% NONSTATIONARITYWINDOW MATLAB code for nonstationarityWindow.fig
%      NONSTATIONARITYWINDOW, by itself, creates a new NONSTATIONARITYWINDOW or raises the existing
%      singleton*.
%
%      H = NONSTATIONARITYWINDOW returns the handle to a new NONSTATIONARITYWINDOW or the handle to
%      the existing singleton*.
%
%      NONSTATIONARITYWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NONSTATIONARITYWINDOW.M with the given input arguments.
%
%      NONSTATIONARITYWINDOW('Property','Value',...) creates a new NONSTATIONARITYWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nonstationarityWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nonstationarityWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nonstationarityWindow

% Last Modified by GUIDE v2.5 22-Jun-2013 00:31:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nonstationarityWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @nonstationarityWindow_OutputFcn, ...
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


% --- Executes just before nonstationarityWindow is made visible.
function nonstationarityWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nonstationarityWindow (see VARARGIN)

% Choose default command line output for nonstationarityWindow
handles.output = hObject;

handles.outer_handles = varargin{1};
handles.flagData=handles.radiobutton1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nonstationarityWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nonstationarityWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pow = str2double(get(handles.edit11,'String'));
st = eval(get(handles.outer_handles.ukrupt, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
sf = eval(get(handles.outer_handles.ukrupf, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
ol = eval(get(handles.outer_handles.obrl, 'String')) ; % - сколько €чеек обрезаем слева
or = eval(get(handles.outer_handles.obrr, 'String')) ; % - сколько €чеек обрезаем справа
ot = eval(get(handles.outer_handles.obrt, 'String')) ; % - сколько €чеек обрезаем сверху
ob = eval(get(handles.outer_handles.obrb, 'String')) ; % - сколько €чеек обрезаем снизу
% 
nx = floor((91-ol-or)/sf); % сколько €чеек берем по оси x(выдел€етс€ центр часть матрицы)

signal = handles.outer_handles.wrow{4};
s = zeros(1,size(signal,2));

if handles.flagData==handles.radiobutton1
    %суммарный р€д
    s = sum(signal,1);
    datastr = 'integral';
elseif handles.flagData == handles.radiobutton2
    x = str2double(get(handles.edit4,'String'));
    y = str2double(get(handles.edit5,'String'));
    n=(x-1)*nx+y;
    s = signal(n,:);
    datastr = strcat('1-point',32,num2str(x),32,num2str(y));
elseif handles.flagData==handles.radiobutton3
    r1=str2double(get(handles.edit6,'String'));
    r2=str2double(get(handles.edit8,'String'));
    c1=str2double(get(handles.edit9,'String'));
    c2=str2double(get(handles.edit10,'String'));
    s = zeros(1, size(signal,2));
    for r = r1:r2
        for c = c1:c2
            n=(r1-1)*nx+c1;
            s = s + signal(n,:);
        end
    end
    datastr = strcat('interval series',num2str(r1),'-',num2str(r2),32,num2str(c1),'-',num2str(c2));
end

handles.s = s;

trendStr = '';
flagTrend = get(handles.checkbox1,'Value');
if(flagTrend == true)
    trend = ChebRazl(s,pow,0);
    s = s - trend;
    trendStr=strcat('cheb:',num2str(pow));
    handles.swt = s;
end
guidata(hObject,handles);

T = str2double(get(handles.edit1,'String'));
alpha = str2double(get(handles.edit2,'String'));
deltaT = str2double(get(handles.edit3,'String'));

ind = 1:size(s,2);
ind = ind';
s = [ind s'];
[m nf] = nonstationarity(T,size(s,1),alpha,deltaT,0,1,2,0,s,-1,25,1);
x = (1+0+T:deltaT:1+(length(nf)-1)*deltaT+0+T);
%x = x./144;

dateStart=handles.outer_handles.date;
numDays = str2double(get(handles.outer_handles.dni,'String'));
dateEnd = addtodate(datenum(handles.outer_handles.date),numDays,'day');
dateStart = datestr(dateStart);
dateEnd = datestr(dateEnd);

temp = zeros(size(x));
dateStartMin = strcat(dateStart, 32, '00:00:00');
for i=1:size(x,2)
    temp(i) = addtodate(datenum(dateStartMin, 0),10*(x(i)-1),'minute');
end
%date_s = get(handles.outer_handles.startdate, 'String');
%date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
%dni = get(handles.outer_handles.dni, 'String');
%dateStart = datestr(addtodate(datenum(dateStart),T*10,'minute'));

%xData = linspace(datenum(dateStart,'dd-mmm-yyyy'),datenum(dateEnd,'dd-mmm-yyyy'),size(nf,2));
%step = addtodate(datenum(dateStart,'dd-mmm-yyyy'),deltaT*10,'minute')-datenum(dateStart,'dd-mmm-yyyy');
%xData = datenum(dateStart,'dd-mmm-yyyy'):step:datenum(dateEnd,'dd-mmm-yyyy');
%xData = xData(2:end);
%xData=xData(1:end-1);
%temp1 = datenum(dateStart,'dd-mmm-yyyy');
%temp2 = datenum(dateEnd,'dd-mmm-yyyy');
%t = datestr(xData);

figname = strcat('nonstationary factor',32,dateStart,'-',dateEnd,32,datastr,32,trendStr,32,'T:',num2str(T),...
    32,'deltaT:',num2str(deltaT),32,'alpha:',num2str(alpha));
metka = str2double(get(handles.outer_handles.metka,'String'));

figure();
plot(temp,nf,'k');
title(figname);
xlim([temp(1) temp(end)]);
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',temp(1:floor(144/deltaT)*metka:size(temp,2)));
datetick('x','m-dd','keepticks','keeplimits');
grid on;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T = str2double(get(handles.edit1,'String'));
alpha = str2double(get(handles.edit2,'String'));
deltaT = str2double(get(handles.edit3,'String'));
sampleFreq = str2double(get(handles.edit12,'String'));

[filename pathname] = uigetfile('*.txt');
%fid = fopen(strcat(pathname,filename));
A = importdata(strcat(pathname,filename));
%D = textscan(fid,'%d %d %d %f %*[^\n]','CommentStyle','//');
%fclose(fid);
%data = D{4};
data = A(:,end);
%idx = data == 0;
%data(idx) = data(idx(end)+1);
ind = 1:size(data,1);
data = [ind' data];

[m nf] = nonstationarity(T,size(data,1),alpha,deltaT,0,1,2,0,data,-1,25,1);
x = (1+0+T:deltaT:1+(length(nf)-1)*deltaT+0+T);
%x = x./(1440/sampleFreq)+1;
figure();
plot(x,nf,'k');
xlim([x(1) x(end)]);



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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



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



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%кнопка ѕоказать исходный.
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure();
dateStart=handles.outer_handles.date;
T = str2double(get(handles.edit1,'String'));
%get x-coordinates
x=T+1:size(handles.s,2);
% get according dates
dateStart = datestr(dateStart);
metka = str2double(get(handles.outer_handles.metka,'String'));
temp = zeros(size(x));
% add time to date
dateStartMin = strcat(dateStart,32,'00:00');
for i=1:size(x,2)
    temp(i) = addtodate(datenum(dateStartMin,'dd-mmm-yyyy HH:MM'),10*(x(i)-1),'minute');
end
plot(temp,handles.s(T+1:end),'k');
xlim([temp(1) temp(end)]);
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',temp(1:144*metka:size(temp,2)));
datetick('x','m-dd','keepticks','keeplimits');
hold on;
if(get(handles.checkbox1,'Value')==true)
    pow = str2double(get(handles.edit11,'String'));
    trend = ChebRazl(handles.s,pow,0);
    plot(temp, trend(T+1:end), 'r');
end
hold off;


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
    case 'radiobutton1'
        handles.flagData = handles.radiobutton1;
    case 'radiobutton2'
        handles.flagData = handles.radiobutton2;
    case 'radiobutton3'
        handles.flagData = handles.radiobutton3;
end
guidata(hObject,handles);
