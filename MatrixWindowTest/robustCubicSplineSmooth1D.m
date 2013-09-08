function [ S ] = robustCubicSplineSmooth1D( input, alpha )
%ROBUSTCUBICSPLINESMOOTH1D Summary of this function goes here
%   Detailed explanation goes here
h=1;
N=size(input,2);
sig = 1;
alpha = 0.5;
R=2;
A0=zeros(N-2);%заполняем матрицу A0
for i=1:N-3
    for j=1:N-2
        if i==j
            A0(i,j)=1/sig^2+2*alpha/h;
            A0(i,j+1)=-alpha/h;
            A0(i+1,j)=-alpha/h;
        end
    end
end
A0(N-2,N-2)=1/sig^2+2*alpha/h;
F0=zeros(1,N-2);%начальное приближение
F0=F0';
F0=zeros(1,N-2);%начальное приближение
F0=F0';
F0(1)=input(2)/sig^2+alpha*input(1)/h;
F0(N-2)=input(N-1)/sig^2+(alpha/h)*input(N);
for i=2:N-3
    F0(i)=input(i+1)/sig^2;
end

S01=zeros(1,N-2);%здесь будет постепенно вычисляться робастный сплайн
y1=zeros(1,N);%это будет меняться на каждой итерации
F01=zeros(1,N-2);%и это тоже
F01=F01';

for i=1:50
    S01=A0\F0;%решаем систему
   for j=2:N-1%по этому решению в цикле вычисляем новый массив значений функции
       if abs(input(j)-S01(j-1))<R*sig
           y1(j)=input(j);
       end
       if abs(input(j)-S01(j-1))>R*sig
           y1(j)=S01(j-1);
       end
   end
   F01(1)=y1(2)/sig^2+alpha*y1(1)/h;%по этому массиву строим новый столбец свободных членов
   F01(N-2)=y1(N-1)/sig^2+alpha*y1(N)/h;
   for k=2:N-3
       F01(k)=y1(k+1)/sig^2;
   end
   F0=F01;%присваиваем старому столбцу новый и решаем систему заново
end
S=zeros(1,N);
S(1)=input(1);
S(N)=input(N);
S(2:N-1)=S01;
end