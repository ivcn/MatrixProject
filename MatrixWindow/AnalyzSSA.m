function B = AnalyzSSA(A);
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
A=Readrow();
A=Obrezka(A);
B=SSA_det(A,1);
n=size(B,2);
plot(1:n,A,1:n,B);