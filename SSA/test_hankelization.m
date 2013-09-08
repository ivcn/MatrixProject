clc;
block = [1,7,6,3;
         1,2,3,5;
         4,3,4,1;
         3,4,8,5;
         4,1,5,1;
         4,5,4,6;
         5,2,6,1;
         1,6,1,7;
         6,9,7,1;
         1,7,6,8;
         7,1,8,5;
         1,8,2,9;
         ]

Ncol = size(block,2);
Nrow = size(block,1);


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
    
% for i=Nrow+1:size(y,2)
%     for j=1:windowSize-(i-numberOfSteps)
%         y_(i)=y_(i)+Y_(numberOfSteps-j+1,1+i-numberOfSteps+j-1);
%     end
%     y_(i)=y_(i)/(windowSize-(i-numberOfSteps));
% end

block