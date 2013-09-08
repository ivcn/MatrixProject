function [ output ] = wavelet3DSmooth( input, level )
%wavelet3DSmooth Трехмерное вейвлет-сглаживание
%   Функция принимает трехмерный сигнал input и уровень
%   вейвлет-разложение level.
%   Возвращает трехмерный сглаженный массив output
%   Рекомендуемое значение level - 2
output = zeros(size(input));
wname = 'db8';%вейвлет
WT_signal=wavedec3(input,level,wname);%трехмерное вейвдет-разложение до
%уровня level

 A = waverec3(WT_signal,'aaa');% восстановление сигнала по
%коэффициентам аппроксимации последнего уровня.
% aaa - аппроксимация по x,y и z

output = A;

end