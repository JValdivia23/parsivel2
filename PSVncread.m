function parsivel=PSVncread(file)
% This function reads a NetCDF file from PSV structure and return a
% structure.
% Use:      parsivel = PSVncread(file)
%       
% JValdivia - 08/2019

time = ncread(file,'time');
RI = ncread(file,'RR');
dbZ = ncread(file,'Z');
SYNOP4680 = ncread(file,'SYNOP4680');
SYNOP4677 = ncread(file,'SYNOP4677');
N_d = ncread(file,'Nd');
raw = ncread(file,'raw');
D = ncread(file,'D');
vel = ncread(file,'vel');
vspread = ncread(file,'vspread');
dspread = ncread(file,'dspread');
parsivel= struct(...
    'time',time,'RI',RI,'dbZ',dbZ,...
    'SYNOP4680',SYNOP4680,'SYNOP4677',SYNOP4677,...
    'N_d',N_d,'v_d',v_d,'raw',raw,'D',D,'vel',vel,...
    dspread,'dspread',vspread,'vspread');