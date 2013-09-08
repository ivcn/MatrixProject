clear;
%close all;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
sig = mat_intens{4};
N1 = size(sig,1);
N2 = size(sig,2);
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;
s = pressure_correction(sig);

for t=1:Ntime
    ser(t) = mean(mean(s(:,:,t)));
end
figure(1);
plot(days,ser,'k');
title('Сигнал усредненный по матрицам');
sf = fourier_proc(ser,0,3000);
figure();
plot(days,sf,'k');
