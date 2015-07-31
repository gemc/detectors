#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use materials;

# Help Message
sub help()
{
  print "\n Usage: \n";
  print "   materials.pl <configuration filename>\n";
  print "   Will create the CLAS12 Central Time of Flight (ctof) materials\n";
  print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
  exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
  help();
  exit;
}


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub make_materials
{
  my $thisVariation = shift;
  $configuration{"variation"} = $thisVariation ;

  # rohacell
  my %mat = init_mat();
  $mat{"name"}          = "rohacell";
  $mat{"description"}   = "target  rohacell scattering chamber material";
  $mat{"density"}       = "0.1";  # 100 mg/cm3
  $mat{"ncomponents"}   = "4";
  $mat{"components"}    = "G4_C 0.6465 G4_H 0.0784 G4_N 0.0839 G4_O 0.1912";
  print_mat(\%configuration, \%mat);	

   if($thisVariation eq "ND3")
   {
     #my %mat = init_mat();
     #$mat{"name"}          = "solidND3";
     #$mat{"description"}   = "solid ND3 target";
     #$mat{"density"}       = "1.007";  # 1.007 g/cm3
     #$mat{"ncomponents"}   = "1";
     #$mat{"components"}    = "ND3 1";
     #print_mat(\%configuration, \%mat);	
     my %mat = init_mat();
     $mat{"name"}          = "lHe";
     $mat{"description"}   = "liquid helium";
     $mat{"density"}        = "0.145";  # 0.145 g/cm3 <—————————————
     $mat{"ncomponents"}   = "1";
     $mat{"components"}    = "G4_He 1";
     print_mat(\%configuration, \%mat);

     %mat = init_mat();
     my $my_density = 0.6*1.007+0.4*0.145; # 60% of ND3 and 40% of liquid-helium
     my $ND3_mass_fraction=0.6*1.007/$my_density;
     my $lHe_mass_fraction=0.4*0.145/$my_density;
     $mat{"name"}          = "solidND3";
     $mat{"description"}   = "solid ND3 target";
     $mat{"density"}        =  $my_density;
     $mat{"ncomponents"}   = "2";
     $mat{"components"}    = "ND3 $ND3_mass_fraction lHe $lHe_mass_fraction";
     print_mat(\%configuration, \%mat);
  }
}

make_materials("lH2");
make_materials("lD2");
make_materials("ND3");

