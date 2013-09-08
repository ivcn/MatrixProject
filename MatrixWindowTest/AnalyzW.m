function [E] = AnalyzW(B,mina, maxa,xo, flagw, Date, figname, metka)
%расчет вейвлет энергии и вывод ее на экран.
% xa - max a
% xo - razmer okna
% flagw - risovat koef
% Date - nach data
    n = size(B,2);% количество точек ряда

 % Data na OX
% if (flagw~=0)    %если надо рисовать окно
%     datestart=Date;
%     interval = n/144;
%     
%     enddate = datevec(addtodate(datenum(Date,'dd mm yyyy'),interval,'day'));
%     
%     datestart = datestr(datenum(datestart,'dd mm yyyy'));
%     enddate = datestr(enddate);
% 
%     xData = linspace(datenum(datestart),datenum(enddate),n);
% end

wcoef = cwt(B,mina:maxa,'cmor2-1');

if (flagw~=0)%если надо рисовать окно
    figure();
    subplot(2,1,1);%первая минифигура-картинка
    imagesc(abs(wcoef).*abs(wcoef));%посчитали коэффициенты и нарисовали
    %title(figname);
    set(gca,'YTick',1:10:maxa-mina+1);
    set(gca,'YTickLabel',mina:10:maxa);
    set(gca,'YDir', 'normal');
    colormap(jet)
end

Ew = sum(abs(wcoef(:,:)).^2);

xs=1;
E=zeros(1,n-xo+1);

while(xs+xo-1<=n)%пока конечная позиция меньше или равна n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(Ew(1,xs:1:xs+xo-1));%суммируем элементы внутри окна
  xs=xs+1;
end

if(flagw~=0)
    subplot(2,1,2)
%plot(1:n+1-xo, E);
%set(gca,'XTick', 0:200:n);
%xlim([0 n]);

    xData = 1:size(E,2);
    p = plot(xData(1:n+1-xo),E);
    set(p,'LineWidth',2);
    set(gca,'FontName','Arial Cyr');
    set(gca,'FontSize',20);
    %set(gca,'XTick',xData(1:metka*144:n));
    grid on;
    %datetick('x','m-dd','keeplimits','keepticks');
    %xlim([datenum(datestart) datenum(enddate)]);
end