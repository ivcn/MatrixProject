% Prompts for the parameters
answer = inputdlg({['Averaging interval (T):'] ['Start point offset:']...
    ['End point index:']...
    ['Alpha - end value for tau (in units of T):']...
    ['Sliding subinterval (delta T)']...
    ['Step size (delta t):'] ['Order of difference moment']...
    ['Type, regular(0) or cumulant(1):']...
    ['Value for missing data (FNS only, -1 - no missing data):']...
    ['Percent of gaps allowed:']...
    ['X axis (real: 0; points: 1):']...
    ['Normalized (no: 0; yes: 1):']},...
    'Parameters for nonstationarity factor',1,...
    {['400'] ['0'] ['32042'] ['0.5'] ['1'] ['1'] ['2'] ['0'] ['-1'] ['25'] ['0'] ['1']});

result = str2double(answer);

T = result(1);
TStart = result(2);
TEnd = result(3);
alpha = result(4);
subinterval = result(5);
DeltaT = result(6);
Ord = result(7);
type = result(8);
nGap = result(9);
nPercentGap = result(10);
bGraph = result(11);
nNorm = result(12);

%Prompts for the source file name
[FileName1,PathName1] = uigetfile('*.txt','Choose the first file');
M1=[PathName1,FileName1]; 

[m, NF] = nonstationarity(T,TEnd,alpha,subinterval,TStart,DeltaT,Ord,type,M1,nGap,nPercentGap,nNorm);

figure();

if bGraph == 1
    x = (1+TStart+T:subinterval:1+(length(NF)-1)*subinterval+TStart+T);
end

if bGraph == 0
    m=(m./144)+1;
    plot(m,NF);
    xlim([m(1) m(end)]);
else
    plot(x,NF);
    x=x./144+1;
    xlim([x(1) x(end)]);
end
xlabel('t','fontsize',16);

if isequal(type,0)
    stype = 'regular';
else
    stype = 'cumulant';
end
ylabel(['nonstationarity; type: ' stype '; order: '  num2str(Ord)],'fontsize',16);

title({['T = ',num2str(T),...
    ', \alpha = ', num2str(alpha),...
    ', \DeltaT = ', num2str(subinterval),...
    ', tstart = ',num2str(TStart),...
    ', \Deltat = ',num2str(DeltaT), ', FileName: ',num2str(FileName1)]});

%Save the results using the tab-delimited format
button = questdlg('Do you want to save the results?','Results','Yes');
if isequal(button,'Yes')
   [FileName2,PathName2]=uiputfile('*.txt','Specify the output file');
   dlmwrite([PathName2,'\',FileName2],[m', NF'],'delimiter','\t', 'precision', 15);
end