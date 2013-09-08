function [ out ] = smoothFilter1D( input, windowSize, times )
%SMOOTHFILTER1D Сглаживание одномерного ряда
N = size(input,2);
radius = fix(windowSize/2);
out = zeros(size(input));
temp = input;
for t=1:times
    out = zeros(size(input));
    for i=1:N
        count = 0;
        for j=i-radius:i+radius
            if( j>=1 && j<=N )
                count=count+1;
            end
        end
        count = count-1;
        for j=i-radius:i+radius
            if(j==i)
                out(i) = out(i) + temp(i)/2;
                continue;
            end
            if(j>=1 && j<=N)
                out(i) = out(i)+temp(j)/(2*count);
            end
        end
    end
    temp = out;
end

end