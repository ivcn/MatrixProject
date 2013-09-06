function [ output ] = smoothFilter( input, windowSize, times )
%SMOOTHFILTER Summary of this function goes here
%   Detailed explanation goes here
Nrow = size(input,1);
Ncol = size(input,2);

radius = fix(windowSize/2);
in_ = input;
for t=1:times
output = zeros(size(input));
for i=1:Nrow
    for j=1:Ncol
         count = 0;
         for i_=i-radius:i+radius
             for j_=j-radius:j+radius
                 if( (i_>0)&&(i_<=Nrow)&&(j_>0)&&(j_<=Ncol) )
                   count = count + 1;
                 end
             end
         end
         count=count-1;
         
         for i_=i-radius:i+radius
             for j_=j-radius:j+radius
                 if( (i_==i)&&(j_==j) )
                     output(i,j) = output(i,j)+in_(i,j)/2;
                     continue;
                 end
                 if( (i_>0)&&(i_<=Nrow)&&(j_>0)&&(j_<=Ncol) )
                   output(i,j) = output(i,j)+in_(i_,j_)/(2*count);
                 end
             end
         end
    end
end
in_ = output;                       
end

end