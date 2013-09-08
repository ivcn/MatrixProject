%[name path] = uigetfile();
load('C:\Users\John\Documents\MATLAB\Data\матрицы 29.02.2012\ANALYZED DATA sm0001 01 04 2010 d10 uf2 ut2 obr1 0 10 35 pr10 cheb71 a1-36 b6.mat');
% data = mat_intens(:,:,:,4);
data_wt = mat_en(:,:,:,4);
%  figure();
%  imagesc(data(:,:,500));
%  
%  for i=1:size(data,1)
%       for j=1:size(data,2)
%           data(i,j,:) = SSA_Filter(data(i,j,:),1);
%       end
%  end
figure();
imagesc(data_wt(:,:,500));

im = data_wt(:,:,500);

for i=1:size(im,1)
    im(i,:) = SSA_Denoise(im(i,:),1);
end
for i=1:size(im,2)
    t = im(:,i);
    im(:,i) = (SSA_Denoise(t',1));
end

figure();
imagesc(im);