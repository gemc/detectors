#=======================================
#	README simple_det
#	J. George, 2/18/2017
#=======================================

This folder contains one of the simplest possible projects:  a simple material in a beam. To make it slightly more interesting, the detector has been made sensitive, that is, it will record hit information when a track passes through it.

The detector material is a pre-defined GEANT4 element “G4_Si” so there is no need to generate a materials file for gemc.  

The sensitive detector is of the “flux” type which means that every track that passes through will generate a hit.  The track parameters (energy deposited, time, position, etc.) are integrated through all steps in the volume and presented as one hit per track, based on the INTEGRATEDRAW=“flux” option in the gcard file.  The raw output true information is always present and is selected for output as text into the ‘out.txt’ file based on the OUTPUT=“txt, out.txt” option in the card file.  The ‘flux’ type detector does not use a digitization factory to simulate the effects of readout electronics on the output signal.


The example should be able to run directly in gemc with the provided text input files and  the gcard option file using the command:
	gemc.command example.gcard
If one wants to generate the text input files from the provided python scripts, the files in the included ‘api/python’ folder must be included in the python path so the modules in the api can be imported.  When this is done, generate the project files using:
	python3 example.py config.dat
WARNING:  this will overwrite the original project text files.

