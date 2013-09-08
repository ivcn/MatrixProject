[filename pathname]=uigetfile('*.txt');
a = dlmread(strcat(pathname,filename));
a = a (:,2)';
e = AnalyzW(a,1,36,1,1);
figure();
plot(e,'k');
