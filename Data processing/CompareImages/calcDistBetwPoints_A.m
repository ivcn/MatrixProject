function [ output ] = calcDistBetwPoints_A( in )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%����������� �������� ���������� ����� �������
%������� �� �����������

Nx = size(in,2);
Ny = size(in,1);
Nt = size(in,3);
%global_dist = 0;
%dist_x = 0;
%count_x=0;
%dist_y = 0;
%count_y = 0;
Rx = zeros(1,Ny);
Ry = zeros(1,Nx);
output = zeros(2,size(in,3));

for t=1:Nt
    t
    %������� ���������� ����� ��� ���
    %�.�. ����� ������ ������
    for j=1:Ny
        [Rx(j) c] = distInSeq(in(j,:,t));
        %Rx(j) - ������� ���������� � ������
        %c - ���-��  ���������� � ������
        %dist_x = dist_x+;%����� ������� ����������
        %count_x  = count_x+c;%����� ����� ���������� �� ���
    end
    %������ ���� �� ��������
    for j=1:Nx
        [Ry(j) c] = distInSeq(in(:,j,t));
        %dist = Ry(j)/c;
        %dist_y = dist_y+dist;
        %count_y = count_y+c;
    end
    %����� ������� ������� �� ���� ����������
    %���� �������� ��� �� ����. ��� ����� ������� ��������� �� ������ 
    %������
    %global_dist = (dist_x+dist_y)/(count_x+count_y);
    Sigma_x = std(Rx);%����� �� ������� ����������
    mean_x = mean(Rx);%��������� �� �������
    Sigma_y = std(Ry);
    mean_y = mean(Ry);%�� ��������
    R = sqrt(mean_x^2+mean_y^2);
    Sigma = sqrt(Sigma_x^2+Sigma_y^2);
    output(:,t) = [R Sigma];
end

end %end function
%//////////////////////////////////////////////////////////////////////
%������ �������� ���������� ����� ���������� ������� � ������������ 
%������������������. ����� ������� ��������� � �������� �� �����������.
%//////////////////////////////////////////////////////////////////////
function [out count] = distInSeq(seq)
i=1;
while( (i<=size(seq,2)) && (seq(i)==0) )
    i=i+1;%����� ������ ��������� �����
end
if(i>=size(seq,2))%���� �� ���� �� �������, ������ ����� ����� ���
    out = 0;%������� ���������� 0?????!!!!!
    count =0;
    %����� ��� �� ���������
    %���� ��� ��������
    return;
end
d_total=0;
d_count =0;
d=0;
while(true)
    prev_i=i;%��������� ������� ��������� �����
    i = i+1;%��������� �� c�������� �����. ��� ������ ���� =0
    d=0;%�������� ����������
    while (i<size(seq,2)) && (seq(i)==0) 
        i=i+1;%���� ��������� ��������� �����
    end
    %������ � i ����� ���� ��������� ��������� �����, ���� ����� ������
    if(i >= size(seq)) 
        break;%���� ��� ����� ������, ���������� ������ �����
        %� ������� �������.
    end
    %���� ��� �� ����� �.�. ����� �����
    d=i-prev_i-1;%������� ������� ����������
    d_total = d_total+d;%����������� ����� ����������
    d_count = d_count+1;%����������� ������� ���������� 
end
%���� � ������-�� ����� 1 �����, �� ����� ����������� ����� 0
%������ ������
if(d_count==0)
    out=0;
    count = 0;
    return;
end
out = d_total/d_count;%������� ������� ����������
%out = d_total;
count = d_count;
end%end subfunction