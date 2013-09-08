function [ outputSeries ] = sumdiag( input )
%SUMDIAG Summary of this function goes here
%   Detailed explanation goes here
Nrow = size(input,1);
Ncol = size(input,2);

outputSeries = zeros(size(input,2)*2);

for i=1:min(Nrow,Ncol)%���� �� ��������, ��� �� �������. �������.
    for j=1:i%����� ��������� �� ��������� ����� ������ �������
        outputSeries(i)=outputSeries(i)+input(i-j+1,j);%����� ���������
    end
    outputSeries(i)=outputSeries(i)/i;%�������
end
for i = min(Nrow,Ncol)+1:max(Nrow,Ncol)
    for j=1:max(Nrow,Ncol)
        outputSeries(i)=outputSeries(i)+input(i-j+1,j);
    end
    outputSeries(i)=outputSeries(i)/windowSize;
end
for i=min(Nrow,Ncol):-1:min(Nrow,Ncol)+max(Nrow,Ncol)+2
    for j=min(Nrow,Ncol):-1:i+min(Nrow,Ncol)-max(Nrow,Ncol)
        outputSeries(i)=outputSeries(i)+input(i-j+2);
    end
    outputSeries(i)=outputSeries(i)/(max(Nrow,Ncol)-i);
end

end

