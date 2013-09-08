function [ output ] = cubicSplineSmooth1D( x, input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = size(input,2);
%краевое условие 2
u1 = 1;
u2 = 0;
v1 = 0;
v2 = 1;
D1 = 0;
D2 = 0;

%задаем матрицу ј
A = zeros(N,N);
%перва€ строка
A(1,1) = u1;
A(1,2) = u2;
%последн€€ строка
A(N,N) = v2;
A(N,N-1) = v1;
%все остальное
for i=2:N-1
    A(i,i-1) = (x(i)-x(i-1))/6;%hi-1/6
    A(i,i) = ((x(i)-x(i-1)) + (x(i+1)-x(i)))/3;% (hi-1+hi)/3
    A(i,i+1) = (x(i+1)-x(i))/6; %hi/6
end

%задаем матрицу H
H = zeros(N,N);
%перва€ и последн€€ строки-нулевые
%остальное
for i=2:N-1
    H(i,i-1) = 1/(x(i)-x(i-1));% 1/hi-1
    H(i,i) = -( 1/(x(i)-x(i-1)) + 1/(x(i+1)-x(i)) ); %-(1/hi-1 - 1/hi)
    H(i,i+1) = 1/(x(i+1)-x(i)); %1/hi
end

%задаем матрицу K
K = zeros(N,N);
for i=1:N
    K(i,i) = 0.25;
end

%альфа-параметр сглаживани€
alpha = 100;

%задаем вектор-столбец f
f = zeros(N,1);
f(1) = D1;
f(N) = D2;

%пишем систему
MatrixOfSystem = A+alpha*H*K*H';
rightVector = H*input' + f;
M = MatrixOfSystem\rightVector;
Sal = input' - alpha*K*H'*M;%значени€ сплайнов в исходных точках xi

%ищем коэффициенты сплайнов
% b = zeros(1,N-1);
% c = zeros(1,N-1);
% d = zeros(1,N-1);
% for i=1:N-1
%     h = x(i+1)-x(i);
%     b(i) = (Sal(i+1)-Sal(i))/h - h*(M(i+1)+2*M(i))/6;
%     c(i) = M(i)/2;
%     d(i) = (M(i+1) - M(i))/(6*h);
% end

output = Sal;
end

