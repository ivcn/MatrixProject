function varargout = Obrabotka(varargin)
% OBRABOTKA MATLAB code for Obrabotka.fig
%      OBRABOTKA, by itself, creates a new OBRABOTKA or raises the existing
%      singleton*.
%
%      H = OBRABOTKA returns the handle to a new OBRABOTKA or the handle to
%      the existing singleton*.
%
%      OBRABOTKA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBRABOTKA.M with the given input arguments.
%
%      OBRABOTKA('Property','Value',...) creates a new OBRABOTKA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Obrabotka_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Obrabotka_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Obrabotka

% Last Modified by GUIDE v2.5 28-Jun-2011 15:02:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Obrabotka_OpeningFcn, ...
                   'gui_OutputFcn',  @Obrabotka_OutputFcn, ...
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


% --- Executes just before Obrabotka is made visible.
function Obrabotka_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Obrabotka (see VARARGIN)

% Choose default command line output for Obrabotka
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Obrabotka wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Obrabotka_OutputFcn(hObject, eventdata, handles) 
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
tic
fid = fopen('test.txt');
fgetl(fid);
fgetl(fid);
C = textscan(fid, '%s %f %f %f %f %f %f %f %f %f %f %f %f %s %f %f %f %f %f');
n = size(C{1},1);
fclose(fid);

mdni = cell2mat(C(2));
msm = cell2mat(C(3));
msf = cell2mat(C(4));
mst = cell2mat(C(5));
mol = cell2mat(C(6));
mor = cell2mat(C(7));
mot = cell2mat(C(8));
mob = cell2mat(C(9));
ml = cell2mat(C(10));
mmina = cell2mat(C(11));
mmaxa = cell2mat(C(12));
mmaxb = cell2mat(C(13));
%mwavetype = cell2mat(C(14))
mlevel = cell2mat(C(15));
malpha = cell2mat(C(16));
mthreshold = cell2mat(C(17));
mpredel = cell2mat(C(18));
msigma = cell2mat(C(19));

