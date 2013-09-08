function [outputMatrix] = SSA_2D( input,numberOfComponents )
Nx = size(input,1);
Ny = size(input,2);

winSizeX = floor(Nx/2);
winSizeY = floor(Ny/2);

numStepsX = Nx - winSizeX + 1;
numStepsY = Ny - winSizeY + 1;

trajectMat = zeros(winSizeX*winSizeY,numStepsX*numStepsY);%����������� �������
% ���������� ��� �� ��������� ������
blockSeries = zeros(winSizeX,Ny*numStepsX);
for i = 1:Ny
    blockSeries(:,(i-1)*numStepsX+1:i*numStepsX) = getBlock(input,i,winSizeX,winSizeY);
end
%�� ���� ������ ���������� ������� ������(������ 4 �����)

for n = 1:winSizeY
    tempArrOfMatr = blockSeries(:,(n-1)*numStepsX+1:(n-1+numStepsY)*numStepsX);
    %trajectMat(n,:,:,:)=tempArrOfMatr; %������ ��� �� ��. ��� ��� ���� � ���� ������� ������� ���������.
    trajectMat((n-1)*winSizeX+1:n*winSizeX,:) = tempArrOfMatr;
end
%����������� ������� ���������. ���������� � ��� ��������� ��������.
%-------����������� ����������-----------
%YTY = trajectMat'*trajectMat;
%[eVec,eVal]=eig(YTY);%���� �� � ��
[eVec, eVal]=eig(trajectMat*trajectMat');
eval_ = diag(eVal);
[eval ind] = sort(eval_,'descend');%������������� �� �� ��������.

figure();
plot(1:size(eval,1),eval,'-k');
hold on;
plot(1:size(eval,1),eval,'.k');


evec = zeros(size(eVec));
for i=1:size(eVal)
    evec(:,i) = eVec(:,ind(i));
end
%omega = zeros(size(eVec,1),size(eVec,2));
U = zeros(size(eVec,1),size(eVec,2));
for i=1:winSizeX*winSizeY
    U(:,i) = evec(:,i);
end
%V = trajectMat*omega;
V = trajectMat'*U;
%---------------------------����� ���������---------------
V_ = zeros(size(V));
U_ = zeros(size(U));
%SV = size(V,2);
%V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);
V_(:,1:numberOfComponents) = V(:,1:numberOfComponents);%*omega(1:numberOfComponents,:);
U_(:,1:numberOfComponents) = U(:,1:numberOfComponents);
%V_=V;
%trajectMat = V_*omega';% �������� ����������� ������� ��� ������ ��
%�����������, ������� �� �� ����� ������� �����, ���������������
%����������� �������
trajectMat = U_*V_';
%-----------------������������-----------------------------
%����� �������. ���������� ��������� ������������.
%���� ��������� �������� �� �������� ���������� ������ ������� �����.
%����� ��������� ���� ����� �� �������� ����������.
%���� ���� �� ������ � ������� ����� � ������ ������� ����� ���������
%�������� �� �������� ���������. ����� ���� �������� �������� ����
%��������� �� ��������� �������.
for i=1:winSizeY
    for j =1:numStepsY%(i-������, j-������� - ���������� ����� � ����������� �������)
        block = trajectMat((i-1)*winSizeX+1:i*winSizeX,(j-1)*numStepsX+1:j*numStepsX);
        block = hankelizeBlock(block);
        trajectMat((i-1)*winSizeX+1:i*winSizeX,(j-1)*numStepsX+1:j*numStepsX) = block;
    end
end
%�� ������ ����� ������������� ����� �������. ������ ���� �������������
%���� �����.
%--------------------------------------------
%TODO: ���� ��������� �� �� ��� ����� ����� ������ ��� ����� ��������.
%����� �������� ��� ��� ���� ���������������.
numColInMatrix = numStepsY;
numRowInMatrix = winSizeY;
numColInBlock = numStepsX;
numRowInBlock = winSizeX;
flagTranspon = 0;
if(numStepsY > winSizeY)
    %���� ������� �������
    trajectMat = trajectMat';
    flagTranspon = 1;
    numColInMatrix = winSizeY;
    numRowInMatrix = numStepsY;
    %���� ����� � ��� ���� ������,� �� �� ���������������, ������ �����
    %����� ��������. � ��������. ���� �������������� ������ ������.
    numColInBlock = winSizeX;
    numRowInBlock = numStepsX;
end

%��������� ������� �����������
for i=1:numColInMatrix%���� �� ��������
    block = zeros(numRowInBlock,numColInBlock);
    for j=1:i%����� ��������� �� ��������� ����� ������ �������
        %val=val + block(i-j+1,j);%����� ���������
        block = block + trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock );
    end
    block = block./i;%�������
    %��������� ��������� ����������� ����������
    for j=1:i
        trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock ) = block;
    end
