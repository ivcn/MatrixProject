%[filename pathname] = uigetfile('*.dat');
pathname='./';
filename='Press2011_09.dat';
fid = fopen(strcat(pathname,filename));
content = textscan(fid,'%s %s %f %f %f %f','commentStyle','//');
fclose(fid);
date = cell2mat(content{1});
time = cell2mat(content{2});
PD   = content{3};
TD   = content{4};
Pdatch=content{5};
Temp = content{6};

%date = datenum(date,'dd.mm.yyyy');
%time = datenum(time,'hh:mm:ss');
dateTime = strcat(date,{' '},time);
dateTime = datenum(dateTime,'dd.mm.yyyy HH:MM:SS');
tenMinutes = datenum('01.01.2012 00.10.00','dd.mm.yyyy HH.MM.SS')-datenum('01.01.2012 00.00.00','dd.mm.yyyy HH.MM.SS');

i=1;
PD_ten = [];
% while i<=size(dateTime,1)
%     t = dateTime(i);
%     sumVal=0;
%     count = 1;
%     while( i <= size(dateTime,1) && dateTime(i)-t<=tenMinutes)
%         sumVal = sumVal+PD(i);
%         count = count+1;
%         i=i+1;
%     end
%     meanVal = sumVal/count;
%     PD_ten = [PD_ten; meanVal];
% end

%����� ������� ���. ����� ��������� ����� � �������������� ��� ������ ��
%��������� 10 ���. �����  ��������� � ���������� 10 ���. � ����� ������
%������ ������� ����������� � ��������� ��������. ����� ������� �������
%������ ������� �� ������ 10 ���. ����� �� �������������� ����� ����� �����
%10-�������� ���������� � 30 ����.
startDate = strcat(date(1,:),{' '},'00:00:00');
startDate = datenum(startDate,'dd.mm.yyyy HH:MM:SS')
currentEndDate = addtodate(startDate,10,'minute')%startDate+tenMinutes
startDateArray = [];
i=1;
while currentEndDate < dateTime(end)
    startDateArray = [startDateArray; datestr(startDate,'dd.mm.yyyy HH:MM:SS')];
    sumVal = 0;
    count =1;
    while i<= size(dateTime,1) && dateTime(i)<=currentEndDate
        sumVal =sumVal+PD(i);
        count=count+1;
        i=i+1;
    end
    meanVal = sumVal/count;
    PD_ten = [PD_ten; meanVal];
    if i<=size(dateTime,1)
        startDate = dateTime(i);
        currentEndDate = addtodate(startDate,10,'minute');
    end
end

%���������� �� 30 ����
i=1;
PD_tenmin=[];
while i<=size(PD,1)
    j=1;
    sunVal = 0;
    count =1;
    while j<30 && i+j<=size(PD,1)
        sumVal = sumVal+PD(i+j);
        count = count+1;
        j=j+1;
    end
    i=i+j;
    meanVal = sumVal/count;
    PD_tenmin = [PD_tenmin; meanVal];
end