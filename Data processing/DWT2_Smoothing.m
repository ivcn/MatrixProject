function [ smoothSignal ] = DWT2_Smoothing( sourceSignal )
%DWT2_Smoothing Сглаживание каждого члена 3-мерного временного ряда
%двумерным вейвлет-преобразованием 
%Возвращает трехмерный массив сглаженных изображений
smoothSignal = zeros(size(sourceSignal));
wname = 'db5';%вейвлет
thr = 90;
sorh = 's';
keepapp = 1;
level = 2;

for i=1:size(sourceSignal,3)
   % [thr,sorh,keepapp] = ddencmp('den','wv',sourceSignal(:,:,i));%параметры по умолчанию.Пока так.
    smoothSignal(:,:,i) = wdencmp('gbl',sourceSignal(:,:,i),wname,level,thr,sorh,keepapp);
end
%den значит de-noising
%wv значит обычный вейвлет, не пакетный
%thr - порог ддля коффициентов
%sorh - вид порога. жесткий или мягкий: 's' & 'h'
%keepapp - сохранять или нет коэффициенты аппроксимации
end

