function [events] = find_events(time,rr,ndrops)
% fin_events(time,rr,ndrops)
%   This function uses the Tokay 2014 definition to find rain eventsm using
%   the time, rain rate (rr) and total particle (ndrops).
%   
% JValdivia - 02, 2021

rain=(rr(:)>0.1 & ndrops(:)>10);
d1=find(diff([0 rain' 0])); % primera derivada
d2=diff(d1); % segunda derivada
iS=d1(1:2:end-1); % ubicación de los inicios
dS=d2(1:2:end); % duración de los eventos
nor=d2(2:2:end); % free-rain time

% filtro de 2h
ni=find(nor>120);
ni=[0 ni length(iS)];

for ii = 1:length(ni)-1
    re(ii)={rr(iS(ni(ii)+1):iS(ni(ii+1))+dS(ni(ii+1))-1)};
    retime(ii)={time(iS(ni(ii)+1):iS(ni(ii+1))+dS(ni(ii+1))-1)};
end

start1=cellfun(@(v) (v(1)),retime);
end1=cellfun(@(v) (v(end)),retime);
durat1=cellfun(@length, re); % mins
intmx1=cellfun(@max, re); %max intensity
total1=cellfun(@nansum,re)./60; % total rain mm
r_min=cellfun(@(v) (sum(v>0)), re);
missing=cellfun(@(v) (sum(isnan(v))/length(v)*100), re);
% filtro de intensidad
yes=total1>1;

% continuar con la tabla
ind1=dsearchn(time(:),start1(:));
ind2=dsearchn(time(:),end1(:));
events = struct(...
    'start',start1(yes),'end',end1(yes),'duration',durat1(yes),'ptotal',total1(yes),...
    'intmax',intmx1(yes),'rainymin',r_min(yes),'missdata',missing(yes),'ind1',ind1(yes),'ind2',ind2(yes)...
    );

