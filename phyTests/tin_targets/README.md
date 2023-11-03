

# Overview

In this program Electrons with an energy of 10.6 GeV are hitting a Tin (Sn: Z = 50) target.
There exist several variations, which differe only by the target thickness.
The target is surrounded with a thin cylinder, in order detect any particle crossing it's inner surface.
The plan is to study photon spectrum on the cylinder surface surrounding the target.

## Create the geometry

If you have already the geometry files ready you don't need to run this step each time. \
Run ``"./xray.pl config.dat"``

This will create geometry files for all available variations in the xray.pl file \
As an example it has created six geometry files for 1μm, 10μm, 20μm, 100μm, 180μmand 360μm thick targets\
xray_flux__geometry_**1**microns.txt \
xray_flux__geometry_**10**microns.txt \
xray_flux__geometry_**20**microns.txt \
xray_flux__geometry_**100**microns.txt \
xray_flux__geometry_**180**microns.txt \
xray_flux__geometry_**360**microns.txt\
In file names target thickness is highlighted by bold font.

## Running gemc

```
 gemc YOUR_GCARD.gcard -N=NGEN -USE_GUI=0
 ```
where you need to replace the ``YOUR_GCARD.gcard`` with the gcard name you want to run gemc with,
and ``NGEN`` is the number of electrons (events) you want to run on the target.

The gemc will create a hipo file in the ``Data`` directory, named ``out_XXmicrons.hipo``, where ``XX`` will
be the target thickness in the units of microns. As an example, if you run 
```
 gemc xray_180um.gcard -N=100000 -USE_GUI=0
 ```
it will run 100000 electrons on the target, and the output hipo file name will be ``./Data/out_180microns.hipo``

## Filtering events
In this study we need only events when at least one particle hits the cylinder surrounding the target.
Depending on the thickness of the target, the number of such events will be different, and especially at small thicknesses
e.g. less than 20μm, those events are very small. 
That is why first we filter those events into a different file in order to efficently process them later.
If any particle will hit the cyliner, then hit details will be written into ``MC::True`` bank, so by filtering
we want to write only events containing this bank.
The filtering command looks like:
```
hipo-utils -filter -b "MC::True" -e "MC::True" -o ./Data/filtered_XXXMicron.hipo ./Data/out_XXXmicrons.hipo
```
Here again ``XXX`` is the target thickness in units of microns.


## Running the analysis
Now we are ready to run the analysis script, which will fill histograms with different variables (energy, polar and azimuthal angles) for
photons and electrons.
In order to create the executable, please compile the code ``PhotonStudy.cc`` through the command in the 
file ``compile_PhotonStudy.sh``
Make sure the the enviromental variable $HIPO is set correctly.
```
./PhotonStudy.exe XXX
```
``XXX`` is the target thickness in microns.\
The output of this command is a root file named ``PhotonSpectra_Sn_XXX_Micron.root``, which contains
different type of histograms.

## Drawing histograms
In order to plot these histograms, pleas run 
```
root -l 'DrawPlots.cc(XXX)'
```
This will produce root histograms in the canvas, and also the same canvas will be saved under the name
``Figs/Photon_Studies_Tin_100um.pdf``