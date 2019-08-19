function parsivel = catPSVstruct(data)
% catPSVstruct(data)
%   This function merge a vector of structures of PARSIVEL2 data
%   
% JValdivia - 07, 2018

time=[data(:).time];
RI=[data.RI];
dbZ=[data.dbZ];
SYNOP4680=[data.SYNOP4680];
SYNOP4677=[data.SYNOP4677];
N_d=[data.N_d];
v_d=[data.v_d];
raw=cat(3,data.raw);

D=[0.062:0.125:1.187, 1.375:0.25:2.375, 2.75:0.5:4.75, 5.5:9.5, 11:2:19, 21.5:3:24.5];
vel=[0.05:0.1:0.95, 1.1:0.2:1.9, 2.2:0.4:3.8, 4.4:0.8:7.6, 8.8:1.6:15.2, 17.6:3.2:20.8]';

parsivel= struct(...
    'time',time,'RI',RI,'dbZ',dbZ,...
    'SYNOP4680',SYNOP4680,'SYNOP4677',SYNOP4677,...
    'N_d',N_d,'v_d',v_d,'raw',raw,'D',D,'vel',vel);
