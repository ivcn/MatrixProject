clear;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
sig = mat_intens{4};
Ntime = size(sig,3);
%days = 1:Ntime;
%days = (days/144)+1;
sig6 = zeros(1,size(sig,3)/6);

for i = 1:size(sig,1)
    for j = 1:size(sig,2)
        for k = 1:size(sig,3)/6
            sig6(i,j,k) = mean(sig(i,j,(k-1)*6+1:k*6));
        end
    end
end
s = squeeze(sig6(5,5,:))';
t = ChebRazl(s,25,0);
days = (1:size(s,2))/24+1;
figure();
plot(days,s);
hold on;
plot(days,t,'r');
hold off;

e = AnalyzW(s-t,1,7,1,1);

figure();
plot(days,e);