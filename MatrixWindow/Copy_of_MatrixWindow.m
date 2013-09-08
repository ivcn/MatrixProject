function varargout = MatrixWindow(varargin)
% MATRIXWINDOW M-file for MatrixWindow.fig
%      MATRIXWINDOW, by itself, creates a new MATRIXWINDOW or raises the existing
%      singleton*.
%
%      H = MATRIXWINDOW returns the handle to a new MATRIXWINDOW or the handle to
%      the existing singleton*.
%
%      MATRIXWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATRIXWINDOW.M with the given input arguments.
%
%      MATRIXWINDOW('Property','Value',...) creates a new MATRIXWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MatrixWindow_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MatrixWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help MatrixWindow

% Last Modified by GUIDE v2.5 04-Oct-2012 17:25:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MatrixWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @MatrixWindow_OutputFcn, ...
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



% --- Executes just before MatrixWindow is made visible.
function MatrixWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MatrixWindow (see VARARGIN)

% Choose default command line output for MatrixWindow



handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes MatrixWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = MatrixWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


c = floor(get(hObject, 'Value'));
set(handles.text1, 'String', int2str(c));



day = floor(c/144);
ost = mod(c,144);
hour = floor(ost*24/144);

curdate = datevec(addtodate(datenum(handles.date),day,'day'));
curdate(4)=hour;

set(handles.MyDate, 'String', datestr(curdate, 0));

h = handles.axes1;
axes(h);

DrawMatrix();

en3d = get(handles.en3d, 'Value');
%figure
if (en3d == 0)
    image(wd);
else
    surf(wd);
    axis([0 size(wd,1) 0 size(wd,1) 0 60 0 60]);
end
set(gca,'YDir','normal');
colorbar


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic

% 
maxa = eval(get(handles.maxa, 'String')) ;
mina = eval(get(handles.mina, 'String')) ;
maxb = eval(get(handles.maxb, 'String')) ;
% 
st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу
% 
nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)


wave_type = get(handles.wave_type, 'String');
wave_type = cell2mat(wave_type(get(handles.wave_type, 'Value')));

if wave_type(1) ~= 'haar'
    val = get(handles.wave_number, 'String');
    wave_number = eval(cell2mat(val(get(handles.wave_number, 'Value'))));
    wave_number = wave_number(1);
    wave_type = [wave_type int2str(wave_number)]
end    

alpha = eval(get(handles.alpha, 'String'));
level = eval(get(handles.level, 'String'));
threshold = get(handles.threshold, 'Value');

if threshold == 1
    SORH = 's';
else
    SORH = 'h';
end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
sm = [0 0 0 0];
% 
    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  
% 
    numsm = sum(sm)
% 
%     
%     
     xo = get(handles.maxb, 'String'); % 
% 
%ffsum = zeros(5,size(handles.wrow,2));

% handles.wavedata = [];
% handles.matrix_without_trend = [];
handles.mat_en = cell(1,5);
handles.mat_wt = cell(1,5);
 for cursm = 1:4
     cursm
     if sm(cursm)~=0    
         %ff = handles.wrow((ty-1)*nx+tx,:, cursm);
         %ff = handles.wrow((ty-1)*nx+tx,:, cursm);
         % 
         wrowrez = [];
         wrow_without_trend = [];
         for j = 1:1:nx*ny
             if (mod(j,25)==0)
                 ['sm ' int2str(cursm) ' row# ' int2str(j)]
             end    
 
    %
            ff = cell2mat(handles.wrow(cursm));%(j,:,cursm);
            ff = ff(j,:);
            %ffsum(cursm,:) = ff;
            
            ff=UdalVibr(ff, 10);
    
  
            %figure
            %plot(ff);
            flagfish = get(handles.fisher, 'Value');
            flagwindow = get(handles.window, 'Value');
            if (flagwindow == 0)    % ne okonniy
                flagssa = get(handles.ssa, 'Value');
                if (flagssa == 0)   % Chebishev      
                    if not(flagfish==0) % fisher  
                        [F,B,l] = Approx(ff,0); 
                        set(handles.maxpow, 'String', l);             
                    else                % fix max step   
                        l=eval(get(handles.maxpow, 'String')); 
                        [F,B] = Approx(ff,l) ;                     
                    end
                    flagvibr = get(handles.vibr, 'Value');
                    if (flagvibr ~= 0)    % Udalyat vibrosi
                        predel = eval(get(handles.predel, 'String'));
                        B=UdalVibr(B, predel);
                        %figure
                        %plot(B);
                    end   

                    sig = std(B);
                    flagsigma = get(handles.sigma, 'Value');
                    if (flagsigma ~= 0)
                        B=B./sig;
                    end
                    % Veivlet-Filter
                    [c,l] = wavedec(B, level, wave_type);
                    sigma = wnoisest(c,l,1);
                    THR = wbmpen(c,l, sigma, alpha);

                    B = wdencmp('gbl',c,l, wave_type, level, THR, SORH, 1);
                    
                    % Energiya
                    E = AnalyzW(B,mina, maxa,maxb,0,1) ;        
                else        % SSA
                    [F,B] = Approx(ff,-1);
                    flagvibr = get(handles.vibr, 'Value');
                    if (flagvibr ~= 0)    % Udalyat vibrosi
                        predel = eval(get(handles.predel, 'String'));
                        B=UdalVibr(B, predel);
                        %figure
                        %plot(B);
                    end
                    sig = std(B);
                    flagsigma = get(handles.sigma, 'Value');
                    if (flagsigma ~= 0)
                        B=B./sig;
                    end
                    [c,l] = wavedec(B, level, wave_type);
                    sigma = wnoisest(c,l,1);
                    THR = wbmpen(c,l, sigma, alpha);

                    B = wdencmp('gbl',c,l, wave_type, level, THR, SORH, 1);
                    
                    % Energiya
                    E = AnalyzW(B,mina, maxa,maxb,0,1) ;
                end
            else               % Okonniy                        
                flagssa = get(handles.ssa, 'Value');
                flagsigma = get(handles.sigma, 'Value');
                if (flagssa == 0)   % Chebishev
                    flagfish = get(handles.fisher, 'Value');
                    if (flagfish == 0) % fisher
                        
                        E = AnalyzWD(ff, xo, 0, flagsigma); 
                        B=E;
                    else            % fix max stepen
                        l = eval(get(handles.maxpow, 'String'));
                        E = AnalyzWD(ff, xo, l,flagsigma);
                        B=E;
                    end
                else    % SSA
                    E = AnalyzWD(ff, xo, -1,flagsigma);
                    B=E;
                end
            end


            E(E~=E)=0; 
            B(B~=B)=0; 

            %
            %[F,B,l] = Approx(wrow(j,:),51) ; 
            %E = AnalyzW(B,maxa,maxb) ;
            wrowrez = [wrowrez; E]; 
            wrow_without_trend = [wrow_without_trend; B]; 
         end
       
        l1 = size(wrowrez,2);
%         wdata = zeros(ny,nx,l1);
%         wdata_wt = zeros(ny,nx,l1);
        wdata = [];
        wdata_wt = [];
        for i = 1:l1
            A=zeros(nx,ny);
            A_wt =zeros(nx,ny); 
            for j = 1:nx*ny
                 A(j)=wrowrez(j,i);
                 A_wt(j)=wrow_without_trend(j,i);
            end
           % A
            A=flipud(A);
            A_wt=flipud(A_wt);
             A=rot90(A,-1);
            A_wt=rot90(A_wt,-1);
            
            wdata(:,:,i)=A;
            wdata_wt(:,:,i)=A_wt;
        end
         
%         handles.wavedata(:,:,:,cursm) = wdata;
%         guidata(hObject, handles);
%         handles.maxm(cursm) = max(max(max(handles.wavedata(:,:,:,cursm))));
%         guidata(hObject, handles);
%         
%         handles.matrix_without_trend(:,:,:,cursm) = wdata_wt;
%         guidata(hObject, handles);
%         handles.maxm_wt(cursm) = max(max(max(handles.matrix_without_trend(:,:,:,cursm))));
%         guidata(hObject, handles);

        handles.mat_en(cursm) = mat2cell(wdata);
        guidata(hObject, handles);
        handles.maxm(cursm) = max(max(max(wdata)));
        guidata(hObject, handles);

        handles.mat_wt(cursm) = mat2cell(wdata_wt);
        guidata(hObject, handles);
        handles.maxm_wt(cursm) = max(max(max(wdata_wt)));
        guidata(hObject, handles);
     end
 end

 % Obrabotka summi  

    'summa'
    if (numsm~=1)
        wrowrez = [];
        wrow_without_trend = [];
             for j = 1:1:nx*ny
                 if (mod(j,25)==0)
                     ['summa'  ' row# ' int2str(j)]
                 end    


                ff = sum(handles.wrow(j,:,:),3);
               % ffsum(5,:) = ff;

                ff=UdalVibr(ff, 10);
    
  
            %figure
            %plot(ff);
            flagfish = get(handles.fisher, 'Value');
            flagwindow = get(handles.window, 'Value');
            if (flagwindow == 0)    % ne okonniy
                flagssa = get(handles.ssa, 'Value');
                if (flagssa == 0)   % Chebishev      
                    if not(flagfish==0) % fisher  
                        [F,B,l] = Approx(ff,0); 
                        set(handles.maxpow, 'String', l);             
                    else                % fix max step   
                        l=eval(get(handles.maxpow, 'String')); 
                        [F,B] = Approx(ff,l) ;                     
                    end
                    flagvibr = get(handles.vibr, 'Value');
                    if (flagvibr ~= 0)    % Udalyat vibrosi
                        predel = eval(get(handles.predel, 'String'));
                        B=UdalVibr(B, predel);
                        %figure
                        %plot(B);
                    end   

                    sig = std(B);
                    flagsigma = get(handles.sigma, 'Value');
                    if (flagsigma ~= 0)
                        B=B./sig;
                    end
                    E = AnalyzW(B,mina, maxa,maxb,0,1) ;        
                else        % SSA
                end
            else               % Okonniy                        
                flagssa = get(handles.ssa, 'Value');
                flagsigma = get(handles.sigma, 'Value');
                if (flagssa == 0)   % Chebishev
                    flagfish = get(handles.fisher, 'Value');
                    if (flagfish == 0) % fisher
                        
                        E = AnalyzWD(ff, xo, 0, flagsigma); 
                        B=E;
                    else            % fix max stepen
                        l = eval(get(handles.maxpow, 'String'));
                        E = AnalyzWD(ff, xo, l,flagsigma);
                        B=E;
                    end
                else    % SSA
                    E = AnalyzWD(ff, xo, -1,flagsigma);
                    B=E;
                end
            end


            E(E~=E)=0; 
            B(B~=B)=0; 

            %
            %[F,B,l] = Approx(wrow(j,:),51) ; 
            %E = AnalyzW(B,maxa,maxb) ;
            wrowrez = [wrowrez; E]; 
            wrow_without_trend = [wrow_without_trend; B];


