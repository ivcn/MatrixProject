function [K] = ApproxWDSSA(A,T,m) 

%K - отклонени€ от теоретического тренда
%m - размер окна
%%T - теоретический тренд
% k = 0 - использу€ критерий ‘ишера, иначе k - макс степень полинома
n = size(A,2);   % количество точек р€да
%UNTITLED1 Summary of this function goes here

nx = 1; % Ќачало окна
K=zeros(1,n);
while (nx+m-1)<=n
    F = SSA_det(A(1, nx:nx+m-1),1);     %%  –аскладываем функцию в окне SSA методом
    K(1,nx)=sum(abs(F-T(nx:nx+m-1)))/m;       %% Ќаходим отклонение от теоретического тренда
    nx = nx+1;
end

    



