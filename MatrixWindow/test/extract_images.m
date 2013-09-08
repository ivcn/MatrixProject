filename = 'ANALYZED DATA sm0001 01 04 2010 d10 uf2 ut2 obr1 0 10 20 pr5 cheb71 a1-36 b12_dwt3.mat';
load(filename, 'D','S');
position = 1426;
lims=[0,140];
name = 'images/im';
%imwrite(S(:,:,position),strcat('images/source.jpg','-',num2str(position),'.bmp'),'jpg');
figure();
imagesc(S(:,:,position),lims);
for i=1:size(D,2)
    %imwrite(D{i}(:,:,position),strcat(name,num2str(position),'-',num2str(i),'.jpg'),'jpg');%name+num2str(position)+num2str(i),'jpg');
    figure();
    imagesc(D{i}(:,:,position),lims);
end