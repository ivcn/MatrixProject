function trend

N=500; %N - dlina ryada;

t=1:N; %t - vremya;


%for kl=1:100


nn=4*N;
shum=randn(1,nn);
str_shum='C:\Users\David\Desktop\NAUKA\MOI STATYI\Borog_Kryanev_Udumyan\shum2.txt'; 
%zapis_vektora(shum,str_shum);
%shum=load(str_shum)';
kappa=0.5;
shum0=shum;
shum=kappa*shum;

w1=2*(1+0.75*(sin(1*2*pi*t/N)));
A1=2*exp(-t/N);
S1=A1.*sin(w1.*2*pi.*t/N);
%figure
%plot(S1)
%return

A2=3*exp(-6*(t/N-0.5).^2);
%plot(A2)
S2=A2.*sin(10*2*pi.*t/N);
%figure
%plot(S2)
%return

T=1:nn;
trend=60+5*exp((T/nn).^2).*sin(6*pi*(T/nn).^2);
%plot(trend)

S=shum;
%S=zeros(1,nn);
S(1*N+1:2*N)=S(1*N+1:2*N)+S1;
S(2*N+1:3*N)=S(2*N+1:3*N)+S2;
figure
plot(S)
%return
S=S+trend;

Analyztrend(S,trend);


return
