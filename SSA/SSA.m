x = 0:0.01:10;
y = sin(x);

yn = y+2*randn(size(y));

windowSize = floor(size(x,2)/4);
numberOfSteps = size(y,2)-windowSize+1;
numberOfComponents = 1;
Y = zeros(numberOfSteps,windowSize);%матрица пошагового движения

for i=1:numberOfSteps
    Y(i,:)=yn(i:i+windowSize-1);%заполняем матрицу
end
YTY = Y'*Y;
[eVec,eVal]=eig(YTY);%ищем сф и сз

eval_ = diag(eVal);
[eval ind] = sort(eval_);%отсортировали сз по убыванию.
evec = zeros(size(eVec));
for i=1:size(eVal)
    evec(:,i) = eVec(:,ind(i));
end

omega = zeros(windowSize,windowSize);   
for i=1:windowSize
    omega(:,i) = evec(:,windowSize-i+1);
end
V=Y*omega;

%выбор компонент
V_ = zeros(size(V));
SV = size(V,2);
V_(:,1:numberOfComponents) = V(:,1:numberOfComponents);%+1:SV);
%Y_=V(:,1:numberOfComponent)*omega(1:numberOfComponent,:);
Y_ = V_*omega';

y_ = zeros(1,size(x,2));

for i=1:windowSize%идем по столбцам
    for j=1:i%число элементов на диагонали равно номеру столбца
        y_(i)=y_(i)+Y_(i-j+1,j);%сумма элементов
    end
    y_(i)=y_(i)/i;%среднее
end
for i=windowSize+1:numberOfSteps
    for j=1:windowSize
        y_(i)=y_(i)+Y_(i-j+1,j);
    end
    y_(i)=y_(i)/windowSize;
end
for i=numberOfSteps+1:size(y,2)
    for j=1:windowSize-(i-numberOfSteps)
        y_(i)=y_(i)+Y_(numberOfSteps-j+1,1+i-numberOfSteps+j-1);
    end
    y_(i)=y_(i)/(windowSize-(i-numberOfSteps));
end



%for i=1:size(Y_,1)
 %   j=i;
  %  k=1;
 %   sum=0;
 %   cnt=0;
 %   while(j>=1)&&(k<=size(Y_,2))
 %       y_(i) = y_(i) + Y_(j,k);
 %       j = j-1;
 %       k=k+1;
 %   end
 %   y_(i) = y_(i)/i;
%end
%for i=2:windowSize
%    j=i;
%    k=1;
%    while(j<=size(Y_,2))&&(k<=size(Y_,1))
%        y_(numberOfSteps+i) = y_(numberOfSteps+i) + Y(k,j);
%        j=j+1;
%        k=k+1;
%    end
%    y_ = y_/(i-size(Y_,2)+1);
%end
subplot(211);
plot(x,yn);
subplot(212);
plot(x,y_);