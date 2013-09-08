clc;
%filename='ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut1 obr0 0 10 20 sigma1 pr5 cheb71 a1-36 b36 wt haar A3 lev5 thr0.mat';
%pathname='C:\Users\John\Documents\Матрицы\';
%load([pathname filename], 'mat_intens');
%im = mat_intens{4}(:,:,580);
N = 48;
x = -5:10/N:5;
y = -5:10/N:5;
field1 = zeros(N,N);
field2 = zeros(N,N);
field3 = zeros(N,N);
for i=1:N
    for j=1:N
        field1(i,j) = sin(2*pi*i/12)*sin(2*pi*j/12);
        field2(i,j) = 0.6.*sin(2*pi*i/6)*sin(2*pi*j/6);
        field3(i,j) = 0.4.*sin(2*pi*i/4+2*pi*j/8);
    end
end
figure(1);
imagesc(field1);
colorbar();
figure(2);
imagesc(field2);
colorbar();
figure(3);
imagesc(field3);
colorbar();

field = field1+field2+field3;
im=field;
figure(4);
imagesc(im);
colorbar();
result4 = SSA_2D(im,4);
result6 = SSA_2D(im,6);
result10 = SSA_2D(im,10);
figure();
imagesc(result4);
colorbar();
%title('тренд');
figure();
imagesc(result6-result4);
colorbar();
%title('разность1');
figure();
imagesc(result10-result6);
colorbar();
%title('разность2');
figure();
imagesc(field-result10);
colorbar();
%title('Остаток')

%norm_im = Normalization(im-result);
%figure();
%imagesc(norm_im)
%title('нормализованное');

%fil = fspecial('gaussian',[10 10],2);
%sm_im = imfilter(norm_im,fil,'replicate');

%figure();
%imagesc(sm_im);