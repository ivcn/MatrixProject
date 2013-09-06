function [ k,rowsitog, itognullintervals, mat_intens, itogmasks ] = ExtractRows(date, n, dir, msizex, msizey,sf, st, ol, or, ot, ob, sm, polosi)
%date - дата начала
% n - количество дней 
% dir - путь к папке с программой извлечения матриц
% msize - размер центральной части матрицы, которую берем (по 2-м осям)
% sf,st - размерность ячейки итоговой матрицы(сколько ячеек суммируем в одну)
% sm - номер супермодуля
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

%rowsitog = zeros(msizex*msizey, 144*n, 4);
rowsitog = cell(1,5);
%mat_intens=[];
mat_intens=cell(1,5);
date1 = datevec(addtodate(datenum(date),n-1,'day'));
date1(4)=23;
date1(5)=59;
count = [91 91];
itognullintervals=cell(1,4);
itogmasks = cell(1,4);

%dirname = [int2str(date(1)) num2str(date(2),'%05.2d') num2str(date(3),'%05.2d') num2str(date(4),'%05.2d') num2str(date(5),'%05.2d') '_' int2str(date1(1)) num2str(date1(2),'%05.2d') num2str(date1(3),'%05.2d') num2str(date1(4),'%05.2d') num2str(date1(5),'%05.2d')];

for cursm = 1:4
    if sm(cursm)~=0  
        dirname = ['urgmatr\sm' int2str(cursm)];

        rows=zeros(msizex*msizey,144*n);
        
        
        k = 0;
        for i = 0:1:n-1
            datet = datevec(addtodate(datenum(date),i,'day'));
            year = num2str(datet(1),'%05.2d');
            filename = [num2str(datet(3),'%05.2d') '_' num2str(datet(2),'%05.2d') '_' year(3:4) '_00_00'];
            path = [dir '\' dirname '\' filename '.bin']

            fid=fopen(path,'rb');
           % Apred = zeros(91,91);
            while(~feof(fid))
               A = fread(fid, count,'ulong');%читаем матрицу
               if (size(A,2)==91)
                   k= k + 1;

%                    if sum(sum(A))==0
%                        A=Apred;
%                    else
%                        Apred=A;
%                    end

                   if (polosi~=0)      % Убираем полосы
                       A(23,:)=(A(22,:)+A(24,:))/2;
                       A(46,:)=(A(45,:)+A(47,:))/2;
                       A(68,:)=(A(67,:)+A(69,:))/2;
                       A(91,:)=(A(90,:)+A(1,:))/2;
                   end

                   A = A(or+1:91-ol,ot+1:91-ob) ;%обрезаем матрицу           
                   A=Ukrupmatr(A,st,sf) ;      %укрупняем матрицу
                   A=rot90(A,-1);%поворачиваем на 90 градусов влево
                   A=flipud(A);%переворачиваем матрицу
                   %mat_intens(:,:,k,cursm) = A;
                  % cur_mat_intens(:,:,k) = A;
                   
    %                msizex
    %                msizey
    %                size(A)
                   %lowindex = floor(size(A,2)/2)+1-floor(msize/2);
                   %A=A(lowindex:1:lowindex+msize-1,lowindex:1:lowindex+msize-1);
                   for y = 1:msizey
                     for x = 1:msizex
                        %rows(x*y,k)=A(x,y);
                        rows((y-1)*msizex+x,k)=A(y,x);
                     end
                   end

               end    
            end
%             if sum(sum(rows(:,144*n)))==0
%                 rows(:,144*n)= rows(:,144*n-1);
%             end
            fclose(fid);   
            
        end
        %/////////////////////OBRABOTKA DIROK /////////////////////////
        
        %1) Esli v nachale - 0
        nullintervals=[];
        kk = 1; %1-iy nenulevoy element
        for y = 1:msizey
            for x = 1:msizex
                if (kk == 1)
                    if(max(rows((y-1)*msizex+x, :))>100)
                        if (rows((y-1)*msizex+x, 1)==0)                        
                            while(rows((y-1)*msizex+x, kk)==0)
                                kk=kk+1; 
                            end
                        end
                    end
                end
            end
        end
        
        if (kk>1)
            for y = 1:msizey
                for x = 1:msizex
                    temp = rows((y-1)*msizex+x, kk);
                    for i=1:kk-1
                       rows((y-1)*msizex+x, i)=temp; 
                    end
                end
            end
            nullintervals=[nullintervals ; 1 kk-1];   
        end                   
                    
                   
        %2) Esli v seredine - 0
        
        kk=1; %1 element = 0 v seredine
        
        Gx=1;
        Gy=1;
        while(max(rows((Gy-1)*msizex+Gx, :))<100)
            Gx=Gx+1;
            Gy=Gy+1;
        end
        
        i=1;
        while (i<=144*n)
            if(rows((Gy-1)*msizex+Gx, i)==0)
                xl = i;
                xr = i+1;
                if (xr>144*n)
                    xr=144*n;
                end
                while((rows((Gy-1)*msizex+Gx, xr)==0) && (xr<144*n))
                    xr=xr+1;
                end
                
                i=xr;
                
                if (xr==n*144)
                    nullintervals=[nullintervals ; xl xr];
                else
                    nullintervals=[nullintervals ; xl xr-1];
                end
            end
            i=i+1;
        end
        
        nullintervals
        for i=1:size(nullintervals,1)
        if nullintervals(i,1)~=1    
            xl = nullintervals(i,1);
            xr = nullintervals(i,2);
             for y = 1:msizey
                for x = 1:msizex            
                    el = rows((y-1)*msizex+x, xl-1);
                    K=0;
                    B=el;
                    if xr==n*144
                        er=el;                   
                    else
                        er=rows((y-1)*msizex+x, xr+1);
                        K = (er-el)/(xr-xl+2);
                        B=el-K*(xl-1);
                    end
                    %soedinyaem y=Kx+B
                    for j=xl:xr
                        rows((y-1)*msizex+x, j)=K*j+B;
                    end
                end
             end
        end
        end
                           
