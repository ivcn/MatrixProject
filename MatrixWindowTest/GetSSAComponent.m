function [ output ] = GetSSAComponent(input,partSize,windowSize,componentNumber )
%GetSSAComponent Summary of this function goes here
%  ������� ���������� ��������� ���������� SSA-���������� ���������� ���� x.
%  �������� ��� ����������� �� �����,%  �������� partSize. � ������ �����
%  �� ����������� ����������� ssa.
%  input - ������� ���������� ��������� ���
%  partSize - ������ ������ �� ������� ����������� ���.
%  componentNumber  - ����� ���������� ������� ���� �������
if(size(input,2) < windowSize )
    output = input;
    return
end
output = zeros(size(input));
N = size(input,2);
partIndex = 1;
part = zeros(1,partSize);
while(partIndex+partSize-1<=N)
    part = input(partIndex:partIndex+partSize-1);
    output(partIndex:partIndex+partSize-1) = ssa(part,windowSize,componentNumber);
    partIndex = partIndex + partSize;
end
if (partIndex < N)
    part = zeros(N-partIndex);
    part = input(partIndex:N);
    output(partIndex:N) = ssa(part, windowSize, componentNumber);
end
%--------------------------------------------------------------------------

%plot(outputSeries);
%������� ����� � ����� �� ���
%sigma = std(outputSeries);
%outputSeries = outputSeries/sigma;

end
%==========================================================================
function [outputSeries] = ssa(inputSeries, windowSize, numberOfComponent)
%dim = ndims(inputSeries);%����� ��������� � �������
a=size(inputSeries,2);%����� ��������� � ���������� ���������
if(a<windowSize)
    outputSeries = inputSeries;
    return
end
%windowSize = floor(a/4);%������ ����
numberOfSteps = size(inputSeries,2)-windowSize+1;
Y = zeros(numberOfSteps,windowSize);%������� ���������� ��������

for i=1:numberOfSteps
    Y(i,:)=inputSeries(i:i+windowSize-1);%��������� �������
end
YTY = Y'*Y;
[eVec,eVal]=eig(YTY);%���� �� � ��

eval_ = diag(eVal);
[eval ind] = sort(eval_,'descend');%������������� �� �� ��������.
evec = zeros(size(eVec));
for i=1:size(eVal)
    evec(:,i) = eVec(:,ind(i));
end
%������� ����������� �������� - ���� �����
%figure(30);
%plot(eval,'--ko');
%title('����������� ��������');

omega = zeros(windowSize,windowSize);   
for i=1:windowSize
    %omega(:,i) = evec(:,windowSize-i+1);
    omega(:,i) = evec(:,i);
end
V=Y*omega;

%����� ���������
V_ = zeros(size(V));
SV = size(V,2);
%V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);%+1:SV
V_(:,1:numberOfComponent) = V(:,1:numberOfComponent);
Y_ = V_*omega';

outputSeries = zeros(1,size(inputSeries,2));

if( size(Y_,1) < size(Y_,2) )
    Y_ = Y_';
end

for i=1:size(Y_,2)%���� �� ��������.
    for j=1:i%����� ��������� �� ��������� ����� ������ �������
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);%����� ���������
    end
    outputSeries(i)=outputSeries(i)/i;%�������
end
for i=size(Y_,2)+1:size(Y_,1)
    for j=1:size(Y_,2);
        outputSeries(i)=outputSeries(i)+Y_(i-j+1,j);
    end
    outputSeries(i)=outputSeries(i)/size(Y_,2);
end
for i=size(Y_,1)+1:size(inputSeries,2)
    for j=1:size(Y_,2)-(i-size(Y_,1))
        outputSeries(i)=outputSeries(i)+Y_(size(Y_,1)-j+1,1+i-size(Y_,1)+j-1);
    end
    outputSeries(i)=outputSeries(i)/(size(Y_,2)-(i-size(Y_,1)));
end
end