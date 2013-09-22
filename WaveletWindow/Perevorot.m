function A = Perevorot(B)
%UNTITLED1 Summary of this function goes here
k = size(B,1);
n = floor(k/2);
A = zeros(1,n);

%dlya 5-minutnih dannih
for i=1:k
  A(1,i)=B(i,1);  
end

%for i=1:k
%  A(1,i)=B(i,1);  
%end
%  Detailed explanation goes here
