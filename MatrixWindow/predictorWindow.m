function varargout = predictorWindow(varargin)
% PREDICTORWINDOW MATLAB code for predictorWindow.fig
%      PREDICTORWINDOW, by itself, creates a new PREDICTORWINDOW or raises the existing
%      singleton*.
%
%      H = PREDICTORWINDOW returns the handle to a new PREDICTORWINDOW or the handle to
%      the existing singleton*.
%
%      PREDICTORWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREDICTORWINDOW.M with the given input arguments.
%
%      PREDICTORWINDOW('Property','Value',...) creates a new PREDICTORWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before predictorWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to predictorWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help predictorWindow

% Last Modified by GUIDE v2.5 28-May-2013 18:58:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @predictorWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @predictorWindow_OutputFcn, ...
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


% --- Executes just before predictorWindow is made visible.
function predictorWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to predictorWindow (see VARARGIN)

% Choose default command line output for predictorWindow
handles.output = hObject;
handles.outer_handles = varargin{1};
handles.flagData = 'integral';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes predictorWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = predictorWindow_OutputFcn(hObject, eventdata, handles) 
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
mina = str2double(get(handles.edit2,'String'));
maxa = str2double(get(handles.edit3,'String'));
num_a = str2double(get(handles.edit1,'String'));
st = eval(get(handles.outer_handles.ukrupt, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
sf = eval(get(handles.outer_handles.ukrupf, 'String')) ; % - сколько €чеек суммируем(укрупн€ем)
ol = eval(get(handles.outer_handles.obrl, 'String')) ; % - сколько €чеек обрезаем слева
or = eval(get(handles.outer_handles.obrr, 'String')) ; % - сколько €чеек обрезаем справа
ot = eval(get(handles.outer_handles.obrt, 'String')) ; % - сколько €чеек обрезаем сверху
ob = eval(get(handles.outer_handles.obrb, 'String')) ; % - сколько €чеек обрезаем снизу
% 
nx = floor((91-ol-or)/sf); % сколько €чеек берем по оси x(выдел€етс€ центр часть матрицы)
%ny = floor((91-ot-ob)/st); % сколько €чеек берем по оси y(выдел€етс€ центр часть матрицы)

dateStart=handles.outer_handles.date;
numDays = str2double(get(handles.outer_handles.dni,'String'));
dateEnd = addtodate(datenum(handles.outer_handles.date),numDays,'day');
dateStart = datestr(dateStart);
dateEnd = datestr(dateEnd);



signal = handles.outer_handles.wrow{4};
s = zeros(1,size(signal,2));
%sizeT = size(s,2);
if strcmp(handles.flagData, 'integral')
    %суммарный р€д
    s = sum(signal,1);
    datastr = 'integral ';
elseif strcmp(handles.flagData, 'single')
    x = str2double(get(handles.edit6,'String'));
    y = str2double(get(handles.edit7,'String'));
    n=(x-1)*nx+y;
    s = signal(n,:);
    datastr = strcat('1-point series',32,'стр:',num2str(x),32,'столб:',num2str(y));
elseif strcmp(handles.flagData, 'interval')
    r1=str2double(get(handles.edit8,'String'));
    r2=str2double(get(handles.edit9,'String'));
    c1=str2double(get(handles.edit10,'String'));
    c2=str2double(get(handles.edit11,'String'));
    n1=(r1-1)*nx+c1;
    n2=(r2-1)*nx+c2;
    s =sum(signal(n1:n2,:),1);
    datastr = strcat('interval','стр',num2str(r1),'-',num2str(r2),32,'столб:',num2str(c1),'-',num2str(c2));
end

handles.s = s;
%x=1:size(s,2);
%days = x./144+1;
%figure();
%plot(days,handles.s,'k');
%title('»сходный р€д');

%sizeT=size(s,2);
flagPressure = get(handles.checkbox1,'Value');
flagTrend = get(handles.checkbox2,'Value');
pressureStr = '';

if(flagPressure == true)
    %учет давлени€
    p0=994;
    beta = str2double(get(handles.edit4,'String'));
    [filename pathname] = uigetfile('*.txt');
    pressure_data = dlmread(strcat(pathname,filename));
    pressure = pressure_data(:,2)';
    for t =1:size(s,2)
        s(t) = s(t)-beta*s(1)*(pressure(t)-p0);
    end
    handles.swp = s;
    pressureStr = strcat('pres:',num2str(beta),'_');
end
guidata(hObject,handles);

%figure();
%plot(days,s,'k');
%title('—игнал после поправки');

%if(flagTrend == true)
    %t = ChebRazl(s,pow,0);
    %s = s-t;
    %figure();
    %plot(days,s,'k');
    %title('ѕосле удалени€ тренда');
    %trendStr = strcat('cheb:',num2str(pow));
%end

%расчет энергии
popupContent = cellstr(get(handles.popupmenu1,'String'));
popupNum = get(handles.popupmenu1,'Value');
wname=popupContent{popupNum};
% index = zeros(1,sizeT);
% for pos = 1:sizeT
%    index(pos) = getIndex(s,pos,mina,maxa,window);
%    pos/sizeT*100
% end
trendStr = '';
if(flagTrend==true)
    pow = str2double(get(handles.edit5,'String'));
    e = mycwt(s,mina,maxa,wname,num_a,flagTrend,pow);
    trendStr = strcat('cheb:',num2str(pow));
else
    e = mycwt(s,mina,maxa,wname,num_a,flagTrend,0);
end

%просуммируем в скольз€щем окне
xo = str2double(get(handles.edit12,'String'));
smoothStr = strcat('smooth:',num2str(xo));
E=zeros(1,size(e,2)-xo+1);
xs=1;
while(xs+xo-1<=size(e,2))%пока конечна€ позици€ меньше или равна n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(e(1,xs:1:xs+xo-1));%суммируем элементы внутри окна
  xs=xs+1;
end

date_s = get(handles.outer_handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
dni = get(handles.outer_handles.dni, 'String');


xData = linspace(datenum(dateStart),datenum(dateEnd),size(E,2));
pos = 1:size(E,2);
metka = str2double(get(handles.outer_handles.metka,'String'));
%days = (pos./144)+1;
figure();
plot(xData,E,'k');
xlim([xData(1) xData(end)]);
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',xData(1:metka*144:size(s,2)));
datetick('x','m-dd','keepticks','keeplimits');
grid on;
title(strcat('1-side WE',32,'date:',date_s,32,'d:',dni,32,datastr,32,'win:',num2str(num_a),32,pressureStr,32,trendStr,32,smoothStr,32,wname,32,'a:',num2str(mina),'-',num2str(maxa)));



% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



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


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
    case 'radiobutton2'
        handles.flagData = 'integral';
    case 'radiobutton3'
        handles.flagData = 'single';
    case 'radiobutton4'
        handles.flagData = 'interval';
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = handles.s;
x=1:size(s,2);
days = x./144+1;
date_s = get(handles.outer_handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
dni = get(handles.outer_handles.dni, 'String');
metka = str2double(get(handles.outer_handles.metka,'String'));

dateStart=handles.outer_handles.date;
numDays = str2double(get(handles.outer_handles.dni,'String'));
dateEnd = addtodate(datenum(handles.outer_handles.date),numDays,'day');
dateStart = datestr(dateStart);
dateEnd = datestr(dateEnd);

xData = linspace(datenum(dateStart),datenum(dateEnd),size(s,2));
figure();
plot(xData,s,'k');
xlim([xData(1) xData(end)]);
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',xData(1:metka*144:size(s,2)));
datetick('x','m-dd','keepticks','keeplimits');
grid on;
title('»сходный сигнал');

flagPressure = get(handles.checkbox1,'Value');
if(flagPressure == true)
    s = handles.swp;
    figure();
    plot(xData,s,'k');
    xlim([xData(1) xData(end)]);
    set(gca,'FontName','Arial Cyr','FontSize',12);
    set(gca,'XTick',xData(1:metka*144:size(s,2)));
    datetick('x','m-dd','keepticks','keeplimits');
    grid on;
    title('ѕосле поправки');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.txt');
fid = fopen(strcat(pathname,filename));
mina = str2double(get(handles.edit2,'String'));
maxa = str2double(get(handles.edit3,'String'));
num_a = str2double(get(handles.edit1,'String'));
popupContent = cellstr(get(handles.popupmenu1,'String'));
popupNum = get(handles.popupmenu1,'Value');
wname=popupContent{popupNum};

D = textscan(fid,'%f %f');
fclose(fid);
s = D{2}';

flagTrend = get(handles.checkbox2,'Value');
if(flagTrend==true)
    pow = str2double(get(handles.edit5,'String'));
    e = mycwt(s,mina,maxa,wname,num_a,flagTrend,pow);
    trendStr = strcat('cheb:',num2str(pow));
else
    e = mycwt(s,mina,maxa,wname,num_a,flagTrend,0);
end

xo = str2double(get(handles.edit12,'String'));
E=zeros(1,size(e,2)-xo+1);
xs=1;

while(xs+xo-1<=size(e,2))%пока конечна€ позици€ меньше или равна n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(e(1,xs:1:xs+xo-1));%суммируем элементы внутри окна
  xs=xs+1;
end

pos = 1:size(E,2);
days = (pos./144)+1;
figure();
plot(days,E,'k');
xlim([days(1) days(end)]);