clear;
windowDays = 1;% движущееся окно в днях
step=1;%шаг движения
a1=1;
a2=36;
beta = -0.002;
p0=994;

sizeA=a2-a1+1;
window = 4*a2;%windowDays*144;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');

[filename pathname] = uigetfile('*.txt');
pressure_data = dlmread(strcat(pathname,filename));
pressure = pressure_data(:,2)';

signal = mat_intens{4};
sizeR = size(signal,1);
sizeC = size(signal,2);
sizeT = size(signal,3);
days = (1:sizeT)./144+1;
index = [];
windowData=zeros(window+1,sizeT/step);
energy = zeros(window+1,sizeT/step);
s= zeros(1,sizeT);
for i=1:sizeT
    s(i) = sum(sum(signal(:,:,i)));
end
figure();
plot(days,s,'k');
title('Исходный ряд')

%поправка на давление
for t =1:size(s,2)
    %s2(t) = s(t)*(1+beta*(pressure(t)-p0));%pressure(1)));
    s(t) = s(t)-beta*s(1)*(pressure(t)-p0);
end
figure();
plot(days,s,'k');
title('после поправки');

%расчет индекса
index = zeros(1,sizeT);
for pos = 1:sizeT
    index(pos) = getIndex(s,pos,a1,a2,window);
    pos/sizeT*100
end

pos = 1:size(index,2);
days = (pos./144)+1;
figure();
plot(days,index,'k');
title(strcat('1-side energy',num2str(a1),'-',num2str(a2)));