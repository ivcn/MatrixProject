function A = Readrow()
%UNTITLED1 Summary of this function goes here
fid=fopen('E:\Veivlet tufanov\�� (17_5 ���) � ��������� �� P\�������.txt','rt');
    A=fscanf(fid,'%d');
fclose(fid); 

%  Detailed explanation goes here
