%[filename pathname]=uigetfile('*.mat');
%load(strcat(pathname,filename),'mat_intens');
%signal = mat_intens{4};
function [diff] = diffSignal(signal)
%returns difference betweeen every matrix
nX = size(signal,1);
nY = size(signal,2);
nT = size(signal,3);
diffSignal = zeros(nX,nY,nT);
for i = 1:nT-1
    diffSignal(:,:,i)=signal(:,:,i+1)-signal(:,:,i);
end
diff = diffSignal;
end