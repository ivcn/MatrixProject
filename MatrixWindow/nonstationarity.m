function [m, NF] = nonstationarity(T,TEnd,alpha,subinterval,TStart,DeltaT,Ord,type,M1,nGap,nPercentGap,nNorm);

%----------------------------NONSTATIONARITY-------------------------------
%T - averaging interval;
%TEnd - end of calculation;
%alpha - the value of alpha - range where tau is evaluated;
%subinterval - sliding interval;
%Tstart - start time;
%DeltaT - step size;
%Ord - difference moment order
%type - type of difference moment
%    'cumulant'
%    'regular'
%M1 - file name and path;
%--------------------------------------------------------------------------

%Loading the data of the first file into a matrix
%V=dlmread(M1,'\t',0,0);
V=M1;

if TEnd>length(V)
    TEnd = length(V);
end

%gets each DeltaT records
if DeltaT > 1
   Vtmp = V(1:DeltaT:size(V,1),:); 
   clear V;
   V = Vtmp;
   clear Vtmp;
end

N = floor(T/DeltaT);
%NEndPoint = floor((TEnd-T)/subinterval);
NEnd = floor((TEnd-TStart-T)/subinterval);
NTau = floor(alpha*T/DeltaT);
NStart = floor(TStart/DeltaT);
NSubint = floor(subinterval/DeltaT);
NF=zeros(1,NEnd);

for k = 0:(NEnd-1)
   Q2 = sum( diffmomentSub(V((1+k*NSubint+NStart):(N+k*NSubint+NStart),2),N,NTau,Ord,type,nGap, nPercentGap) );
   Q1 = sum( diffmomentSubNonstatC(V((1+k*NSubint+NStart):(N+k*NSubint+NStart),2),N,NTau,Ord,type,nGap, nPercentGap,NSubint) );
   if isequal(Q2,0)
       NF(k+1) = 0;
   else
       if nNorm == 1
           NF(k+1) = 2*N/NSubint*(Q2-Q1)/(Q2+Q1);
       else
           NF(k+1) = (Q2-Q1)/NSubint;
       end
   end
end

mrange = (1+N+NStart):NSubint:(1+(NEnd-1)*NSubint+N+NStart);
m=V(mrange,1)';
