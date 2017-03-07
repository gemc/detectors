#=======================================
#	README parameters and variations (ctof)
#=======================================

This folder contains a python implementation of the clas12 ctof detector with some minor changes for illustration.  It already provides a very good example of how to use both parameters and variations in gemc.  The base example can be found at:
https://gemc.jlab.org/gemc/html/examples/paddles.html

The example builds a barrel shaped array of scintillator paddles.  This version of the example implements three configuration variations: "original", "red", and "green". The configuration is chosen with an option on the command line or in the gcard file. The "original" variation implements the paddles example without changes.  The "red" variation changes the color of the bars and makes them shorter. The "green" variation again changes the color as well as the number of the bars.  These are trivial changes but show how new configurations can be created.

The advantage of the variations is that the different configurations can be built all at once using the build files. These prepare the input files for gemc.  The configuration can be selected in gemc either on the command line or in the gcard file without rebuilding the input files.


The example also demonstrate the use of a parameter file.  This allows a user to supply values to the build files when the gemc input files are being built.  The values could be almost any parameter, from the number of detector copies to dimensions, or text.  Additional fields are provided to identify the source of the parameters being passed, for instance, if they come from a CAD drawing or other source.  

In this example, the config.dat file sets the "original" variation and the "original" parameter file is loaded up front.  This lets the parameters from that file be available for all of the other variations that are built. Another option would be to put the parameter load command inside the configuration loop in ctof.py and let it pick up a separate parameter file for each variation.


The example should be able to run directly in gemc with the provided text input files and  the gcard option 
file using the command:
	gemc.command ctof.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./ctof.py config.dat
WARNING:  this will overwrite the original project text files.

