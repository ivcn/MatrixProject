function [ output ] = calcDistBetwPoints_B( input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Nx = size(input,2);
Ny = size(input,1);
Nt = size(input,3);
%global_dist = 0;
%dist_x = 0;
%count_x=0;
%dist_y = 0;
%count_y = 0;
Rx = zeros(1,Ny);
Ry = zeros(1,Nx);
output = zeros(2,size(input,3));

for t=1:Nt
    %считаем расстояние вдоль оси икс
    %т.е. вдоль каждой строки
    for j=1:Ny
        [Rx(j) c] = distInSeq(input(j,:,t));
        %Rx(j) - среднее расстояние в строке
        %c - кол-во  расстояний в строке
        %dist_x = dist_x+;%сумма средних расстояний
        %count_x  = count_x+c;%общее число расстояний по икс
    end
    %теперь идем по столбцам
    for j=1:Nx
        [Ry(j) c] = distInSeq(input(:,j,t));
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
    R = sqrt(mean_x.^2+mean_y.^2);
    Sigma = sqrt(Sigma_x^2+Sigma_y^2);
    output(:,t) = [R Sigma];
end
end%end function

function [out count] = distInSeq(seq)
d_total = 0;
d_count = 0;
i = 1;
while(true)
    prev_i=i;%сохраняем позицию ненулевой точки
    i = i+1;%переходим на cледующую точку. она,предположительно !=0
    d=0;%обнуляем расстояние
    while( (i<size(seq,2))&&(seq(i)==0) )
        i=i+1;%ищем следующую ненулевую точку
    end
    %теперь в i лежит либо следующая ненулевая точка, либо конец строки
    %если еще не конец т.е. нашли точку
    d=i-prev_i-1;%считаем текущее расстояние
    d_total = d_total+d;%увеличиваем сумму расстояний
    d_count = d_count+1;%увеличиваем счетчик расстояний 
    if(i >= size(seq))
        break;%если это конец строки, прекращаем искать точки
    end
end
%если в последовательности нет точек
if(d_count==0)
    out=size(seq);
    count = 0;
    return;
end
out = d_total/d_count;%считаем среднее расстояние
count = d_count;
end%end subfunction