%                 E(E~=E)=0; 
%                 B(B~=B)=0; 
%                 
%                 E=rot90(E,-1);
%                 B=rot90(B,-1);
%                 %
%                 %[F,B,l] = Approx(wrow(j,:),51) ; 
%                 %E = AnalyzW(B,maxa,maxb) ;
%                 wrowrez = [wrowrez; E]; 
%                 wrow_without_trend = [wrow_without_trend; B]; 
             end
            
            l1 = size(wrowrez,2);
           %         wdata = zeros(ny,nx,l1);
%         wdata_wt = zeros(ny,nx,l1);
        wdata = [];
        wdata_wt = [];
            for i = 1:l1
                A=zeros(nx,ny);
                A_wt =zeros(nx,ny); 
                for j = 1:nx*ny
                     A(j)=wrowrez(j,i);
                     A_wt(j)=wrow_without_trend(j,i);
                end
               % A
                A=rot90(A,-1);
                 A_wt=rot90(A_wt,-1);
               
                wdata(:,:,i)=A;
                wdata_wt(:,:,i)=A_wt;
            end
    end 
%         handles.wavedata(:,:,:,5) = wdata;
%         handles.maxm(5) = max(max(max(handles.wavedata(:,:,:,5))));
%        
%         
%         handles.matrix_without_trend(:,:,:,5) = wdata_wt;    
%         handles.maxm_wt(5) = max(max(max(handles.matrix_without_trend(:,:,:,5))));
%        
%         handles.minm_wt = min(min(min(handles.matrix_without_trend(:,:,:,5))));
%         guidata(hObject, handles);
           
    handles.mat_en(5) = mat2cell(wdata);
    handles.maxm(5) = max(max(max(wdata)));
    guidata(hObject, handles);

    handles.mat_wt(5) = mat2cell(wdata_wt);
    handles.maxm_wt(5) = max(max(max(wdata_wt)));
    handles.minm_wt = min(min(min(wdata_wt)));
    guidata(hObject, handles);    


    
% handles.wavedata = wdata;
% guidata(hObject, handles);
% handles.maxm = max(max(max(max(handles.wavedata))))
% guidata(hObject, handles);

toc


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maxa = eval(get(handles.maxa, 'String')) ;
mina = eval(get(handles.mina, 'String')) ;
maxb = eval(get(handles.maxb, 'String')) ;

st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

l=eval(get(handles.maxpow, 'String')); 

%
sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    predel =get(handles.predel, 'String');

    date_s0 = get(handles.startdate, 'String');
    date_s = datestr(datenum(date_s0, 'dd/mm/yyyy'), 'dd mm yyyy');
    dni = get(handles.dni, 'String');

 
wave_type = get(handles.wave_type, 'String');
wave_type = cell2mat(wave_type(get(handles.wave_type, 'Value')));

if wave_type(1) ~= 'haar'
    val = get(handles.wave_number, 'String');
    wave_number = eval(cell2mat(val(get(handles.wave_number, 'Value'))));
    wave_number = wave_number(1);
    wave_type = [wave_type int2str(wave_number)]
end    

alpha = eval(get(handles.alpha, 'String'));
level = eval(get(handles.level, 'String'));
threshold = get(handles.threshold, 'Value');

if threshold == 1
    SORH = 's';
else
    SORH = 'h';
end    
    

flagssa = get(handles.ssa, 'Value');
ssaname = 'ssa';
if (flagssa == 0)
    ssaname = 'cheb';
end

windowname = 'wd ';
flagwindow = get(handles.window, 'Value');
if (flagwindow == 0)   
    windowname='';
end

flagsigma = get(handles.sigma, 'Value');

  smstr = [int2str(sm(1)) int2str(sm(2)) int2str(sm(3)) int2str(sm(4))];
figname = ['ANALYZED DATA' ' sm' smstr ' ' date_s ' d' dni ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob) ' sigma' int2str(flagsigma)];
figname = [figname ' pr' predel ' ' windowname ssaname  int2str(l) ' a' int2str(mina) '-' int2str(maxa) ' b' int2str(maxb) ' wt ' wave_type ' A' int2str(alpha) ' lev' int2str(level) ' thr' int2str(threshold) '.mat'];  


[filename, pathname] = uiputfile({'*.mat'}, 'Save as',figname);
dat = handles.date;

wrow = handles.wrow;

nullintervals = handles.nullintervals;
masks = handles.masks;

mat_intens = handles.mat_intens;   %Matrici intensivnostei
maxm_intens = handles.maxm_intens; 
    %max matr intens

mat_wt =  handles.mat_wt; %Matrici bez trenda
maxm_wt = handles.maxm_wt;  
minm_wt = handles.minm_wt;

mat_en = handles.mat_en; %matrici energii
maxm_en=handles.maxm;



save([pathname filename], 'mat_en','mat_wt','maxm_wt', 'minm_wt','maxm_intens', 'mat_intens', 'wrow','dat','sm', 'dni', 'date_s0','maxm_en', 'maxa', 'mina', 'maxb', 'st', 'sf', 'ol', 'or', 'ot', 'ob', 'l', 'nullintervals', 'wave_type', 'alpha', 'level', 'threshold', 'flagsigma','masks', '-mat');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat'});
load([pathname filename], 'mat_en');
handles.mat_en = mat_en;

load([pathname filename], 'mat_intens');
handles.mat_intens = mat_intens;
load([pathname filename], 'maxm_intens');
handles.maxm_intens = maxm_intens;

load([pathname filename], 'mat_wt');
handles.mat_wt = mat_wt;
load([pathname filename], 'maxm_wt');
handles.maxm_wt = maxm_wt;
load([pathname filename], 'minm_wt');
handles.minm_wt = sum(minm_wt);


load([pathname filename], 'date_s0');
set(handles.startdate, 'String', date_s0);
load([pathname filename], 'dni');
set(handles.dni, 'String', dni);
load([pathname filename], 'dat');
handles.date = dat;
load([pathname filename], 'maxm_en');
handles.maxm = maxm_en;
load([pathname filename], 'mina');
set(handles.mina, 'String', num2str(mina));
load([pathname filename], 'maxa');
set(handles.maxa, 'String', num2str(maxa));
load([pathname filename], 'maxb');
set(handles.maxb, 'String', num2str(maxb));
load([pathname filename], 'st');
set(handles.ukrupt, 'String', num2str(st));
load([pathname filename], 'sf');
set(handles.ukrupf, 'String', num2str(sf));
load([pathname filename], 'ol');
set(handles.obrl, 'String', num2str(ol));
load([pathname filename], 'or');
set(handles.obrr, 'String', num2str(or));
load([pathname filename], 'ot');
set(handles.obrt, 'String', num2str(ot));
load([pathname filename], 'ob');
set(handles.obrb, 'String', num2str(ob));

load([pathname filename], 'flagsigma');
set(handles.sigma, 'Value', flagsigma);

load([pathname filename], 'l');
set(handles.maxpow, 'String', num2str(l));

load([pathname filename], 'alpha');
set(handles.alpha, 'String', num2str(alpha));
load([pathname filename], 'threshold');
set(handles.threshold, 'Value', threshold);
load([pathname filename], 'level');
set(handles.level, 'String', num2str(level));

load([pathname filename], 'wave_type');
wave_type(1:2)
if strcmp(wave_type,'haar')
    set(handles.wave_type, 'Value', 1);
elseif strcmp(wave_type(1:2),'db')
    set(handles.wave_type, 'Value', 2);
    set(handles.wave_number, 'Value', eval(wave_type(3:size(wave_type,2)))); 
elseif strcmp(wave_type(1:3),'sym') 
    set(handles.wave_type, 'Value', 3); 
    set(handles.wave_number, 'Value', eval(wave_type(4:size(wave_type,2)))); 
elseif strcmp(wave_type(1:4),'coif') 
    set(handles.wave_type, 'Value', 4);
    set(handles.wave_number, 'Value', eval(wave_type(5:size(wave_type,2)))); 
end    
    

load([pathname filename], 'sm');

set(handles.sm1, 'Value', 0);
set(handles.sm2, 'Value', 0);
set(handles.sm3, 'Value', 0);
set(handles.sm4, 'Value', 0);

 if (sm(1)==1)
     set(handles.sm1, 'Value', 1);
 end    
 if (sm(2)==1)
     set(handles.sm2, 'Value', 1);
 end   
 if (sm(3)==1)
     set(handles.sm3, 'Value', 1);
 end   
 if (sm(4)==1)
     set(handles.sm4, 'Value', 1);
 end   

 load([pathname filename], 'wrow');
 handles.wrow = wrow;
 
 load([pathname filename], 'nullintervals');
 handles.nullintervals = nullintervals;
 
 load([pathname filename], 'masks');
 handles.masks = masks;
 
guidata(hObject, handles);
set(handles.slider1, 'Max', size(cell2mat(handles.mat_en(5)),3));

handles.cur_matrix = cell2mat(handles.mat_intens(5));
handles.cur_maxm = handles.maxm_intens(5);
guidata(hObject, handles); 




% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function dni_Callback(hObject, eventdata, handles)
% hObject    handle to dni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dni as text
%        str2double(get(hObject,'String')) returns contents of dni as a double


% --- Executes during object creation, after setting all properties.
function dni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dni (see GCBO)
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
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.wrow = [];
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start(handles.tmr);
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.tmr);
guidata(hObject, handles);




function ogr_Callback(hObject, eventdata, handles)
% hObject    handle to ogr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ogr as text
%        str2double(get(hObject,'String')) returns contents of ogr as a double


% --- Executes during object creation, after setting all properties.
function ogr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ogr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ukrupt_Callback(hObject, eventdata, handles)
% hObject    handle to ukrupt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ukrupt as text
%        str2double(get(hObject,'String')) returns contents of ukrupt as a double


% --- Executes during object creation, after setting all properties.
function ukrupt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ukrupt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

c = floor(get(handles.slider1, 'Value'))+6;
set(handles.slider1, 'Value', c);
set(handles.text1, 'String', int2str(c));

