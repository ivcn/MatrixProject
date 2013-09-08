[filename pathname]=uigetfile('*.mat');
load(strcat(pathname,filename),'B');
sig = B;
%ms1 = sum(sig,1);
%ms2 = sum(ms1,2);
ms = floor(sig);

fid = fopen('1_30сент€бр€ 2011.txt','w');
fprintf(fid,'%f\n',ms);
fclose(fid);