function xdet=SSA_sgl(x,m)

% funkciya sglajivaet ryad "x" metodom "SSA" ispol'zuya pervie "m" glavnie
% komponenti. 

N=length(x);

p=4;
L=fix(N/p); %Выбираем длину окна
K=N-L+1;

x=x'; %teper x-sroka
X=zeros(K,L);
for i=1:K
    X(i,:)=x(i:L+i-1);
end

%vi4islyaem necentral'nuyu kovariacionnuyu matricu
V=(X'*X)/K;

%vi4islyaem sobstvennie 4isla i sobstvennie vektora matrici V
[Fi,Lam]=eig(V); %stolbci matrici Fi sostoyat iz sobstvennix vektorov matrici V; a po diaganali matrici Lam stoyat sobstvennie znacheniya
                 
%vi4islim sobstvennie zna4eniya                
lam=diag(Lam);

[lam, ind]=sort(lam);%otsortirovali v poryadke vozrastaniya
 
%uporyado4em sobstvennie vektora v sootvetstvii s ind;
Psi=zeros(L,L);
for i=1:length(lam)
    Psi(:,i)=Fi(:,ind(i));
end
Fi=Psi;

%lam=-sort(-lam); %uporyadochili po ubivaniyu;

%sobstvennie vektora takje neobxodimo uporyadochit po ubianiyu:
Psi=zeros(L,L);
for j=1:L
    Psi(:,j)=Fi(:,L-j+1);
end
Fi=Psi; 

P=Fi;%P-ortogonal'naya matrica sobstvennix vektorov matrici V

%polu4aem matricu glavnix  komponent
Y=X*P; %stolbci matrici Y predstavlyayut soboy glavnie komponenti
%size(Y); %doljno bit' k x M;

%otbiraem nujnie komponenti
Y1=zeros(K,L);

v_komp=1:m; %zadaem vektor iz nomerov komponent kotorie otbiraem!!!
Y1(:,v_komp)=Y(:,v_komp);

%vosstanavlivaem matricu X, obozna4im ee 4erez X1
X1=Y1*P';


%%%%%%%%%%teper' sgladim ryad%%%%%%%%%%
xdet=zeros(1,N);
for i=1:L
    for j=1:i
        xdet(i)=xdet(i)+X1(i-j+1,j);
    end
    xdet(i)=xdet(i)/i;
end

K=N-L+1;
for i=L+1:K
    for j=1:L
        xdet(i)=xdet(i)+X1(i-j+1,j);
    end
    xdet(i)=xdet(i)/L;
end

for i=K+1:N
    for j=1:L-(i-K)
        xdet(i)=xdet(i)+X1(K-j+1,1+i-K +j-1);
    end
    xdet(i)=xdet(i)/(L-(i-K));
end



