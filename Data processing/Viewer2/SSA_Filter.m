function [ outputSeries ] = SSA_Filter( inputSeries, numberOfComponents )
%SSA_Filter ���������� ����������� ���������� ���� ������� SSA.
%  ��������� ������(�������������� ����������) ���������� ������� �������
%  �����������-������������ �������
%  inputSeries - ������� ���������� ��������� ���
%   numberOfComponents  ����� ��������� ���������(� ������ 1)
dim = ndims(inputSeries);%����� ��������� � �������
a=size(inputSeries,dim);%����� ��������� � ���������� ���������
windowSize = floor(a/8);%������ ����
numberOfSteps = size(inputSeries,dim)-windowSize+1;
Y = zeros(numberOfSteps,windowSize);%������� ���������� ��������

for i=1:numberOfSteps
    Y(i,:)=inputSeries(i:i+windowSize-1);%��������� �������
end
YTY = Y'*Y;
[eVec,eVal]=eig(YTY);%���� �� � ��
omega = zeros(windowSize,windowSize);   
for i=1:windowSize
    omega(:,i) = eVec(:,windowSize-i+1);
end
V=Y*omega;

%����� ���������
V_ = zeros(size(V));
SV = size(V,2);
V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);%+1:SV
%Y_=V(:,1:numberOfComponent)*omega(1:numberOfComponent,:);
Y_ = V_*omega';

outputSeries = zeros(1,size(inputSeries,dim));

for i=1:windowSize%���� �� ��������
    for j=1:i%����� ��������� �� ��������� ����� ������ �������
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);%����� ���������
    end
    outputSeries(i)=outputSeries(i)/i;%�������
end
for i=windowSize+1:numberOfSteps
    for j=1:windowSize
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);
    end
    outputSeries(i)=outputSeries(i)/windowSize;
end
for i=numberOfSteps+1:size(inputSeries,dim)
    for j=1:windowSize-(i-numberOfSteps)
        outputSeries(i)=outputSeries(i)+Y_(numberOfSteps-j+1,1+i-numberOfSteps+j-1);
    end
    outputSeries(i)=outputSeries(i)/(windowSize-(i-numberOfSteps));
end
% plot(outputSeries);
%������� ����� � ����� �� ���
%sigma = std(outputSeries);
%outputSeries = outputSeries/sigma;

end