function [ output ] = smoothFilter3D( input,windowSize,times )
%SMOOTHFILTER3D Summary of this function goes here
%   Detailed explanation goes here
Nrow = size(input,1);
Ncol = size(input,2);
Ntime = size(input,3);
radius = fix(windowSize/2);
in_ = input;
for t=1:times%количество итераций
output = zeros(size(input));
for time = 1:Ntime
for i=1:Nrow
    for j=1:Ncol
         count = 0;
         for time_=time-radius:time+radius
            for i_=i-radius:i+radius
                for j_=j-radius:j+radius
                    if( (i_>0)&&(i_<=Nrow)&&(j_>0)&&(j_<=Ncol)&&(time_>0)&&(time_<=Ntime) )
                        count = count + 1;
                    end
                end
            end
         end
         count=count-1;
         
         for time_=time-radius:time+radius
            for i_=i-radius:i+radius
                for j_=j-radius:j+radius
                    if( (i_==i)&&(j_==j)&&(time_==time) )%центр кубика
                        output(i,j,time) = output(i,j,time)+in_(i,j,time)/2;
                        continue;
                    end
                    if( (i_>0)&&(i_<=Nrow)&&(j_>0)&&(j_<=Ncol)&&(time_>0)&&(time_<=Ntime) )
                        output(i,j,time) = output(i,j,time)+in_(i_,j_,time_)/(2*count);
                    end
                end
            end
         end
    end
end
in_ = output;                       
end

end