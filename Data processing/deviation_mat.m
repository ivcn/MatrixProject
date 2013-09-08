function [ deviationMatrix ] = deviation_mat( sourceIm, smoothIm )
%DEVIATION_MAT ���������� ������� ���������� ����������� �� ��� ����������
%������
%   Detailed explanation goes here
if(size(sourceIm)~=size(smoothIm))
    error('MATLAB: size mismatch');
end
N = size(sourceIm,1)*size(sourceIm,2);
sum = 0; 
for i=1:size(sourceIm,1)
    for j=1:size(sourceIm,2)
    sum = sum + (sourceIm(i,j)-smoothIm(i,j))^2;
    end
end
sigma1=sqrt(sum/N);
%������ ���� �� �������, ���� ����� � ������� ���������� �� ������ �����
%��������� �� ������ ��� � k ���
sum=0;
k=2;% �������� ������
for i=1:size(sourceIm,1)
    for j=1:size(sourceIm,2)
        if( (sourceIm(i,j)-smoothIm(i,j)) >= k*sigma1)
            continue;
        else
            sum = sum + (sourceIm(i,j)-smoothIm(i,j))^2;
        end
    end
end
sigma2=sqrt(sum/N);
%������ ����� ���������. ������ ������� ����������
deviationMatrix = zeros(size(sourceIm));
for i=1:size(deviationMatrix,1)
    for j=1:size(deviationMatrix,2)
        deviationMatrix(i,j) = (sourceIm(i,j)-smoothIm(i,j))/sigma2;
    end
end
end
