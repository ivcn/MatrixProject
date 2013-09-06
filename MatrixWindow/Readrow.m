function A = Readrow()
%UNTITLED1 Summary of this function goes here
fid=fopen('E:\Veivlet tufanov\МО (17_5 мин) с поправкой на P\ИЗМИРАН.txt','rt');
    A=fscanf(fid,'%d');
fclose(fid); 

%  Detailed explanation goes here
