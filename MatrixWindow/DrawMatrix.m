k=size(colormap,1);
max_color = get(handles.max_color, 'Value');
flag_wt = get(handles.flag_wt, 'Value');
% if (flag_wt == 0)
%     wd = handles.cur_matrix(:,:,c).*k.*k./(handles.cur_maxm*max_color);
% else
%     wd = (handles.cur_matrix(:,:,c)+abs(handles.minm_wt)).*k.*k./((abs(handles.minm_wt)+handles.cur_maxm)*max_color); 
% end
if (flag_wt == 0)
    wd = handles.cur_matrix(:,:,c).*k./(handles.cur_maxm);
else
    wd = (handles.cur_matrix(:,:,c)+abs(handles.minm_wt)).*k./(abs(handles.minm_wt)+handles.cur_maxm); 
end

ogr=eval(get(handles.ogr, 'String'));
ogr_verh=eval(get(handles.ogr_verh, 'String'));

%ogr = ogr*k/max_color;
%ogr_verh = ogr_verh*k/max_color;

wd = (wd>=ogr).*wd;
wd = (wd<=ogr_verh).*wd;

wd = wd.*(k/max_color);

wd = 64.*(wd>=64) + (wd<64).*wd;



% ogr=eval(get(handles.ogr, 'String'));
% ogr_verh=eval(get(handles.ogr_verh, 'String'));
% 
% ogr = ogr*k/max_color;
% ogr_verh = ogr_verh*k/max_color;
% 
% wd = (wd>=ogr).*wd;
% wd = (wd<=ogr_verh).*wd;

%—глаживание

smooth_on = get(handles.smooth_on, 'Value');

if (smooth_on ~= 0)
    smooth_size = eval(get(handles.smooth_size, 'String')); 
    smooth_count = eval(get(handles.smooth_count, 'String'));
    wd = smoothFilter(wd, smooth_size, smooth_count);
end