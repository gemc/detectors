use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_pipe_ionside';

sub det1_beamline_pipe_ionside
{
my $NUM  = 9;
my @name=(
"VertexChamber","VertexFlare","VertexTaper","VertexExitWindow","EleExitAperture","IonExtranceAperture","IonBeamPipe","SynchrotronRadShield1","SynchrotronRadShield2",
);
my @mother = (
"$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorName\_VertexExitWindow","$DetectorName\_VertexExitWindow","$DetectorMother","$DetectorMother","$DetectorMother",
);
my @mat  = (
"G4_Be","G4_Be","det1_beamline_pipe_BeAl","G4_Al","G4_Galactic","G4_Galactic","G4_Al","G4_Cu","G4_Cu",
);
my @x    = (
0,0,0,0,2.0445*tan(0.025),-2.0445*tan(0.025),0,0,0,
);
my @z1    = (
0-0.6723/2,0.3362,1.9179,2.0445-0.002/2,2.0445-0.002/2,2.0445-0.002/2,2.0445,1,2.0445,
);
my @z2    = (
0+0.6723/2,1.9179,2.0445,2.0445+0.002/2,2.0445+0.002/2,2.0445+0.002/2,7.0,2.0445,2.4,
);
my @Rin1  = (
32.2,32.2,148.7,0,0,0,24.2,15,19,
);
my @Rout1  = (
32.2+1,32.2+1,148.7+2,0+75.6,0+21.0,0+25.2,24.2+1,15+2,19+2,
);
my @Rin2  = (
32.2,148.7,75.6,0,0,0,85.3,19,30,
);
my @Rout2  = (
32.2+1,148.7+2,75.6+2,0+75.6,0+21.0,0+25.2,85.3+2,19+2,30+2,
);
my @rot  = (
0.025,0.025,0.025,0.025,0,0,0.050,0,0,
);
my @color = (
"8b9494","8b9494","8b9494","8b9494","f5ecd9","f5ecd9","8b9494","ff9494","ff9494",
);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "$x[$n-1]*m 0*m 0*m";
    $detector{"rotation"}   = "0*rad $rot[$n-1]*rad 0*rad";
    $detector{"color"}      = $color[$n-1]; 
    $detector{"type"}       = "Polycone";
    $detector{"dimensions"} = "0*deg 360*deg 2*counts $Rin1[$n-1]*mm $Rin2[$n-1]*mm $Rout1[$n-1]*mm $Rout2[$n-1]*mm $z1[$n-1]*m $z2[$n-1]*m";    
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
    if ($n ne 1) {
     print_det(\%configuration, \%detector);
    }
 }
}
1;