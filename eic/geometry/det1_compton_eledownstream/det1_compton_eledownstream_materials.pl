#!/usr/bin/perl -w
###################################################################
# Note: G4_* are for materials, so use percentage                 #
#  For components,like C9H10, use the element "C" but not "G4_C"  #                              
#                                                                 #
#  -- Zhihong Ye, yez@jlab.org, 06/12/2014                        # 
###################################################################

############
#Note:
# (0) Define your new material in the section it belongs to,
#     DO-NOT just simply add it to the end of the file. 
#     Put your name and date near where you define your new items.
# (1) Pay attention to the density unit, which should be g/cm3
# (2) For elements, they should be like "He","C", ...
#     For materials, they should be like "G4_He", "G4_C"
# (3) "SL_NewMaterial" is the newly defined material for SoLID    
# (4) If the new material is composed of elements, 
#     use "integer" to define the number of elements,
#     e.g "H 2 O 1"
# (5) If the new material is mixers of other materials,
#     use "mass fraction" to define the components, 
#     e.g. "G4_Si 0.70 G4_O 0.30"       
# (6) When you define a new material mixed by other materials, 
#     pay attention to how they are mixed,
#     e.g. by "mass fraction" or by "mole fraction" or volumn etc.
#
 
use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use materials;

# Help Message
sub help()
{
    print "\n Usage: \n";
    print "   materials.pl <configuration filename>\n";
    print "   Will create a simple scintillator material\n";
    exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
    help();
    exit;
}


# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub det1_compton_eledownstream_materials
{
    my %mat;
    
    %mat = init_mat();
    $mat{"name"}          = "H_GAS_HD";
    $mat{"description"}   = "High density H gas";
    $mat{"density"}       = "8.3748e-05";  # in g/cm3
    $mat{"ncomponents"}   = "1";
    $mat{"components"}    = "H 2";
    print_mat(\%configuration, \%mat);

}

det1_compton_eledownstream_materials();