day = floor(c/144);
ost = mod(c,144);
hour = floor(ost*24/144);

curdate = datevec(addtodate(datenum(handles.date),day,'day'));
curdate(4)=hour;

set(handles.MyDate, 'String', datestr(curdate, 0));


h = handles.axes1;
axes(h);

DrawMatrix();

en3d = get(handles.en3d, 'Value');
if (en3d == 0)
    image(wd);
else
    surf(wd);
    axis([0 size(wd,1) 0 size(wd,1) 0 60 0 60]);
end
set(gca,'YDir','normal');
colorbar



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = floor(get(handles.slider1, 'Value'))-6;
set(handles.slider1, 'Value', c);
set(handles.text1, 'String', int2str(c));

day = floor(c/144);
ost = mod(c,144);
hour = floor(ost*24/144);

curdate = datevec(addtodate(datenum(handles.date),day,'day'));
curdate(4)=hour;

set(handles.MyDate, 'String', datestr(curdate, 0));


h = handles.axes1;
axes(h);

DrawMatrix();

en3d = get(handles.en3d, 'Value');
if (en3d == 0)
    image(wd);
else
    surf(wd);
    axis([0 size(wd,1) 0 size(wd,1) 0 60 0 60]);
end
set(gca,'YDir','normal');
colorbar


% --- Executes on button press in en3d.
function en3d_Callback(hObject, eventdata, handles)
% hObject    handle to en3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of en3d


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on;
rotate3d off;


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom off;
rotate3d on;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
n = floor(91/s); % сколько ячеек берем(выделяется центр часть матрицы)
date_s = get(handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2)
handles.date = datevec(date_s);
dni = eval(get(handles.dni, 'String'))
guidata(hObject, handles);
wrow = handles.wrow;

[filename, pathname] = uiputfile( {'*.mat'}, 'Save as');
save(filename, 'wrow');



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Name', '0-90');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(1:n,:,:)));
V=V(:);
plot(V);



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Name', '90-180');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(n:2*n,:,:)));
V=V(:);
plot(V);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Name', '180-270');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(2*n:3*n,:,:)));
V=V(:);
plot(V);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Name', '270-360');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(3*n:4*n,:,:)));
V=V(:);
plot(V);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datestart=handles.date;
interval = size(handles.wavedata,3);


day = floor(interval/144);
ost = mod(interval,144);
hour = floor(ost*24/144);

enddate = datevec(addtodate(datenum(handles.date),day,'day'));
enddate(4)=hour;
datestart = datenum(datestr(datestart))
enddate = datenum(datestr(enddate))
xData = linspace(datestart,enddate,interval);


figure('Name', '0-90');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(1:n,:,:)));
V=V(:);
subplot(4,1,1);
plot(xData,V);set(gca,'FontName','Arial Cyr');title('0-90');set(gca,'XTick',xData(1:144:interval));
grid on
datetick('x','mmm-dd-HH','keeplimits','keepticks');
V=sum(sum(handles.wavedata(n:2*n,:,:)));
V=V(:);
subplot(4,1,2);
plot(xData,V);set(gca,'FontName','Arial Cyr');title('90-180');set(gca,'XTick',xData(1:144:interval));
grid on
datetick('x','mmm-dd-HH','keeplimits','keepticks');
V=sum(sum(handles.wavedata(2*n:3*n,:,:)));
V=V(:);
subplot(4,1,3);
plot(xData,V);set(gca,'FontName','Arial Cyr');title('180-270');set(gca,'XTick',xData(1:144:interval));
grid on
datetick('x','mmm-dd-HH','keeplimits','keepticks');
V=sum(sum(handles.wavedata(3*n:4*n,:,:)));
V=V(:);
subplot(4,1,4);
plot(xData,V);set(gca,'FontName','Arial Cyr');title('270-360');set(gca,'XTick',xData(1:144:interval));
grid on
datetick('x','mmm-dd-HH','keeplimits','keepticks');

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datestart=handles.date;
interval = size(handles.wavedata,3)


day = floor(interval/144);
ost = mod(interval,144);
hour = floor(ost*24/144);

enddate = datevec(addtodate(datenum(handles.date),day,'day'))
enddate(4)=hour;

datestart = datestr(datestart)
enddate = datestr(enddate)

xData = linspace(datenum(datestart),datenum(enddate),interval);

figure('Name', '0-360');
n=floor(size(handles.wavedata,1)/4);
V=sum(sum(handles.wavedata(:,:,:)));
V=V(:);

plot(xData,V);set(gca,'FontName','Arial Cyr');title('0-360');set(gca,'XTick',xData(1:144:interval));
grid on
datetick('x','mmm-dd-HH','keeplimits','keepticks');



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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imsave(handles.axes1);


% --- Executes on button press in window.
function window_Callback(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of window



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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fisher.
function fisher_Callback(hObject, eventdata, handles)
% hObject    handle to fisher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fisher



function obrezka_Callback(hObject, eventdata, handles)
% hObject    handle to obrezka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obrezka as text
%        str2double(get(hObject,'String')) returns contents of obrezka as a double


% --- Executes during object creation, after setting all properties.
function obrezka_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obrezka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    

st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

date_s = get(handles.startdate, 'String');
date_s = datevec(date_s, 'dd/mm/yyyy');

sm = [0 0 0 0];

if get(handles.sm1, 'Value')~=0
    sm(1) = 1;
end    
if get(handles.sm2, 'Value')~=0
    sm(2) = 1;
end  
if get(handles.sm3, 'Value')~=0
    sm(3) = 1;
end  
if get(handles.sm4, 'Value')~=0
    sm(4) = 1;
end  

numsm = sum(sm);

if numsm > 1
    dw = 1;
else    
    dw = get(handles.difwindow, 'Value');
end

if dw~=0
    figure
end  

for i = 1:4
    if numsm > 1
        subplot(2,2,i);
    end
    
    if sm(i)~=0       
        year = num2str(date_s(1),'%05.2d');
        filename = [num2str(date_s(3),'%05.2d') '_' num2str(date_s(2),'%05.2d') '_' year(3:4) '_00_00'];
        path = ['D:\Veivlet tufanov\ExtractMatrix' '\' 'urgmatr\sm' int2str(i) '\' filename '.bin']       
        fid=fopen(path,'rb');

        count = [91 91];
        A = fread(fid, count,'ulong');

        if get(handles.polosi, 'Value')~=0      % Убираем полосы
            A(23,:)=(A(22,:)+A(24,:))/2;
            A(46,:)=(A(45,:)+A(47,:))/2;
            A(68,:)=(A(67,:)+A(69,:))/2;
            A(91,:)=(A(90,:)+A(1,:))/2;
        end

        B = A(or+1:91-ol,ot+1:91-ob); 
        B=Ukrupmatr(B,st,sf);

        B=rot90(B,-1);
        B=flipud(B);
        
        
        titlename = ['sm ' int2str(i)];
        imagesc(B);
        set(gca,'YDir','normal');
        title(['sm ' int2str(i)]);
    end
end
fclose(fid);



function obrl_Callback(hObject, eventdata, handles)
% hObject    handle to obrr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obrr as text
%        str2double(get(hObject,'String')) returns contents of obrr as a double


% --- Executes during object creation, after setting all properties.
function obrl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obrr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obrr_Callback(hObject, eventdata, handles)
% hObject    handle to obrl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obrl as text
%        str2double(get(hObject,'String')) returns contents of obrl as a double


% --- Executes during object creation, after setting all properties.
function obrr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obrl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obrt_Callback(hObject, eventdata, handles)
% hObject    handle to obrr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obrr as text
%        str2double(get(hObject,'String')) returns contents of obrr as a double


% --- Executes during object creation, after setting all properties.
function obrt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obrr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obrb_Callback(hObject, eventdata, handles)
% hObject    handle to obrl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obrl as text
%        str2double(get(hObject,'String')) returns contents of obrl as a double


% --- Executes during object creation, after setting all properties.
function obrb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obrl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_Callback(hObject, eventdata, handles)
% hObject    handle to tx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx as text
%        str2double(get(hObject,'String')) returns contents of tx as a double


% --- Executes during object creation, after setting all properties.
function tx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ty_Callback(hObject, eventdata, handles)
% hObject    handle to ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ty as text
%        str2double(get(hObject,'String')) returns contents of ty as a double


% --- Executes during object creation, after setting all properties.
function ty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% '2'
% kkk = handles.wrow(:,:,4)
    st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
    or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
    ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
    ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

    nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
    ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

    tx = eval(get(handles.tx, 'String'));  % - trend x
    ty = eval(get(handles.ty, 'String'));  % - trend y
  
%     if size(handles.wrow,2)==0  
%         date_s = get(handles.startdate, 'String');
%         date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
%         handles.date = datevec(date_s);
%         dni = eval(get(handles.dni, 'String'));
%         guidata(hObject, handles);
%        
% 
%         [l,wrow]=ExtractRows(handles.date, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,s, ol, or, ot, ob);
%         handles.wrow = wrow;
%         guidata(hObject, handles);
%     end
    sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    numsm = sum(sm);

    if numsm > 1
        dw = 1;
    else    
        dw = get(handles.difwindow, 'Value');
    end
    
    if dw~=0
        figure('Name', 'Интенсивность потока мюонов');
    end    

    ffsum = zeros(5,size(cell2mat(handles.wrow),2));
%      'ffsum'
%     size(ffsum)
    handles.B = [];
    for cursm = 1:4
        if numsm > 1
            subplot(3,2,cursm);
        end    
        if sm(cursm)~=0  
            ff = cell2mat(handles.wrow(cursm));
            ff = ff((ty-1)*nx+tx,:); %, cursm
            n=size(ff,2);
%              'ff'
%              size(ff)
            handles.sig(cursm) = std(ff);
            guidata(hObject, handles);

            flagvibr = get(handles.vibr, 'Value');
            if (flagvibr ~= 0)    % Udalyat vibrosi
                predel = eval(get(handles.predel, 'String'));
                ff=UdalVibr(ff, predel);
            end

            flagfish = get(handles.fisher, 'Value');
            flagwindow = get(handles.window, 'Value');
            flagssa = get(handles.ssa, 'Value');
            
            
            if (flagwindow == 0)    % ne okonniy
                if (flagssa ~= 0) %SSA
                    [F,B] = Approx(ff,-1) ; 
                    handles.B(cursm,:) = B;
                    guidata(hObject, handles);
                else %Chebishev            
                    if not(flagfish==0) % fisher  
                        [F,B,l] = Approx(ff,0); 
                        set(handles.maxpow, 'String', l);   
                        handles.B(cursm,:) = B;
                        guidata(hObject, handles);
                    else                % fix max step   
                        l=eval(get(handles.maxpow, 'String')); 
                        [F,B] = Approx(ff,l) ;     
                        handles.B(cursm,:) = B;
                        guidata(hObject, handles);
                    end
                end
            end       
        ffsum(cursm,:) = ff;
        guidata(hObject, handles);
        
        if numsm > 1
            hold on;
            nullintervals=cell2mat(handles.nullintervals(cursm));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);
                MX=[xl xr  xr xl];
                MY=[max(ff) max(ff) min(ff) min(ff)];
                p=patch(MX,MY,[1 0 0]); 
                set(p, 'EdgeColor', 'none');
            end
            
            nullintervals=cell2mat(handles.masks(cursm));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);
                MX=[xl xr  xr xl];
                MY=[max(ff) max(ff) min(ff) min(ff)];
                p=patch(MX,MY,[0 0 1]); 
                set(p, 'EdgeColor', 'none');
            end

            flagssa = get(handles.ssa, 'Value');


            if (flagwindow~=0)
                plot(1:n, ff, 'k');
            else
                plot(1:n, ff, 'k', 1:n, F, 'b');
                hPlot = plot(1:n, F, 'b');
                set( hPlot, 'LineWidth', 2 );
            end

            set(gca, 'FontSize', 14);
    
            hold off;
            title(['sm ' int2str(cursm)]);
        end  
        end
    end
    % Obrabotka summi
    if numsm > 1
        subplot(3,2,5:6);
    end    
    
    ff = sum(ffsum);
    n=size(ff,2);
    handles.sig(5) = std(ff);
    guidata(hObject, handles);

    flagvibr = get(handles.vibr, 'Value');
    if (flagvibr ~= 0)    % Udalyat vibrosi
       predel = eval(get(handles.predel, 'String'));
       ff=UdalVibr(ff, predel);
    end