end
%��������� ��������
for i=numColInMatrix+1:numRowInMatrix
    block = zeros(numRowInBlock,numColInBlock);
    for j=1:numColInMatrix
        %val=val+block(i-j+1,j);
        block = block + trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock );
    end
    block = block./numColInMatrix;
    for j=1:numColInMatrix
        trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock ) = block;
    end
end
%��������� ������ �����������
for i = 2:numColInMatrix
    block = zeros(numRowInBlock,numColInBlock);
    for j = i:numColInMatrix
        block = block + trajectMat( (numRowInMatrix+i-j-1)*numRowInBlock+1:(numRowInMatrix+i-j)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock );
    end
    block = block./(numColInMatrix-i+1);
    for j = i:numColInMatrix
        trajectMat( (numRowInMatrix+i-j-1)*numRowInBlock+1:(numRowInMatrix+i-j)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock ) = block;
    end
end
%%-----------------------------------------------
%%������������ ���������. ����� ������������ ������������ ��������� ���� ��
%������ �������� � ����������� �������.
%��� ����� ������� ����������� � ����������� ������� ��������� �� ��
%������ ������ � ��������� �������, ������� ����� ����,
%���������� ��� � ��� � ���� � ������� �������������� �������.
%%-----------------------------------------------
if(flagTranspon == 1)
    trajectMat = trajectMat';%������������� ������� �����, ���� ��� �����
end

outputMatrix = zeros(size(input));
%block = zeros(winSizeX,numStepsY);
%���� �� ������ ������
for i = 1:numStepsY
    %�������� ����
    block = trajectMat(1:winSizeX,(i-1)*numStepsX+1:i*numStepsX);
    %���� ���� ��������� ���������� ������� �������
    outputMatrix(1:numStepsX,i) = block(1,:);
    outputMatrix(numStepsX+1:Nx,i) = block(2:winSizeX,numStepsX);
end
%���� �� ���������� �������
for i = 2:winSizeY
    block = trajectMat((i-1)*winSizeX+1:i*winSizeX,size(trajectMat,2)-numStepsX+1:size(trajectMat,2));
    outputMatrix(1:numStepsX,numStepsY+i-1) = block(1,:);
    outputMatrix(numStepsX+1:Nx,numStepsY+i-1) = block(2:winSizeX,numStepsX);
end

end %end SSA_2D

%%--------------------------------------------------------------------
%%��������������� �������.
%%--------------------------------------------------------------------
function [block] = getBlock(input,j,winSizeX,winSizeY)
Nx = size(input,1);

numStepsX = Nx - winSizeX + 1;

block = zeros(winSizeX,numStepsX);

for i = 1:numStepsX
    block(:,i) = input(i:i+winSizeX-1,j);
end

end
%%----------------------------------------------------------
%������ �������� ������������ �������, ������� ����� � �������
%������������. �� ����� ����� ����������� �������, ��� ��� ������ ���������
%�������� ���������.
%<----Ncol----->
%*************/^
%************/*|
%***********/**|
%**********/***|
%*********/****|
%********/*****|
%*******/******|
%******/******/|
%*****/******/*|
%****/******/**|
%***/******/***| Nrow
%**/******/****|
%*/******/*****|
%/******/******|
%******/*******|
%*****/********|
%****/*********|
%***/**********|
%**/***********|
%*/************|
%/*************^
%%----------------------------------------------------
%������������ ������ �����
function [out] = hankelizeBlock(block)
Ncol = size(block,2);
Nrow = size(block,1);
%���� �������� �������� ������ ���� ����� ����� ������ ��� ����� ��������
%�.�. ��� ����� ������. ����  ��� �� ��� �������������. ������ ��
%���������.
flagTranspon = 0;
if(size(block,1) < size(block,2))
    block = block';
    flagTranspon = 1;%���� ����������������
    %������������� Nrow � Ncol
    %������ ������� block ���������
    Ncol = size(block,2);
    Nrow = size(block,1);
end
%������� �����������
for i=1:Ncol%���� �� ��������
    val = 0;
    for j=1:i%����� ��������� �� ��������� ����� ������ �������
        val=val + block(i-j+1,j);%����� ���������
    end
    val = val/i;%�������
    %��������� ��������� ����������� ����������
    for j=1:i
        block(i-j+1,j) = val;
    end
end
%������� ����� �������
for i=Ncol+1:Nrow
    val = 0;
    for j=1:Ncol
        val=val+block(i-j+1,j);
    end
    val=val/Ncol;
    for j=1:Ncol
        block(i-j+1,j) = val;
    end
end
%������ �����������
for i = 2:Ncol
    val = 0;
    for j = i:Ncol
        val = val+block(Nrow+i-j,j);
    end
    val = val/(Ncol-i+1);
    for j = i:Ncol
        block(Nrow+i-j,j) = val;
    end
end
if(flagTranspon == 1)
    block = block';
end
out = block;

end