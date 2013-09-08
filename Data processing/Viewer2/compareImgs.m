function [ out featureOfSeries ] = compareImgs( in, tolerance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Nx = size(in,1);
Ny = size(in,2);
Nt = size(in,3);

out = zeros(size(in));
tol = tolerance;
out(:,:,1) = in(:,:,1);
numOfPix = count(out(:,:,1));
curNumOfPix = 0;
featureOfSeries = zeros(size(in,3),1);%характер серий
% indSer = 0;
for t = 2:Nt
    t
    for i=1:Nx
        for j=1:Ny
            if(in(i,j,t)==0)
                continue;
            end
            diff = difference(in,out,i,j,t);
            if(diff <= tol )
                out(i,j,t) = in(i,j,t);
                curNumOfPix = curNumOfPix + 1;
            else
                for k=-1:1
                    for l=-1:1
                        if( (k==-1)&&(i==1) ) continue; end
                        if( (k==1)&&(i==Nx) ) continue; end
                        if( (l==-1)&&(j==1) ) continue; end
                        if( (l==1)&&(j==Ny) ) continue; end
                        if(difference(in,out,i+k,j+l,t) <= tol)
                            out(i+k,j+l) = in(i+k,j+l);
                            curNumOfPix = curNumOfPix+1;
                        end
                    end
                end 
            end
        end
    end
    if(curNumOfPix < 0.5*numOfPix)
        %здесь число похожих точек уменьшилось больше чем наполовину
        %значит это уже новая матрица и надо сохранить в выходном массиве
        %именно ее, а не ее обработанную версию.Это начало новой серии.
        out(:,:,t) = in(:,:,t);
        numOfPix = count(out(:,:,t));%сохраняем число точек отличных от
        %нуля в этой картинке.
        %т.к. началась новая серия, надо сохранить информацию о ней
        %в массиве характеристик серий.
%         indSer = indSer+1;
%         featureOfSeries(indSer,1) = numOfPix;
%         featureOfSeries(indSer,2) = t;%сохраняем номер текущей картинки
    end
    curNumOfPix=0;
    featureOfSeries(t,1) = numOfPix;
    %featureOfSeries(indSer,2) = t;%сохраняем номер текущей картинки
end
% indSer = indSer+1;
% featureOfSeries(indSer,:)=-1;
end %end function

function [out] = difference(input_array,output_array,i,j,t)
a=abs(input_array(i,j,t)-output_array(i,j,t-1));
b=input_array(i,j,t-1);
out = a/b;
end

%число точек отличных от нуля в картинке
function [out] = count(input)
out = 0;
for i=1:size(input,1)
    for j=1:size(input,2)
        if(input(i,j) ~= 0)
            out = out+1;
        end
    end
end

end
