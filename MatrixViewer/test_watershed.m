function varargout = test_watershed(varargin)
% WATERSHED MATLAB code for watershed.fig
%      WATERSHED, by itself, creates a new WATERSHED or raises the existing
%      singleton*.
%
%      H = WATERSHED returns the handle to a new WATERSHED or the handle to
%      the existing singleton*.
%
%      WATERSHED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WATERSHED.M with the given input arguments.
%
%      WATERSHED('Property','Value',...) creates a new WATERSHED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before watershed_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to watershed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help watershed

% Last Modified by GUIDE v2.5 14-May-2013 16:17:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_watershed_OpeningFcn, ...
                   'gui_OutputFcn',  @test_watershed_OutputFcn, ...
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


% --- Executes just before watershed is made visible.
function test_watershed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to watershed (see VARARGIN)

% Choose default command line output for watershed
handles.output = hObject;
handles.framePos = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes watershed wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_watershed_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menuItem_LOAD_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_LOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat'});
load([pathname filename], 'mat_intens');
handles.signal = cell2mat(mat_intens(4));
handles.sourceSignal=handles.signal;
handles.newSignal = handles.signal;
downImageRange = min(min(min(handles.signal)));
upImageRange = max(max(max(handles.signal)));
handles.lims = [downImageRange upImageRange];
guidata(hObject,handles);
UpdateWindow(hObject,handles);


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
handles.newSignal = handles.signal;
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
handles.newSignal = handles.signal;
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


% --- Executes on button press in btn_SobelFilter.
function btn_SobelFilter_Callback(hObject, eventdata, handles)
% hObject    handle to btn_SobelFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hy=fspecial('sobel');
hx=hy';
for i=1:size(handles.newSignal,3);
Iy=imfilter(handles.newSignal(:,:,i), hy, 'replicate');
Ix=imfilter(handles.newSignal(:,:,i), hx, 'replicate');
handles.newSignal(:,:,i) = Ix.^2+Iy.^2;
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnGaussFilter.
function btnGaussFilter_Callback(hObject, eventdata, handles)
% hObject    handle to btnGaussFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newSignal = gaussFilter(handles.newSignal);
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btn_Segmentation.
function btn_Segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.newSignal,3)
    i
    %L=watershed(handles.newSignal(:,:,i));
    L=edge(handles.newSignal(:,:,i),'canny',[0.04 0.1],2);
    I = handles.newSignal(:,:,i);%=rgb2gray(label2rgb(L));
    %I(L==0)=255;
    I(L==1)=handles.lims(2);
    handles.newSignal(:,:,i) = I;
end
guidata(hObject,handles);
UpdateWindow(hObject, handles);

function UpdateWindow(hObject,handles)
set(handles.edit_framePos,'String',int2str(handles.framePos));
% axes(handles.axesOriginal);
% imagesc(handles.signal(:,:,handles.framePos),handles.lims);
axes(handles.axesFinished);
imagesc(handles.newSignal(:,:,handles.framePos),handles.lims);
colorbar();


% --- Executes on button press in btn_Back.
function btn_Back_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.framePos>1)
    handles.framePos=handles.framePos-1;
    guidata(hObject, handles);
    UpdateWindow(hObject, handles);
end

% --- Executes on button press in btn_Forward.
function btn_Forward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.framePos<size(handles.signal,3))
    handles.framePos=handles.framePos+1;
guidata(hObject, handles);
UpdateWindow(hObject,handles);
end


% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
% hObject    handle to btnReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newSignal = handles.signal;
guidata(hObject,handles);
UpdateWindow(hObject,handles);



function editSobel_Callback(hObject, eventdata, handles)
% hObject    handle to editSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSobel as text
%        str2double(get(hObject,'String')) returns contents of editSobel as a double


% --- Executes during object creation, after setting all properties.
function editSobel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_framePos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_framePos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.framePos = str2double(get(hObject,'String'));
guidata(hObject,handles);
UpdateWindow(hObject,handles);
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