pathname = uigetdir(pwd, '”кажите им€ директории куда будут сохранены проанализированные данные');
pathname = [pathname '\'];

for nomer = 1:n
    mat_en = cell(1,5);
    memUsed
    date_s = C{1}(nomer);
    wave_type = C{14}(nomer);
    date_s0 = date_s;
    dni = mdni(nomer);
    cursm = msm(nomer);
    sf = msf(nomer);
    st = mst(nomer);
    ol = mol(nomer);
    or = mor(nomer);
    ot = mot(nomer);
    ob = mob(nomer);
    l = ml(nomer);
    mina = mmina(nomer);
    maxa = mmaxa(nomer);
    maxb = mmaxb(nomer);
    predel = mpredel(nomer);
    nx = floor((91-ol-or)/sf); % сколько €чеек берем по оси x(выдел€етс€ центр часть матрицы)
    ny = floor((91-ot-ob)/st); % сколько €чеек берем по оси y(выдел€етс€ центр часть матрицы)
    flagsigma = msigma(nomer);
    
    wave_type = cell2mat(wave_type);
   
    alpha = malpha(nomer);
    level = mlevel(nomer);
    threshold = mthreshold(nomer);

    if threshold == 1
        SORH = 's';
    else
        SORH = 'h';
    end
      
    %n = floor(91/s); % сколько €чеек берем(выдел€етс€ центр часть матрицы)
    date_s = datestr(datenum(date_s, 'dd/mm/yyyy'), 2);
    
    datestart = datevec(date_s);
    %dni = eval(get(handles.dni, 'String'));
    handles.date = datestart;
    date_s = datestr(datenum(date_s0, 'dd/mm/yyyy'), 'dd mm yyyy');


    polosi = 1;
    sm = [0 0 0 0];
    sm(cursm) = 1;
    numsm = sum(sm);
    
    [kkk,wrow, nullintervals, mat_intens, masks]=ExtractRows(datestart, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,sf, st, ol, or, ot, ob, sm, polosi);
    %[kkk,wrow]=ExtractRows(datestart, dni,'D:\Veivlet tufanov\ExtractMatrix',nx, ny,sf, st, ol, or, ot, ob, sm, polosi);
    
   
    handles.wrow = wrow;
    handles.nullintervals = [];
    handles.nullintervals = nullintervals;
    handles.masks = [];
    handles.masks = masks;
    % Perevodim v matrici
    mat_intens(5) = mat_intens(cursm);
    handles.maxm_intens(5) = max(max(max(cell2mat(mat_intens(5)))));

    %clear('mat_intens')
%     handles.cur_matrix = handles.mat_intens(:,:,:,5);
%     handles.cur_maxm = handles.maxm_intens(5);
%     guidata(hObject, handles); 
    
    %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    xo = maxb; % 
    % 
    ffsum = zeros(5,size(handles.wrow,2));
    mat_en = cell(1,5);
    mat_wt = cell(1,5);
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
                flagfish = 0;
                flagwindow = 0;
                if (flagwindow == 0)    % ne okonniy
                    flagssa = 0;
                    if (flagssa == 0)   % Chebishev      
                        if not(flagfish==0) % fisher  
                            [F,B,l] = Approx(ff,0); 
                            set(handles.maxpow, 'String', l);             
                        else                % fix max step   
                            [F,B] = Approx(ff,l) ;                     
                        end
                        flagvibr = 1;
                        if (flagvibr ~= 0)    % Udalyat vibrosi
                            B=UdalVibr(B, predel);
                            %figure
                            %plot(B);
                        end   

                        sig = std(B);
                        %flagsigma = 1;
                        if (flagsigma ~= 0)
                            B=B./sig;
                        end
                        % Veivlet-Filter
                        [c,ll] = wavedec(B, level, wave_type);
                        sigma = wnoisest(c,ll,1);
                        THR = wbmpen(c,ll, sigma, alpha);

                        B = wdencmp('gbl',c,ll, wave_type, level, THR, SORH, 1);

                        % Energiya
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

            mat_en(cursm) = mat2cell(wdata);
            guidata(hObject, handles);
            handles.maxm(cursm) = max(max(max(wdata)));
            guidata(hObject, handles);

            mat_wt(cursm) = mat2cell(wdata_wt);
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
                    %ffsum(5,:) = ff;

                    ff=UdalVibr(ff, 10);


                %figure
                %plot(ff);
                flagfish = 0;
                flagwindow = 0;
                if (flagwindow == 0)    % ne okonniy
                    flagssa = 0;
                    if (flagssa == 0)   % Chebishev      
                        if not(flagfish==0) % fisher  
                            [F,B,l] = Approx(ff,0); 
                            set(handles.maxpow, 'String', l);             
                        else                % fix max step   
                            [F,B] = Approx(ff,l) ;                     
                        end
                        flagvibr = 1;
                        if (flagvibr ~= 0)    % Udalyat vibrosi
                            B=UdalVibr(B, predel);
                            %figure
                            %plot(B);
                        end   

                        sig = std(B);
     
                        if (flagsigma ~= 0)
                            B=B./sig;
                        end
                        % Veivlet-Filter
                        [c,ll] = wavedec(B, level, wave_type);
                        sigma = wnoisest(c,ll,1);
                        THR = wbmpen(c,ll, sigma, alpha);

                        B = wdencmp('gbl',c,ll, wave_type, level, THR, SORH, 1);

                        % Energiya
                        E = AnalyzW(B,mina, maxa,maxb,0,1) ;        
                    else        % SSA
                    end
                else               % Okonniy                        
                    flagssa = get(handles.ssa, 'Value');
                   % flagsigma = get(handles.sigma, 'Value');
                    if (flagssa == 0)   % Chebishev
                        flagfish = get(handles.fisher, 'Value');
                        if (flagfish == 0) % fisher

                            E = AnalyzWD(ff, xo, 0, flagsigma); 
                            B=E;
                        else            % fix max stepen
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
%             handles.wavedata(:,:,:,5) = wdata;
%             handles.maxm(5) = max(max(max(handles.wavedata(:,:,:,5))));
% 
% 
%             handles.matrix_without_trend(:,:,:,5) = wdata_wt;    
%             handles.maxm_wt(5) = max(max(max(handles.matrix_without_trend(:,:,:,5))));
% 
%             handles.minm_wt = min(min(min(handles.matrix_without_trend(:,:,:,5))));
%             guidata(hObject, handles);
            
            mat_en(5) = mat2cell(wdata);
            handles.maxm(5) = max(max(max(wdata)));
            guidata(hObject, handles);

            mat_wt(5) = mat2cell(wdata_wt);
            handles.maxm_wt(5) = max(max(max(wdata_wt)));
            handles.minm_wt(5) = min(min(min(wdata_wt)));
            guidata(hObject, handles);
    
    % Zapis v fail
     
    smstr = [int2str(sm(1)) int2str(sm(2)) int2str(sm(3)) int2str(sm(4))];
    filename = ['ANALYZED DATA' ' sm' smstr ' ' date_s ' d' int2str(dni) ' uf' int2str(sf) ' ut' int2str(st) ' obr' int2str(ol) ' ' int2str(or) ' ' int2str(ot) ' ' int2str(ob)  ' sigma' int2str(flagsigma)];
    filename = [filename ' pr' int2str(predel) ' ' 'cheb'  int2str(l) ' a' int2str(mina) '-' int2str(maxa) ' b' int2str(maxb) ' wt ' wave_type ' A' int2str(alpha) ' lev' int2str(level) ' thr' int2str(threshold) '.mat'];  
    
    filename 
 
    dat = handles.date;
%     maxm = max(max(max(wdata)));
%     AA = wdata;
%     wrow = wrow;
%  

      %Matrici intensivnostei
    maxm_intens = handles.maxm_intens; 
    
    clearvars handles.mat_intens handles.maxm_intens
        %max matr intens

 %Matrici bez trenda
    maxm_wt = handles.maxm_wt; 
    minm_wt = handles.minm_wt;
    
    clearvars handles.matrix_without_trend handles.maxm_wt handles.minm_wt

 %matrici energii
    maxm_en=handles.maxm;

    clearvars handles.wavedata handles.maxm

    save([pathname filename], 'mat_en','mat_wt','maxm_wt', 'minm_wt' ,'maxm_intens', 'mat_intens', 'wrow','dat','sm', 'dni', 'date_s0','maxm_en', 'maxa', 'mina', 'maxb', 'st', 'sf', 'ol', 'or', 'ot', 'ob', 'l', 'nullintervals', 'wave_type', 'alpha', 'level', 'threshold', 'flagsigma', 'masks', '-mat');

    clearvars mat_en mat_wt maxm_wt minm_wt maxm_intens mat_intens wrow dat sm dni date_s0 maxm_en maxa mina maxb st sf ol or ot ob l nullintervals wave_type alpha level threshold
    progress = ['Obrabotano ' num2str(nomer) ' strok']
    
    memUsed
end

toc
