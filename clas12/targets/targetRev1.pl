use strict;
use warnings;

our %configuration;


# For all shapes please refer to a the labelled diagram in the
# package which associates the methods with their respective shapes.
# For example, build_cork below will be labelled as 1.1 in the diagram
# in the package, and its shape will roughly be like the shape drawn two methods down
# Similarly, innercork will be labelled as 1.2 in the diagram.

# General Remarks
# All the windows are made of Aluminium, with a thicknes of 15 micro-inch
# Setting visibility as zero just makes the geometry as the word implies, invisible.
# But it still exists and will interact with any particle that passes through its region



# Some of the materials used to build these shapes were actually not avaiable in the
# Geant4 materials database, but were rather mentioned in the source code for GEMC
# and so they were found by GREP-ing the source code for the material that was needed,
# in the file materials.cc in installation directory of GEMC

# One more number can be added to the end of this 6 digit
# number and this defines the opacity of the color,
# with 0 being the most opaque and 6 being the least opaque


# There is a frame which acts like a mother volume for all the geometries made below.
# Therefore this frame allows us to move the target in different directions and also to rotate it however we like

sub build_totalFrame
{
	my %detector = init_det();
	$detector{"name"}        = "biggestFrame";
	$detector{"mother"}      = "root";
	$detector{"description"} = "In order to move the picture";
	$detector{"pos"}         = "0*mm 0*mm -2.05837*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "C875334";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 50.9*mm 400*mm 0*deg 360*deg";
	$detector{"material"}    = "vacuum_m9";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#The innercork is the liquid hydrogen
sub build_innerCork #1.2
{
	my %detector = init_det();
	$detector{"name"}        = "innerCork";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The liquid hydrogen";
	$detector{"pos"}         = "0*mm 0*mm 23.9537*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "C87533";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0*mm 2.2509*mm 0*mm 5.49125*mm 0.98535*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_lH2";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This is the Aluminium casing for the liquid hydrogen
sub build_innerCorkCase #1.21
{
	my %detector = init_det();
	$detector{"name"}        = "innerCorkCase";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The container for the liquid hydrogen";
	$detector{"pos"}         = "0*mm 0*mm 23.9537*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "C875333";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "1.8135*mm 2.2509*mm 5.05385*mm 5.49125*mm 0.98535*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# This is a supporting structure fo the container of liquid hydrogen
sub build_cork #1.1
{
	my %detector = init_det();
	$detector{"name"}        = "cork";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The structure that supports the liquid hydrogen";
	$detector{"pos"}         = "0*mm 0*mm 22.36835*mm";#25.53395
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "C875333";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "5.23735*mm 5.49125*mm 5.5841*mm 5.838*mm 2.48275*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# There is an opening in the centre of the innerCorkCase which is closed off  by making a very thin window
sub build_corkWindow #1.3
{
	my %detector = init_det();
	$detector{"name"}        = "corkWindow";
	$detector{"mother"}      =  "biggestFrame";
	$detector{"description"} = "The glass window for the top cork";
	$detector{"pos"}         = "0*mm 0*mm 22.96835*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF0000";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 1.8135*mm 0.000381*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
#
#
#        ___________
#       /\   1.1   /\
#      /  \_______/  \
#     /      1.3      \
#    /                 \
#   /        1.2        \
#   ~~~~~~~~~~~~~~~~~~~~~


#---------------------------------------------------------------------------------------------------


# This is the outermost layer and is comprised of two cones, the kaptonLayer and the kaptonCone

# The kaptonLayer is the longer cone that runs through the length of the target
sub build_kaptonLayer #2.1
{
	my %detector = init_det();
	$detector{"name"}        = "kapLayer";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The outermost cone that encapsulates the cork and the liquid duterium constructs";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "99CC004";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "7.9911*mm 7.9912*mm 17.90044*mm 17.90045*mm 39.28*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# The kaptonCone is the smaller cone that basically caps the kaptonLayer cone
sub build_kaptonCone #2.2
{
	my %detector = init_det();
	$detector{"name"}        = "kapCone";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the cap of the outermost cone";
	$detector{"pos"}         = "0*mm 0*mm 41.11685*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "99CC004";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "1.9982*mm 1.9983*mm 7.99124*mm 7.99125*mm 1.83685*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# The LH2 system is created taking into account that the outhermost kapton cone
# has LH2 except for the spaces which have other shapes in them or the piping.
# Therefore, this system shape is desinged by subtracting the solids that take up
# space inside the kapton cone such as the kapton cover which encloses the LD2
# system as well as the first outer pipe which protrudes into the kapton layer
sub build_lH2StorageSystem #2.1
{
	my %detector = init_det();
	$detector{"name"}        = "mykapLayer";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The outermost cone that encapsulates the cork and the liquid duterium constructs";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "99CC00";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0*mm 7.9912*mm 0*mm 17.90045*mm 39.28*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	%detector = init_det();
	$detector{"name"}        = "mykaptonCover";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The kapton that encloses the LH2 and the foam";
	$detector{"pos"}         = "0*mm 0*mm 2.0293*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "B266FF";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0*mm 5.838*mm 0*mm 12.69566*mm 27.0538*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	%detector = init_det();
	$detector{"name"}        = "myfirstOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The pipeline touching the ld2 storage as well as the foam layer";
	$detector{"pos"}         = "0*mm 0*mm 45.2375*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 14.2672*mm 23.13425*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	%detector = init_det();
	$detector{"name"}        = "lh2KaptonConeA";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "Kapton Cone minus kapLayer";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Operation: mykapLayer - mykaptonCover";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	%detector = init_det();
	$detector{"name"}        = "lH2System";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "Kapton Cone - kapLayer - firstOuterPipe";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "3399994";
	$detector{"type"}        = "Operation: lh2KaptonConeA - myfirstOuterPipe";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "G4_lH2";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
}


sub build_lh2Cone #2.2
{
	my %detector = init_det();
	$detector{"name"}        = "lh2Cone";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the cap of the outermost cone";
	$detector{"pos"}         = "0*mm 0*mm 41.11685*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "99CC004";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0*mm 1.9983*mm 0*mm 7.99125*mm 1.83685*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_lH2";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



#There is an opening in the center of the kaptonCone which is covered off by making an aluminium window
sub build_kaptonConeWindow #2.3
{
	my %detector = init_det();
	$detector{"name"}        = "kaptonConeWindow";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The window for the kapton cone ";
	$detector{"pos"}         = "0*mm 0*mm 42.9537*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF00003";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.0001*mm 1.9982*mm 0.000381*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# The LD2 Storage is the liquid duterium... very similar to teh liquid hydrogen we did above.
# This time the only thing inside the ld2 storage was the central pipeline so we subtracted
# that volume for our volume of the cone of LD2 storage and the remainder was the actual LD2 Storage amount

sub build_LD2StorageSystem #4.1
{
	
	my %detector = init_det();
	$detector{"name"}        = "myld2Storage";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the liquid duterimum";
	$detector{"pos"}         = "0*mm 0*mm -9.7*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "8000004";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0.001*mm 4.4162*mm 0.001*mm 10.1119*mm 20.3958*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	%detector = init_det();
	$detector{"name"}        = "mycentralPipeline";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The main pipeline going into the LD2 Storage Cone";
	$detector{"pos"}         = "0*mm 0*m  42.4*mm"; #-48.6557
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "CCCC003";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.5*mm 5*mm 43.2062*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	%detector = init_det();
	$detector{"name"}        = "ld2System";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "ld2 storage - space inside which isnt ld2(i.e. central pipeline)";
	$detector{"pos"}         = "0*mm 0*mm -10*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "3399993";
	$detector{"type"}        = "Operation: myld2Storage -  mycentralPipeline";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "LD2";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
}

#This is the casing for the liquid duterium.
sub build_LD2StorageCover #4.2
{
	my %detector = init_det();
	$detector{"name"}        = "ld2StorageCover";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the outer casing for the whole LD2 Storage cone";
	$detector{"pos"}         = "0*mm 0*mm -9.7*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E4";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "4.4151*mm 4.4162*mm 5.000*mm 10.1119*mm 20.3958*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#This is some more liquid duterium as a cone that sits above the previous cone that we defined (LD2 Storage)
sub build_LD2Cap #5.1
{
	my %detector = init_det();
	$detector{"name"}        = "ld2Cap";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the cap for the LD2 storage";
	$detector{"pos"}         = "0*mm 0*mm 11.4715*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "8000004";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0.0001*mm 4.4162*mm 0.0001*mm  2*mm 0.85495*mm 270*deg 360*deg";
	$detector{"material"}    = "LD2";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This is the casing for the liquid duterium cone made above
sub build_LD2CapCover #5.2
{
	my %detector = init_det();
	$detector{"name"}        = "ld2CapCover";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The outer-copper-casing of the front cone of the LD2 Storage";
	$detector{"pos"}         = "0*mm 0*mm 11.4715*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E4";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "4.4161*mm 4.4162*mm 1.9*mm 2*mm 0.85495*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#There is an opening in the center of the ld2Cap which is covered by making a very thin aluminium window
sub build_LD2CapWindow #5.3
{
	my %detector = init_det();
	$detector{"name"}        = "ld2CapWindow";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The lid of the front cone of the LD2 Storage ";
	$detector{"pos"}         = "0*mm 0*mm 12.2645*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF00003";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.0001*mm 2*mm 0.000381*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}




# There are 3 pieces of foam that have been made to surround the liquid duterium shapes shown above. The 3 pieces are all identical to each
# other and were made in parts so that they could be placed with gaps between them, as per the specifications of the geometry
# The foam pieces are approximately 111 degree wide and have consistent gaps beteween them.


sub build_foamLayer1 #3.1
{
	my %detector = init_det();
	$detector{"name"}        = "foamLayer1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the first foam layer approximately 111 degree wide enclosing the liquid duterium";
	$detector{"pos"}         = "0*mm 0*mm -4.75*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "FFFF003";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "3.5422*mm 5.838*mm 10.16675*mm 12.69565*mm 24.57105*mm 214.49*deg 111.02*deg";
	$detector{"material"}    = "Rohacell31";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_foamLayer2 #3.1
{
	my %detector = init_det();
	$detector{"name"}        = "foamLayer2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the second foam layer approximately 111 degree wide enclosing the liquid duterium";
	$detector{"pos"}         = "0*mm 0*mm -4.75*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "FFFF003";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "3.5422*mm 5.838*mm 10.16675*mm 12.69565*mm 24.57105*mm 334.4855*deg 111.02*deg";
	$detector{"material"}    = "Rohacell31";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub build_foamLayer3 #3.1
{
	my %detector = init_det();
	$detector{"name"}        = "foamLayer3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "the third foam layer approximately 111 degree wide enclosing the liquid duterium ";
	$detector{"pos"}         = "0*mm 0*mm -4.75*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "FFFF003";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "3.5422*mm 5.838*mm 10.16675*mm 12.69565*mm 24.57105*mm 454.481*deg 111.02*deg";
	$detector{"material"}    = "Rohacell31";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#This is a kapton casing for the foam as well as the cork (the structure containing the liquid hydrogen (see above) )
sub build_kaptonCoverForFoamAndDuterium #3.1
{
	my %detector = init_det();
	$detector{"name"}        = "kaptonCover";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The kapton that encloses the LH2 and the foam";
	$detector{"pos"}         = "0*mm 0*mm -2.0293*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "B266FF3";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "5.4669*mm 5.838*mm 12.69565*mm 12.69566*mm 27.0538*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_C";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This is another casing for the foam only
sub build_carbonCoverForFoam #3.2
{
	my %detector = init_det();
	$detector{"name"}        = "cabonCoverForFoam";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "A carbon cone that covers the foam";
	$detector{"pos"}         = "0*mm 0*mm -4.00*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "170E0E3";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "5.838*mm 6.138*mm 12.69566*mm 12.99566*mm 23.7707*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_C";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



# PLUMBING
# --------
#
# This is the central pipeline that extends into the liquid duterium container
sub build_centralPipeline #6.1
{
	my %detector = init_det();
	$detector{"name"}        = "centralPipeline";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The main pipeline going into the LD2 Storage Cone";
	$detector{"pos"}         = "0*mm 0*mm -52.5*mm"; #-48.6557
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "CCCC003";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "2*mm 5*mm 43.2062*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# There is a hole at the front of this pipeline which is covered by making a thin aluminium window
sub build_centralPipelineWindow #6.2
{
	my %detector = init_det();
	$detector{"name"}        = "centralPipelineWindow";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The window for the main pipeline";
	$detector{"pos"}         = "0*mm 0*mm -9.154*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF0000";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.00001*mm 2*mm 0.000381*mm  270*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part of this pipeline is in contact with the liquid duterium and is a smaller tube
sub build_firstOuterPipe #7.1
{
	my %detector = init_det();
	$detector{"name"}        = "firstOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The pipeline touching the ld2 storage as well as the foam layer";
	$detector{"pos"}         = "0*mm 0*mm -51.7953*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "5*mm 14.2672*mm 23.13425*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
}

# This pipeline extends back from the pipeline made above and is a larger tube
sub build_secondOuterPipe #8.1
{
	my %detector = init_det();
	$detector{"name"}        = "secondOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The secondary pipeline extending the first outer pipeline";
	$detector{"pos"}         = "0*mm 0*mm -84.7427*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "5*mm 18.8116*mm 9.81315*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#          secondOuterPipe
#          ----------
#                     ------------------
#
#                     ------------------
#          ----------        firstOuterPipe



# This pipeline has 4 components

# If these components are being looked at with reference to the diagram, backwards means left and forward means right

# 1) This is a tube that starts at the back of the kapton Layer cone (#2.1) mentioned above and extends backwards
sub build_thirdOuterPipe #9.1
{
	my %detector = init_det();
	$detector{"name"}        = "thirdOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The secondary pipeline extending the first outer pipeline";
	$detector{"pos"}         = "0*mm 0*mm -47.83465*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "16.9504*mm 19.9832*mm 5.95065*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#2) This is a cone that starts at the front of the tube just made above, extends forward, and goes over the sides of the kapton layer cone
sub build_ccThirdOuterPipe #9.2
{
	my %detector = init_det();
	$detector{"name"}        = "ccThirdOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The top cone of the third outerpipe, connecting to the kapton layer";
	$detector{"pos"}         = "0*mm 0*mm -40.12025*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "16.9504*mm 19.9232*mm 16.9504*mm 17.9504*mm 1.76375*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#3) This is a cone that starts at the back of the tube #9.1 and extends backwards
sub build_cThirdOuterPipe #9.3
{
	my %detector = init_det();
	$detector{"name"}        = "cThirdOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cone for the third outer pipe";
	$detector{"pos"}         = "0*mm 0*mm -57.80105*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "16.9504*mm 34.01*mm 16.9504*mm 19.9832*mm 4.01575*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#4) This is a tube that starts at the back of the #9.3 and extends backwards
sub build_tThirdOuterPipe #9.4
{
	my %detector = init_det();
	$detector{"name"}        = "tThirdOuterPipe";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The Tube (cylinder) for the third outer pipe";
	$detector{"pos"}         = "0*mm 0*mm -78.3168*mm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "0FE61E3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "16.9504*mm 34.01*mm 16.5*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#The following pipes will be providing liquid hydrogen and duterium to the storage tanks mentioned above
#Their relative positioning is identical to that of the foam mentioned above, i.e. each set of pipes is separated by 111 degrees. One set of pipes include, airCylinderVerticalTop1, pipetoLD2Top1,
#airCylinderVerticalBottom1, pipetoLD2Bottom1
#There are 3 such sets of piping just like there were three sets of foam layers


#This is the first vertical pipe that lies in a vertical plane and is connected to an outside supply of liquid duterium
sub build_airCylinderVerticalTop1 #10.1
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalTop1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder from which we will feed liquid duterium";
	$detector{"pos"}         = "0*mm 24.4041*mm -70.89165*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8635*mm 3.8735*mm 8.5188*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#This pipe connects the first vertical pipe to the kapton layer
sub build_pipeToLD2Top1 #10.2
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Top1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting to the LD2 tank";
	$detector{"pos"}         = "0*mm 15.1323*mm -58.29065*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "1.4090*mm 1.4091*mm 16.56905*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This is a copy of the first vertical pipe but is slightly smaller and is situation slightly below the first vertical pipe
sub build_airCylinderVerticalBottom1 #10.3
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalBottom1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "Entry/Exit Point number 2 for the liquid duterium";
	$detector{"pos"}         = "0*mm 13.1679*mm -82.1877*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8735*mm 3.8736*mm 7.405*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This pipe connects the pipe above to the liquid duterium cone
sub build_pipeToLD2Bottom1 #10.4
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Bottom1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting the vertical pipe to the LD2 tank";
	$detector{"pos"}         = "0*mm 5.001*mm -57.851325*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.85*mm 0.86*mm 28.191375*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub build_airCylinderVerticalTop2
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalTop2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder from which we will feed liquid duterium";
	$detector{"pos"}         = "19.3958*mm -13.3958*mm -71.19065*mm";
	$detector{"rotation"}    = "90*deg 424.4835*deg 180*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8635*mm 3.8735*mm 8.5188*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub build_pipeToLD2Top2
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Top2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting to the LD2 tank";
	$detector{"pos"}         = "12*mm -8.4162*mm -58.29065*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "1.4090*mm 1.4091*mm 16.56905*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_airCylinderVerticalBottom2
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalBottom2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "Entry/Exit Point number 2 for the liquid duterium";
	$detector{"pos"}         = "10.0*mm -9.119*mm -82.1877*mm";
	$detector{"rotation"}    = "90*deg 424.4835*deg 180*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8735*mm 3.8736*mm 7.405*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_pipeToLD2Bottom2
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Bottom2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting the vertical pipe to the LD2 tank";
	$detector{"pos"}         = "3.5*mm -4.5*mm -57.851352*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.85*mm 0.86*mm 28.191375*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#!!!!!--------------------THIRD FOAM LAYER------------------!!!!!!!!!!!!!!!!!!!!!!!!!!1


sub build_airCylinderVerticalTop3
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalTop3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder from which we will feed liquid duterium";
	$detector{"pos"}         = "-19.3958*mm -13.6958*mm -71.19055*mm";
	$detector{"rotation"}    = "90*deg 300.4835*deg 180*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8635*mm 3.8735*mm 8.5188*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_pipeToLD2Top3
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Top3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting to the LD2 tank";
	$detector{"pos"}         = "-12.5*mm -8.9162*mm -58.29065*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "66FFFF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "1.4090*mm 1.4091*mm 16.56905*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_airCylinderVerticalBottom3
{
	my %detector = init_det();
	$detector{"name"}        = "airCylinderVerticalBottom3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "Entry/Exit Point number 2 for the liquid duterium";
	$detector{"pos"}         = "-10.0*mm -8.119*mm -82.1877*mm";
	$detector{"rotation"}    = "90*deg 300.4835*deg 180*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.8735*mm 3.8736*mm 7.405*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_pipeToLD2Bottom3
{
	my %detector = init_det();
	$detector{"name"}        = "pipeToLD2Bottom3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder connecting the vertical pipe to the LD2 tank";
	$detector{"pos"}         = "-3.5*mm -4.5*mm -57.851325*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "CC0066";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.85*mm 0.86*mm 28.191375*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



#This is the largest cylinder that encloses everything
sub build_finalTube #11.1
{
	my %detector = init_det();
	$detector{"name"}        = "finalTube";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The final tube that encloses everything ";
	$detector{"pos"}         = "0*mm 0*mm -30.6043*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF99993";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "43.6533*mm 50.0033*mm 64.09025*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#This is the cap of the largest cylinder and is made of multiple shapes as will be shown below
sub build_topCap #11.2
{
	#We make a cone that we will subtract from the volume to get a cone like crater
	my %detector = init_det();
	$detector{"name"}        = "emptyCone";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cone shaped crater made inside the shell";
	$detector{"pos"}         = "0*mm 50.96835*mm 0*mm";
	$detector{"rotation"}    = "-270*deg 0*deg 0*deg";
	$detector{"color"}       = "8800003";
	$detector{"type"}        = "Cons";
	$detector{"dimensions"}  = "0*cm 3.7059*mm 0*cm 4.49185*mm 8.91505*mm 270*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	#We make a cylindrical volume which acts like a nozel to the cap
	%detector = init_det();
	$detector{"name"}        = "outsideProngs";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The cylinder that is going to extend from the shell";
	$detector{"pos"}         = "0*mm 50.96835*mm 0*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "4400193";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 9.52455*mm 8.31505*mm 0*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	#We make a hemisphere that is the bulk of the cap
	%detector = init_det();
	$detector{"name"}        = "shell";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The shell which acts like the cap for the cylinder";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "4400193";
	$detector{"type"}        = "Sphere";
	$detector{"dimensions"}  = "43.6533*mm 50.0033*mm 0*deg 180*deg 0*deg 180*deg";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	#We add the cylinder to the top of the sphere to make a hemisphere with a tube like extension
	%detector = init_det();
	$detector{"name"}        = "shellWithProngs";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The outercap with the tube added";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "3399993";
	$detector{"type"}        = "Operation: shell + outsideProngs";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Component";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	#We remove the cone from the cylinder and part of the sphere to make a cone like crater in the center of the tube extension, to make a window
	%detector = init_det();
	$detector{"name"}        = "shellWithCraterAndProngs";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The outercap with tube and with the crater removed";
	$detector{"pos"}         = "0*mm 0*mm 33.3957*mm";
	$detector{"rotation"}    = "-90*deg 0*deg 0*deg";
	$detector{"color"}       = "3399993";
	$detector{"type"}        = "Operation: shellWithProngs - emptyCone";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	
}

#This is the window of front of the final tube i.e. the window to cover the top of the crater made by removing a cone from the cylinder above ( please see above)
sub build_finalTubeWindow #11.3
{
	my %detector = init_det();
	$detector{"name"}        = "finalTubeWindow";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The window of the final tube";
	$detector{"pos"}         = "0*mm 0*mm 92.76085*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FF00003";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 9.52455*mm 0.000381*mm  270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This is the back extension of the tube and has been added beause there is another material that extends behind this large tube
sub build_finalTubeExtension #11.4
{
	my %detector = init_det();
	$detector{"name"}        = "finalTubeExtension";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The extension behind the final tube";
	$detector{"pos"}         = "0*mm 0*mm -134.6043*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "FFCCFF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "48.34255*mm 50.80165*mm 40*mm 270*deg 360*deg";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# There are 3 sets of piping for the 3 sets of plumbing mentioned above
# (i.e. where the separation between the parts was 111 degree )
# Each set of piping has two vertical tubes that are supposed to bring liquid duteirum from the outside, and therefore each set needs piping to do so. These are therefore horizontal pipes that
# extend from the vertical pipes named airCylinderVerticalTop and Bottom, and provide the necessary plumbing
# This also means that these three sets of pipes are also separated by 111 degrees

#This pipe extends from airCylinderVerticalTop1 horizontally and extends to the left
sub build_endPipingTop1 #12.1
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping1";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that extends from the first vertical tube at the top ";
	$detector{"pos"}         = "0*mm 28.116*mm -154.604*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 80*mm 270*deg 360*deg";
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#This pipe extends from airCylinderBottom1 horizontally and extends to the left
sub build_endPipingBottom1 #12.2
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping11";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that ends from the first lower vertical tube at the top ";
	$detector{"pos"}         = "0*mm 16.3*mm -161.104*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 75*mm 270*deg 360*deg";
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_endPipingTop2
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping2";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that extends from the second vertical tube at the top ";
	$detector{"pos"}         = "-23.0*mm -15.5*mm -155.14*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 80*mm 270*deg 360*deg";
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub build_endPipingBottom2
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping22";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that extends from the second lower vertical tube at the top";
	$detector{"pos"}         = "-13*mm -10*mm -161.604*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 75*mm 270*deg 360*deg";
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

#--------------------------------------------------------------------------------------------------------------------------
sub build_endPipingTop3
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping3";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that extends from the third vertical tube at the top ";
	$detector{"pos"}         = "23.0*mm -15.5*mm -155.14*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 80*mm 270*deg 360*deg" ;
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_endPipingBottom3
{
	my %detector = init_det();
	$detector{"name"}        = "finalPiping33";
	$detector{"mother"}      = "biggestFrame";
	$detector{"description"} = "The tube that extends from the third lower vertical tube at the top ";
	$detector{"pos"}         = "13*mm -10*mm -161.604*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "0080FF3";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "3.875*mm 3.876*mm 75*mm 270*deg 360*deg" ;
	$detector{"material"}    = "StainlessSteel";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}




# All the methods are called now, so that these geometries can be built.
# My research on GEMC and Geant4 and experimentation with these geometries
# has led me to believe that the order in which these methods are written
# does not change the final outcome. For instance.
# The method directly below, totalFrame, acts like the mother frame,
# or the ROOT, for everything else made in this geometry.
# Therefore all other geometries are dependent on totalFrame.
# Even so, I was able to move the line building totalFrame at the very end, and everything still seemed in order.

# I think that the dependencies between the mother and child volumes are
# resolved at RUNTIME and not COMPLILE TIME and therefore it doesn't
# really matter what is the order in which we call the build methods to make the shapes.


sub buildElaborate
{
	
	build_totalFrame();
	
	build_cork();
	build_innerCork();
	build_innerCorkCase();
	build_kaptonLayer();
	build_kaptonCone();
	build_lh2Cone();
	
	
	build_foamLayer1();
	build_LD2StorageSystem();
	build_LD2Cap();
	build_LD2StorageCover();
	build_LD2CapCover();
	build_LD2CapWindow();
	build_centralPipeline();
	build_firstOuterPipe();
	build_secondOuterPipe();
	build_thirdOuterPipe();
	build_ccThirdOuterPipe();
	build_cThirdOuterPipe();
	build_tThirdOuterPipe();
	build_corkWindow();
	build_centralPipelineWindow();
	build_kaptonConeWindow();
	build_lH2StorageSystem();
	
	
	build_airCylinderVerticalTop1();
	build_pipeToLD2Top1();
	build_kaptonCoverForFoamAndDuterium();
	build_carbonCoverForFoam();
	build_airCylinderVerticalBottom1();
	build_pipeToLD2Bottom1();
	
	build_foamLayer2();
	build_airCylinderVerticalTop2();
	build_pipeToLD2Top2();
	build_airCylinderVerticalBottom2();
	build_pipeToLD2Bottom2();
	
	
	build_foamLayer3();
	build_airCylinderVerticalTop3();
	build_pipeToLD2Top3();
	build_airCylinderVerticalBottom3();
	build_pipeToLD2Bottom3();
	
	build_finalTube();
	build_finalTubeWindow();
	build_finalTubeExtension();
	
	build_endPipingTop1();
	build_endPipingTop2();
	build_endPipingTop3();
	
	build_endPipingBottom1();
	build_endPipingBottom2();
	build_endPipingBottom3();
	
	
	build_topCap();
}
