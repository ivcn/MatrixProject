function varargout = Viewer2(varargin)
% VIEWER2 MATLAB code for Viewer2.fig
%      VIEWER2, by itself, creates a new VIEWER2 or raises the existing
%      singleton*.
%
%      H = VIEWER2 returns the handle to a new VIEWER2 or the handle to
%      the existing singleton*.
%
%      VIEWER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWER2.M with the given input arguments.
%
%      VIEWER2('Property','Value',...) creates a new VIEWER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Viewer2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Viewer2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Viewer2

% Last Modified by GUIDE v2.5 19-Feb-2012 15:24:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Viewer2_OpeningFcn, ...
                   'gui_OutputFcn',  @Viewer2_OutputFcn, ...
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


% --- Executes just before Viewer2 is made visible.
function Viewer2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Viewer2 (see VARARGIN)

% Choose default command line output for Viewer2
handles.output = hObject;
handles.framePos = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Viewer2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Viewer2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

% --------------------------------------------------------------------
function menuItem_File_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_File_Open_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_File_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat'});
load([pathname filename], 'mat_wt','mat_en','mat_intens');
% load([pathname filename],'AA');
% handles.sourceSignal = AA;%(:,:,:,4);
handles.sourceSignal = mat_en(:,:,:,4);
handles.signal = handles.sourceSignal;
% handles.sourceSignalCopy = handles.sourceSignal;
downImageRange = min(min(min(handles.signal)));
%upImageRange = 600;
upImageRange = max(max(max(handles.signal)));
handles.lims = [downImageRange upImageRange];
set(handles.editDownImageRange,'String',num2str(downImageRange));
set(handles.editUpImageRange,'String',num2str(upImageRange));
handles.movieMode = false;
handles.moviePos = 1;
handles.framePos = 1;
handles.featuresOfSeries = zeros(size(handles.signal,3),1);
guidata(hObject, handles);
UpdateWindow(hObject, handles);


%---------------------------------------------------------------------
function UpdateWindow(hObject, handles)
 set(handles.editFramePos,'String',int2str(handles.framePos));
 total_min = handles.framePos*10;
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
 set(handles.textTime,'String',strcat(num2str(hours),' ч.  ',num2str(min),' мин.'));
 set(handles.editDay,'String',num2str(days));
 axes(handles.canvas);
%  colormap('hot');
 imagesc(handles.signal(:,:,handles.framePos),handles.lims);
 %------график серий
 axes(handles.axes_graphic);
 plot(handles.featuresOfSeries);
 if(handles.movieMode==true)
     handles.movie(handles.moviePos) = getframe;
     handles.moviePos = handles.moviePos+1;
 end
 colorbar('YTickLabel',{'Freezing','Cold','Cool','Neutral','Warm','Hot','Burning','Nuclear'});
 guidata(hObject,handles);
%----------------------------------------------------------------------



function editFramePos_Callback(hObject, eventdata, handles)
% hObject    handle to editFramePos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.framePos = str2double(get(hObject,'String'));
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of editFramePos as text
%        str2double(get(hObject,'String')) returns contents of editFramePos as a double


% --- Executes during object creation, after setting all properties.
function editFramePos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFramePos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDay_Callback(hObject, eventdata, handles)
% hObject    handle to editDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
day = str2double(get(hObject,'String'));
handles.framePos= (day-1)*24*6;
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% Hints: get(hObject,'String') returns contents of editDay as text
%        str2double(get(hObject,'String')) returns contents of editDay as a double


% --- Executes during object creation, after setting all properties.
function editDay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to sliderThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject,'Value');
set(handles.editUpThreshold,'String',num2str(value));
minv = min(min(min(handles.sourceSignal)));
maxv = max(max(max(handles.sourceSignal)));
threshold = minv+abs(maxv-minv)*value/255;
for i=1:size(handles.sourceSignal,3)
    handles.signal(:,:,i) = handles.sourceSignal(:,:,i).*(handles.sourceSignal(:,:,i)>=threshold);
end
% for i=1:size(im,1)
%     for j=1:size(im,2)
%         if(im(i,j)<threshold);
%             im(i,j) = 0;
%         end
%     end
% end
guidata(hObject,handles);
UpdateWindow(hObject,handles);
%---------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function sliderThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function editUpThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editUpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editUpThreshold as text
%        str2double(get(hObject,'String')) returns contents of editUpThreshold as a double


% --- Executes during object creation, after setting all properties.
function editUpThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editUpThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDownThresold_Callback(hObject, eventdata, handles)
% hObject    handle to editDownThresold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDownThresold as text
%        str2double(get(hObject,'String')) returns contents of editDownThresold as a double


% --- Executes during object creation, after setting all properties.
function editDownThresold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDownThresold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderThresholdDown_Callback(hObject, eventdata, handles)
% hObject    handle to sliderThresholdDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% value = get(hObject,'Value');
% im = handles.signal(:,:,handles.framePos);
% minv = min(min(im));
% maxv = max(max(im));
% value = value;
% set(handles.editUpThreshold,'String',num2str(value));
% threshold = minv+abs(maxv-minv)*value/255;
% for i=1:size(im,1)
%     for j=1:size(im,2)
%         if(im(i,j)>threshold);
%             im(i,j) = 0;
%         end
%     end
% end
% axes(handles.canvas);
% imagesc(im,handles.lims);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderThresholdDown_CreateFcn(hObject, ~, handles)
% hObject    handle to sliderThresholdDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function menuItem_Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_Smooth_GaussFilter_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Smooth_GaussFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i=1:size(handles.signal,3)
    im0 = handles.signal(:,:,i);
    s = std(im0(:));
    if s==0
        continue
    end
    w=fspecial('gaussian',3,s);
    handles.signal(:,:,i) = imfilter(handles.signal(:,:,i),w,'replicate');
