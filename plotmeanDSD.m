function f1 = plotmeanDSD(D,N_d,style)
% plotmeanDSD(D,N_d,style)
%   This function plot the mean DSD (concentration vs diameter)
%   D is de diameter class (mm), and N_d is concentration (log10(m^-3 mm^-1))
%   
% JValdivia - 07, 2018

if ndims(N_d)>2, N_d=squeeze(N_d); end
if max(N_d(:))>1e1, N_d=log10(N_d); end
N_d(N_d<=-4)=NaN;

N_d=10.^N_d;
N_d(isnan(N_d))=0;
Nmean=mean(N_d,2);
if exist('style','var')
    f1 = plot(D,Nmean,style,'LineWidth',2);
else
    f1 = plot(D,Nmean,'LineWidth',2);
end
% set(gca,'LineWidth',2)
ylim([10^-4 10^4])
xlim([0 8])
set(gca,'yscale','log')
set(gca,'xtick',0:2:8)
