# parsivel2
A MATLAB toolbox for reading, plotting and manipulating OTT Parsivel2 disdrometer 'raw' data.
[![DOI](https://zenodo.org/badge/203242951.svg)](https://zenodo.org/badge/latestdoi/203242951)

## Overview
The OTT Parsivel2 is a laser-optical disdrometer that measures the size and velocity of
hydrometeors (Loffler-Mang and Joss, 2000). Usually the sampling output is 1 min,
in a text file. The Parsivel2 provides the number of drops in a 32x32 size versus fall velocity matrix.
Additionally, the rain rate, radar reflectivity factor and other rain parameters are computed
from drop size distribution.
This toolbox include some functions for reading, plotting and manipulate the data.

## Functions
**get_parsivel** - The function reads the time and date of sampling (MATLAB time [days since year 0]), 
rainfall intensity (mm / h), reflectivity (dBZ), synoptic codes SYNOP 4680 and 4677 
(see PARSIVEL2 manual), drop concentration (log [1 / m mm]), velocities (m / s), 
and raw data of sizes versus velocity (1).

**cat_PSVstruct** - The following function is useful for combining the information of several files into a single structure.
The function uses input an array of data structures and assembles it into one.

**timecutPSVsctturct** - The following script is for cutting structures that have more 
data than desired. The function uses input a data structure and the start and end times 
that interest and throws a new structure with the indicated period.

**plotrawdata** - The following function serves to graph the raw data of size versus fall rate.
The function uses the vectors of diameters, velocity and the raw data matrix to generate a graph. 
The graph also includes the reference lines based on the diameter-speed ratio of 
Gunn and Kinzer (1949) and the height correction based on the approach of Foote and Du Toit (1969).

**plotDSDbytime** - The following function serves to graph the distribution of the droplet size in relation to time.
The function uses the vectors of time, diameter and the concentration matrix of drops.

**plotmeanDSD** - The following function graphs the average of drop size distribution for a group of input data.
The function uses the diameter vector and the drop concentration matrix to graph a line of the average concentration versus the drop diameter.

## Syntax

```Matlab
	parsivel = get_parsivel2(filename)
	
	[parsivel,D,vel]=get_parsivel2(filename)
	
	parsivel = catPSVstruct(data)
	
	parsivel = timecutPSVstruct(data,stime,etime)
	
	plotrawdata(D,vel,raw)
	
	plotDSDbytime(time, D, N_d)
	
	plotmeanDSD(D, N_d)
	
	plotmeanDSD(D, N_d, sytle)
```

## Examples

**1** - Reading the file *00PARSIVEL_20180807222500.txt*, that is on the folder *\PARSIVEL2\\*:
```Matlab
filename='.\PARSIVEL2\00PARSIVEL_20180807222500.txt';
data=get_parsivel2(filename)

Out>>
data = 

         time: 7.3728e+05
           RI: 0
          dbZ: -9.9990
    SYNOP4680: 0
    SYNOP4677: 0
          N_d: [32x1 double]
          v_d: [32x1 double]
          raw: [32x32 double]

```

**2** - Reading all files on the folder *\PARSIVEL2\\* and get an only structure *PSV2*:
```Matlab
ruta='.\PARSIVEL2\';
files=dir([ruta,'*.txt']);
for ii = 1:length(files)
    filename=[ruta,files(ii).name];
    datos(ii)=get_parsivel2(filename);
end
PSV2=catPSVstruct(datos)

Out>>
PSV2 = 

         time: [1x1440 double]
           RI: [1x1440 double]
          dbZ: [1x1440 double]
    SYNOP4680: [1x1440 double]
    SYNOP4677: [1x1440 double]
          N_d: [32x1440 double]
          v_d: [32x1440 double]
          raw: [32x32x1440 double]
            D: [1x32 double]
          vel: [32x1 double]
```
**3** - Cut the structure *PSV2*, that have data of the day 07-08-2018, between 14:50 y 15:50:
```Matlab
stime=datenum(2018,8,7,14,50,0);
etime=datenum(2018,8,7,15,50,0);
parsivel = timecutPSVstruct(PSV2,stime,etime)

Out>>
parsivel = 

         time: [1x61 double]
           RI: [1x61 double]
          dbZ: [1x61 double]
    SYNOP4680: [1x61 double]
    SYNOP4677: [1x61 double]
          N_d: [32x61 double]
          v_d: [32x61 double]
          raw: [32x32x61 double]
            D: [1x32 double]
          vel: [32x1 double]
```

**3** - Plot the raw data of the Parsivel2:
```Matlab
plotrawdata(parsivel.D, parsivel.vel, parsivel.raw)
xlabel('Diameter [mm]')
ylabel('Velocity [m s^{-1}]')
title('Numero de gotas [log(N)]')
```

**4** - Plot the drop size distribution versus time using the Parsivel2 structure:
```Matlab
plotDSDbytime(parsivel.time,parsivel.D,parsivel.N_d)
xlabel('Tiempo [UTC-5]')
```

**5** - Plot the mean drop size distribution from the structure:

```Matlab
plotmeanDSD(parsivel.D,parsivel.N_d)
xlabel('Diameter [mm]')
ylabel('Drop concentration [log(m^{-3} mm^{-1})]')
```