function [ k,data ] = ExtractMatrix(date, n, dir, msize)
%date - дата начала
% n - количество дней 
% dir - путь к папке с программой извлечения матриц
% msize - размер центральной части матрицы, которую берем
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here


date1 = datevec(addtodate(datenum(date),n-1,'day'));
date1(4)=23;
date1(5)=59;
count = [91 91];
%dirname = [int2str(date(1)) num2str(date(2),'%05.2d') num2str(date(3),'%05.2d') num2str(date(4),'%05.2d') num2str(date(5),'%05.2d') '_' int2str(date1(1)) num2str(date1(2),'%05.2d') num2str(date1(3),'%05.2d') num2str(date1(4),'%05.2d') num2str(date1(5),'%05.2d')];
dirname = '';

data=zeros(msize,msize,144*n);

k = 0;
for i = 0:1:n-1
        datet = datevec(addtodate(datenum(date),i,'day'));
        year = num2str(datet(1),'%05.2d');
        filename = [num2str(datet(3),'%05.2d') '_' num2str(datet(2),'%05.2d') '_' year(3:4) '_00_00'];
        path = [dir '\' dirname '\' filename '.bin']
        
        fid=fopen(path,'rb');
        
        while(~feof(fid))
           A = fread(fid, count,'ulong');
           %if (size(A,2)==91)
               k= k + 1;
               lowindex = 46-floor(msize/2);
               A=A(lowindex:1:lowindex+msize-1,lowindex:1:lowindex+msize-1);
               data(:,:,k)=A;
         
          % end    
        end
        fclose(fid);        
    end
end
 

