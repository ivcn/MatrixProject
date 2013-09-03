function [ B ] = UdalVibr( A, l )
%UDALVIBR Summary of this function goes here
%   Udalyaet vibrosi ryada s otkloneniem > l sigm. 
sredn = mean(A);
sigma = std(A);

B=A;

n=size(B,2);
for i=1:n
    if abs(B(i)-sredn)>l*sigma
        %B(i)=sredn;
        k1 = i-5;
        if k1<1 
            k1=1;
        end
        
        k2=n;
        flag = 0;
        for t = i:i+5
            if (flag==0)
                if t==n
                    flag=1;
                    k2=t;
                end
            end
        end
        
        if flag==0
            k2=i+5;
        end
        
        B(i)=(B(k1)+B(k2))/2;
    end
end



end

