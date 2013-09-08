function [ smoothSignal ] = DWT2_Smoothing( sourceSignal )
%DWT2_Smoothing ����������� ������� ����� 3-������� ���������� ����
%��������� �������-��������������� 
%���������� ���������� ������ ���������� �����������
smoothSignal = zeros(size(sourceSignal));
wname = 'db5';%�������
thr = 90;
sorh = 's';
keepapp = 1;
level = 2;

for i=1:size(sourceSignal,3)
   % [thr,sorh,keepapp] = ddencmp('den','wv',sourceSignal(:,:,i));%��������� �� ���������.���� ���.
    smoothSignal(:,:,i) = wdencmp('gbl',sourceSignal(:,:,i),wname,level,thr,sorh,keepapp);
end
%den ������ de-noising
%wv ������ ������� �������, �� ��������
%thr - ����� ���� ������������
%sorh - ��� ������. ������� ��� ������: 's' & 'h'
%keepapp - ��������� ��� ��� ������������ �������������
end

