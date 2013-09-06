function varargout = TrendWindow(varargin)
% TRENDWINDOW M-file for TrendWindow.fig
%      TRENDWINDOW, by itself, creates a new TRENDWINDOW or raises the existing
%      singleton*.
%
%      H = TRENDWINDOW returns the handle to a new TRENDWINDOW or the handle to
%      the existing singleton*.
%
%      TRENDWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRENDWINDOW.M with the given input arguments.
%
%      TRENDWINDOW('Property','Value',...) creates a new TRENDWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrendWindow_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrendWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help TrendWindow

% Last Modified by GUIDE v2.5 25-Feb-2012 18:50:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrendWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @TrendWindow_OutputFcn, ...
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


% --- Executes just before TrendWindow is made visible.
function TrendWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrendWindow (see VARARGIN)

% Choose default command line output for TrendWindow
handles.output = hObject;
handles.ltrend = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrendWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrendWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function trend_Callback(hObject, eventdata, handles)
% hObject    handle to trend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trend as text
%        str2double(get(hObject,'String')) returns contents of trend as a double


% --- Executes during object creation, after setting all properties.
function trend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nn=2000;
T=1:nn;

trends = get(handles.trend, 'String')
handles.ltrend = eval(trends);

k=handles.axes1;
axes(k);

plot(handles.ltrend);
guidata(hObject, handles);







% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.axes0;
axes(h);
u=eval(get(handles.noiselvl, 'String'));
mat = get(handles.mat, 'Value');
if (mat==0)
    ff=handles.A;
else
    ff=modelrow(u, handles.ss0,handles.ss1,handles.ss2,handles.ss3)+handles.ltrend;
    handles.A=ff;
end
flagapprox = get(handles.approx, 'Value');


if (flagapprox == 0)
    plot(ff);
else
    flagssa = get(handles.ssa, 'Value');
    if (flagssa == 0)
        flagfish = get(handles.fisher, 'Value');
        flagwindow = get(handles.window, 'Value');
        if (flagwindow == 0)    %%   
            if not(flagfish==0) %%   
                [F,B,l] = Approx(ff,0); 
                n=size(F,2);
                plot(1:n, ff, 1:n, F);
                set(handles.maxpow, 'String', l);
                handles.F=F;               
            else                %%    
                l=eval(get(handles.maxpow, 'String')); 
                [F,B] = Approx(ff,l) ;
                n=size(F,2);
                plot(1:n, ff, 1:n, F);
                handles.F=F;               
            end
        else        %%     ()
            windowsize = eval(get(handles.windowsize, 'String'));
            if not(flagfish==0) %%   
                K = ApproxWD(ff,handles.ltrend,windowsize,0) ;
                plot(ff);
                handles.K=K;                
            else                %%    
                l=eval(get(handles.maxpow, 'String')); 
                K = ApproxWD(ff,handles.ltrend,windowsize,l) ;
                plot(ff);
                handles.K=K;             
            end
        end
    else        %% SSA
        windowsize = eval(get(handles.windowsize, 'String'));
        K=ApproxWDSSA(ff,handles.ltrend,windowsize);
        plot(ff);
        handles.K=K;       
    end
end

 guidata(hObject, handles);

function noiselvl_Callback(hObject, eventdata, handles)
% hObject    handle to noiselvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noiselvl as text
%        str2double(get(hObject,'String')) returns contents of noiselvl as a double


% --- Executes during object creation, after setting all properties.
function noiselvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiselvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end





function s1_Callback(hObject, eventdata, handles)
% hObject    handle to s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s1 as text
%        str2double(get(hObject,'String')) returns contents of s1 as a double


% --- Executes during object creation, after setting all properties.
function s1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function s2_Callback(hObject, eventdata, handles)
% hObject    handle to s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s2 as text
%        str2double(get(hObject,'String')) returns contents of s2 as a double


% --- Executes during object creation, after setting all properties.
function s2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
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
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function s3_Callback(hObject, eventdata, handles)
% hObject    handle to s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s3 as text
%        str2double(get(hObject,'String')) returns contents of s3 as a double


% --- Executes during object creation, after setting all properties.
function s3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.axes0;
axes(h);
mat = get(handles.mat, 'Value');
if (mat==0)
    plot(handles.A);
else
    handles.ss0=get(handles.s0, 'String');
    handles.ss1=get(handles.s1, 'String');
    handles.ss2=get(handles.s2, 'String');
    handles.ss3=get(handles.s3, 'String');
    ff=modelrow(0, handles.ss0,handles.ss1,handles.ss2,handles.ss3);
end

plot(ff);
guidata(hObject, handles);


% --- Executes on button press in approx.
function approx_Callback(hObject, eventdata, handles)
% hObject    handle to approx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of approx



function Maxpow_Callback(hObject, eventdata, handles)
% hObject    handle to Maxpow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Maxpow as text
%        str2double(get(hObject,'String')) returns contents of Maxpow as a double


% --- Executes during object creation, after setting all properties.
function Maxpow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Maxpow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function maxpow_Callback(hObject, eventdata, handles)
% hObject    handle to maxpow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxpow as text
%        str2double(get(hObject,'String')) returns contents of maxpow as a double


% --- Executes during object creation, after setting all properties.
function maxpow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxpow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in fisher.
function fisher_Callback(hObject, eventdata, handles)
% hObject    handle to fisher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fisher




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.axes3;
axes(h);

flagwindow = get(handles.window, 'Value');
if (flagwindow == 0)    %%   
    handles.B =handles.A-handles.F;
    handles.XD = handles.B;
    guidata(hObject, handles);
    plot(handles.B);
else
    
end    



