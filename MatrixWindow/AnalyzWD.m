function E = AnalyzWD(A, xo, k, flagsigma) 
% ���������� ������ ������� ������� � ����
% xo - ������ ����
% k = 0 - Fisher, >0 - ���� ������� ��������, <0 - SSA
n = size(A,2);   % ���������� ����� ����
%UNTITLED1 Summary of this function goes here

xa = floor(xo/2)-1;

xs=1;
E=[];

while (xs+xo-1<=n)
   if (k==0)
        l = Fisher(A(1, xs:xs+xo-1),3,10);    %%  ������� ����������� ������� �������� �� �������� ������
        F = ChebRazl(A(1, xs:xs+xo-1),l,0);     %%  ������������ ������� � ���� �� ��������� ��������  
    else
        if (k>0)
            F = ChebRazl(A(1, xs:xs+xo-1),k,0);     %%  ������������ ������� � ���� �� ��������� ��������  
        else
            F = SSA_det(A(1, xs:xs+xo-1),1); % SSA
            %F = SSA_Filter_Part(A(1,xs:xs+x0-1),72,1);
        end
    end
    B = A(1, xs:xs+xo-1)-F;
    sig = std(B);
                    
    if (flagsigma ~= 0)
      B=B./sig;
    end
    wcoef = cwt(B,1:xa,'cmor2-1');
    E=[E sum(sum(abs(wcoef).^2))];
    xs=xs+1;
end

