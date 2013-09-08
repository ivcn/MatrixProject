%[filename pathname] = uigetfile('*.txt');
fid = fopen('B_16.08.11-30.09.11.txt');%strcat(pathname,filename));
D = textscan(fid,'%d %d %d %f %*[^\n]','CommentStyle','//');
fclose(fid);
data1 = D{4};

idx = data1>=999;
data1(idx) = 0;

fid = fopen('ProtonDensity_16.08.11-30.09.11.txt');%strcat(pathname,filename));
D = textscan(fid,'%d %d %d %f %*[^\n]','CommentStyle','//');
fclose(fid);
data2 = D{4};

idx = data2>=999;
data2(idx) = 0;

fid = fopen('Flow Speed_16.08.11-30.09.11.txt');%strcat(pathname,filename));
D = textscan(fid,'%d %d %d %f %*[^\n]','CommentStyle','//');
fclose(fid);
data3 = D{4};

idx = data3>=999;
data3(idx) = 0;

% fid = fopen('ProtonFlux10_16.08.11-30.09.11.txt');%strcat(pathname,filename));
% D = textscan(fid,'%d %d %d %f %*[^\n]','CommentStyle','//');
% fclose(fid);
% data4 = D{4};
% 
% idx = data4>=999;
% data4(idx) = 0;



x=1:size(data1,1);
days = x./24+1;

startDate = '16.08.2011';
endDate = '1.10.2011';

xData = linspace(datenum(startDate,'dd.mm.yyyy'),datenum(endDate,'dd.mm.yyyy'),size(data1,1))';
%hour = addtodate(datenum(startDate,'dd.mm.yyyy'),1,'hour')-datenum(startDate,'dd.mm.yyyy');
%xData = datenum(startDate,'dd.mm.yyyy'):hour:datenum(endDate,'dd.mm.yyyy');
testDate = datestr(xData);

figure();
subplot(311);
plot(xData,data1,'k');
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',xData(1:120:size(data1,1)));
xlim([xData(1) xData(size(data1,1))]);
ylim([0 30]);
datetick('x','m-dd','keepticks','keeplimits');
title('B');

subplot(312);
plot(xData,data2,'k');
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',xData(1:120:size(data1,1)));
xlim([xData(1) xData(size(data2,1))]);
ylim([0 40]);
datetick('x','m-dd','keepticks','keeplimits');
title('Proton Density');

subplot(313);
plot(xData,data3,'k');
set(gca,'FontName','Arial Cyr');
set(gca,'XTick',xData(1:120:size(data1,1)));
xlim([xData(1) xData(size(data3,1))]);
ylim([200 800]);
datetick('x','m-dd','keepticks','keeplimits');
title('Flow Speed');

% subplot(414);
% plot(xData,data4);
% set(gca,'FontName','Arial Cyr');
% set(gca,'XTick',xData(1:120:size(data4,1)));
% xlim([xData(1) xData(size(data4,1))]);
% datetick('x','m-dd','keepticks','keeplimits');
% title('Proton Flux (>10 MeV)');