%     flagfish = get(handles.fisher, 'Value');
%     flagwindow = get(handles.window, 'Value');
%     if (flagwindow == 0)    % ne okonniy  
%         if not(flagfish==0) % fisher  
%             [F,B,l] = Approx(ff,0); 
%             set(handles.maxpow, 'String', l);   
%             handles.B(5,:) = B;
%             guidata(hObject, handles);
%         else                % fix max step   
%             l=eval(get(handles.maxpow, 'String')); 
%             [F,B] = Approx(ff,l) ;     
%             handles.B(5,:) = B;
%             guidata(hObject, handles);
%         end
%     end  
    if (flagwindow == 0)    % ne okonniy
        if (flagssa ~= 0) %SSA
            [F,B] = Approx(ff,-1) ; 
            handles.B(5,:) = B;
            guidata(hObject, handles);
        else %Chebishev            
            if not(flagfish==0) % fisher  
                [F,B,l] = Approx(ff,0); 
                set(handles.maxpow, 'String', l);   
                handles.B(5,:) = B;
                guidata(hObject, handles);
            else                % fix max step   
                l=eval(get(handles.maxpow, 'String')); 
                [F,B] = Approx(ff,l) ;     
                handles.B(5,:) = B;
                guidata(hObject, handles);
            end
        end
    end
    
    if numsm == 1
        cla reset
    end    
    hold on;
    for i=1:4    
        if sm(i)~=0
            nullintervals=cell2mat(handles.nullintervals(i));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);
                MX=[xl xr  xr xl];
                MY=[max(ff) max(ff) min(ff) min(ff)];
                p=patch(MX,MY,[1 0 0]); 
                set(p, 'EdgeColor', 'none');
            end
            
            nullintervals=cell2mat(handles.masks(cursm));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);
                MX=[xl xr  xr xl];
                MY=[max(ff) max(ff) min(ff) min(ff)];
                p=patch(MX,MY,[0 0 1]); 
                set(p, 'EdgeColor', 'none');
            end
        end
    end
        
    ffsum(5,:) = ff;
    handles.ff = ffsum;
    guidata(hObject, handles);
    flagssa = get(handles.ssa, 'Value');
        
        if (flagwindow~=0)
            plot(1:n, ff, 'k');
        else
            plot(1:n, ff, 'k', 1:n, F, 'b');
            hPlot = plot(1:n, F, 'b');
            set( hPlot, 'LineWidth', 2 );
        end
        
    set(gca, 'FontSize', 14);
    
    if numsm > 1    
        title('summa');
    else
        title('Интенсивность потока мюонов');
    end    
    
    xlabel( 'Время' ); ylabel( 'Число мюонов' ); 
    hold off;
   
  
    






% --- Executes during object creation, after setting all properties.
function pushbutton19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if size(handles.wrow, 2)~=0
    set(hObject, 'String', '!!!!');
    guidata(hObject, handles);
end    



% --- Executes on button press in difwindow.
function difwindow_Callback(hObject, eventdata, handles)
% hObject    handle to difwindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of difwindow


% --- Executes on button press in sm1.
function sm1_Callback(hObject, eventdata, handles)
% hObject    handle to sm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sm1


% --- Executes on button press in sm2.
function sm2_Callback(hObject, eventdata, handles)
% hObject    handle to sm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sm2


% --- Executes on button press in sm3.
function sm3_Callback(hObject, eventdata, handles)
% hObject    handle to sm3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sm3


% --- Executes on button press in sm4.
function sm4_Callback(hObject, eventdata, handles)
% hObject    handle to sm4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sm4


% --- Executes on button press in polosi.
function polosi_Callback(hObject, eventdata, handles)
% hObject    handle to polosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of polosi


% --- Executes on button press in vibr.
function vibr_Callback(hObject, eventdata, handles)
% hObject    handle to vibr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vibr



function predel_Callback(hObject, eventdata, handles)
% hObject    handle to predel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of predel as text
%        str2double(get(hObject,'String')) returns contents of predel as a double


% --- Executes during object creation, after setting all properties.
function predel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to predel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    flagsigma = get(handles.sigma, 'Value');

    sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    numsm = sum(sm);

%     h = handles.axes1;
%         axes(h);
        
    if numsm > 1
        dw = 1;
    else    
        dw = get(handles.difwindow, 'Value');
    end
    
    if dw~=0
        figure
    end    

    for cursm = 1:4
        if numsm > 1
            subplot(3,2,cursm);
        end    
        if sm(cursm)~=0  
            ff = handles.B(cursm,:);
            n=size(ff,2);

            sig = std(ff);

            flagvibr = get(handles.vibr, 'Value');
            if (flagvibr ~= 0)    % Udalyat vibrosi
                predel = eval(get(handles.predel, 'String'));
                ff=UdalVibr(ff, predel);
            end   
   
% D = var(ff);
% Me=sum((ff/D).^2);
% l=eval(get(handles.maxpow, 'String')); 
% chi = Me/(n-l-1);
% msgbox(['l = ' num2str(l) 'Chi^2 = ' num2str(chi) 'mean = ' num2str(mean(ff)) ' std = ' num2str(std(ff))], ['l = ' num2str(l) 'Chi^2 = ' num2str(chi)],'replace');

            if (flagsigma ~= 0)
                ff=ff./sig;
            end

            handles.ff(cursm,:) = ff;
            guidata(hObject, handles);
            
            if numsm > 1
                hold on;
                nullintervals=cell2mat(handles.nullintervals(cursm));
                for kk=1:size(nullintervals,1)
                    xl = nullintervals(kk,1);
                    xr = nullintervals(kk,2);
                    MX=[xl xr  xr xl];
                    MY=[max(ff) max(ff) min(ff) min(ff)];
                    p=patch(MX,MY,[1 0 0]); 
                    set(p, 'EdgeColor', 'none');
                end
                
                nullintervals=cell2mat(handles.masks(cursm));
                for kk=1:size(nullintervals,1)
                    xl = nullintervals(kk,1);
                    xr = nullintervals(kk,2);
                    MX=[xl xr  xr xl];
                    MY=[max(ff) max(ff) min(ff) min(ff)];
                    p=patch(MX,MY,[0 0 1]); 
                    set(p, 'EdgeColor', 'none');
                end

                plot(1:n, ff, 'k');
                
                 set(gca, 'FontSize', 14);
                title(['sm ' int2str(cursm)]);
                 hold off;
            end    
        end
    end
    
    %Obrabotka summi
        if numsm > 1
            subplot(3,2,5:6);
        end    
            ff = handles.B(5,:);
            n=size(ff,2);

            sig = std(ff);

            flagvibr = get(handles.vibr, 'Value');
            if (flagvibr ~= 0)    % Udalyat vibrosi
                predel = eval(get(handles.predel, 'String'));
                ff=UdalVibr(ff, predel);
            end   
   
