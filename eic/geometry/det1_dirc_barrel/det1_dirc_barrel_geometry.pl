use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_dirc_barrel';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_dirc_barrel{
det1_dirc_barrel_box();
det1_dirc_barrel_bar();
det1_dirc_barrel_readout();
}

 my @Dz   = (200);
#  my @Dz   = (185);
 
sub det1_dirc_barrel_box
{
 my $NUM  = 1;
 my @z    = (-20+$offset_inner);
# my @z    = (-5+$offset_inner);
 my @Rin  = (100);
 my @Rout = (109);
#  my @Dz   = (200);
 my @name = ("box"); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Vacuum");
 my @rot  = (0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
#     $detector{"color"}      = "C0C0C0";
    $detector{"color"}      = "79ff61"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
     print_det(\%configuration, \%detector);
 }
}

sub det1_dirc_barrel_bar
{
 my $NUM  = 1;
 my @z    = (0);
 my @Rin  = (104);
 my @Rout = (106);
#  my @Dz   = (200);
 my @name = ("bar"); 
 my @mother = ("det1_dirc_barrel_box"); 
 my @mat  = ("Vacuum");
 my @rot  = (0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
    $detector{"color"}      = "79ff61"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
     print_det(\%configuration, \%detector);
 }
}

sub det1_dirc_barrel_readout
{
 my $NUM  = 1;
#  my @z    = (-200-15);
 my @Rin1  = (104);
 my @Rin2  = (104);
 my @Rout1 = (134); 
 my @Rout2 = (106);
 my @Dz   = (15); 
 my @name = ("readout"); 
 my @mother = ("det1_dirc_barrel_box"); 
 my @mat  = ("Vacuum");
 my @rot  = (0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
#     $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"pos"}        = "0*cm 0*cm 0*cm";
    $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
    $detector{"color"}      = "79ff61"; 
    $detector{"type"}       = "Polycone";
    $detector{"dimensions"} = "0*deg 360*deg 3*counts 104*cm 104*cm 104*cm 106*cm 124*cm 106*cm -225*cm -213*cm -195*cm";       
#     $detector{"dimensions"} = "0*deg 360*deg 3*counts 104*cm 104*cm 104*cm 106*cm 124*cm 106*cm -215*cm -203*cm -185*cm";    
#     $detector{"dimensions"} = "0*deg 360*deg 3*counts 104*cm 104*cm 104*cm 106*cm 124*cm 106*cm -230*cm -218*cm -200*cm";
#     $detector{"type"}       = "Cons";
#     $detector{"dimensions"} = "$Rin1[$n-1]*cm $Rout1[$n-1]*cm $Rin2[$n-1]*cm $Rout2[$n-1]*cm    $Dz[$n-1]*cm 0*deg 360*deg"; 
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
     print_det(\%configuration, \%detector);
 }
}

# sub det1_dirc_barrel_readout
# {
#  my $NUM  = 1;
#  my @z    = (-200-15);
#  my @Rin1  = (104);
#  my @Rin2  = (104);
#  my @Rout1 = (134); 
#  my @Rout2 = (106);
#  my @Dz   = (15); 
#  my @name = ("readout"); 
#  my @mother = ("det1_dirc_barrel_box"); 
#  my @mat  = ("Vacuum");
#  my @rot  = (0);
# 
#  for(my $n=1; $n<=$NUM; $n++)
#  {
#     my %detector=init_det();
#     $detector{"name"}        = "$DetectorName\_$name[$n-1]";
#     $detector{"mother"}      = "$mother[$n-1]" ;
#     $detector{"description"} = "$DetectorName\_$name[$n-1]";
#     $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
#     $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
#     $detector{"color"}      = "79ff61"; 
# #     $detector{"type"}       = "Polycone";
# #     $detector{"dimensions"} = "0*deg 360*deg 3*counts 104*cm 104*cm 104*cm 130*cm 130*cm 106*cm -210*cm -209*cm -210*cm";
#     $detector{"type"}       = "Cons";
#     $detector{"dimensions"} = "$Rin1[$n-1]*cm $Rout1[$n-1]*cm $Rin2[$n-1]*cm $Rout2[$n-1]*cm    $Dz[$n-1]*cm 0*deg 360*deg"; 
#     $detector{"material"}   = $mat[$n-1];
#     $detector{"mfield"}     = "no";
#     $detector{"ncopy"}      = 1;
#     $detector{"pMany"}       = 1;
#     $detector{"exist"}       = 1;
#     $detector{"visible"}     = 1;
#     $detector{"style"}       = 1;
#     $detector{"sensitivity"} = "no";
#     $detector{"hit_type"}    = "no";
#     $detector{"identifiers"} = "no";
#      print_det(\%configuration, \%detector);
#  }
# }

# sub det1_dirc_barrel_readout
# {
#  my $NUM  = 1;
#  my @z    = (0);
#  my @name = ("readout"); 
#  my @mother = ("det1_dirc_barrel_box"); 
#  my @mat  = ("Vacuum");
#  my @rot  = (0);
# 
#  for(my $n=1; $n<=$NUM; $n++)
#  {
#     my %detector=init_det();
#     $detector{"name"}        = "$DetectorName\_$name[$n-1]";
#     $detector{"mother"}      = "$mother[$n-1]" ;
#     $detector{"description"} = "$DetectorName\_$name[$n-1]";
#     $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
#     $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
#     $detector{"color"}      = "79ff61"; 
#     $detector{"type"}       = "Polycone";
#     $detector{"dimensions"} = "0*deg 360*deg 3*counts 129*cm 104*cm 104*cm 130*cm 130*cm 130*cm -230*cm -205*cm -200*cm";
#     $detector{"material"}   = $mat[$n-1];
#     $detector{"mfield"}     = "no";
#     $detector{"ncopy"}      = 1;
#     $detector{"pMany"}       = 1;
#     $detector{"exist"}       = 1;
#     $detector{"visible"}     = 1;
#     $detector{"style"}       = 1;
#     $detector{"sensitivity"} = "no";
#     $detector{"hit_type"}    = "no";
#     $detector{"identifiers"} = "no";
#      print_det(\%configuration, \%detector);
#  }
# }
