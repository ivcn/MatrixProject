clear;
windowDays = 1;% движущееся окно в днях
step=1;%шаг движения
a1=139;
a2=147;
beta = -0.002;
p0=994;

sizeA=a2-a1+1;
window = windowDays*144;
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
%index = [];
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

%расчет индексов
pos_index=1;
index = zeros(1,(sizeT-window)/step);
h_index = zeros(1,(sizeT-window)/step);
d_index = zeros(1,(sizeT-window)/step);
for pos = 1:step:sizeT-window
    windowData = s(pos:pos+window);
    trend = ChebRazl(windowData,3,0);
    windowData = windowData-trend;
    %e = mycwt(windowData,a1,a2);
    %index(pos_index) = e(end);
    index(pos_index) = sum(AnalyzW(windowData,a1,a2,1,0));
    %index(pos_index) = sum(mycwt(windowData,a1,a2));
    h_index(pos_index) = estimate_hurst_exponent(windowData);
    d_index(pos_index) = std(windowData);
    pos_index=pos_index+1;
    
    progress = floor(pos_index./size(index,2)*100);
    if(rem(progress,10)==0)
        progress
    end
end

pos = 1:size(index,2);
pos = pos+window;
%x = (1+T:subinterval:1+(length(NF)-1)*subinterval+T);
%x = (window:step:1+(length(index)-1)*step+window);
%pos = window+(pos-1)*step;
days = (pos./144)+1;
figure();
plot(days,index,'k');
title('ener');
figure();
plot(days,h_index,'k');
title('hurst');
figure();
plot(days,d_index,'k');
title('disp');