% D = var(ff);
% Me=sum((ff/D).^2);
% l=eval(get(handles.maxpow, 'String')); 
% chi = Me/(n-l-1);
% msgbox(['l = ' num2str(l) 'Chi^2 = ' num2str(chi) 'mean = ' num2str(mean(ff)) ' std = ' num2str(std(ff))], ['l = ' num2str(l) 'Chi^2 = ' num2str(chi)],'replace');

            if (flagsigma ~= 0)
                ff=ff./sig;
            end

            if numsm == 1
                cla reset
            end    
             hold on;
            for i=1:4    
                if sm(i)~=0
                    nullintervals=cell2mat(handles.nullintervals(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);
                        MX=[xl xr  xr xl];
                        MY=[max(ff) max(ff) min(ff) min(ff)];
                        p=patch(MX,MY,[1 0 0]); 
                        set(p, 'EdgeColor', 'none');
                    end
                    
                    nullintervals=cell2mat(handles.masks(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);
                        MX=[xl xr  xr xl];
                        MY=[max(ff) max(ff) min(ff) min(ff)];
                        p=patch(MX,MY,[0 0 1]); 
                        set(p, 'EdgeColor', 'none');
                    end
                end
            end
            handles.ff(5,:) = ff;
            guidata(hObject, handles);
            plot(1:n, ff, 'k');
             set(gca, 'FontSize', 14);
    
            if numsm > 1    
                title('summa');
            else
                title('Интенсивность потока мюонов (без тренда)');
            end    

            xlabel( 'Время' ); ylabel( 'Число мюонов (без тренда)' ); 
            
            hold off;
            


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)

maxa = eval(get(handles.maxa, 'String')) ;
mina = eval(get(handles.mina, 'String')) ;
maxb = eval(get(handles.maxb, 'String')) ;

 ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
 or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
 ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
 ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

tx = eval(get(handles.tx, 'String'));  % - trend x
ty = eval(get(handles.ty, 'String'));  % - trend y
metka = eval(get(handles.metka, 'String'));

 sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    numsm = sum(sm);

predel =get(handles.predel, 'String');

%n = floor(91/s); % сколько ячеек берем(выделяется центр часть матрицы)

date_s = get(handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
dni = get(handles.dni, 'String');

flagwindow = get(handles.window, 'Value');
flagssa = get(handles.ssa, 'Value');
l = eval(get(handles.maxpow, 'String'));

ssaname = 'ssa';
if (flagssa == 0)
    ssaname = 'cheb';
end

windowname = 'wd ';

if (flagwindow == 0)   
    windowname='';
end

smstr = [int2str(sm(1)) int2str(sm(2)) int2str(sm(3)) int2str(sm(4))];
figname = ['sm' smstr ' ' date_s ' d' dni ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob)];
figname = [figname ' pr' predel ' ' windowname ssaname  int2str(l) ' a' int2str(mina) '-' int2str(maxa) ' b' int2str(maxb)  ' x' int2str(tx) ' y' int2str(ty)]; 

if numsm > 1
    dw = 1;
else    
    dw = get(handles.difwindow, 'Value');
end

if dw~=0
    figure('Name', figname,'FileName', figname)
else
    h = handles.axes1;
    axes(h);
end    

for cursm = 1:4
    if numsm > 1
        subplot(3,2,cursm);
    end    
    if sm(cursm)~=0  
        ff = handles.ff(cursm,:);
        
        flagw = get(handles.flagw, 'Value');
        if (flagwindow == 0)   
%             if (flagw ~= 0)
%                 figure('Name', figname,'FileName', figname);
%             end
            E = AnalyzW(ff,mina,maxa,maxb, 0, handles.date, figname,metka);  
        else
            if (flagssa == 0)   % Chebishev
                flagfish = get(handles.fisher, 'Value');
                if (flagfish == 0) % fisher
                    E = AnalyzWD(ff, maxb, 0); 
                else            % fix max stepen           
                    E = AnalyzWD(ff, maxb, l);
                end
            else    % SSA
                E = AnalyzWD(ff, maxb, -1);
            end
        end

        datestart=handles.date;
        interval = size(E,2);

        day = floor(interval/144);
        ost = mod(interval,144);
        hour = floor(ost*24/144);

        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
        enddate(4)=hour;

        datestart = datestr(datestart);
        enddate = datestr(enddate);

        xData = linspace(datenum(datestart),datenum(enddate),interval);

        metka = eval(get(handles.metka, 'String'));
        
        if numsm > 1
            hold on;
            nullintervals=cell2mat(handles.nullintervals(cursm));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);

                intervaln = xl;
                day = floor(intervaln/144);
                ost = mod(intervaln,144);
                hour = floor(ost*24/144);
                minute = floor((ost-hour*6)*10);
                enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                enddate(4)=hour;
                enddate(5)=minute;
                xl=datenum(enddate);

                intervaln = xr;
                day = floor(intervaln/144);
                ost = mod(intervaln,144);
                hour = floor(ost*24/144);
                minute = floor((ost-hour*6)*10);
                enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                enddate(4)=hour;
                enddate(5)=minute;
                xr=datenum(enddate);

                MX=[xl xr  xr xl];
                MY=[max(E) max(E) min(E) min(E)];
                p=patch(MX,MY,[1 0 0]); 
                set(p, 'EdgeColor', 'none');
            end
            
            nullintervals=cell2mat(handles.masks(cursm));
            for kk=1:size(nullintervals,1)
                xl = nullintervals(kk,1);
                xr = nullintervals(kk,2);

                intervaln = xl;
                day = floor(intervaln/144);
                ost = mod(intervaln,144);
                hour = floor(ost*24/144);
                minute = floor((ost-hour*6)*10);
                enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                enddate(4)=hour;
                enddate(5)=minute;
                xl=datenum(enddate);

                intervaln = xr;
                day = floor(intervaln/144);
                ost = mod(intervaln,144);
                hour = floor(ost*24/144);
                minute = floor((ost-hour*6)*10);
                enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                enddate(4)=hour;
                enddate(5)=minute;
                xr=datenum(enddate);

                MX=[xl xr  xr xl];
                MY=[max(E) max(E) min(E) min(E)];
                p=patch(MX,MY,[0 0 1]); 
                set(p, 'EdgeColor', 'none');
            end

            plot(xData,E, 'k');set(gca,'FontName','Arial Cyr');
            set(gca,'XTick',xData(1:metka*144:interval));
            
             set(gca, 'FontSize', 14);
    
     
            
            % if dw~=0
            %    title(figname)
            % end
            title(['sm ' int2str(cursm)]);

            % set(gca,'XMinorTick', 'on');
            % set(gca,'XMinorGrid', 'on');
            grid on
            datetick('x','m-dd','keepticks','keeplimits');
            hold off;
        end
    end
end

% Obrabotka summi
    if numsm > 1
        subplot(3,2,5:6);
    end    
        ff = handles.ff(5,:);
        
        flagw = get(handles.flagw, 'Value');
        if (flagwindow == 0)   
