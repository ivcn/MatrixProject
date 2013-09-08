clear;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_wt');
sig = mat_wt{4};
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;

%сглаживание 3д
newSig = zeros(size(sig));
sizeR = size(sig,1);
sizeC = size(sig,2);

for i=1:sizeR
    i
    for j=1:sizeC
        for k=1:Ntime
            newSig(i,j,k) = mean(mean(mean(sig(max(i-1,1):min(i+1,sizeR),max(j-1,1):min(j+1,sizeC),max(k-1,1):min(k+1,Ntime)))));
        end
    end
end

% figure();
% plot(days,squeeze(sig(5,5,:)));
% hold on;
% plot(days,squeeze(newSig(5,5,:)),'k');
% hold off;
% uisave('newSig');

s = squeeze(mean(mean(sig(:,:,:))))';
figure();
plot(days,s);
e = AnalyzW(s,1,36,1,1);
plot(days,e);