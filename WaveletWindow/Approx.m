function [F,B,l] = Approx(A, k, wS,sS,numComp) 
% k = 0 - используя критерий Фишера, иначе k - макс степень полинома, k=-1 - SSA
n = size(A,2);   % количество точек ряда
%UNTITLED1 Summary of this function goes here

F = [];

if (k==-1)    %SSA
   %SSA
   if(sS>0)
       if( (wS>0)&&(wS<sS) )
           F = GetSSAComponent(A,sS,wS,numComp);
       else
           'invalid windowSize'
       end
   else
       'invalid segmentSize'
   end
elseif (k==0)
    l = Fisher(A,3,20);    %%  находим оптимальную степень полинома по критерию Фишера
    F = ChebRazl(A,l,0);     %%  Раскладываем функцию по полиномам Чебышева
else
    l=k;
    F = ChebRazl(A,l,0);     %%  Раскладываем функцию по полиномам Чебышева
end    

B = A - F;      %%  Убираем тренд 