%             if (flagw ~= 0)
%                 figure('Name', figname,'FileName', figname);
%             end
            E = AnalyzW(ff,mina,maxa,maxb, 0, handles.date, figname,metka);  
        else
            if (flagssa == 0)   % Chebishev
                flagfish = get(handles.fisher, 'Value');
                if (flagfish == 0) % fisher
                    E = AnalyzWD(ff, maxb, 0); 
                else            % fix max stepen           
                    E = AnalyzWD(ff, maxb, l);
                end
            else    % SSA
                E = AnalyzWD(ff, maxb, -1);
            end
        end

        datestart=handles.date;
        interval = size(E,2);

        day = floor(interval/144);
        ost = mod(interval,144);
        hour = floor(ost*24/144);

        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
        enddate(4)=hour;

        datestart = datestr(datestart);
        enddate = datestr(enddate);

        xData = linspace(datenum(datestart),datenum(enddate),interval);

        metka = eval(get(handles.metka, 'String'));
        
        if numsm == 1
            cla reset
        end    
         hold on;
            for i=1:4    
                if sm(i)~=0
                    nullintervals=cell2mat(handles.nullintervals(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);

                        intervaln = xl;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xl=datenum(enddate);

                        intervaln = xr;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xr=datenum(enddate);
                        MX=[xl xr  xr xl];
                        MY=[max(E) max(E) min(E) min(E)];
                        p=patch(MX,MY,[1 0 0]); 
                        set(p, 'EdgeColor', 'none');
                    end
                    
                    nullintervals=cell2mat(handles.masks(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);

                        intervaln = xl;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xl=datenum(enddate);

                        intervaln = xr;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xr=datenum(enddate);
                        MX=[xl xr  xr xl];
                        MY=[max(E) max(E) min(E) min(E)];
                        p=patch(MX,MY,[0 0 1]); 
                        set(p, 'EdgeColor', 'none');
                    end
                end
            end  
        
        
        plot(xData,E, 'k');set(gca,'FontName','Arial Cyr');
        set(gca,'XTick',xData(1:metka*144:interval));
        % if dw~=0
        %    title(figname)
        % end
         set(gca, 'FontSize', 14);
    
        if numsm > 1    
            title('summa');
        else
            title('Энергия ряда');
        end    
    
        xlabel( 'Время' ); ylabel( 'Энергия' ); 
        % set(gca,'XMinorTick', 'on');
        % set(gca,'XMinorGrid', 'on');
        grid on
        datetick('x','m-dd','keepticks','keeplimits');
        hold off;
   
%plot(E);



% --- Executes on button press in sigma.
function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sigma



function ogrstat_Callback(hObject, eventdata, handles)
% hObject    handle to ogrstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ogrstat as text
%        str2double(get(hObject,'String')) returns contents of ogrstat as a double


% --- Executes during object creation, after setting all properties.
function ogrstat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ogrstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
    or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
    ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
    ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

    nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
    ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

    tx = eval(get(handles.tx, 'String'));  % - trend x
    ty = eval(get(handles.ty, 'String'));  % - trend y
    
    
     maxa = eval(get(handles.maxa, 'String')) ;
    mina = eval(get(handles.mina, 'String')) ;
    maxb = eval(get(handles.maxb, 'String')) ;

    predel =get(handles.predel, 'String');

    date_s = get(handles.startdate, 'String');
    date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
    dni = get(handles.dni, 'String');

    flagwindow = get(handles.window, 'Value');
    
    l = eval(get(handles.maxpow, 'String'));


flagssa = get(handles.ssa, 'Value');
ssaname = 'ssa';
if (flagssa == 0)
    ssaname = 'cheb';
end

windowname = 'wd ';

if (flagwindow == 0)   
    windowname='';
end

sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    ogrstat = eval(get(handles.ogrstat, 'String'));
    
    smstr = [int2str(sm(1)) int2str(sm(2)) int2str(sm(3)) int2str(sm(4))];
    figname = ['Analyse' int2str(ogrstat) ' sm' smstr ' ' date_s ' d' dni ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob)];
    figname = [figname ' pr' predel ' ' windowname ssaname  int2str(l) ' a' int2str(mina) '-' int2str(maxa) ' b' int2str(maxb)];  
    numsm = sum(sm);
    

    if numsm > 1
        dw = 1;
    else    
        dw = get(handles.difwindow, 'Value');
    end
    
    if dw~=0
        figure('Name', figname,'FileName', figname)
    else
        %h = handles.axes1;
        %axes(h);
    end    

    for cursm = 1:4
        if numsm > 1
            subplot(3,2,cursm);
        end    
        if sm(cursm)~=0   
            
            wavedata = cell2mat(handles.mat_en(cursm));
            %size(wavedata)
            
            if ((size(wavedata,2)>1) && (size(wavedata,1)>1))
                V=sum(sum(wavedata(:,:,:).*(wavedata(:,:,:)>ogrstat)));
                V=V(:);
            else
                V=sum(wavedata(:,:,:).*(wavedata(:,:,:)>ogrstat));
                V=V(:);
            end

        datestart=handles.date;
        interval = size(V,1);

        day = floor(interval/144);
        ost = mod(interval,144);
        hour = floor(ost*24/144);

        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
        enddate(4)=hour;

        datestart = datestr(datestart);
        enddate = datestr(enddate);

        xData = linspace(datenum(datestart),datenum(enddate),interval);

        metka = eval(get(handles.metka, 'String'));
        
        if numsm > 1
        hold on;
        nullintervals=cell2mat(handles.nullintervals(cursm));
        for kk=1:size(nullintervals,1)
            xl = nullintervals(kk,1);
            xr = nullintervals(kk,2);
            
            intervaln = xl;
            day = floor(intervaln/144);
            ost = mod(intervaln,144);
            hour = floor(ost*24/144);
            minute = floor((ost-hour*6)*10);
            enddate = datevec(addtodate(datenum(handles.date),day,'day'));
            enddate(4)=hour;
            enddate(5)=minute;
            xl=datenum(enddate);
            
            intervaln = xr;
            day = floor(intervaln/144);
            ost = mod(intervaln,144);
            hour = floor(ost*24/144);
            minute = floor((ost-hour*6)*10);
            enddate = datevec(addtodate(datenum(handles.date),day,'day'));
            enddate(4)=hour;
            enddate(5)=minute;
            xr=datenum(enddate);
            
            MX=[xl xr  xr xl];
            MY=[max(V) max(V) min(V) min(V)];
            p=patch(MX,MY,[1 0 0]); 
            set(p, 'EdgeColor', 'none');
        end
        
        nullintervals=cell2mat(handles.masks(cursm));
        for kk=1:size(nullintervals,1)
            xl = nullintervals(kk,1);
            xr = nullintervals(kk,2);
            
            intervaln = xl;
            day = floor(intervaln/144);
            ost = mod(intervaln,144);
            hour = floor(ost*24/144);
            minute = floor((ost-hour*6)*10);
            enddate = datevec(addtodate(datenum(handles.date),day,'day'));
            enddate(4)=hour;
            enddate(5)=minute;
            xl=datenum(enddate);
            
            intervaln = xr;
            day = floor(intervaln/144);
            ost = mod(intervaln,144);
            hour = floor(ost*24/144);
            minute = floor((ost-hour*6)*10);
            enddate = datevec(addtodate(datenum(handles.date),day,'day'));
            enddate(4)=hour;
            enddate(5)=minute;
            xr=datenum(enddate);
            
            MX=[xl xr  xr xl];
            MY=[max(V) max(V) min(V) min(V)];
            p=patch(MX,MY,[0 0 1]); 
            set(p, 'EdgeColor', 'none');
        end
        
         plot(xData,V, 'k');set(gca,'FontName','Arial Cyr');
        set(gca,'XTick',xData(1:metka*144:interval));
        % if dw~=0
        %    title(figname)
        % end
        
         set(gca, 'FontSize', 14);
        
        title(['sm ' int2str(cursm)]);
        
        
        
        % set(gca,'XMinorTick', 'on');
        % set(gca,'XMinorGrid', 'on');
        grid on
        datetick('x','m-dd','keepticks','keeplimits');
        hold off;
        end
        end
    end
    
    V=[];
    % OBRABOTKA SUMMI
    if numsm > 1
        subplot(3,2,5:6);
    end    
            wavedata = cell2mat(handles.mat_en(5));
            %size(wavedata)
            
            if ((size(wavedata,2)>1) && (size(wavedata,1)>1))
                V=sum(sum(wavedata(:,:,:).*(wavedata(:,:,:)>ogrstat)));
                V=V(:);
            else
                V=sum(wavedata(:,:,:).*(wavedata(:,:,:)>ogrstat));
                V=V(:);
            end

        datestart=handles.date;
        interval = size(V,1)

        day = floor(interval/144);
        ost = mod(interval,144);
        hour = floor(ost*24/144);

        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
        enddate(4)=hour;

        datestart = datestr(datestart);
        enddate = datestr(enddate);

        xData = linspace(datenum(datestart),datenum(enddate),interval);

        metka = eval(get(handles.metka, 'String'));
        
       if numsm == 1 
            cla reset
       end
       hold on;
            for i=1:4    
                if sm(i)~=0
                    nullintervals=cell2mat(handles.nullintervals(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);

                        intervaln = xl;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xl=datenum(enddate);

                        intervaln = xr;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xr=datenum(enddate);
                        MX=[xl xr  xr xl];
                        MY=[max(V) max(V) min(V) min(V)];
                        p=patch(MX,MY,[1 0 0]); 
                        set(p, 'EdgeColor', 'none');
                    end
                    
                    nullintervals=cell2mat(handles.masks(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);

                        intervaln = xl;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xl=datenum(enddate);

                        intervaln = xr;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xr=datenum(enddate);
                        MX=[xl xr  xr xl];
                        MY=[max(V) max(V) min(V) min(V)];
                        p=patch(MX,MY,[0 0 1]); 
                        set(p, 'EdgeColor', 'none');
                    end
                end
            end  
        
         plot(xData,V, 'k');set(gca,'FontName','Arial Cyr');
        set(gca,'XTick',xData(1:metka*144:interval));
        % if dw~=0
        %    title(figname)
        % end
         set(gca, 'FontSize', 14);
    
        if numsm > 1    
            title('summa');
        else
            title('Полная энергия матричного ряда');
        end    

        xlabel( 'Время' ); ylabel( 'Энергия' ); 
        
        % set(gca,'XMinorTick', 'on');
        % set(gca,'XMinorGrid', 'on');
        grid on
        datetick('x','m-dd','keepticks','keeplimits');
        hold off;


% --- Executes during object creation, after setting all properties.
function pushbutton24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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



function ukrupf_Callback(hObject, eventdata, handles)
% hObject    handle to ukrupf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ukrupf as text
%        str2double(get(hObject,'String')) returns contents of ukrupf as a double


% --- Executes during object creation, after setting all properties.
function ukrupf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ukrupf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
memUsed
st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)


%n = floor(91/s); % сколько ячеек берем(выделяется центр часть матрицы)

date_s = get(handles.startdate, 'String');
date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
handles.date = datevec(date_s);
dni = eval(get(handles.dni, 'String'));

sm = [0 0 0 0];

if get(handles.sm1, 'Value')~=0
    sm(1) = 1;
end    
if get(handles.sm2, 'Value')~=0
    sm(2) = 1;
end  
if get(handles.sm3, 'Value')~=0
    sm(3) = 1;
end  
if get(handles.sm4, 'Value')~=0
    sm(4) = 1;
end  

numsm = sum(sm);


polosi = get(handles.polosi, 'Value');

[l,wrow, nullintervals, mat_intens, masks]=ExtractRows(handles.date, dni,'.\ExtractMatrix',nx, ny,sf, st, ol, or, ot, ob, sm, polosi);
set(handles.slider1, 'Max', l);

handles.wrow = wrow;
% '1'
% kkk = handles.wrow(:,:,4)
handles.nullintervals = [];
handles.nullintervals = nullintervals;

handles.masks = [];
handles.masks = masks;

% Perevodim v matrici

handles.mat_intens=mat_intens;

%handles.maxm_intens = [];
%handles.mat_intens=[];
% %sum_intens = zeros(ny,nx,size(wrow,2));
% for cursm = 1:4
%     if sm(cursm)~=0 
%     l1 = size(wrow,2);
%         %wdata = zeros(ny,nx,l1);
%         wdata = [];
%         for i = 1:l1
%             A=zeros(nx,ny);
%             for j = 1:nx*ny
%                  A(j)=wrow(j,i,4);
%             end
%            A=rot90(A,-1);
%            % A=flipud(A);
%            % A
%             wdata(:,:,i)=A;
%             %sum_intens(:,:,i) = sum_intens(:,:,i)+A;
%         end
%        % wdata
%     
%     handles.mat_intens(:,:,:,cursm) = wdata;
%     handles.maxm_intens(cursm) = max(max(max(handles.mat_intens(:,:,:,cursm))));
%     clear('wdata')
%     clear('A')
%     end
% end

sum_intens = zeros(ny,nx,l);

for cursm = 1:4  %Formiruem summu - ryad
     if sm(cursm)~=0 
         sum_intens = sum_intens+cell2mat(handles.mat_intens(cursm));
     end
end
handles.mat_intens(5) = mat2cell(sum_intens);
handles.maxm_intens(5) = max(max(max(sum_intens)));



clear('mat_intens')
%handles.cur_matrix = handles.mat_intens(:,:,:,5);
%handles.cur_maxm = handles.maxm_intens(5);

handles.cur_matrix = cell2mat(handles.mat_intens(5));
handles.cur_maxm = handles.maxm_intens(5);

guidata(hObject, handles); 
memUsed
toc


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
    or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
    ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
    ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

    nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
    ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

    tx = eval(get(handles.tx, 'String'));  % - trend x
    ty = eval(get(handles.ty, 'String'));  % - trend y
    
     metka = eval(get(handles.metka, 'String'));
    
   sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    numsm = sum(sm);
    
    if size(handles.wrow,2)==0  
        date_s = get(handles.startdate, 'String');
        date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
        handles.date = datevec(date_s);
        dni = eval(get(handles.dni, 'String'));
        guidata(hObject, handles);
       

        [l,wrow]=ExtractRows(handles.date, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,sf, st, ol, or, ot, ob, sm);
        set(handles.slider1, 'Max', l);
        handles.wrow = wrow;
        guidata(hObject, handles);
    end
    
    %444444444444444444444444444 
    
      ffsum = zeros(4,size(cell2mat(handles.wrow),2));
%      'ffsum'
%     size(ffsum)
    handles.B = [];
    for cursm = 1:4
        if sm(cursm)~=0   
            ff = cell2mat(handles.wrow(cursm));
            ff = ff((ty-1)*nx+tx,:);
            ffsum(cursm,:) = ff;
            guidata(hObject, handles);
        end
    end
    % Obrabotka summi
  
    ff = sum(ffsum);
       
    %44444444444444444444444444444444      
    
    
    
%     ff = handles.wrow((ty-1)*nx+tx,:);
    n=size(ff,2);
    
%     handles.sig = std(ff);
%     guidata(hObject, handles);
    
    flagvibr = get(handles.vibr, 'Value');
    if (flagvibr ~= 0)    % Udalyat vibrosi
        predel = eval(get(handles.predel, 'String'));
        ff=UdalVibr(ff, predel);
    end

    handles.ff = ff;
%     figure
%     plot(handles.ff);
    guidata(hObject, handles);
    
    flagfish = get(handles.fisher, 'Value');
    flagwindow = get(handles.window, 'Value');
    if (flagwindow == 0)    % ne okonniy  
            if not(flagfish==0) % fisher  
                [F,B,l] = Approx(ff,0); 
                set(handles.maxpow, 'String', l);   
                handles.B(5,:) = B;
                guidata(hObject, handles);
            else                % fix max step   
                l=eval(get(handles.maxpow, 'String')); 
                [F,B] = Approx(ff,l) ;     
                handles.B(5,:) = B;
                guidata(hObject, handles);
            end
    end   
    


    flagmontrend = get(handles.montrend, 'Value');
    flagssa = get(handles.ssa, 'Value');
    if (flagmontrend ~= 0) %Ubiraem trend 
        if (flagwindow == 0)
            flagsigma = get(handles.sigma, 'Value');

            ff = handles.B(5,:);
            n=size(ff,2);

            sig = std(ff);

            flagvibr = get(handles.vibr, 'Value');
            if (flagvibr ~= 0)    % Udalyat vibrosi
                predel = eval(get(handles.predel, 'String'));
                ff=UdalVibr(ff, predel);
            end   

            if (flagsigma ~= 0)
                ff=ff./sig;
            end

            handles.ff = ff;
            guidata(hObject, handles);
        end
    end 
%     figure
%     plot(handles.ff);
    
    % Veivlet
    
    maxa = eval(get(handles.maxa, 'String')) ;
    mina = eval(get(handles.mina, 'String')) ;
    maxb = eval(get(handles.maxb, 'String')) ;

    predel =get(handles.predel, 'String');

    date_s = get(handles.startdate, 'String');
    date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
    dni = get(handles.dni, 'String');

    flagwindow = get(handles.window, 'Value');
    
    l = eval(get(handles.maxpow, 'String'));

    ssaname = 'ssa';
    if (flagssa == 0)
        ssaname = 'cheb';
    end

    windowname = 'wd ';
    if (flagwindow == 0)   
        windowname='';
    end
  
    
    figname = ['sm' int2str(sm) ' ' date_s ' d' dni ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob)];
    figname = [figname ' pr' predel ' ' windowname ssaname int2str(l) ' a' int2str(mina) '-' int2str(maxa) ' b' int2str(maxb) ' x' int2str(tx) ' y' int2str(ty)]; 

    flagw = get(handles.flagw, 'Value');
    if (flagwindow == 0)   
        if (flagw ~= 0)
            figure('Name', figname,'FileName', figname);
        end
        E = AnalyzW(handles.ff,mina,maxa,maxb, flagw, handles.date, figname,metka);  
    else
        flagsigma = get(handles.sigma, 'Value');
        if (flagssa == 0)   % Chebishev
            flagfish = get(handles.fisher, 'Value');
            if (flagfish == 0) % fisher
                E = AnalyzWD(handles.ff, maxb, 0,flagsigma); 
            else            % fix max stepen           
                E = AnalyzWD(handles.ff, maxb, l,flagsigma);
            end
        else    % SSA
            
            E = AnalyzWD(handles.ff, maxb, -1,flagsigma);
        end
    end

     

    if numsm > 1
        dw = 1;
    else    
        dw = get(handles.difwindow, 'Value');
    end
    
    if dw~=0
        figure('Name', figname, 'FileName', figname)
    else
        h = handles.axes1;
        axes(h);
    end    

     % Data na OX
    
     datestart=handles.date;
    interval = size(E,2);


    day = floor(interval/144);
    ost = mod(interval,144);
    hour = floor(ost*24/144);

    enddate = datevec(addtodate(datenum(handles.date),day,'day'));
    enddate(4)=hour;

    datestart = datestr(datestart);
    enddate = datestr(enddate);

    xData = linspace(datenum(datestart),datenum(enddate),interval);
    
    if numsm == 1
         cla reset
    end    
     
         hold on;
            for i=1:4    
                if sm(i)~=0
                    nullintervals=cell2mat(handles.nullintervals(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);

                        intervaln = xl;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xl=datenum(enddate);

                        intervaln = xr;
                        day = floor(intervaln/144);
                        ost = mod(intervaln,144);
                        hour = floor(ost*24/144);
                        minute = floor((ost-hour*6)*10);
                        enddate = datevec(addtodate(datenum(handles.date),day,'day'));
                        enddate(4)=hour;
                        enddate(5)=minute;
                        xr=datenum(enddate);
                        MX=[xl xr  xr xl];
                        MY=[max(E) max(E) min(E) min(E)];
                        p=patch(MX,MY,[1 0 0]); 
                        set(p, 'EdgeColor', 'none');
                    end
                end
            end  
        
    
    
   
    plot(xData,E, 'k');set(gca,'FontName','Arial Cyr');set(gca,'XTick',xData(1:metka*144:interval));
     
    set(gca, 'FontSize', 14);
    
    if numsm > 1    
        title('summa');
    else
        title('Энергия ряда');
    end    
    
    xlabel( 'Время' ); ylabel( 'Энергия' ); 
    grid on
    datetick('x','m-dd','keeplimits','keepticks');
    
    





% --- Executes on button press in montrend.
function montrend_Callback(hObject, eventdata, handles)
% hObject    handle to montrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of montrend


% --- Executes during object creation, after setting all properties.
function pushbutton22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in flagw.
function flagw_Callback(hObject, eventdata, handles)
% hObject    handle to flagw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flagw



function metka_Callback(hObject, eventdata, handles)
% hObject    handle to dgfg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dgfg as text
%        str2double(get(hObject,'String')) returns contents of dgfg as a double


% --- Executes during object creation, after setting all properties.
function dgfg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dgfg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
    ol = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем слева
    or = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем справа
    ot = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем сверху
    ob = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем снизу

    ny = floor((91-ol-or)/st); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
    nx = floor((91-ot-ob)/sf); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

    tx = eval(get(handles.tx, 'String'));  % - trend x
    ty = eval(get(handles.ty, 'String'));  % - trend y
  
%     if size(handles.wrow,2)==0  
%         date_s = get(handles.startdate, 'String');
%         date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
%         handles.date = datevec(date_s);
%         dni = eval(get(handles.dni, 'String'));
%         guidata(hObject, handles);
%        
% 
%         [l,wrow]=ExtractRows(handles.date, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,s, ol, or, ot, ob);
%         handles.wrow = wrow;
%         guidata(hObject, handles);
%     end
    
    ff = handles.wrow((ty-1)*nx+tx,:);
    n=size(ff,2);
    
    handles.sig = std(ff);
    guidata(hObject, handles);
    
    flagvibr = get(handles.vibr, 'Value');
    if (flagvibr ~= 0)    % Udalyat vibrosi
        predel = eval(get(handles.predel, 'String'));
        ff=UdalVibr(ff, predel);
    end
    
    flagfish = get(handles.fisher, 'Value');
    flagwindow = get(handles.window, 'Value');
    
    maxl=eval(get(handles.maxpow, 'String')); 
    
    MasChi = [];
    for l = 1:maxl
        if (flagwindow == 0)    % ne okonniy  
                if not(flagfish==0) % fisher  
                    [F,B,l] = Approx(ff,0); 
                    set(handles.maxpow, 'String', l);   
                    handles.B = B;
                    guidata(hObject, handles);
                else                % fix max step   
                    %%l=eval(get(handles.maxpow, 'String')); 
                    [F,B] = Approx(ff,l) ;     
                    handles.B = B;
                    guidata(hObject, handles);
                end
        end   
    


        flagsigma = get(handles.sigma, 'Value');


        n=size(B,2);

      

        flagvibr = get(handles.vibr, 'Value');
        if (flagvibr ~= 0)    % Udalyat vibrosi
            predel = eval(get(handles.predel, 'String'));
            B=UdalVibr(B, predel);
        end   

        Bsredn = mean(B);
        D = var(B);
        
        sumB = sum(B.^2)
        Ssigma=std(B)
        
        %rezultat = sumB/(Ssigma^2)
        
        %sumS = sum((B/Ssigma).^2)
        
        Me=sum(B.^2);
       %chi = Me/(n-l-1);
       chi = Me/n;
        MasChi = [MasChi chi];
        %msgbox(num2str(chi), ['l = ' num2str(l) 'Chi^2 = ' num2str(chi)],'replace');

        %h = handles.axes1;
        %axes(h);
    end
    
    dw = get(handles.difwindow, 'Value');
    if dw~=0
        figure
    else
        h = handles.axes1;
        axes(h);
    end    
    
    MasChi
    p=plot(1:maxl, MasChi)
    set(p, 'Color', 'Black', 'LineWidth', 3);



% --- Executes during object creation, after setting all properties.
function pushbutton31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% end
% end
% end
% end
% end
% end
% end
% end
% end
% end
% end end end end end end end end end end end end end end end end end end end end end
% end end end end end end end end end end end end end end end end end end end end end end
% end end end end end end end end end end end end end end end end end end end end end end end end end
% end end end end end end end end end end end


% --- Executes during object creation, after setting all properties.
% function metka_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to metka (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes during object creation, after setting all properties.
function metka_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
% handles.cur_matrix = handles.mat_intens(:,:,:,5);
% guidata(hObject, handles); 
% handles.cur_maxm = handles.maxm_intens(5);
% guidata(hObject, handles); 
% 'muon_matrix'

handles.cur_matrix = cell2mat(handles.mat_intens(5));
handles.cur_maxm = handles.maxm_intens(5);
guidata(hObject, handles); 
'muon_matrix'


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
% handles.cur_matrix = handles.wavedata(:,:,:,5);
% guidata(hObject, handles); 
% handles.cur_maxm = handles.maxm(5);
% guidata(hObject, handles); 
% 'energ_matrix'

handles.cur_matrix = cell2mat(handles.mat_en(5));
guidata(hObject, handles); 
handles.cur_maxm = handles.maxm(5);
guidata(hObject, handles); 
'energ_matrix'




% --- Executes on button press in flag_wt.
function flag_wt_Callback(hObject, eventdata, handles)
% hObject    handle to flag_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag_wt
% handles.cur_matrix =  handles.matrix_without_trend(:,:,:,5);
% guidata(hObject, handles); 
% handles.cur_maxm = handles.maxm_wt(5);
% guidata(hObject, handles); 
% 'trend_matrix'

handles.cur_matrix = cell2mat(handles.mat_wt(5));
guidata(hObject, handles); 
handles.cur_maxm = handles.maxm_wt(5);
guidata(hObject, handles); 
'trend_matrix'








function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*txt');
if FileName~=0 
   % nullintervals=cell(1,4);
    %nullintervals(1,4) = [];
    handles.nullintervals=cell(1,4);
    handles.nullintervals(4) = mat2cell([]);
    FullName = [PathName FileName];
    
    date_s = get(handles.startdate, 'String');
    date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
    handles.date = datevec(date_s);

    fid=fopen(FullName);
    A=fscanf(fid,'%d');
    fclose(fid); 
    A=Obrezka(A);
    size(A)
    handles.wrow = [];
    handles.wrow(:,:,4) = A;
    handles.wrow(:,:,5) = A;
    guidata(hObject, handles);
end


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 flagsigma = get(handles.sigma, 'Value');
 
wave_type = get(handles.wave_type, 'String');
wave_type = cell2mat(wave_type(get(handles.wave_type, 'Value')));

if wave_type(1) ~= 'haar'
    val = get(handles.wave_number, 'String');
    wave_number = eval(cell2mat(val(get(handles.wave_number, 'Value'))));
    wave_number = wave_number(1);
    wave_type = [wave_type int2str(wave_number)]
end    


alpha = eval(get(handles.alpha, 'String'));
level = eval(get(handles.level, 'String'));
threshold = get(handles.threshold, 'Value');



if threshold == 1
    SORH = 's';
else
    SORH = 'h';
end





    sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  

    numsm = sum(sm);

%     h = handles.axes1;
%         axes(h);
        
    if numsm > 1
        dw = 1;
    else    
        dw = get(handles.difwindow, 'Value');
    end
    
    if dw~=0
        figure
    end    

    for cursm = 1:4
        if numsm > 1
            subplot(3,2,cursm);
        end    
        if sm(cursm)~=0  
            ff = handles.ff(cursm,:);
            n=size(ff,2);

           % ff = Veyvlet_filter(ff);       
         
            [c,l] = wavedec(ff, level, wave_type);
            sigma = wnoisest(c,l,1);
            THR = wbmpen(c,l, sigma, alpha);

            ff = wdencmp('gbl',c,l, wave_type, level, THR, SORH, 1);
            
            handles.ff(cursm,:) = ff;
            guidata(hObject, handles);
            
            if numsm > 1
                hold on;
                nullintervals=cell2mat(handles.nullintervals(cursm));
                for kk=1:size(nullintervals,1)
                    xl = nullintervals(kk,1);
                    xr = nullintervals(kk,2);
                    MX=[xl xr  xr xl];
                    MY=[max(ff) max(ff) min(ff) min(ff)];
                    p=patch(MX,MY,[1 0 0]); 
                    set(p, 'EdgeColor', 'none');
                end
                
                nullintervals=cell2mat(handles.masks(cursm));
                for kk=1:size(nullintervals,1)
                    xl = nullintervals(kk,1);
                    xr = nullintervals(kk,2);
                    MX=[xl xr  xr xl];
                    MY=[max(ff) max(ff) min(ff) min(ff)];
                    p=patch(MX,MY,[0 0 1]); 
                    set(p, 'EdgeColor', 'none');
                end

                plot(1:n, ff, 'k');
                
                 set(gca, 'FontSize', 14);
                title(['sm ' int2str(cursm)]);
                 hold off;
            end    
        end
    end
    
    %Obrabotka summi
        if numsm > 1
            subplot(3,2,5:6);
        end    
            ff = handles.ff(5,:);
            n=size(ff,2);

           %ff = Veyvlet_filter(ff);
           
           [c,l] = wavedec(ff, level, wave_type);
            sigma = wnoisest(c,l,1);
            THR = wbmpen(c,l, sigma, alpha);

            ff = wdencmp('gbl',c,l, wave_type, level, THR, SORH, 1);
            
            if numsm == 1
                cla reset
            end    
             hold on;
            for i=1:4    
                if sm(i)~=0
                    nullintervals=cell2mat(handles.nullintervals(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);
                        MX=[xl xr  xr xl];
                        MY=[max(ff) max(ff) min(ff) min(ff)];
                        p=patch(MX,MY,[1 0 0]); 
                        set(p, 'EdgeColor', 'none');
                    end
                    
                    nullintervals=cell2mat(handles.masks(i));
                    for kk=1:size(nullintervals,1)
                        xl = nullintervals(kk,1);
                        xr = nullintervals(kk,2);
                        MX=[xl xr  xr xl];
                        MY=[max(ff) max(ff) min(ff) min(ff)];
                        p=patch(MX,MY,[0 0 1]); 
                        set(p, 'EdgeColor', 'none');
                    end
                end
            end
            handles.ff(5,:) = ff;
            guidata(hObject, handles);
            plot(1:n, ff, 'k');
             set(gca, 'FontSize', 14);
    
            if numsm > 1    
                title('summa');
            else
                title('Интенсивность потока мюонов (без тренда)');
            end    

            xlabel( 'Время' ); ylabel( 'Число мюонов (без тренда)' ); 
            
            hold off;



% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st = eval(get(handles.ukrupt, 'String')) ; % - сколько ячеек суммируем(укрупняем)
sf = eval(get(handles.ukrupf, 'String')) ; % - сколько ячеек суммируем(укрупняем)
ol = eval(get(handles.obrl, 'String')) ; % - сколько ячеек обрезаем слева
or = eval(get(handles.obrr, 'String')) ; % - сколько ячеек обрезаем справа
ot = eval(get(handles.obrt, 'String')) ; % - сколько ячеек обрезаем сверху
ob = eval(get(handles.obrb, 'String')) ; % - сколько ячеек обрезаем снизу

nx = floor((91-ol-or)/sf); % сколько ячеек берем по оси x(выделяется центр часть матрицы)
ny = floor((91-ot-ob)/st); % сколько ячеек берем по оси y(выделяется центр часть матрицы)

tx = eval(get(handles.tx, 'String'));  % - trend x
ty = eval(get(handles.ty, 'String'));  % - trend y
  
%     if size(handles.wrow,2)==0  
%         date_s = get(handles.startdate, 'String');
%         date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
%         handles.date = datevec(date_s);
%         dni = eval(get(handles.dni, 'String'));
%         guidata(hObject, handles);
%        
% 
%         [l,wrow]=ExtractRows(handles.date, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,s, ol, or, ot, ob);
%         handles.wrow = wrow;
%         guidata(hObject, handles);
%     end
    sm = [0 0 0 0];

    if get(handles.sm1, 'Value')~=0
        sm(1) = 1;
    end    
    if get(handles.sm2, 'Value')~=0
        sm(2) = 1;
    end  
    if get(handles.sm3, 'Value')~=0
        sm(3) = 1;
    end  
    if get(handles.sm4, 'Value')~=0
        sm(4) = 1;
    end  
    
    
    date_s = get(handles.startdate, 'String');
    date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 'dd mm yyyy');
    dni = get(handles.dni, 'String');


    smstr = [int2str(sm(1)) int2str(sm(2)) int2str(sm(3)) int2str(sm(4))];
    figname = ['sm' smstr ' ' date_s ' d' dni ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob)];
    figname = [figname ' x' int2str(tx) ' y' int2str(ty)]; 


    for cursm = 1:4  
        if sm(cursm)~=0    
            ff = handles.wrow((ty-1)*nx+tx,:, cursm);
            [filename, pathname] = uiputfile({'*.txt'}, 'Save as', figname);
            %dlmwrite([pathname filename], ff, 'delimiter', '\r\n');
            fid = fopen([pathname filename],'wt');  
            fprintf(fid,'%g\n',round(ff));  
            fclose(fid);
        end
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


% --- Executes on button press in threshold.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of threshold


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel20, 'Visible', 'off');


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel20, 'Visible', 'on');


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% wdata = handles.wavedata(:,:,:,5);
% n = size(wdata,3);
% maxx = size(wdata,1);
% maxy = size(wdata,2);

