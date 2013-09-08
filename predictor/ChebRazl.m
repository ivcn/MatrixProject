function [F] = ChebRazl(A,l,graph) % A - ��������� ���, l -������������ ������� �������� ��������, graph - ������� �� ������
%UNTITLED1 Summary of this function goes here
n = size(A,2);   % ���������� ����� ����

K = zeros(1,l+1);  % ������ ������������� ��� ����������

Cheb = zeros(1,n);  % ��������� ������� ��������� ��������
Cheb1 = zeros(1,n);  % ��������� ������� ��������� ��������

Cheb(1,:) = 1; % ������� 0-�� �������
Cheb1(1,:) = 1; % ������� 0-�� �������

% for i = 1:1:n
%     Cheb(2,i)=i-(n+1)/2;  % ������� 1-�� �������
% end

for i =1:1:n  
   Cheb(2,i)=i-(n+1)/2;  % ������� 1-�� ������� 
   for j = 3:1:l+1
      p = j-2;
      Cheb(j,i)= Cheb(2,i)*Cheb(j-1,i)-((p*p*n*n-p*p*p*p)/(16*p*p-4))*Cheb(j-2,i);  % ��������� ��������
     % p = j-1;
     % Cheb(j,i)= Cheb(2,i)*Cheb(p,i)-((p*p*n*n-p*p*p*p)/(16*p*p-4))*Cheb(j-2,i);  % ��������� ��������
   end
end

%Cheb(:,100)

% for i=1:1:n
%     Cheb1(2,i)=i-(n+1)/2;
%     Cheb1(3,i)=Cheb1(2,i)^2-(n^2-1)/12;
%     Cheb1(4,i)=Cheb1(2,i)^3-((3*n^2-7)/20)*Cheb1(2,i);
%     Cheb1(5,i)=Cheb1(2,i)^4-((3*n^2-13)/14)*(Cheb1(2,i)^2)+3*(n^2-1)*(n^2-9)/560;
%     Cheb1(6,i)=Cheb1(2,i)^5-(5*(n^2-7)/18)*(Cheb1(2,i)^3)+((15*n^4-230*n^2+407)/1008)*Cheb1(2,i);
% end
% 
% Cheb
% Cheb1



K=zeros(1,l+1);  % ������������ � ����������
for j=1:1:l+1
    K(j)=sum(A.*Cheb(j,:))/sum(Cheb(j,:).^2);
end



F=zeros(1,n);  % �������

for i=1:1:n
    for j=1:1:l+1
        F(i)=F(i)+K(j)*Cheb(j,i);
    end
end

if (graph==1)
   plot(1:n,A(1,:),1:n,F(1,:)) 
   set(gca,'FontName','Arial Cyr');
   title('������������� ���������� ������','FontSize',14)
   xlabel('������'); 
   ylabel('���������� ������');

end


%  Detailed explanation goes here
