use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_solenoid_hybrid';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_solenoid_hybrid
{
det1_solenoid_hybrid_coil_inner();
det1_solenoid_hybrid_coil_side_eleside();
det1_solenoid_hybrid_coil_side_ionside();
det1_solenoid_hybrid_coil_eleside();
det1_solenoid_hybrid_coil_ionside();
det1_solenoid_hybrid_iron_barrel();
}

sub det1_solenoid_hybrid_coil_inner
{
 my $NUM  = 1;
 my @z    = ($offset_inner);
 my @Rin  = (150);
 my @Rout = (160);
 my @Dz   = (160);
 my @name = ("coil_inner"); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "C0C0C0"; #silver
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

sub det1_solenoid_hybrid_coil_side_eleside
{
 my $NUM  = 1;
 my @z    = (-160.5-20+$offset_inner);
 my @Rin  = (190);
 my @Rout = (202.4);
 my @Dz   = (20);
 my @name = ("coil_side_eleside"); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "C0C0C0"; #silver
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

sub det1_solenoid_hybrid_coil_side_ionside
{
 my $NUM  = 1;
 my @z    = (160.5+20+$offset_inner);
 my @Rin  = (190);
 my @Rout = (202.4);
 my @Dz   = (20);
 my @name = ("coil_side_ionside"); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "C0C0C0"; #silver
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

sub det1_solenoid_hybrid_coil_eleside
{
 my $coilthickness=17;
 my $NUM  = 8;
 my @z    = (-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset,-412.5-3.5+45+$offset);
 my @Rin  = (32,62,93,123,154,184,214,280);
 my @Rout =  (32+$coilthickness,62+$coilthickness,93+$coilthickness,123+$coilthickness,154+$coilthickness,184+$coilthickness,214+$coilthickness,280+$coilthickness);
 my @Dz   = (3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5);
 my @name = ("coil_eleside_1","coil_eleside_2","coil_eleside_3","coil_eleside_4","coil_eleside_5","coil_eleside_6","coil_eleside_7","coil_eleside_8"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother"); 
 my @mat  = ("Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite");
 my @rot  = (0,0,0,0,0,0,0,0);

#  for(my $n=1; $n<=$NUM; $n++)
 for(my $n=2; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "C0C0C0"; #silver
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


sub det1_solenoid_hybrid_coil_ionside
{
 my $coilthickness=17;
 my $NUM  = 7;
 my @z    = (412.5+3.5+$offset,412.5+3.5+$offset,412.5+3.5+$offset,412.5+3.5+$offset,412.5+3.5+$offset,412.5+3.5+$offset,412.5+3.5+$offset);
 my @Rin  = (32,62,93,123,154,184,214);
 my @Rout = (32+$coilthickness,62+$coilthickness,93+$coilthickness,123+$coilthickness,154+$coilthickness,184+$coilthickness,214+$coilthickness);
 my @Dz   = (3.5,3.5,3.5,3.5,3.5,3.5,3.5);
 my @name = ("coil_ionside_1","coil_ionside_2","coil_ionside_3","coil_ionside_4","coil_ionside_5","coil_ionside_6","coil_ionside_7"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother"); 
 my @mat  = ("Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite");
 my @rot  = (0,0,0,0,0,0,0);

#  for(my $n=1; $n<=$NUM; $n++)
 for(my $n=2; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "C0C0C0"; #silver
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



sub det1_solenoid_hybrid_iron_barrel
{
 my $NUM  = 1;
 my @z    = ($offset_inner);
 my @Rin  = (210);
 my @Rout = (300);
 my @Dz   = (180);
 my @name = ("iron_barrel"); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "9900CC";
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