function [ output ] = wavelet3DSmooth( input, level )
%wavelet3DSmooth ���������� �������-�����������
%   ������� ��������� ���������� ������ input � �������
%   �������-���������� level.
%   ���������� ���������� ���������� ������ output
%   ������������� �������� level - 2
output = zeros(size(input));
wname = 'db8';%�������
WT_signal=wavedec3(input,level,wname);%���������� �������-���������� ��
%������ level

 A = waverec3(WT_signal,'aaa');% �������������� ������� ��
%������������� ������������� ���������� ������.
% aaa - ������������� �� x,y � z

output = A;

end