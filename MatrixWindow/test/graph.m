x=0:0.1:5;
f=(x.^2).*log2(x);
f2=2.^(x.^2);
plot(x,f,'k');
hold on;
plot(x,f2);