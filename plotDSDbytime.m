function plotDSDbytime(time,D,N_d)
% plotDSDbytime(time,D,N_d)
%   This function plots DSD by time (diameter vs time vs concentration)
%   
% JValdivia - 07, 2018
if ~isnumeric(time)
    time=datenum(time);
end
[t2, D2] = meshgrid(time, D);
if ndims(N_d)>2, N_d=squeeze(N_d); end
% if max(N_d(:))>1.5e1, N_d=log10(N_d); end
N_d(N_d<=-4)=NaN;
% gca;
pcolor(t2,D2,N_d)
shading flat
c1=colorbar;
colormap(jet(64))
ylim([0 8]), caxis([-3 4])
ylabel('Diameter [mm]'), ylabel(c1,'log_{10}Drop density')
set(gca,'ytick',0:2:8)

% f1.CurrentAxes.FontSize=11;
% f1.CurrentAxes.LineWidth=1.5;
hold on, plot(datetime(datevec(time)),time*NaN), hold off
xlim([time(1) time(end)])
% xt=f1.CurrentAxes.XTick;
% f1.CurrentAxes.XTick=xt;

