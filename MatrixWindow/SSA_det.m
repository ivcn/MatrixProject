function xglav=SSA_det(x,mm)
%Функция возвращает mm-компоненту SSA-разложения.

N=length(x);
M=fix((N-1)/2)-1;

k=N-M+1;

X=zeros(k,M);
for i=1:k
    X(i,:)=x(i:M+i-1);
end

V=(1/k)*X'*X;

[Fi,Lam]=eig(V);

lam=diag(Lam);

[lam, ind]=sort(lam);

Psi=zeros(M,M);
for i = 1 : length(lam)
    Psi(:,i)=Fi(:,ind(i));
end
Fi=Psi;

lam=-sort(-lam);%%uporyadochili po ubivaniyu;

Psi=zeros(M,M);
for j=1:M
    Psi(:,j)=Fi(:,M-j+1);
end
Fi=Psi;

P=Fi;%P-ortogonal'naya matrica sobstvennix vektorov matrici V
Y=X*P;%stolbci matrici Y predstavlyayut soboy glavnie komponenti

Y1=zeros(k,M);
Y1(:,mm)=Y(:,mm);

X1=Y1*P';

xdet=zeros(size(x));

for i=1:M
    for j=1:i
        xdet(i)=xdet(i)+X1(i-j+1,j);
    end
    xdet(i)=xdet(i)/i;
end

k=N-M+1;
for i= M+1 : k
    for j=1:M
        xdet(i)=xdet(i)+X1(i-j+1,j);
    end
    xdet(i)=xdet(i)/M;
end

for i = k+1 : N
    for j = 1 : M-(i-k)
        xdet(i)=xdet(i)+X1(k-j+1,1+i-k +j-1);
    end
    xdet(i)=xdet(i)/(M-(i-k));
end

xglav=xdet;%vibrali glavnie komponenti;