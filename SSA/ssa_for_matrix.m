filename='ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut1 obr0 0 10 20 sigma1 pr5 cheb71 a1-36 b36 wt haar A3 lev5 thr0.mat';
pathname='C:\Users\John\Documents\Матрицы\';
load([pathname filename], 'mat_intens');
numberOfComponents = 2;
Y = mat_intens{4}(:,:,747);
YTY = Y'*Y;
[eVec,eVal]=eig(YTY);%ищем сф и сз
figure();
eval_ = diag(eVal);
plot(eval_,'o');
[eval ind] = sort(eval_,'descend');%отсортировали сз по убыванию.
evec = zeros(size(eVec));
for i=1:size(eVal)
    evec(:,i) = eVec(:,ind(i));
end
omega = zeros(size(Y,2),size(Y,2));   
for i=1:size(Y,1)
    omega(:,i) = eVec(:,size(Y,2)-i+1);
end
V=Y*omega;

%выбор компонент
V_ = zeros(size(V));
SV = size(V,2);
V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);
%Y_=V(:,1:numberOfComponent)*omega(1:numberOfComponent,:);
Y_ = V_*omega';
figure();
imagesc(Y);
figure();
imagesc(Y_);
h = fspecial('gaussian',10,5);
B = imfilter(Y_,h);
figure();
imagesc(B);