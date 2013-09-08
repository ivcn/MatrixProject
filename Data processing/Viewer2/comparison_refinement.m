function [ output_array,characSer ] = comparison_refinement( input_array,tol )
%comparison_refinement Очистка массива изображений от импульсных шумов
%путем сравнения каждой картинки с предыдущей. Возвращает массив длиной на
%единицу меньше исходного.
%   Возвращает массив:) 
Nt = size(input_array,3);
Nx = size(input_array,1);
Ny = size(input_array,2);
%characSer - характер серий
%indSer - индекс серии
output_array = zeros(size(input_array));
tolerance = tol;
output_array(:,:,1) = input_array(:,:,1);
curNumPix = count(output_array(:,:,1));
characSer = zeros(size(input_array/2,3),1,2);
indSer = 1;
for t=2:Nt
    t
    for i=1:Nx
        for j=1:Ny
            if(input_array(i,j,t-1)==0)
                continue;
            end
            diff = difference(input_array,output_array,i,j,t);% = abs(input_array(i,j,t)-input_array(i,j,t-1))/input_array(i,j,t-1);
            if(diff <= tolerance)
                output_array(i,j,t) = input_array(i,j,t);
            else
                if(i<Nx)
                    if(difference(input_array,output_array,i+1,j,t) <= tolerance)
                        output_array(i+1,j,t) = input_array(i+1,j,t);
                    end
                    if(j<Ny)
                        if(difference(input_array,output_array,i+1,j+1,t) <= tolerance)
                            output_array(i+1,j+1,t) = input_array(i+1,j+1,t);
                        end
                    end
                    if(j>1)
                        if(difference(input_array,output_array,i+1,j-1,t) <= tolerance)
                            output_array(i+1,j-1,t) = input_array(i+1,j-1,t);
                        end
                    end
                end
                if(j<Ny)
                    if(difference(input_array,output_array,i,j+1,t) <= tolerance)
                        output_array(i,j+1,t) = input_array(i,j+1,t);
                    end
                end
                if(j>1)
                    if(difference(input_array,output_array,i,j-1,t) <= tolerance)
                        output_array(i,j-1,t) = input_array(i,j-1,t);
                    end
                end
                if(i>1)
                    if(difference(input_array,output_array,i-1,j,t) <= tolerance)
                        output_array(i-1,j,t) = input_array(i-1,j,t);
                    end
                    if(j<Ny)
                        if(difference(input_array,output_array,i-1,j+1,t) <= tolerance)
                            output_array(i-1,j+1,t) = input_array(i-1,j+1,t);
                        end
                    end
                    if(j>1)
                        if(difference(input_array,output_array,i-1,j-1,t) <= tolerance)
                            output_array(i-1,j-1,t) = input_array(i-1,j-1,t);
                        end
                    end
                end
            end
        end
    end
    a = count(output_array(:,:,t));%если число ненулевых точек уменьшилось наполовину,то
    %в эту выходную матрицу пихаем исходную и сравниваем далее уже с ней
    if( a < 0.5*curNumPix)
        output_array(:,:,t) = input_array(:,:,t);
        curNumPix = count(output_array(:,:,t));
        %сохраняем информацию о прошедщей серии
        if indSer == 1
            characSer(indSer,1,:) = [curNumPix (t-1)*10];
        else
            characSer(indSer,1,:) = [curNumPix (t-1)*10-characSer(indSer-1)]
        end
        indSer = indSer + 1;
    end
end

end
%-------------------------------------
function [out] = difference(input_array,output_array,i,j,t)
a=abs(input_array(i,j,t)-output_array(i,j,t-1));
b=input_array(i,j,t-1);
out = a/b;
end
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