k=size(colormap,1);
flag_wt = get(handles.flag_wt, 'Value');
if (flag_wt == 0)
    wd = handles.cur_matrix.*k./handles.cur_maxm;
else
    wd = (handles.cur_matrix+abs(handles.minm_wt)).*k./(abs(handles.minm_wt)+handles.cur_maxm); 
end

ogr=eval(get(handles.ogr, 'String'));
wd = (wd>=ogr).*wd;


n = size(wd,3);
maxx = size(wd,1);
maxy = size(wd,2);

A = [];

for i = 1:(n-1)    
    %wd = handles.wavedata(:,:,c,5).*k./handles.maxm(5);  
    cur_count = 0;
    for x = 1:maxx
        for y = 1:maxy
            if (wd(x,y,i) >0) && (wd(x,y,i+1)>0)
                cur_count = cur_count+1;
            end
        end
    end 
    A(i)=cur_count;
end

plot(A);


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

c = floor(get(hObject, 'Value'));
set(handles.binar, 'String', int2str(c));

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in do_binarize.
function do_binarize_Callback(hObject, eventdata, handles)
% hObject    handle to do_binarize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of do_binarize



function smooth_size_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smooth_size as text
%        str2double(get(hObject,'String')) returns contents of smooth_size as a double


% --- Executes during object creation, after setting all properties.
function smooth_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function smooth_count_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smooth_count as text
%        str2double(get(hObject,'String')) returns contents of smooth_count as a double