%         for y = 1:msizey
%             for x = 1:msizex
%                 if (kk == 1)
%                     if(max(rows((y-1)*msizex+x, :))>10)
%                         i = 1;
%                         while((rows((y-1)*msizex+x, i)==0) && (i<=144*n))
%                             i=i+1;
%                         end
%                         if i~=144*n
%                             kk=i;                
        %/////////////////////////////////////////////////////////////
        
        %///// Maski Uragana //////
        
        masks = [];
        start_month = date(2);
        end_month = date1(2);
        start_year = num2str(date(1));
        
        for curm = start_month:end_month     
            dir_month = 'uragan_masks';
            file_month = [start_year(3:4) num2str(curm,'%05.2d') '_' num2str(cursm-1) '.mask'];
            path_month = [dir '\' dir_month '\' file_month]
            fid = fopen(path_month);
            first_line = fgetl(fid);
            Mask = fscanf(fid, '%d-%d-%d %d:%d	%d-%d-%d %d:%d', [10, inf]);
            for i = 1:size(Mask, 2)
                datefrom = [2000+Mask(3,i) Mask(2,i) Mask(1,i) Mask(4,i) Mask(5,i) 0]
                dateto = [2000+Mask(8,i) Mask(7,i) Mask(6,i) Mask(9,i) Mask(10,i) 0]
                
               %date
                datediff = datenum(datefrom) - datenum(date);
                from_datediff = round(datediff*24*6)
                
                datediff = datenum(dateto) - datenum(date);
                to_datediff = round(datediff*24*6)
                
                maxn = n*144;
                if (from_datediff <= maxn)
                    if (to_datediff >=maxn)
                        to_datediff = maxn;
                    end
                    masks = [masks; from_datediff to_datediff];
                end
            end
            
        end
        
        masks
        %/////////////////////////////////////////////////////////////
        
        cur_mat_intens=zeros(msizey, msizex, n);
        
        for t = 1:1:k
            for y = 1:msizey
                for x = 1:msizex
                    A(y,x) = rows((y-1)*msizex+x,t);
                end
            end
            cur_mat_intens(:,:,t) = A;
        end
        
        rowsitog(cursm)=mat2cell(rows);
        clear('rows');
        itognullintervals(cursm) = mat2cell(nullintervals);
        itogmasks(cursm) = mat2cell(masks);
        mat_intens(cursm)=mat2cell(cur_mat_intens);
        
        
        
        
    end
end
 

