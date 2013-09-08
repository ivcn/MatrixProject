clear;
%close all;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
sig = mat_intens{4};
sig1 = zeros(size(sig));
for pos_col = 1:size(sig,2)
    for pos_row = 1:size(sig,1)
        Ntime = size(sig,3);
        days = 1:Ntime;
        days = (days/144)+1;
        s = zeros(1,size(sig,3));
        temp_pos_col = pos_col;
        temp_pos_row = pos_row;
        for i=1:size(sig,3)
            s(i) = sig(temp_pos_row,temp_pos_col,i);
            if(temp_pos_col <= 1)
                temp_pos_col = size(sig,2);
            else
                temp_pos_col = temp_pos_col - 1;
            end
            if( temp_pos_row - size(sig,1)<1 )
                temp_pos_row = 1;
            else
                temp_pos_row = temp_pos_row+1;
            end
%             if ( temp_pos_col >= size(sig,2)/2 )
%                 if( temp_pos_row - size(sig,1)<1 )
%                     temp_pos_row = 1;
%                 else
%                     temp_pos_row = temp_pos_row+1;
%                 end
%             else
%                 if( temp_pos_row <=1 )
%                     temp_pos_row = size(sig,1);
%                 else
%                     temp_pos_row = temp_pos_row-1;
%                 end
%             end
        end
        sig1(pos_row,pos_col,:) = s;
    end
end

s = squeeze(sig1(30,50,:))';
figure(1);
plot(days,s,'k');
hold on;
t = ChebRazl(s,25,0);
swt = s-t;
plot(days,t,'r');
hold off;

figure(2);
plot(days,swt,'k');
hold on;
swn=fourier_proc(swt,0,0);
plot(days,swn,'r');
hold off;

e = AnalyzW(swn,1,40,1,1);
figure(4);
plot(days,e);