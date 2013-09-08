clear;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
sig = mat_intens{4};
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;
inter = 48;
sig1 = zeros(size(sig,1),size(sig,2),size(sig,3)/inter);
%s = squeeze(mean(sig(floor(size(sig,1)/2),:,:),2))';
%sig1 = zeros(size(sig));
k=2;
sig1(:,:,1) = sig(:,:,1);
for i=1:size(sig,3)
    if( rem(i,inter)==0 )
        sig1(:,:,k) = sig(:,:,i);
        k=k+1;
    end
end
s=zeros(1,size(sig1,3));
for i = 1:size(sig1,3)
    s(i) = mean(mean(sig1(:,:,i)));
end
days = 1:size(s,2);
day=24/(inter/6);
days = (days/day)+1;

days = 1:size(s,2);
day=24/(inter/6);
days = (days/day)+1;
figure();
plot(days,s,'k');
hold on;
h = 0;
l=1;
while abs(h-0.5)>0.1
    res = s-ChebRazl(s,l,0);
    R = max(res-mean(res))-min(res-mean(res));
    S = std(res);
    h = log(R/S)/log(1.5*length(res))
    l=l+1;
end
l
t = ChebRazl(s,l,0);
swt = s-t;
plot(days,t,'r');
hold off;

e = AnalyzW(swt,1,136,1,1);
figure(4);
plot(days,e);