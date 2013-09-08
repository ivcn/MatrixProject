[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
signal = mat_intens{4};
win = 144;
normMatr = zeros(size(signal,1),size(signal,2),size(signal,3)-win+1);
for i=win:size(signal,3)
    normMatr(:,:,i-win+1) = signal(:,:,i)-mean(signal(:,:,i-win+1:i),3);
end

% day=1;
% while((day+1)*144 <= size(signal,3))
%     m = squeeze(mean(signal(:,:,(day-1)*144+1:day*144),3));
%     for i=day*144+1:(day+1)*144
%         normMatr(:,:,i-144) = signal(:,:,i)-m;
%     end
%     day = day+1;
% end
index = squeeze(sum(sum(normMatr,1),2))';
pos = win:size(signal,3);
pos = pos./win+1;

figure();
plot(pos,index,'k');
figure();
plot(squeeze(sum(sum(signal,1),2)));
AnalyzW(index,1,144,1,1);