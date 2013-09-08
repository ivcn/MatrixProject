[Lo_D, Hi_D, Lo_R, Hi_R]=wfilters('db2');
im=imread('Cover.jpg');
im=rgb2gray(im);
figure(1);
imagesc(im);
[C,S] = wavedec2(im,2,Lo_D);
im0 = waverec2(C,S,Lo_R);
figure(2);
imagesc(im0);
