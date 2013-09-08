function varargout = CompareViewer(varargin)
% COMPAREVIEWER MATLAB code for CompareViewer.fig
%      COMPAREVIEWER, by itself, creates a new COMPAREVIEWER or raises the existing
%      singleton*.
%
%      H = COMPAREVIEWER returns the handle to a new COMPAREVIEWER or the handle to
%      the existing singleton*.
%
%      COMPAREVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPAREVIEWER.M with the given input arguments.
%
%      COMPAREVIEWER('Property','Value',...) creates a new COMPAREVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompareViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompareViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompareViewer

% Last Modified by GUIDE v2.5 22-Mar-2012 19:19:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompareViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @CompareViewer_OutputFcn, ...
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


% --- Executes just before CompareViewer is made visible.
function CompareViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompareViewer (see VARARGIN)

% Choose default command line output for CompareViewer
handles.output = hObject;
set(handles.radbtn_SourceMatrix,'Value',1);
handles.framePos = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CompareViewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
% --- Outputs from this function are returned to the command line.
function varargout = CompareViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function UpdateWindow(hObject,handles)
 %расчет времени
 total_min = handles.framePos*10;
 total_hours = total_min / 60;
 %if(total_hours>24)
     handles.date(3) = 1+floor(total_hours/24);%day
     handles.date(4) = floor(rem(total_hours,24));%hour
     handles.date(5) = rem(total_min,60);%minute
 %else
  %   handles.days = 1;
  %   hours = floor(total_min/60);
  %   min = floor(rem(total_min,60));
 %end
 %--------------
 set(handles.edit_framePos,'String',int2str(handles.framePos));
 set(handles.edit_Day,'String',num2str(handles.date(3)));
 set(handles.text_Date,'String',datestr(handles.date,'dd/mm/yyyy HH:MM'));
 axes(handles.miniCanvas);
 imagesc(handles.signal(:,:,handles.framePos),handles.lims);
 colorbar('YTickLabel',{'Freezing','Cold','Cool','Neutral','Warm','Hot','Burning','Nuclear'});
 axes(handles.axes_graphic);
 plot(handles.featuresOfSeries);

% --- Executes on button press in radbtn_SourceMatrix.
function radbtn_SourceMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to radbtn_SourceMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radbtn_MatWithoutTren,'Value',0);
set(handles.radbtn_MatEnergy,'Value',0);
handles.signal = handles.mat_intens;
handles.sourceSignal = handles.signal;
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radbtn_SourceMatrix


% --- Executes on button press in radbtn_MatWithoutTren.
function radbtn_MatWithoutTren_Callback(hObject, eventdata, handles)
% hObject    handle to radbtn_MatWithoutTren (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radbtn_SourceMatrix,'Value',0);
set(handles.radbtn_MatEnergy,'Value',0);
handles.signal = handles.mat_wt;
handles.sourceSignal = handles.signal;
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radbtn_MatWithoutTren


% --- Executes on button press in radbtn_MatEnergy.
function radbtn_MatEnergy_Callback(hObject, eventdata, handles)
% hObject    handle to radbtn_MatEnergy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radbtn_MatWithoutTren,'Value',0);
set(handles.radbtn_SourceMatrix,'Value',0);
handles.signal = handles.mat_en;
handles.sourceSignal = handles.signal;
UpdateWindow(hObject,handles);
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of radbtn_MatEnergy


% --------------------------------------------------------------------
function menu_FILE_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_PROCESSING_Callback(hObject, eventdata, handles)
% hObject    handle to menu_PROCESSING (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_Item_OPEN_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Item_OPEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat'});
load([pathname filename], 'mat_wt','mat_en','mat_intens','dat');%,'maxm_intens',...
    %'maxm_wt','maxm_en');
handles.mat_wt = mat_wt(:,:,:,4);
handles.mat_en = mat_en(:,:,:,4);
handles.mat_intens = mat_intens(:,:,:,4);
handles.date = dat;
if(get(handles.radbtn_SourceMatrix,'Value'))
    handles.signal = handles.mat_intens;
end
if(get(handles.radbtn_MatWithoutTren,'Value'))
        handles.signal = handles.mat_wt;
end
if(get(handles.radbtn_MatEnergy,'Value'))
    handles.signal = handles.mat_en;
end
handles.sourceSignal=handles.signal;
downImageRange = min(min(min(handles.signal)));
upImageRange = max(max(max(handles.signal)));
handles.lims = [downImageRange upImageRange];
handles.featuresOfSeries = zeros(size(handles.signal,3),1);

set(handles.edit_LowerColorRange,'String',num2str(downImageRange));
set(handles.edit_UpperColorRange,'String',num2str(upImageRange));


UpdateWindow(hObject,handles);
guidata(hObject,handles);


% --------------------------------------------------------------------
function menu_Item_DELTREND_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Item_DELTREND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nx=size(handles.signal,1);
Ny = size(handles.signal,2);
for i=1:Nx
    for j=1:Ny
        i,j
        handles.signal(i,j,:) = SSA_Filter(handles.signal(i,j,:),1);
    end
end
%handles.sourceSignal = handles.signal;
guidata(hObject,handles);
UpdateWindow(hObject, handles);
% --------------------------------------------------------------------
function menu_Item_COMPARE_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Item_COMPARE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.signal handles.featuresOfSeries] = compareImgs(handles.signal,0.99);
guidata(hObject,handles);
UpdateWindow(hObject, handles);

% --- Executes on button press in btnPrev.
function btnPrev_Callback(hObject, eventdata, handles)
% hObject    handle to btnPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.framePos>1)
    handles.framePos=handles.framePos-1;
    guidata(hObject, handles);
    UpdateWindow(hObject, handles);
end

% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.framePos<size(handles.signal,3))
    handles.framePos=handles.framePos+1;