% --- Executes on button press in ssa_smooth_btn.
function ssa_smooth_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ssa_smooth_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s_row = zeros(size(handles.signal,1),size(handles.signal,2));
s_col = zeros(size(s_row));
for t=1:size(handles.newSignal,3)
    for i=1:size(handles.newSignal,1)
        s_row(i,:) = SSA_Denoise(handles.newSignal(i,:,t),3);
    end
    for j=1:size(handles.newSignal,2)
        s_col(:,j) = SSA_Denoise(handles.newSignal(:,j,t)',3);
    end
    handles.newSignal(:,:,t) = sqrt(s_row.^2+s_col.^2);
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnSmoothn.
function btnSmoothn_Callback(hObject, eventdata, handles)
% hObject    handle to btnSmoothn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.newSignal,3)
    handles.newSignal(:,:,i) = smoothn(handles.newSignal(:,:,i))
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);



function editMinLim_Callback(hObject, eventdata, handles)
% hObject    handle to editMinLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
min = str2num(get(hObject,'String'));
handles.lims(1) = min;
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% Hints: get(hObject,'String') returns contents of editMinLim as text
%        str2double(get(hObject,'String')) returns contents of editMinLim as a double


% --- Executes during object creation, after setting all properties.
function editMinLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMaxLim_Callback(hObject, eventdata, handles)
% hObject    handle to editMaxLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
max = str2num(get(hObject,'String'));
handles.lims(2) = max;
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% Hints: get(hObject,'String') returns contents of editMaxLim as text
%        str2double(get(hObject,'String')) returns contents of editMaxLim as a double


% --- Executes during object creation, after setting all properties.
function editMaxLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMaxLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnWaveletFilter.
function btnWaveletFilter_Callback(hObject, eventdata, handles)
% hObject    handle to btnWaveletFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.signal = handles.newSignal;
for i=1:size(handles.newSignal,3)
    handles.newSignal(:,:,i) = WaveletDenoise2D(handles.newSignal(:,:,i));
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnKryanev.
function btnKryanev_Callback(hObject, eventdata, handles)
% hObject    handle to btnKryanev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.newSignal,3)
    handles.newSignal(:,:,i) = smoothFilter(handles.newSignal(:,:,i),3,7);
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnSmooth3D.
function btnSmooth3D_Callback(hObject, eventdata, handles)
% hObject    handle to btnSmooth3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newSignal(:,:,:) = smoothFilter3D(handles.newSignal(:,:,:),3,1);
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnNormalization.
function btnNormalization_Callback(hObject, eventdata, handles)
% hObject    handle to btnNormalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.newSignal,3);
    handles.newSignal(:,:,i) = Normalization(handles.newSignal(:,:,i));
end
% for i=1:size(handles.newSignal,1)
% %     for j=1:size(handles.newSignal,2)
%         handles.newSignal(i,j,:) = SSA_Filter_Part(handles.newSignal(i,j,:),144,1);
%     end
% end

guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in btnNewWin.
function btnNewWin_Callback(hObject, eventdata, handles)
% hObject    handle to btnNewWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure();
imagesc(handles.newSignal(:,:,handles.framePos),handles.lims);
colorbar();
%axis off;


% --- Executes on button press in btnDelTrend.
function btnDelTrend_Callback(hObject, eventdata, handles)
% hObject    handle to btnDelTrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = 1:size(handles.newSignal,2);
for i=1:size(handles.newSignal,3)
    for j=1:size(handles.newSignal,1)
   %     figure(1);
    %    plot(handles.newSignal(j,:,i));
     %   hold on;
        handles.newSignal(j,:,i) = handles.newSignal(j,:,i)-cubicSplineSmooth1D(x,(handles.newSignal(j,:,i)));%WaveletDenoise1D('db4',handles.newSignal(j,:,i));
      %  plot(handles.newSignal(j,:,i),'r');
      % hold off;
    end
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pbtn2DSSA.
function pbtn2DSSA_Callback(hObject, eventdata, handles)
% hObject    handle to pbtn2DSSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
for j=1:size(handles.newSignal,3)
    j
    handles.newSignal(:,:,j) = handles.newSignal(:,:,j) - SSA_2D(handles.newSignal(:,:,j),1);
