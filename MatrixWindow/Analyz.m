function [l] = Analyz(A) 
n = size(A,2);   % ���������� ����� ����
%UNTITLED1 Summary of this function goes here

l = Fisher(A,1,20);    %%  ������� ����������� ������� �������� �� �������� ������
F = ChebRazl(A,l,0);     %%  ������������ ������� �� ��������� ��������
B = Balance(A,F);      %%  ������� ����� 



xa = 30;

wcoef = cwt(B,1:xa,'cmor2-1');
wcoef1 = cwt(B,1:xa,'morl');

Ew = sum(abs(wcoef(:,:)).^2);
Ew1 = sum(wcoef1(:,:).^2);

xo = 48;  %% ������ ����
xs=1;

E=[];
E1=[];

while (xs+xo-1<=n)
  E=[E sum(Ew(1,xs:1:xs+xo-1))];      
  E1=[E1 sum(Ew1(1,xs:1:xs+xo-1))];
  xs=xs+1;
end

nw = size(E,2);
nw1 = size(E1,2);

subplot(4,1,1);
plot(1:n, A, 1:n,F);set(gca,'FontName','Arial Cyr');title(['��������� ���, ���� ������� ��������: ' int2str(l)]);set(gca,'XTick',0:100:n);
subplot(4,1,2);
plot(1:n, B);set(gca,'FontName','Arial Cyr');title('��� �� ������ �������');set(gca,'XTick',0:100:n);
subplot(4,1,3);
plot(1:nw, E);set(gca,'FontName','Arial Cyr'); title(['�������-�������������� cmor2-1 �������� a: 1-' int2str(xa)]);set(gca,'XTick',0:100:n);
subplot(4,1,4); 
plot(1:nw1, E1);set(gca,'FontName','Arial Cyr');title('�������-�������������� morl');set(gca,'XTick',0:100:n);
% figure (1); plot(1:n, B);
% subplot(211),plot(1:n, B);
% subplot(212), wcoef = cwt(B,1:30,'morl', 'abslvl',[0 10]);
% wcoef


Nsr = sum(B)/n;      %% ������� �������� ����������������� ����

D = sqrt(sum((B-Nsr).^2)/(n-1));   %% ������������������ ����������

G = sort(B);
G = G/D;
%Gauss(G);
%  Detailed explanation goes here
