function [outputMatrix] = SSA_2D( input,numberOfComponents )
Nx = size(input,1);
Ny = size(input,2);

winSizeX = floor(Nx/2);
winSizeY = floor(Ny/2);

numStepsX = Nx - winSizeX + 1;
numStepsY = Ny - winSizeY + 1;

trajectMat = zeros(winSizeX*winSizeY,numStepsX*numStepsY);%траекторная матрица
% составляем ряд из матричных блоков
blockSeries = zeros(winSizeX,Ny*numStepsX);
for i = 1:Ny
    blockSeries(:,(i-1)*numStepsX+1:i*numStepsX) = getBlock(input,i,winSizeX,winSizeY);
end
%по ряду матриц составляем матрицу матриц(тензор 4 ранга)

for n = 1:winSizeY
    tempArrOfMatr = blockSeries(:,(n-1)*numStepsX+1:(n-1+numStepsY)*numStepsX);
    %trajectMat(n,:,:,:)=tempArrOfMatr; %походу это не то. Мне все надо в одну большую матрицу запихнуть.
    trajectMat((n-1)*winSizeX+1:n*winSizeX,:) = tempArrOfMatr;
end
%траекторная матрица построена. Производим с ней привычные действия.
%-------сингулярное разложение-----------
%YTY = trajectMat'*trajectMat;
%[eVec,eVal]=eig(YTY);%ищем сф и сз
[eVec, eVal]=eig(trajectMat*trajectMat');
eval_ = diag(eVal);
[eval ind] = sort(eval_,'descend');%отсортировали сз по убыванию.

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
%---------------------------выбор компонент---------------
V_ = zeros(size(V));
U_ = zeros(size(U));
%SV = size(V,2);
%V_(:,numberOfComponents+1:SV) = V(:,numberOfComponents+1:SV);
V_(:,1:numberOfComponents) = V(:,1:numberOfComponents);%*omega(1:numberOfComponents,:);
U_(:,1:numberOfComponents) = U(:,1:numberOfComponents);
%V_=V;
%trajectMat = V_*omega';% исходная траекторная матрица нам больше не
%понадобится, поэтому на ее место положим новую, восстановленную
%траекторную матрицу
trajectMat = U_*V_';
%-----------------Ганкелизация-----------------------------
%самое сложное. применение оператора ганкелизации.
%надо усреднить значения на побочных диагоналях внутри каждого блока.
%потом усреднить сами блоки на побочных диагоналях.
%надо идти по блокам в двойном цикле и внутри каждого блока усреднять
%элементы на побочной диагонали. после чего заменить элементы этой
%диагонали на полученый элемент.
for i=1:winSizeY
    for j =1:numStepsY%(i-строка, j-столбец - координаты блока в траекторной матрице)
        block = trajectMat((i-1)*winSizeX+1:i*winSizeX,(j-1)*numStepsX+1:j*numStepsX);
        block = hankelizeBlock(block);
        trajectMat((i-1)*winSizeX+1:i*winSizeX,(j-1)*numStepsX+1:j*numStepsX) = block;
    end
end
%на данном этапе ганкелизованы блоки изнутри. теперь надо ганкелизовать
%сами блоки.
%--------------------------------------------
%TODO: надо проверить на то что число строк больше чем число столбцов.
%иначе придется все это дело транспонировать.
numColInMatrix = numStepsY;
numRowInMatrix = winSizeY;
numColInBlock = numStepsX;
numRowInBlock = winSizeX;
flagTranspon = 0;
if(numStepsY > winSizeY)
    %если матрица широкая
    trajectMat = trajectMat';
    flagTranspon = 1;
    numColInMatrix = winSizeY;
    numRowInMatrix = numStepsY;
    %если блоки в ней были узкими,а мы ее транспонировали, значит блоки
    %стали широкими. И наоборот. Надо переобозначить размер блоков.
    numColInBlock = winSizeX;
    numRowInBlock = numStepsX;
end

%усредняем верхний треугольник
for i=1:numColInMatrix%идем по столбцам
    block = zeros(numRowInBlock,numColInBlock);
    for j=1:i%число элементов на диагонали равно номеру столбца
        %val=val + block(i-j+1,j);%сумма элементов
        block = block + trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock );
    end
    block = block./i;%среднее
    %заполняем диагональ полученными значениями
    for j=1:i
        trajectMat( (i-j+1-1)*numRowInBlock+1:(i-j+1)*numRowInBlock,(j-1)*numColInBlock+1:j*numColInBlock ) = block;
    end
end
%усредняем середину
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
%усредняем нижний треугольник
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
%%Ганкелизация закончена. Нужно восстановить обработанное двумерное поле по
%блокам входящим в траекторную матрицу.
%Все блоки которые встречаются в траекторной матрице находятся на ее
%первой строке и последнем столбце, поэтому берем блок,
%превращаем его в ряд и суем в столбец результирующей матрицы.
%%-----------------------------------------------
if(flagTranspon == 1)
    trajectMat = trajectMat';%транспонируем матрицу назад, если это нужно
end

outputMatrix = zeros(size(input));
%block = zeros(winSizeX,numStepsY);
%идем по первой строке
for i = 1:numStepsY
    %получаем блок
    block = trajectMat(1:winSizeX,(i-1)*numStepsX+1:i*numStepsX);
    %блок надо прочитать аналогично блочной матрице
    outputMatrix(1:numStepsX,i) = block(1,:);
    outputMatrix(numStepsX+1:Nx,i) = block(2:winSizeX,numStepsX);
end
%идем по последнему столбцу
for i = 2:winSizeY
    block = trajectMat((i-1)*winSizeX+1:i*winSizeX,size(trajectMat,2)-numStepsX+1:size(trajectMat,2));
    outputMatrix(1:numStepsX,numStepsY+i-1) = block(1,:);
    outputMatrix(numStepsX+1:Nx,numStepsY+i-1) = block(2:winSizeX,numStepsX);
end

end %end SSA_2D

%%--------------------------------------------------------------------
%%вспомогательные функции.
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
%пример верхнего треугольника матрицы, средней части и нижнего
%треугольника. На такие части разбивается матрица, ибо так удобно усреднять
%побочные диагонали.
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
%ганкелизация внутри блока
function [out] = hankelizeBlock(block)
Ncol = size(block,2);
Nrow = size(block,1);
%этот алгоритм работает только если число строк больше чем число столбцов
%т.е. для узких матриц. Если  это не так транспонируем. Ничего не
%изменится.
flagTranspon = 0;
if(size(block,1) < size(block,2))
    block = block';
    flagTranspon = 1;%флаг транспонирования
    %пересчитываем Nrow и Ncol
    %размер матрицы block изменился
    Ncol = size(block,2);
    Nrow = size(block,1);
end
%верхний треугольник
for i=1:Ncol%идем по столбцам
    val = 0;
    for j=1:i%число элементов на диагонали равно номеру столбца
        val=val + block(i-j+1,j);%сумма элементов
    end
    val = val/i;%среднее
    %заполняем диагональ полученными значениями
    for j=1:i
        block(i-j+1,j) = val;
    end
end
%средняя часть матрицы
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
%нижний треугольник
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