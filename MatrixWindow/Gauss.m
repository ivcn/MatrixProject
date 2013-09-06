function Gauss(G)
%GAUSS    Create plot of datasets and fits
%   GAUSS(G)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

% This function was automatically generated on 28-Sep-2010 15:23:09
 
% Data from dataset "G data":
%    Y = G
 
% Remove missing values
t_ = ~isnan(G);
G = G(t_);

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
ax_ = newplot;
set(ax_,'Box','on');
hold on;

 
% --- Plot data originally in dataset "G data"
G = G(:);
[F_,X_] = ecdf(G,'Function','cdf'...
              );  % compute empirical cdf
Bin_.rule = 1;
[C_,E_] = dfswitchyard('dfhistbins',G,[],[],Bin_,F_,X_);
[N_,C_] = ecdfhist(F_,X_,'edges',E_); % empirical pdf from cdf
h_ = bar(C_,N_,'hist');
set(h_,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
       'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
legh_(end+1) = h_;
legt_{end+1} = 'G data';

% Nudge axis limits beyond data limits
xlim_ = get(ax_,'XLim');
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end

x_ = linspace(xlim_(1),xlim_(2),100);

% --- Create fit "fit 1"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     p_ = [-1.09158881589e-014, 1];
pargs_ = cell(1,2);
[pargs_{:}] = normfit(G, 0.05);
p_ = [pargs_{:}];
y_ = normpdf(x_,p_(1), p_(2));
h_ = plot(x_,y_,'Color',[1 0 0],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_;
legt_{end+1} = 'fit 1';

hold off;
legend(ax_,legh_, legt_, 'Location','NorthEast');
