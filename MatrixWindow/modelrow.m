function [ff] = trend(u,ss0,ss1,ss2,ss3)

N=500; %N - dlina ryada;

t=1:N; %t - vremya;


%for kl=1:100


nn=4*N;
%shum=randn(1,nn);
str_shum='D:\Veivlet tufanov\noise.txt'; 
%zapis_vektora(shum,str_shum);
shum=load(str_shum)';
kappa=u;
shum0=shum;
shum=kappa*shum;

S0=eval(ss0);

w1=2*(1+0.75*(sin(1*2*pi*t/N)));
% A1=2*exp(-t/N);
% S1=A1.*sin(w1.*2*pi.*t/N);
S1=eval(ss1);




A2=3*exp(-6*(t/N-0.5).^2);

%S2=A2.*sin(10*2*pi.*t/N);
S2=eval(ss2);
S3=eval(ss3);


S=shum;
%S=zeros(1,nn);
S(1:N)=S(1:N)+S0;
S(1*N+1:2*N)=S(1*N+1:2*N)+S1;
S(2*N+1:3*N)=S(2*N+1:3*N)+S2;
S(3*N+1:4*N)=S(3*N+1:4*N)+S3;

ff = S;
return
