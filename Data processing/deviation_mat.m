function [ deviationMatrix ] = deviation_mat( sourceIm, smoothIm )
%DEVIATION_MAT Вычисление матрицы отклонений изображения от его сглаженной
%версии
%   Detailed explanation goes here
if(size(sourceIm)~=size(smoothIm))
    error('MATLAB: size mismatch');
end
N = size(sourceIm,1)*size(sourceIm,2);
sum = 0; 
for i=1:size(sourceIm,1)
    for j=1:size(sourceIm,2)
    sum = sum + (sourceIm(i,j)-smoothIm(i,j))^2;
    end
end
sigma1=sqrt(sum/N);
%теперь идем по матрице, ищем точки в которых отклонение от первой сигмы
%превышает ее больше чем в k раз
sum=0;
k=2;% параметр отбора
for i=1:size(sourceIm,1)
    for j=1:size(sourceIm,2)
        if( (sourceIm(i,j)-smoothIm(i,j)) >= k*sigma1)
            continue;
        else
            sum = sum + (sourceIm(i,j)-smoothIm(i,j))^2;
        end
    end
end
sigma2=sqrt(sum/N);
%вторую сигму посчитали. строим матрицу отклонений
deviationMatrix = zeros(size(sourceIm));
for i=1:size(deviationMatrix,1)
    for j=1:size(deviationMatrix,2)
        deviationMatrix(i,j) = (sourceIm(i,j)-smoothIm(i,j))/sigma2;
    end
end
end
