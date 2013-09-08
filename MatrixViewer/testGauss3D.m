load('../../Data/1 апреля 2010/ANALYZED DATA sm0001 01 04 2010 d15 uf1 ut1 obr1 0 15 45 sigma0 pr5 cheb_maxpow25 a1-36 b36','mat_intens');
sig=mat_intens{4};
r = gaussFilter3D(sig,6,6,3,2);

figure();
imagesc(r(:,:,1));
figure();
imagesc(r(:,:,2));