use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_solenoid_CLEO';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_solenoid_CLEO
{
coil();
yoke_barrel();
yoke_endcapdonut();
cryostat();
det1_solenoid_dual_coil_eleside();
det1_solenoid_dual_coil_ionside();
}


#build from Poisson input file CLEOv8.am, add/substract 0.01cm at various interface to avoid overlap 

 my $material_coil = "Aluminum";
 my $color_coil = "ff8000";

 my $material_yoke = "Iron";
 my $color_yoke = "F63BFF";

sub coil
{
 my $NUM  = 1;
 my @name = ("Coil"); 
 my @dim = ("0*deg 360*deg 2*counts 152.30*cm 152.30*cm 154.30*cm 154.30*cm -173.80*cm 173.80*cm");
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = $DetectorMother;
    $detector{"description"} = $detector{"name"};
    $detector{"pos"}        = "0*cm 0*cm $offset_inner*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"} = $color_coil;
    $detector{"type"}       = "Polycone";
    $detector{"dimensions"} = "$dim[$n-1]";    
    $detector{"material"} = $material_coil;
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}	     = 1;
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

sub yoke_barrel
{
 my $NUM  = 6;
 my @name = ("BarrelYokeInner","BarrelYokeOuter","SlabSpacerUpstream","SlabSpacerDownstream","CoilCollarUpstream","CoilCollarDownstream");
 my @dim = (
 "0*deg 360*deg 2*counts 176.60*cm 176.60*cm 212.60*cm 212.60*cm -189.00*cm 189.00*cm", # BarrelYokeInner  
 "0*deg 360*deg 2*counts 221.51*cm 221.51*cm 257.50*cm 257.50*cm -189.00*cm 189.00*cm", # BarrelYokeOuter 
 "0*deg 360*deg 2*counts 212.61*cm 212.61*cm 221.50*cm 221.50*cm -159.00*cm -189.00*cm", # SlabSpacerUpstream  
 "0*deg 360*deg 2*counts 212.61*cm 212.61*cm 221.50*cm 221.50*cm 159.00*cm 189.00*cm", # SlabSpacerDownstream  
 "0*deg 360*deg 2*counts 144.00*cm 144.00*cm 257.50*cm 257.50*cm -189.01*cm -209.00*cm", # CoilCollarUpstream  
 "0*deg 360*deg 2*counts 144.00*cm 144.00*cm 257.50*cm 257.50*cm  189.01*cm  209.00*cm" # CoilCollarDownstream
#  "0*deg 360*deg 3*counts 144.00*cm 144.00*cm 156.00*cm 285.00*cm 285.00*cm 285.00*cm -189.01*cm -193.00*cm -209.00*cm", # CoilCollarUpstream  
#  "0*deg 360*deg 3*counts 144.00*cm 144.00*cm 156.00*cm 285.00*cm 285.00*cm 285.00*cm 189.01*cm 193.00*cm 209.00*cm" # CoilCollarDownstream 
 );
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = $DetectorMother;
    $detector{"description"} = $detector{"name"};
    $detector{"pos"}        = "0*cm 0*cm $offset_inner*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"} = $color_yoke;
    $detector{"type"}       = "Polycone";
    $detector{"dimensions"} = "$dim[$n-1]";
    $detector{"material"} = $material_yoke;
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}	     = 1;
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

sub yoke_endcapdonut
{
 my $NUM  = 2;
 my @name = ("EndcapDonutUpstream","EndcapDonutDownstream");
 my @dim = (
#   "0*deg 360*deg 2*counts 270.00*cm 270.00*cm 285.00*cm 285.00*cm -209.01*cm -390.00*cm", # EndcapDonutUpstream  
#   "0*deg 360*deg 2*counts 270.00*cm 270.00*cm 285.00*cm 285.00*cm 209.01*cm 450.00*cm" # EndcapDonutDownstream
  "0*deg 360*deg 2*counts 242.50*cm 242.50*cm 257.50*cm 257.50*cm -209.01*cm -390.00*cm", # EndcapDonutUpstream  
  "0*deg 360*deg 2*counts 242.50*cm 242.50*cm 257.50*cm 257.50*cm 209.01*cm 450.00*cm" # EndcapDonutDownstream 
 );
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = $DetectorMother;
    $detector{"description"} = $detector{"name"};
    $detector{"pos"}        = "0*cm 0*cm $offset_inner*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"} = $color_yoke;
    $detector{"type"}       = "Polycone";
    $detector{"dimensions"} = "$dim[$n-1]";
    $detector{"material"} = $material_yoke;
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}	     = 1;
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

# from CLEO-II NIM paper "The cryostat consists of a 12 mm thick outer cylinder, a 10 mm inner cylinder and two 20 mm thick end flanges which are bolted and sealed with O-rings."

sub cryostat
{
 my $Nplate  = 4;
 my @PlateZ  = ($offset_inner+0, $offset_inner+0, $offset_inner-(189.00-1),$offset_inner+189.00-1);
 my @Rin  = (144.00,176.60-0.12,144.00,144.00);
 my @Rout = (144.00+0.10,176.60-0.01,176.60-0.01,176.60-0.01);
 my @Dz   = ((189*2-2-2)/2,(189*2-2-2)/2,2/2-0.005,2/2-0.005);
 my @name = ("CryostatInner","CryostatOuter","CryostatFlangeUpstream","CryostatFlangeDownstream");
 my $material="StainlessSteel";
 my $color="ffffff";

 for(my $n=1; $n<=$Nplate; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$DetectorMother" ;
    $detector{"description"} = $detector{"name"};
    $detector{"pos"}        = "0*cm 0*cm $PlateZ[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "$color";
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = "$material";
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

sub det1_solenoid_dual_coil_eleside
{
 my $coilthickness=17;
 my $NUM  = 7;
 my @z    = (-412.5-3.5+$offset,-412.5-3.5+$offset,-412.5-3.5+$offset,-412.5-3.5+$offset,-412.5-3.5+$offset,-412.5-3.5+$offset,-412.5-3.5+$offset);
 my @Rin  = (32,62,93,123,154,184,214);
 my @Rout =  (32+$coilthickness,62+$coilthickness,93+$coilthickness,123+$coilthickness,154+$coilthickness,184+$coilthickness,214+$coilthickness);
 my @Dz   = (3.5,3.5,3.5,3.5,3.5,3.5,3.5);
 my @name = ("coil_eleside_1","coil_eleside_2","coil_eleside_3","coil_eleside_4","coil_eleside_5","coil_eleside_6","coil_eleside_7"); 
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


sub det1_solenoid_dual_coil_ionside
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