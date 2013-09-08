function [ output ] = calcDistBetwPoints_A( in )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Вычисленияе среднего расстояния между точками
%границы не учитываются

Nx = size(in,2);
Ny = size(in,1);
Nt = size(in,3);
%global_dist = 0;
%dist_x = 0;
%count_x=0;
%dist_y = 0;
%count_y = 0;
Rx = zeros(1,Ny);
Ry = zeros(1,Nx);
output = zeros(2,size(in,3));

for t=1:Nt
    t
    %считаем расстояние вдоль оси икс
    %т.е. вдоль каждой строки
    for j=1:Ny
        [Rx(j) c] = distInSeq(in(j,:,t));
        %Rx(j) - среднее расстояние в строке
        %c - кол-во  расстояний в строке
        %dist_x = dist_x+;%сумма средних расстояний
        %count_x  = count_x+c;%общее число расстояний по икс
    end
    %теперь идем по столбцам
    for j=1:Nx
        [Ry(j) c] = distInSeq(in(:,j,t));
        %dist = Ry(j)/c;
        %dist_y = dist_y+dist;
        %count_y = count_y+c;
    end
    %здесь считаем среднее от всех расстояний
    %надо уточнить это ли надо. или стоит сначала усреднить по каждой 
    %строке
    %global_dist = (dist_x+dist_y)/(count_x+count_y);
    Sigma_x = std(Rx);%сигма от средних расстояний
    mean_x = mean(Rx);%усредняем по строкам
    Sigma_y = std(Ry);
    mean_y = mean(Ry);%по столбцам
    R = sqrt(mean_x^2+mean_y^2);
    Sigma = sqrt(Sigma_x^2+Sigma_y^2);
    output(:,t) = [R Sigma];
end

end %end function
%//////////////////////////////////////////////////////////////////////
%расчет среднего расстояния между ненулевыми точками в произвольной 
%последовательности. Части которые примыкают к границам не учитываются.
%//////////////////////////////////////////////////////////////////////
function [out count] = distInSeq(seq)
i=1;
while( (i<=size(seq,2)) && (seq(i)==0) )
    i=i+1;%поиск первой ненулевой точки
end
if(i>=size(seq,2))%если мы ушли за границу, значит таких точек нет
    out = 0;%среднее расстояние 0?????!!!!!
    count =0;
    %никак его не учитываем
    %надо это уточнить
    return;
end
d_total=0;
d_count =0;
d=0;
while(true)
    prev_i=i;%сохраняем позицию ненулевой точки
    i = i+1;%переходим на cледующую точку. она должна быть =0
    d=0;%обнуляем расстояние
    while (i<size(seq,2)) && (seq(i)==0) 
        i=i+1;%ищем следующую ненулевую точку
    end
    %теперь в i лежит либо следующая ненулевая точка, либо конец строки
    if(i >= size(seq)) 
        break;%если это конец строки, прекращаем искать точки
        %и считать среднее.
    end
    %если еще не конец т.е. нашли точку
    d=i-prev_i-1;%считаем текущее расстояние
    d_total = d_total+d;%увеличиваем сумму расстояний
    d_count = d_count+1;%увеличиваем счетчик расстояний 
end
%если в послед-ти всего 1 точка, то число промежутков будет 0
%делить нельзя
if(d_count==0)
    out=0;
    count = 0;
    return;
end
out = d_total/d_count;%считаем среднее расстояние
%out = d_total;
count = d_count;
end%end subfunction