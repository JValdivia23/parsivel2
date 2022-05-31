function parsivel = timecutPSVstruct(data,stime,etime)
% catPSVstruct

pos = datenum(data.time) >= stime & datenum(data.time) <= etime;

time=data.time(pos);
RI=data.RI(pos);
dbZ=data.dbZ(pos);
SYNOP4680=data.SYNOP4680(pos);
SYNOP4677=data.SYNOP4677(pos);
N_d = data.N_d(:,pos);
v_d = data.v_d(:,pos);
raw= data.raw(:,:,pos);

D = data.D;
vel = data.vel;

parsivel= struct(...
    'time',time,'RI',RI,'dbZ',dbZ,...
    'SYNOP4680',SYNOP4680,'SYNOP4677',SYNOP4677,...
    'N_d',N_d,'v_d',v_d,'raw',raw,'D',D,'vel',vel);