#=======================================
#	README shapes
#=======================================

This folder has a simple example of how shapes can be constructed in gemc.

The first method uses the GEANT4 Constructive Solid Geometry (CSG) solids.  These are well
documented in the GEANT4 user's guide at:

http://geant4.web.cern.ch/geant4/G4UsersDocuments/UsersGuides/ForApplicationDeveloper/html/Detector/geomSolids.html

The example contains an example of a box (shown in wireframe), a solid sphere, and a cut hollow cone. The main
differences are the type field in the detector definition and the dimensions field, which changes to accomodate all
needed dimensions to define that shape.  These follow the number and order shown in the GEANT4 page above.


The second method of constructing shapes is to do boolean operations on them.  These include addition (union), 
subtraction, and solid intersection. This is done by use of the "Operation:" keyword in the type field of the detector
definition.  Things to know are that each of the component volumes must still be defined and written to the
geometry text file since the operation actually happens in gemc, not in the python script that generates the files. 
Each component file will have "Component" in the material field of the volume definition.  Properties like material, 
color, style, etc., are given for the final volume, not for the components.  The dimension field is not needed for the
final volume because it is already defined for the components.

addition (union) operator: "+"
subtraction operator: "-"
intersection operator: "*"

The positioning of the second volume is with respect to the coordinate system of the first volume UNLESS
the type field for the finished volume uses "Operation:@ " instead of "Operation: ".  In this case, both volumes
are positioned relative to their mother volume.


The example should be able to run directly in gemc with the provided text input files and  the gcard option 
file using the command:
	gemc.command example.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./example.py config.dat
WARNING:  this will overwrite the original project text files.

