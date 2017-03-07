#=======================================
#	README simple_det add_digitization
#=======================================

This folder contains one of the simplest possible projects:  a simple material in a beam. To make it slightly more interesting, the detector has been made sensitive, that is, it will record hit information when a track passes through it. For this example, the hits are processed through a digitization factory to simulate the response of the readout electronics.

The detector material is a pre-defined GEANT4 element “G4_Si” so there is no need to generate a materials file for gemc.  

The digitization factories are currently compiled into gemc for specific JLab detectors.  This is planned to change to a plugin approach similar to geometry and materials that will allow users to drop in their own definitions of their front end electronics.  For now, the options are to either recompile gemc to include a new digitization factory or to adapt one of the existing factories.  In this example, hits in the simple detector are assigned as though they were from a scintillator paddle in the “ctof” detector.  The identifier uses the “paddle” keyword to fool the “ctof” factory into accepting our hit and processing it.  We can still define various parameters of the readout signal through the hit definition. This examples shows how this can be done using hit and bank input files to gemc. In addition, the “ctof” bank is added to the output in the card file.


The example should be able to run directly in gemc with the provided text input files and  the gcard option file using the command:
	gemc.command example.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./example.py config.dat
WARNING:  this will overwrite the original project text files.