% --- Executes on button press in window.
function window_Callback(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of window



function windowsize_Callback(hObject, eventdata, handles)
% hObject    handle to windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowsize as text
%        str2double(get(hObject,'String')) returns contents of windowsize as a double


% --- Executes during object creation, after setting all properties.
function windowsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in SSA.
function SSA_Callback(hObject, eventdata, handles)
% hObject    handle to SSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SSA




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=handles.axes4;
axes(h);

flagwindow = get(handles.window, 'Value');
if (flagwindow == 0)    %%   
    plot(handles.ltrend-handles.F);
else
    plot(handles.K);
end    


% --- Executes on button press in ssa.
function ssa_Callback(hObject, eventdata, handles)
% hObject    handle to ssa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ssa




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
WaveletWindow



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.txt');
if FileName~=0
    %     
    FullName = [PathName FileName];
    fid=fopen(FullName);
    A=fscanf(fid,'%f');
    fclose(fid); 
    
    fivemin = get(handles.fivemin, 'Value');
    if fivemin ~=0
        A=Obrezka(A);
    else
        A=Perevorot(A);
    end
    
    handles.A=A;
    
    h = handles.axes0;
    axes(h);
    plot(A);
    guidata(hObject, handles);
end



% --- Executes on button press in mat.
function mat_Callback(hObject, eventdata, handles)
% hObject    handle to mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mat




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.axes4;
axes(h);

xa = eval(get(handles.maxa, 'String'));
xo = eval(get(handles.wavewindow, 'String'));

flagwindow = get(handles.window, 'Value');

if (flagwindow == 0)      
    E = AnalyzW(handles.B,xa,xo);  
else
    flagssa = get(handles.ssa, 'Value');
    if (flagssa == 0)   % Chebishev
        flagfish = get(handles.fisher, 'Value');
        if (flagfish == 0) % fisher
            E = AnalyzWD(handles.A, xo, 0); 
        else            % fix max stepen
            l = eval(get(handles.maxpow, 'String'));
            E = AnalyzWD(handles.A, xo, l);
        end
    else    % SSA
        E = AnalyzWD(handles.A, xo, -1);
    end
end
plot(E);


function maxa_Callback(hObject, eventdata, handles)
% hObject    handle to maxa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxa as text
%        str2double(get(hObject,'String')) returns contents of maxa as a double


% --- Executes during object creation, after setting all properties.
function maxa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end





function wavewindow_Callback(hObject, eventdata, handles)
% hObject    handle to wavewindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wavewindow as text
%        str2double(get(hObject,'String')) returns contents of wavewindow as a double


% --- Executes during object creation, after setting all properties.
function wavewindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavewindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes during object creation, after setting all properties.
function pushbutton8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wave_type = get(handles.wave_type, 'String');
wave_type = cell2mat(wave_type(get(handles.wave_type, 'Value')));

if wave_type(1) ~= 'haar'
    val = get(handles.wave_number, 'String');
    wave_number = eval(cell2mat(val(get(handles.wave_number, 'Value'))));
    wave_number = wave_number(1);
    wave_type = [wave_type int2str(wave_number)]
end    

X = handles.B;
alpha = eval(get(handles.alpha, 'String'));
level = eval(get(handles.level, 'String'));
threshold = get(handles.threshold, 'Value');



if threshold == 1
    SORH = 's';
else
    SORH = 'h';
end

%[XD, CXD, LXD] = wden(X, 'minimaxi', SORH, 'sln', level)

[c,l] = wavedec(X, level, wave_type);
sigma = wnoisest(c,l,1);
THR = wbmpen(c,l, sigma, alpha);

XD = wdencmp('gbl',c,l, wave_type, level, THR, SORH, 1);
handles.XD = XD;
guidata(hObject, handles);

h = handles.axes2;
axes(h);

plot(XD)




function level_Callback(hObject, eventdata, handles)
% hObject    handle to level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of level as text
%        str2double(get(hObject,'String')) returns contents of level as a double


% --- Executes during object creation, after setting all properties.
function level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in threshold.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of threshold


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maxa = eval(get(handles.maxa, 'String')) ;
mina = eval(get(handles.mina, 'String')) ;
maxb = eval(get(handles.maxb, 'String')) ;

B = handles.XD;
n = size(B,2);   % количество точек ряда
%UNTITLED1 Summary of this function goes here


wcoef = cwt(B,mina:maxa,'cmor2-1');

Ew = sum(abs(wcoef(:,:)).^2);

xs=1;

E=[];


while (xs+maxb-1<=n)
  E=[E sum(Ew(1,xs:1:xs+maxb-1))];      
  xs=xs+1;
end

h = handles.axes10;
axes(h);

plot(E)



function maxb_Callback(hObject, eventdata, handles)
% hObject    handle to maxb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxb as text
%        str2double(get(hObject,'String')) returns contents of maxb as a double


% --- Executes during object creation, after setting all properties.
function maxb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mina_Callback(hObject, eventdata, handles)
% hObject    handle to mina (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mina as text
%        str2double(get(hObject,'String')) returns contents of mina as a double


% --- Executes during object creation, after setting all properties.
function mina_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mina (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in wave_type.
function wave_type_Callback(hObject, eventdata, handles)
% hObject    handle to wave_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wave_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wave_type


% --- Executes during object creation, after setting all properties.
function wave_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wave_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in wave_number.
function wave_number_Callback(hObject, eventdata, handles)
% hObject    handle to wave_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wave_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wave_number


% --- Executes during object creation, after setting all properties.
function wave_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wave_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fivemin.
function fivemin_Callback(hObject, eventdata, handles)
% hObject    handle to fivemin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fivemin
