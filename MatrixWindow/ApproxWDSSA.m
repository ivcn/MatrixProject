function [K] = ApproxWDSSA(A,T,m) 

%K - ���������� �� �������������� ������
%m - ������ ����
%%T - ������������� �����
% k = 0 - ��������� �������� ������, ����� k - ���� ������� ��������
n = size(A,2);   % ���������� ����� ����
%UNTITLED1 Summary of this function goes here

nx = 1; % ������ ����
K=zeros(1,n);
while (nx+m-1)<=n
    F = SSA_det(A(1, nx:nx+m-1),1);     %%  ������������ ������� � ���� SSA �������
    K(1,nx)=sum(abs(F-T(nx:nx+m-1)))/m;       %% ������� ���������� �� �������������� ������
    nx = nx+1;
end

    



