clear;
x =1:0.01:5;
y=zeros(size(x));
y(1:end) = 1;%cos(5.*x(1:end));
y(200:250) = 5;
%[filename pathname] = uigetfile('*.mat');
%load(strcat(pathname,filename),'mat_intens');
%signal = mat_intens{4};
%sizeT = size(signal,3);
%s= zeros(1,sizeT);
% for i=1:sizeT
%     s(i) = sum(sum(signal(:,:,i)));
% end

mina = 1;
maxa = 36;
figure();
plot(y,'k');
axis([0 400 0 6]);

e = mycwt(y,mina,maxa);
%figure();
%imagesc(abs(c).^2);
%set(gca,'YTick',1:10:maxa-mina+1);
%set(gca,'YTickLabel',mina:10:maxa);
%set(gca,'YDir', 'normal');
%colormap(jet);
figure();
plot(e,'k');
set(gca,'FontName','Arial Cyr','FontSize',12);
xlim([0 400]);
sum(e)
e = AnalyzW(y,mina,maxa,1,1);
figure();
plot(e,'k');
set(gca,'FontName','Arial Cyr','FontSize',12);
xlim([0 400]);
%sum(e)
