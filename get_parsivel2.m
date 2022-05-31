function [parsivel,D,vel]=get_parsivel2(filename)
% get_parsivel2 - Load variables from PARSIVEL2 file
%
%   This function loads data from filename and return a structure with data
%   S = get_parsivel2(filename)
%
%   Also you can use it for generate the diameter and velocity vectors
%   [S, D, vel] = get_parsivel2(filename)
%
% Created by: Jairo Valdivia - IGP                          Oct, 2017

D=[0.062:0.125:1.187, 1.375:0.25:2.375, 2.75:0.5:4.75, 5.5:9.5, 11:2:19, 21.5:3:24.5];
vel=[0.05:0.1:0.95, 1.1:0.2:1.9, 2.2:0.4:3.8, 4.4:0.8:7.6, 8.8:1.6:15.2, 17.6:3.2:20.8]';
if ~exist(filename,'file'), parsivel=[]; disp([filename,' not exist']),...
        return, end
fileID = fopen(filename);
h = textscan(fileID,'%s',2);
data=textscan(fileID,'%s','Delimiter',':','EndOfLine','\n');

fdot=find(filename=='.'); fdot=fdot(1)-1;
time=datevec(filename(fdot-13:fdot),'yyyymmddHHMMSS');
time=datenum(time);

if isempty(data{1})
    parsivel= struct(...
    'time',time,'RI',NaN,'dbZ',NaN,...
    'SYNOP4680',[],'SYNOP4677',[],...
    'N_d',[],'v_d',[],'raw',[]);
    fclose(fileID); 
    return 
end

sf=0;
while ~(strcmp(data{1}{sf+1},'01'))
    sf=sf+1;
    if sf>5
        error([filename, ' has incorrect format'])
        break
    end
end
ndpos=[];vdpos=[];rpos=[];
for ii = 0:round(length(data{1})/2)-(1+sf)
    pos=2*ii+1+sf;
    if strcmp(data{1}{pos},'90');
        ndpos=pos+1;
    elseif strcmp(data{1}{pos},'91');
        vdpos=pos+1;
    elseif strcmp(data{1}{pos},'93');
        rpos=pos+1;
    end
end
RI=str2double(data{1}{2+sf});
SYNOP4680=str2double(data{1}{6+sf});
SYNOP4677=str2double(data{1}{8+sf});
dbZ=str2double(data{1}{14+sf});

if isempty(ndpos)||isempty(vdpos)||isempty(rpos)
    disp([filename,' is corrupted file!'])
    fclose(fileID);
    parsivel= struct(...
    'time',time,'RI',RI,'dbZ',dbZ,...
    'SYNOP4680',SYNOP4680,'SYNOP4677',SYNOP4677,...
    'N_d',NaN(32,1),'v_d',NaN(32,1),'raw',NaN(32,32));
    return
end
N_d=str2num(data{1}{ndpos});
v_d=str2num(data{1}{vdpos});
raw=str2num(data{1}{rpos}); 
raw=reshape(raw,[32 32]); raw=rot90(flip(raw,2));
fclose(fileID);

parsivel= struct(...
    'time',time,'RI',RI,'dbZ',dbZ,...
    'SYNOP4680',SYNOP4680,'SYNOP4677',SYNOP4677,...
    'N_d',N_d,'v_d',v_d,'raw',raw);

