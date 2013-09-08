pathname = 'C:\Users\John\Documents\MATLAB\Матрицы\PRESSURE_2011_SM4\';

startDate_str = '1.09.2011';%включительно
endDate_str   = '1.10.2011';%от этой даты войдет временная точка 00:00

%формируем список нужных файлов
date = startDate_str;
filename = '';
while(datenum(date,'dd.mm.yyyy') <= datenum(endDate_str,'dd.mm.yyyy'))
    vec = datevec(date,'dd.mm.yyyy');
    y = vec(1);
    m = vec(2);
    y_str = num2str(rem(y,2000));
    if(m<10)
        m_str = strcat('0',num2str(m));
    else
        m_str = strcat(num2str(m));
    end
    filename = [filename; strcat(y_str,m_str,'S4','.dat')];
    date = datestr(addtodate(datenum(date,'dd.mm.yyyy'),1,'month'),'dd.mm.yyyy');
end
temp = datevec(endDate_str,'dd.mm.yyyy');
if( temp(3) == 1)
    %правый конец на границе месяцев
    %надо добавить еще месяц
    vec = datevec(date,'dd.mm.yyyy');
    y = vec(1);
    m = vec(2);
    y_str = num2str(rem(y,2000));
    if(m<10)
        m_str = strcat('0',num2str(m));
    else
        m_str = strcat(num2str(m));
    end
    filename = [filename; strcat(y_str,m_str,'S4','.dat')];
end

%извлекаем данные из файлов
date=[];
pressure=[];
for i =1:size(filename,1)
    fid = fopen(strcat('./',filename(i,:)));
    data = textscan(fid,'%s %s %f %f %f %f %*[^\n]','CommentStyle','//');
    fclose(fid);
    %temp = strcat(cell2mat(data{1}),32,cell2mat(data{2}));
    date = [date; strcat(cell2mat(data{1}),32,cell2mat(data{2}))];
    pressure = [pressure; data{3}];
end

%Выбираем нужные даты

indexes=1:size(date,1);
idx1 = indexes(datenum(date,'dd-mm-yy HH:MM')>=datenum(startDate_str,'dd.mm.yyyy'));
idx2 = indexes(datenum(date,'dd-mm-yy HH:MM')<=datenum(endDate_str,'dd.mm.yyyy'));
idx = intersect(idx1,idx2)';

needed_date = date(idx,:);
needed_pressure = pressure(idx);

%pressure = data{3};
%noncorrected = data{4};
%corrected = data{6};
%nums = 1:size(pressure,1);

filename = filename(1:end-4);
fid = fopen(strcat('pressure_',startDate_str,'_',endDate_str,'.txt'),'w');
for i=1:size(needed_pressure,1)
    fprintf(fid,'%f\t%f\n',i,needed_pressure(i));
end
fclose(fid);

%fid = fopen(strcat('muons_corr_',startDate_str,endDate_str,'.txt'),'w');
%for i=1:size(nums,1)
%    fprintf(fid,'%f\t%f\n',nums(i),corrected(i));
%end
%fclose(fid);