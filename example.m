%% leer datos de PARSIVEL2

% direccion de los archivos:
ruta1='/Volumes/KINGSTON/PSVs/PSV2a/';
ruta2='/Volumes/KINGSTON/PSVs/PSV2b/';

% lectura de PSV2a
files1=dir([ruta1,'*.txt']);
files1([files1.bytes]~=5209)=[];
for ii = 1:length(files1)
    filename=[ruta1,files1(ii).name];
    psv2a(ii)=get_parsivel2(filename);
end

PSV2a=catPSVstruct(psv2a);

%% Plot raw data
figure(1)
plotrawdata(PSV2a.D,PSV2a.vel,PSV2a.raw)

%% Plot DSD vs time
figure(2)
plotDSDbytime(PSV2a.time,PSV2a.D,PSV2a.N_d)

%% Mean DSD
figure(3)
plotmeanDSD(PSV2a.D,PSV2a.N_d)

%%
filename='J:\Otros\PARSIVEL2\PSV2a\20180807\00PARSIVEL_20180807222500.txt';
data=get_parsivel2(filename);
disp(data)
[data,D,vel]=get_parsivel2(filename);
%%
ruta='J:\Otros\PARSIVEL2\PSV2a\20180807\';
files=dir([ruta,'*.txt']);
files([files.bytes]~=5209)=[];
for ii = 1:length(files)
    filename=[ruta,files(ii).name];
    datos(ii)=get_parsivel2(filename);
end
PSV2=catPSVstruct(datos)
%%
stime=datenum(2018,8,7,14,50,0);
etime=datenum(2018,8,7,15,50,0);
parsivel = timecutPSVstruct(PSV2,stime,etime);
figure(1)
plotrawdata(parsivel.D,parsivel.vel,parsivel.raw)
xlabel('Diameter [mm]')
ylabel('Velocity [m s^{-1}]')
title('Numero de gotas [log(N)]')
plotDSDbytime(parsivel.time,parsivel.D,parsivel.N_d)
xlabel('Tiempo [UTC-5]')
plotmeanDSD(parsivel.D,parsivel.N_d)
xlabel('Diameter [mm]')
ylabel('Drop concentration [log(m^{-3} mm^{-1})]')