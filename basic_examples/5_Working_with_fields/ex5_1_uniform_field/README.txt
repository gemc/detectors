#=======================================
#	README uniform field
#=======================================

This folder contains a simple example of a charged particle moving in a uniform magnetic field.
The example is for a 90 degree dipole bending magnet.  As can be seen, the actual magnet
structure is just decoration.  The real physics happens in the invisible volume defined with the
magnetic field.  The field could have been applied to the magnet volume itself, but since the magnet
yoke was defined as a subtraction solid with a hole through the middle, the magnet volume does not
include the hole where the particle is supposed to travel!  This was overcome by simply defining an
invisible volume the same shape as the outside of the dipole magnet to hold the field through its entirety.
This field volume does overlap with the magnet volume.  That is not a problem here but if it was an
issue with a more complicated geometry, one could assign the field volume only to the hole.

The field is defined in a separate file called dipoleZ.dat.  This file is stored in a "field_files" folder in the
project folder for convenience.  The folder name and location are arbitrary.  Typically a user would have a
central storage folder for all field files of interest.  The field folder location is pointed to by the FIELD_DIR 
option on the command line or in the gcard file.  The value may be a relative path.  When gemc runs, it 
will go to the folder pointed to by the FIELD_DIR option and scan all files in that folder for a field definition
with the name requested by the detector definition.  Only that field will be loaded into gemc.  For more
information on fields, see the gemc documentation at:

https://gemc.jlab.org/gemc/html/documentation/fields/fields.html


The example should be able to run directly in gemc with the provided text input files and  the gcard option 
file using the command:
	gemc.command example.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./example.py config.dat
WARNING:  this will overwrite the original project text files.


