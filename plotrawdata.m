function plotrawdata(D,vel,raw)
% plotrawdata(D,vel,raw)
%   This function plots the raw data (velocity vs diameter)
%   D is diameter (mm), vel is velocity (m s^-1), and raw is the drops
%   number
%   
% JValdivia - 07, 2018


% raw = raw/max(raw(:)) * 100; % normalized to max value
dD=[ones(1,10)*0.125, ones(1,5)*0.25, ones(1,5)*0.5, ones(1,5), ones(1,5)*2, ones(1,2)*3];
pcolor(D-dD/2,vel-0.05,log10(sum(raw,3)))

try
    colormap(boonlib('airmap',64))
catch
end
xlim([0 8])
ylim([0 15.15]) %
caxis([0 3])
%colorbar;
shading flat
% h.Ruler.Scale='log';
% h.Ruler.MinorTick='on';

hold on
range=150:31.17:13000;
masl=3230;
nue = 1+3.68*10^-5.*(range+masl)+1.71*10^-9.*(range+masl).^2; nue=[1,nue];
D=0.1:0.1:8;
v=(9.65-10.3*exp(-0.6*D))*nue(2);
v0=(9.65-10.3*exp(-0.6*D))*nue(1);
plot(D,v,'k','LineWidth',1), hold on, plot(D,v0,'--','LineWidth',1)
hold off
set(gca,'xtick',0:2:8)
% c=colorbar('Location','north','Box','off');
% cpos=c.Position;
% c.Position = [cpos(1) cpos(2)+cpos(4)*0.75 cpos(3) cpos(4)/2];
% labs=c.TickLabels;
% c.TickLabels=cellfun(@(x) ['10^',x],labs,'UniformOutput',0);