% --- Executes during object creation, after setting all properties.
function smooth_count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = floor(get(handles.slider1, 'Value'));

h = handles.axes1;
axes(h);

DrawMatrix();

en3d = get(handles.en3d, 'Value');
if (en3d == 0)
    image(wd);
else
    surf(wd);
    axis([0 size(wd,1) 0 size(wd,1) 0 60 0 60]);
end

set(gca,'YDir','normal');
colorbar


% --- Executes on button press in smooth_on.
function smooth_on_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of smooth_on


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = floor(get(handles.slider1, 'Value'));
set(handles.slider1, 'Value', c);
set(handles.text1, 'String', int2str(c));
 
DrawMatrix();

wd = round(wd.*1000);

wd = flipud(wd);

[filename, pathname] = uiputfile({'*.txt'}, 'Save as');

file_str = [pathname filename];

%fid = fopen(file_str,'w');
dlmwrite(file_str, wd, 'delimiter', '\t', 'newline', 'pc');



function ogr_verh_Callback(hObject, eventdata, handles)
% hObject    handle to ogr_verh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ogr_verh as text
%        str2double(get(hObject,'String')) returns contents of ogr_verh as a double


% --- Executes during object creation, after setting all properties.
function ogr_verh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ogr_verh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function max_color_Callback(hObject, eventdata, handles)
% hObject    handle to max_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function max_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.uipanel22, 'Visible'),'on')
    set(handles.uipanel22, 'Visible', 'off');
else
    set(handles.uipanel22, 'Visible', 'on');
end