end
toc
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pbtn2DSSA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pbtn2DSSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numberOfMatrixForMeaning=36;
N = size(handles.newSignal,3);
numSegments = N/numberOfMatrixForMeaning;
for i =1:numSegments
    meanMat = mean(handles.newSignal(:,:,(i-1)*numberOfMatrixForMeaning+1:i*numberOfMatrixForMeaning),3);
    %meanMat = mean(handles.newSignal(:,:,max(i-numberOfMatrixForMeaning+1,1):i),3);
    for j = (i-1)*numberOfMatrixForMeaning+1:i*numberOfMatrixForMeaning
        handles.newSignal(:,:,j) = handles.newSignal(:,:,j)-meanMat;
    end
end
% for i=1:size(handles.newSignal,3)
%     i
%     meanMat = mean(handles.newSignal(:,:,max(i-numberOfMatrixForMeaning+1,1):i),3);
%     handles.newSignal(:,:,i) = (handles.newSignal(:,:,i)-meanMat)./sqrt(meanMat);
% end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in pushbutton18.
% расчет вейвлет-энергии изображения
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
for i =500:700%size(handles.newSignal,3)
    i
    handles.newSignal(:,:,i) = waveletEnergy2D(handles.newSignal(:,:,i),5,20);
end
toc
guidata(hObject,handles);
UpdateWindow(hObject,handles);
% --------------------------------------------------------------------
function Data_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plot_image_Callback(hObject, eventdata, handles)
% hObject    handle to plot_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%усреднение по нескольким матрицам
 vals = zeros(1,size(handles.newSignal,3));
 threshold = 1e100;
 for i = 1:size(vals,2)
     mat=handles.newSignal(:,:,i);
     mat2=mat(mat<threshold);
     vals(i) = sum(sum(mat2));
 end
%t = ChebRazl(vals,15,0);
%vals = fourier_proc(vals,0,4000);
% num_mean_matrix = 6;%по сколько матриц усреднять
%mean_vals = zeros(1,floor(size(vals,2)/num_mean_matrix));
%for i =1:length(mean_vals);
%    mean_vals(i) = mean(vals(i:i+num_mean_matrix-1));
%end
%сгладим ряд с помощью скользящего среднего
N = size(handles.newSignal,3);
windowSize = 0;
step = 1;%лучше не менять) сглаживание корявое
newVals = zeros(1,N);
for i=1:N
    newVals(i) = mean(vals(i:min(i+windowSize,N)));
end
%сгладим с помощью оконного метода
%windowRad = 3;
% for i=1:N
%     newVals(i) = mean(vals(max(1,i-windowRad):min(N,i+windowRad)));
 %end
figure();
x = 1:N;
%x = x./(144/num_mean_matrix)+1;
x = x./144+1;
%plot(x,vals,'y');
%hold on;
plot(x,newVals,'k');
%title(strcat('порог=',num2str(threshold),' окно=',num2str(windowSize)));
e = AnalyzW(newVals,36,72,1);
figure();
plot(x,e);


% --------------------------------------------------------------------
function menuItem_SAVE_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_SAVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signal = handles.newSignal;
uisave('signal');


% --------------------------------------------------------------------
function menuItem_LOAD_PROCESSED_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_LOAD_PROCESSED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'signal');
handles.sourceSignal = signal;
handles.signal = signal;
handles.newSignal = signal;
downImageRange = min(min(min(handles.signal)));
upImageRange = max(max(max(handles.signal)));
handles.lims = [downImageRange upImageRange];
guidata(hObject,handles);



% --------------------------------------------------------------------
function wavelet_3D_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newSignal = wavelet3DSmooth(handles.newSignal,2);
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuItem_DIFF_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_DIFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newSignal = diffSignal(handles.newSignal);
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuItem_ALIGN_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_ALIGN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:size(handles.newSignal,3)
    handles.newSignal(:,:,i) = alignFunc(handles.newSignal(:,:,i),20);
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuItem_CUBESMOOTH_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_CUBESMOOTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig = handles.newSignal;
newSig = zeros(size(sig));
sizeR = size(sig,1);
sizeC = size(sig,2);
Ntime = size(sig,3);
for i=1:sizeR
    i
    for j=1:sizeC
        for k=1:Ntime
            newSig(i,j,k) = mean(mean(mean(sig(max(i-1,1):min(i+1,sizeR),max(j-1,1):min(j+1,sizeC),max(k-2,1):min(k+2,Ntime)))));
        end
    end