guidata(hObject, handles);
UpdateWindow(hObject,handles);
end



function edit_framePos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_framePos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.framePos = str2double(get(hObject,'String'));
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit_framePos as text
%        str2double(get(hObject,'String')) returns contents of edit_framePos as a double


% --- Executes during object creation, after setting all properties.
function edit_framePos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_framePos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_OpenNewIm.
function btn_OpenNewIm_Callback(hObject, eventdata, handles)
% hObject    handle to btn_OpenNewIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure();
imagesc(handles.signal(:,:,handles.framePos),handles.lims);


function edit_Day_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Day as text
%        str2double(get(hObject,'String')) returns contents of edit_Day as a double
day = str2double(get(hObject,'String'));
handles.framePos= (day-1)*24*6;
guidata(hObject,handles);
UpdateWindow(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Day_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_UpThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to slider_UpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = get(hObject,'Value');
set(handles.edit_UpThreshold,'String',num2str(value*100));
minv = min(min(min(handles.sourceSignal)));
maxv = max(max(max(handles.sourceSignal)));
threshold = minv+abs(maxv-minv)*value;%255
for i=1:size(handles.sourceSignal,3)
    handles.signal(:,:,i) = handles.sourceSignal(:,:,i).*(handles.sourceSignal(:,:,i)>=threshold);
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_UpThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_UpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_UpThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to edit_UpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject,'String'));
minv = min(min(min(handles.sourceSignal)));
maxv = max(max(max(handles.sourceSignal)));
threshold = minv+abs(maxv-minv)*value/100;%255
for i=1:size(handles.sourceSignal,3)
    handles.signal(:,:,i) = handles.sourceSignal(:,:,i).*(handles.sourceSignal(:,:,i)>=threshold);
end
set(handles.slider_UpThreshold,'Value',value/100);
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit_UpThreshold as text
%        str2double(get(hObject,'String')) returns contents of edit_UpThreshold as a double


% --- Executes during object creation, after setting all properties.
function edit_UpThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_UpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UpperColorRange_Callback(hObject, eventdata, handles)
% hObject    handle to edit_UpperColorRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
downRange = str2double(get(handles.edit_LowerColorRange,'String'));
upRange = str2double(get(hObject,'String'));
handles.lims = [downRange upRange];
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit_UpperColorRange as text
%        str2double(get(hObject,'String')) returns contents of edit_UpperColorRange as a double


% --- Executes during object creation, after setting all properties.
function edit_UpperColorRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_UpperColorRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_LowerColorRange_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LowerColorRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
downRange = str2double(get(hObject,'String'));
upRange = str2double(get(handles.edit_UpperColorRange,'String'));
handles.lims = [downRange upRange];
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit_LowerColorRange as text
%        str2double(get(hObject,'String')) returns contents of edit_LowerColorRange as a double


% --- Executes during object creation, after setting all properties.
function edit_LowerColorRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LowerColorRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SeriesRow_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SeriesRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SeriesRow as text
%        str2double(get(hObject,'String')) returns contents of edit_SeriesRow as a double


% --- Executes during object creation, after setting all properties.
function edit_SeriesRow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SeriesRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SeriesColumn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SeriesColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SeriesColumn as text
%        str2double(get(hObject,'String')) returns contents of edit_SeriesColumn as a double


% --- Executes during object creation, after setting all properties.
function edit_SeriesColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SeriesColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_ShowSeries.
function btn_ShowSeries_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ShowSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.edit_SeriesColumn,'String'));
y = str2double(get(handles.edit_SeriesRow,'String'));
d = zeros(1,size(handles.signal,3));
for i=1:size(handles.signal,3)
    d(i) = handles.signal(y,x,i);
end
figure();
plot(d);
xlim([0 1000]);
ylim([-handles.lims(2) handles.lims(2)]);


% --- Executes on button press in btn_AutoColorRange.
function btn_AutoColorRange_Callback(hObject, eventdata, handles)
% hObject    handle to btn_AutoColorRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
downImageRange = min(min(min(handles.signal)));
upImageRange = max(max(max(handles.signal)));
handles.lims = [downImageRange upImageRange];
set(handles.edit_LowerColorRange,'String',num2str(downImageRange));
set(handles.edit_UpperColorRange,'String',num2str(upImageRange));
UpdateWindow(hObject,handles);
guidata(hObject,handles);


% --------------------------------------------------------------------
function menu_FILTER_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FILTER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_GAUSS_FIL_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_GAUSS_FIL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.signal = gaussFilter(handles.signal);
guidata(hObject,handles);
UpdateWindow(hObject,handles);

% --------------------------------------------------------------------
function menuIem_SOBEL_FIL_Callback(hObject, eventdata, handles)
% hObject    handle to menuIem_SOBEL_FIL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hy=fspecial('sobel');
hx=hy';
for i=1:size(handles.signal,3);
Iy=imfilter(handles.signal(:,:,i), hy, 'replicate');
Ix=imfilter(handles.signal(:,:,i), hx, 'replicate');
handles.signal(:,:,i) = Ix.^2+Iy.^2;
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuItem_SEGMENT_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_SEGMENT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.signal,3)
    L=watershed(handles.signal(:,:,i));
    handles.signal(:,:,i)=rgb2gray(label2rgb(L));
end
guidata(hObject,handles);
UpdateWindow(hObject, handles);


% --------------------------------------------------------------------
function menuItem_SAVE_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_SAVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig = handles.signal;
uisave('sig');


% --- Executes on button press in btnDist.
function btnDist_Callback(hObject, eventdata, handles)
% hObject    handle to btnDist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RS = calcDistBetwPoints_A(handles.signal);
figure();
x=1:size(RS,2);
x=(x./144)+1;
plot(x,RS(1,:));