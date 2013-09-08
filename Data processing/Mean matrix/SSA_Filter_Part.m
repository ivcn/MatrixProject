function [ output ] = SSA_Filter_Part(input,partSize,componentNumber )
%SSA_FILTER_PART Summary of this function goes here
%  Удаление тренда(низкочастотной компоненты) одномерной функции методом
%  спектрально-сингулярного анализа. Исходный ряд разбивается на части,
%  размером partSize. К каждой части по отдельности применяется ssa.
%  inputSeries - входной одномерный временной ряд
%  numberOfComponents  число удаляемых компонент(я удалял 1)
output = zeros(size(input));
N = size(input,2);
partIndex = 1;
part = zeros(1,partSize);
while(partIndex+partSize-1<=N)
    part = input(partIndex:partIndex+partSize-1);
    output(partIndex:partIndex+partSize-1) = ssa(part,componentNumber);
    partIndex = partIndex + partSize;
end
if (partIndex < N)
    part = zeros(N-partIndex);
    part = input(partIndex:N);
    output(partIndex:N) = ssa(part,componentNumber);
end
%--------------------------------------------------------------------------

%plot(outputSeries);
%считаем сигму и делим на нее
%sigma = std(outputSeries);
%outputSeries = outputSeries/sigma;

end
%==========================================================================
function [outputSeries] = ssa(inputSeries,numberOfComponents)
%dim = ndims(inputSeries);%число измерений в массиве
a=size(inputSeries,2);%число элементов в последнему измерению
windowSize = floor(a/4);%размер окна
numberOfSteps = size(inputSeries,2)-windowSize+1;
Y = zeros(numberOfSteps,windowSize);%матрица пошагового движения

for i=1:numberOfSteps
    Y(i,:)=inputSeries(i:i+windowSize-1);%заполняем матрицу
end
YTY = Y'*Y;
[eVec,eVal]=eig(YTY);%ищем сф и сз

eval_ = diag(eVal);
[eval ind] = sort(eval_,'descend');%отсортировали сз по убыванию.
evec = zeros(size(eVec));
for i=1:size(eVal)
    evec(:,i) = eVec(:,ind(i));
end
% figure(30);
% plot(eval,'--ko');
%title('Собственные значения');

omega = zeros(windowSize,windowSize);   
for i=1:windowSize
    %omega(:,i) = evec(:,windowSize-i+1);
    omega(:,i) = evec(:,i);
end
V=Y*omega;

%выбор компонент
V_ = zeros(size(V));
SV = size(V,2);
V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);%+1:SV
%Y_=V(:,1:numberOfComponent)*omega(1:numberOfComponent,:);
Y_ = V_*omega';

outputSeries = zeros(1,size(inputSeries,2));

for i=1:windowSize%идем по столбцам
    for j=1:i%число элементов на диагонали равно номеру столбца
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);%сумма элементов
    end
    outputSeries(i)=outputSeries(i)/i;%среднее
end
for i=windowSize+1:numberOfSteps
    for j=1:windowSize
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);
    end
    outputSeries(i)=outputSeries(i)/windowSize;
end
for i=numberOfSteps+1:size(inputSeries,2)
    for j=1:windowSize-(i-numberOfSteps)
        outputSeries(i)=outputSeries(i)+Y_(numberOfSteps-j+1,1+i-numberOfSteps+j-1);
    end
    outputSeries(i)=outputSeries(i)/(windowSize-(i-numberOfSteps));
end
end