function PSVstruct2nc(data,dpath)
% This function create a NetCDF file from DSD structure
% Use:      ncDSDstruct(data,dpath)
%       data is DSD structure, a dpath is the folder of output
% JValdivia - 08/2019


file=['PARSIVEL_',datestr(data.time(1),'yyyymmdd'),...
    '.nc'];
name=[dpath,file];
if exist(name,'file'), disp('Overwritting file!'), delete(name), end
dimt=numel(data.time);
dimd=numel(data.D);
dimv=numel(data.vel);

dD=[ones(1,10)*0.125, ones(1,5)*0.25, ones(1,5)*0.5, ones(1,5), ones(1,5)*2, ones(1,2)*3];
dvel=[ones(1,10)*0.1, ones(1,5)*0.2, ones(1,5)*0.4, ones(1,5)*0.8, ones(1,5)*1.6, ones(1,2)*3.2]';

nccreate(name,'time','Dimensions',{'time',Inf},'Format','classic')
nccreate(name,'D','Dimensions',{'D',dimd},'Datatype','single')
nccreate(name,'vel','Dimensions',{'vel',dimv},'Datatype','single')

nccreate(name,'RR','Dimensions',{'time',dimt},'Datatype','single')
nccreate(name,'Z','Dimensions',{'time',dimt},'Datatype','single')
nccreate(name,'SYNOP4680','Dimensions',{'time',dimt},'Datatype','single')
nccreate(name,'SYNOP4677','Dimensions',{'time',dimt},'Datatype','single')
nccreate(name,'Nd','Dimensions',{'D',dimd,'time',dimt},'Datatype','single')
nccreate(name,'raw','Dimensions',{'vel',dimv,'D',dimd,'time',dimt},'Datatype','single')
nccreate(name,'dspread','Dimensions',{'D',dimd},'Datatype','single')
nccreate(name,'vspread','Dimensions',{'vel',dimv},'Datatype','single')

% nccreate(name,'Ze','Dimensions',{'range',dimd,'time',dimt},'Datatype','single')
% nccreate(name,'VEL','Dimensions',{'range',dimd,'time',dimt},'Datatype','single')
% nccreate(name,'RMS','Dimensions',{'range',dimd,'time',dimt},'Datatype','single')
% nccreate(name,'HSDco','Dimensions',{'range',dimd,'time',dimt},'Datatype','single')
% nccreate(name,'PIA','Dimensions',{'range',dimd,'time',dimt},'Datatype','single')
% nccreate(name,'velshift','Datatype','int16')
% nccreate(name,'ERRmod','Dimensions',{'time',dimt},'Datatype','single')
% nccreate(name,'WetAtt','Dimensions',{'time',dimt},'Datatype','single')

ncwrite(name,'time',data.time)
ncwrite(name,'D',data.D)
ncwrite(name,'vel',data.vel)

ncwrite(name,'RR',single(data.RI))
ncwrite(name,'Z',single(data.dbZ))
ncwrite(name,'SYNOP4680',single(data.SYNOP4680))
ncwrite(name,'SYNOP4677',single(data.SYNOP4677))
ncwrite(name,'Nd',single(data.N_d))
ncwrite(name,'raw',single(data.raw))
ncwrite(name,'vspread',dvel)
ncwrite(name,'dspread',dD)
% ncwrite(name,'VEL',single(data.vlx))
% ncwrite(name,'RMS',single(data.vvx))
% ncwrite(name,'HSDco',single(data.HSDV_co))
% ncwrite(name,'PIA',single(data.PIA))
% ncwrite(name,'velshift',data.fix)
% ncwrite(name,'ERRmod',data.Er)
% ncwrite(name,'WetAtt',data.wetatt)

ncwriteatt(name,'time','long_name','Days since 01.01.0000 00:00 UTC (MatLab format)')
ncwriteatt(name,'time','units','days')
ncwriteatt(name,'D','long_name','Drop diameter bin centred')
ncwriteatt(name,'D','units','mm')
ncwriteatt(name,'vel','long_name','Drop velocity')
ncwriteatt(name,'vel','units','m/s')
ncwriteatt(name,'vspread','long_name','Bin class spread velocity')
ncwriteatt(name,'vspread','units','mm')
ncwriteatt(name,'dspread','long_name','Bin class spread diameter')
ncwriteatt(name,'dspread','units','mm')

ncwriteatt(name,'RR','long_name','Rain Rate')
ncwriteatt(name,'RR','units','mm/h')
ncwriteatt(name,'Z','long_name','Radar Reflectivity Factor Z')
ncwriteatt(name,'Z','units','dBZ')
ncwriteatt(name,'SYNOP4680','long_name','Weather code acc. to SYNOP; Table 4680')
ncwriteatt(name,'SYNOP4680','units',' ')
ncwriteatt(name,'SYNOP4677','long_name','Weather code acc. to SYNOP; Table 4677')
ncwriteatt(name,'SYNOP4677','units',' ')
ncwriteatt(name,'Nd','long_name','Drop density')
ncwriteatt(name,'Nd','units','log 1/m^3 mm')
ncwriteatt(name,'raw','long_name','Raw data')
ncwriteatt(name,'raw','units','1')


