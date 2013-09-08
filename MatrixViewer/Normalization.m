function [ out ] = Normalization( in )
%NORMALIZATION Нормализация матрицы.
%Рассчитывается среднее значение и сигма для каждой строки.
%Вычисляется разность каждого элемента от среднего, затем делится на сигму.
%В результате получается нормализованная матрица отклонений.
Nrow = size(in,1);
Ncol = size(in,2);
out = zeros(size(in));
for i=1:Nrow
    m = mean(in(i,:));
    s = std(in(i,:));
    for j=1:Ncol
        out(i,j) = (in(i,j)-m)/s;
    end
end

end