end
handles.sourceSignal = handles.signal;
guidata(hObject,handles);
UpdateWindow(hObject,handles);
%axes(handles.canvas);
%imagesc(im,handles.lims);


function editDownImageRange_Callback(hObject, eventdata, handles)
% hObject    handle to editDownImageRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
downRange = str2double(get(hObject,'String'));
upRange = str2double(get(handles.editUpImageRange,'String'));
handles.lims = [downRange upRange];
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of editDownImageRange as text
%        str2double(get(hObject,'String')) returns contents of editDownImageRange as a double


% --- Executes during object creation, after setting all properties.
function editDownImageRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDownImageRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editUpImageRange_Callback(hObject, eventdata, handles)
% hObject    handle to editUpImageRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
downRange = str2double(get(handles.editDownImageRange,'String'));
upRange = str2double(get(hObject,'String'));
handles.lims = [downRange upRange];
UpdateWindow(hObject,handles);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of editUpImageRange as text
%        str2double(get(hObject,'String')) returns contents of editUpImageRange as a double


% --- Executes during object creation, after setting all properties.
function editUpImageRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editUpImageRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menuItem_Smooth_Compare_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Smooth_Compare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[handles.signal characSer] = comparison_refinement(handles.signal,0.1);
[handles.signal handles.featuresOfSeries] = compareImgs(handles.signal,0.1);
guidata(hObject,handles);
UpdateWindow(hObject, handles);


% --------------------------------------------------------------------
function menuItem_Smooth_Wavelet3D_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Smooth_Wavelet3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.signal = wavelet3DSmooth(handles.signal,1);
handles.sourceSignal = handles.signal;
guidata(hObject,handles);
UpdateWindow(hObject, handles);


% --- Executes on button press in pbtnData.
function pbtnData_Callback(hObject, eventdata, handles)
% hObject    handle to pbtnData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togBtnData.
function togBtnData_Callback(hObject, eventdata, handles)
% hObject    handle to togBtnData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm_obj=datacursormode(handles.figure1);
state=get(dcm_obj,'Enable');
if strcmp(state,'on')
    datacursormode off
else
datacursormode on;
end
% Hint: get(hObject,'Value') returns toggle state of togBtnData


% --- Executes on button press in togbtnMovie.
function togbtnMovie_Callback(hObject, eventdata, handles)
% hObject    handle to togbtnMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.movieMode == false
    handles.movieMode = true;
    set(handles.togbtnMovie,'String','Остановить запись');
    handles.moviePos = 1;
    
else
    handles.movieMode = false;
    set(handles.togbtnMovie,'String','Начать запись');
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of togbtnMovie


% --- Executes on button press in pbtnPlay.
function pbtnPlay_Callback(hObject, eventdata, handles)
% hObject    handle to pbtnPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% for i=1:size(handles.signal,3)
%     handles.movie(i) = im2frame(handles.signal(:,:,i));
% end
movie(handles.movie,1,3);
% --------------------------------------------------------------------
function menuItem_Trend_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Trend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_Trend_SSA_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Trend_SSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nx=size(handles.signal,1);
Ny = size(handles.signal,2);
for i=1:Nx
    for j=1:Ny
        i,j
        handles.signal(i,j,:) = SSA_Filter(handles.signal(i,j,:),2);
    end
end
handles.sourceSignal = handles.signal;
guidata(hObject,handles);
UpdateWindow(hObject, handles);


% --------------------------------------------------------------------
function menuItem_File_Save_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_File_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editViewSeriesX_Callback(hObject, eventdata, handles)
% hObject    handle to editViewSeriesX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editViewSeriesX as text
%        str2double(get(hObject,'String')) returns contents of editViewSeriesX as a double


% --- Executes during object creation, after setting all properties.
function editViewSeriesX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editViewSeriesX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editViewSeriesY_Callback(hObject, eventdata, handles)
% hObject    handle to editViewSeriesY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editViewSeriesY as text
%        str2double(get(hObject,'String')) returns contents of editViewSeriesY as a double


% --- Executes during object creation, after setting all properties.
function editViewSeriesY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editViewSeriesY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbtnViewSeries.
function pbtnViewSeries_Callback(hObject, eventdata, handles)
% hObject    handle to pbtnViewSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.editViewSeriesX,'String'));
y = str2double(get(handles.editViewSeriesY,'String'));
d = zeros(1,size(handles.signal,3));
for i=1:size(handles.signal,3)
    d(i) = handles.signal(x,y,i);
end
figure();
plot(d);
xlim([0 1000]);
ylim([-handles.lims(2) handles.lims(2)]);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure();
imagesc(handles.signal(:,:,handles.framePos),handles.lims);
% colorbar('YTickLabel',{handles.lims(1): (handles.lims(2)-handles.lims(1))/9:handles.lims(2)});%{'Freezing','Cold','Cool','Neutral','Warm','Hot','Burning','Nuclear'});