end
handles.newSignal = newSig;
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% -------------хрень какая-то----------------------------------------------
function menuItem_BlockMean_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_BlockMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig = handles.newSignal;
blockSizeRow = size(sig,1);
blockSizeCol = size(sig,2);
blockSizeT   = 6;
interval = 144;
numBlocks = interval/blockSizeT;
numIntervals = size(sig,3)/interval;
for j =1:numIntervals
    tempBlock = zeros(blockSizeRow,blockSizeCol,blockSizeT);
    for i =1:numBlocks
        tempBlock = tempBlock+sig(:,:,(j-1)*interval+(i-1)*blockSizeT+1:(j-1)*interval+i*blockSizeT);
    end
    meanBlock = tempBlock./numBlocks;
    for i =1:numBlocks
        sig(:,:,(j-1)*interval+(i-1)*blockSizeT+1:(j-1)*interval+i*blockSizeT) = sig(:,:,(j-1)*interval+(i-1)*blockSizeT+1:(j-1)*interval+i*blockSizeT)-meanBlock;
    end
end
handles.newSignal = sig;
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuItem_GAUSS3D_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_GAUSS3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig = handles.newSignal;
handles.newSignal = gaussFilter3D(sig,15,30,5,3);
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --------------------------------------------------------------------
function menuitem_PRESSURE_Callback(hObject, eventdata, handles)
% hObject    handle to menuitem_PRESSURE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.txt');
pressure_data = dlmread(strcat(pathname,filename));
pressure = pressure_data(:,2)';
%fid = fopen(strcat(pathname,filename));
%D = textscan(fid,'%s %s %s');
%D = str2double(D{3});
%pressure = (D./10)';
%pressure = pressure.*0.1;
sig = handles.newSignal;
beta = -0.002;
p0=994;
s = zeros(size(sig));
for i=1:size(sig,1)
    i
    for j=1:size(sig,2)
        for t =1:size(sig,3)
            %a = 1-beta*(pressure(t)-pressure(1));
            s(i,j,t) = sig(i,j,t)-beta*sig(i,j,1)*(pressure(t)-p0);
        end
    end
end
handles.newSignal = s;
guidata(hObject,handles);


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% x = 1:size(handles.newSignal,2);
for i=1:size(handles.newSignal,1)
    i
    for j=1:size(handles.newSignal,2)
        temp = squeeze(handles.newSignal(i,j,:))';
        temp1 = ChebRazl(temp,15,0);
        handles.newSignal(i,j,:) = temp-temp1;
    end
end
guidata(hObject,handles);
UpdateWindow(hObject,handles);


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sig = handles.signal;
s = zeros(1,size(sig,3));
for i=1:size(sig,3)
    s(i)=sum(sum(sig(:,:,i)));
end

windowDays = 0.5;% движущееся окно в днях
step=1;%шаг движения
a1=36;
a2=72;
beta = -0.002;
p0=994;

sizeA=a2-a1+1;
window = windowDays*144;

% [filename pathname] = uigetfile('*.txt');
% pressure_data = dlmread(strcat(pathname,filename));
% pressure = pressure_data(:,2)';

sizeT = size(sig,3);
%поправка на давление
% for t =1:size(s,2)
%     %s2(t) = s(t)*(1+beta*(pressure(t)-p0));%pressure(1)));
%     s(t) = s(t)-beta*s(1)*(pressure(t)-p0);
% end

%расчет индексов
pos_index=1;
index = zeros(1,(sizeT-window)/step);
d_index = zeros(1,(sizeT-window)/step);
for pos = 1:step:sizeT-window
    windowData = s(pos:pos+window);
    trend = ChebRazl(windowData,3,0);
    windowData = windowData-trend;
    %e = mycwt(windowData,a1,a2);
    %index(pos_index) = e(end);
    index(pos_index) = sum(AnalyzW(windowData,a1,a2,1));
    %index(pos_index) = sum(mycwt(windowData,a1,a2));
    d_index(pos_index) = std(windowData);
    pos_index=pos_index+1;
    
    progress = floor(pos_index./size(index,2)*100);
    if(rem(progress,10)==0)
        progress
    end
end
pos = 1:size(index,2);
pos = pos+window;
days = (pos./144)+1;
figure();
plot(days,index,'k');
title('ener');
figure();
plot(days,d_index,'k');
title('disp');
