function [ output ] = calcDistBetwPoints_B( input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Nx = size(input,2);
Ny = size(input,1);
Nt = size(input,3);
%global_dist = 0;
%dist_x = 0;
%count_x=0;
%dist_y = 0;
%count_y = 0;
Rx = zeros(1,Ny);
Ry = zeros(1,Nx);
output = zeros(2,size(input,3));

for t=1:Nt
    %������� ���������� ����� ��� ���
    %�.�. ����� ������ ������
    for j=1:Ny
        [Rx(j) c] = distInSeq(input(j,:,t));
        %Rx(j) - ������� ���������� � ������
        %c - ���-��  ���������� � ������
        %dist_x = dist_x+;%����� ������� ����������
        %count_x  = count_x+c;%����� ����� ���������� �� ���
    end
    %������ ���� �� ��������
    for j=1:Nx
        [Ry(j) c] = distInSeq(input(:,j,t));
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
    R = sqrt(mean_x.^2+mean_y.^2);
    Sigma = sqrt(Sigma_x^2+Sigma_y^2);
    output(:,t) = [R Sigma];
end
end%end function

function [out count] = distInSeq(seq)
d_total = 0;
d_count = 0;
i = 1;
while(true)
    prev_i=i;%��������� ������� ��������� �����
    i = i+1;%��������� �� c�������� �����. ���,���������������� !=0
    d=0;%�������� ����������
    while( (i<size(seq,2))&&(seq(i)==0) )
        i=i+1;%���� ��������� ��������� �����
    end
    %������ � i ����� ���� ��������� ��������� �����, ���� ����� ������
    %���� ��� �� ����� �.�. ����� �����
    d=i-prev_i-1;%������� ������� ����������
    d_total = d_total+d;%����������� ����� ����������
    d_count = d_count+1;%����������� ������� ���������� 
    if(i >= size(seq))
        break;%���� ��� ����� ������, ���������� ������ �����
    end
end
%���� � ������������������ ��� �����
if(d_count==0)
    out=size(seq);
    count = 0;
    return;
end
out = d_total/d_count;%������� ������� ����������
count = d_count;
end%end subfunction