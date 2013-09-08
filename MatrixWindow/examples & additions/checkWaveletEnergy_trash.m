load('ANALYZED DATA sm0001 01 09 2011 d30 uf30 ut20 obr1 0 10 35 sigma1 pr5 cheb71 a1-36 b24 wt haar A3 lev5 thr0__for_test.mat','mat_wt');
sig = mat_wt{4};
Nr = size(sig,1);
Nc = size(sig,2);
Nt = size(sig,3);
days = 1:size(sig,3);
days = (days/144)+1;
win = 24;
energy = zeros(Nr,Nc,Nt-win+1);
for i=1:Nr
    for j=1:Nc
        i,j
        s = sig(i,j,:);
        s = s(:)';
        ww = cwt(s,1:36,'cmor2-1');
        Ew = sum(abs(ww).^2);
        pos=1;
        e=[];%zeros(1,Nt-win+1);
        while(pos+win-1<=Nt)%пока конечная позиция меньше или равна n
            e=[e sum(Ew(1,pos:1:pos+win-1))];
            %e(pos)=sum(Ew(pos:pos+win-1));%суммируем элементы внутри окна
            pos=pos+1;
        end
        energy(i,j,:) = e;
    end
end
E1 = sum(energy,1);
E2 = sum(E1,2);
E = E2(:)';
figure();
plot(E);
%ylim([min(E) max(E)]);