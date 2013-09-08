%[filename pathname] = uigetfile('*.txt');
fid = fopen('РусГидро15.txt');%strcat(pathname,filename));
D = textscan(fid,'%s %s %f %f %f %f %*[^\n]','CommentStyle','//');
fclose(fid);
data1 = D{4};%close
%data_low = D{5};%low
%data_high = D{4};%high
%data_open = D{3};%open
date = D{1};
time = D{2};

DateTime = strcat(cell2mat(date),32,cell2mat(time));

indexes = 1:size(data1,1);
indexes = indexes';
s = [indexes data1];

T = 160;
subinterval = 1;
TStart=0;

[m1 nf_data1] = nonstationarity(T,size(s,1),0.5,subinterval,TStart,1,2,0,s,-1,25,1);
%[mPT nf_PT] = nonstationarity(T,size(needed_dataPT,1),0.5,subinterval,TStart,1,2,0,dataPT,-1,25,1);
xData = datenum(DateTime,'dd.mm.yyyy HHMMSS');
xs = 1:size(data1,1);
x = (1+TStart+T:subinterval:1+(length(nf_data1)-1)*subinterval+TStart+T);
xData1 = xData(x)';
figure();
%subplot(311);
plot(x,nf_data1,'k');
set(gca,'FontName','Arial Cyr');

%set(gca,'XTick',xData1(1:4*floor(34/subinterval):size(xData1,2)));
xlim([x(1) x(size(x,2))]);
%ylim([0 30]);
%datetick('x','m-dd','keepticks','keeplimits');

figure();
plot(xs,data1,'k');
set(gca,'FontName','Arial Cyr');
%set(gca,'XTick',xData(1:4*34:size(xData,1)));
xlim([xs(1) xs(size(xs,2))]);
%datetick('x','m-dd','keepticks','keeplimits');