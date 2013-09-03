function [ B ] = Ukrupmatr( A,ly, lx )
%lt,lf - сколько €чеек суммируем по x,y
%UKRUPMATR Summary of this function goes here
%   Detailed explanation goes here
   % k=floor(size(A,1)/l);   % количество €чеек в новой матрице
   k1=floor(size(A,1)/lx);   % количество €чеек в новой матрице
   k2=floor(size(A,2)/ly);   % количество €чеек в новой матрице
    B=[];
    Bt=[];
    for i=1:k1
        for j=1:k2
            At = sum(sum(A((i-1)*lx+1:(i-1)*lx+lx, (j-1)*ly+1:(j-1)*ly+ly)));
            Bt=[Bt At];
            if (j==k2)
                B=[B ; Bt];
                Bt=[];         
            end
        end
    end
    

end

