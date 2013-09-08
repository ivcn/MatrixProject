function [E] = AnalyzW(B,mina, maxa,xo) 
% xa - max a
% xo - razmer okna
% flagw - risovat koef
% Date - nach data
n = size(B,2);   % количество точек ряда
wcoef = cwt(B,mina:maxa,'cmor2-1');

% subplot(2,1,1);
% imagesc(abs(wcoef).*abs(wcoef));
% set(gca,'YTick',1:10:maxa-mina+1);
% set(gca,'YTickLabel',mina:10:maxa);
% set(gca,'YDir', 'normal');
% colormap(jet)

Ew = sum(abs(wcoef(:,:)).^2);

xs=1;

%E=[];
E=zeros(1,n-xo+1);
while (xs+xo-1<=n)
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];   
  E(xs)=sum(Ew(1,xs:1:xs+xo-1)); 
  xs=xs+1;
end

% subplot(2,1,2);
% plot(E);
end