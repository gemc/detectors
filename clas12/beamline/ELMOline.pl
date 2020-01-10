use strict;
use warnings;

our %configuration;


my $shieldStart = 963; # start of vacuum pipe is 1mm downstream of target vac extension
my $pipeFirstStep = 2413;
my $torusStart    = 2754.17 ;
my $mediumPipeEnd = 5016; # added by hand by shooting geantino vertically to locate the point
my $bigPipeBegins = 5064; # added by hand by shooting geantino vertically to locate the point
my $pipeEnds      = 5732;
my $alcovePipeStarts = 5741;
my $alcovePipeEnds   = 9400;
my $mediumStarts  = $pipeFirstStep + 76.5; # added by hand by shooting geantino vertically to locate the point

# apex cad model not filled with lead.
my $apexIR = 140;
my $apexOR = 190;
my $apexLength = 1000;
my $apexPos = 5372;

sub ELMOline()
{

	if( $configuration{"variation"} eq "FTOff") {
		$shieldStart = 503;
	}

	# in "root" the first part of the pipe is straight
	# 1.651mm thick
	my $pipeLength = 800.9;
	my $zpos = 1455.9;
	my $firstVacuumIR = 33.28;
	my $firstVacuumOR = 34.28;

	my %detector = init_det();
	$detector{"name"}        = "vacuumPipe1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe 2.75 inch OD 0.065 thick ";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	my $zpos = 885.9;
	my $pipeLength = 220.;
	my $firstVacuumIR = 0;
	my $firstVacuumOR = 33.275;

	my %detector = init_det();
	$detector{"name"}        = "vacuumInPipe1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	my $zpos = 1681.8;
	my $firstVacuumIR = 30.;
	my $firstVacuumOR = 33.275;
	my $pipeLength = 575.;
	my %detector = init_det();
	$detector{"name"}        = "InnerWcone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Tungsten Cone inside beam pipe";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "30.0*mm $firstVacuumOR*mm 25.4*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	my $zpos = 1681.8;
	my $firstVacuumIR = 25.3;
	my $firstVacuumOR = 29.9;
	my $pipeLength = 575.;
	my %detector = init_det();
	$detector{"name"}        = "vacuumInPipe1Con2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "vacuum in Pipe1 cone 2";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0.*mm $firstVacuumOR*mm 0*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	my $zpos = 2621.735;
	my $firstVacuumIR = 0.;
	my $firstVacuumOR = 34.925;
	my $pipeLength = 132.235;
	my %detector = init_det();
	$detector{"name"}        = "vacuumPipe2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe"
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	my $zpos = 0.
	my $firstVacuumIR = 0.;
	my $firstVacuumOR = 33.275;
	my $pipeLength = 132.235;
	my %detector = init_det();
	$detector{"name"}        = "vacuumInPipe2";
	$detector{"mother"}      = "vacuumPipe2";
	$detector{"description"} = "straightVacuumPipe"
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_GalacticL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);



         vacuumPipe3  |                root  |            straightVacuumPipe  |                              0*mm 0*mm 2451.15*mm  |                                   0 0 0  | aaffff   |                Tube  |                  33.375*mm 34.925*mm 38.15*mm 0*deg 360*deg  |  G4_STAINLESS-STEEL  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
       vacuumInPipe3  |                root  |            straightVacuumPipe  |                              0*mm 0*mm 2451.15*mm  |                                   0 0 0  | 000000   |                Tube  |                        0*mm 28.52*mm 38.15*mm 0*deg 360*deg  |         G4_Galactic  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
          vacuumPipe  |                  fc  |           vacuumPipe beampipe  |                                             0 0 0  |                                   0 0 0  | aaffff   |            Polycone  |0.0*deg 360*deg 4*counts 0.0*mm 0.0*mm 0.0*mm 0.0*mm 34.925*mm 34.925*mm 63.5*mm 63.5*mm 2754.17*mm 5016*mm 5064*mm 5732*mm  |  G4_STAINLESS-STEEL  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
        vacuumInPipe  |          vacuumPipe  |      vacuum inside vacuumPipe  |                                             0 0 0  |                                   0 0 0  | 000000   |            Polycone  |0.0*deg 360*deg 4*counts 0.0*mm 0.0*mm 0.0*mm 0.0*mm 33.274*mm 33.274*mm 60.325*mm 60.325*mm 2754.17*mm 5016*mm 5064*mm 5732*mm  |         G4_Galactic  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
  vacuumPipeToAlcove  |                  fc  |            straightVacuumPipe  |                               0*mm 0*mm 7570.4*mm  |                                   0 0 0  | aaffff   |                Tube  |                          0*mm 68*mm 1829.4*mm 0*deg 360*deg  |  G4_STAINLESS-STEEL  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
      leadInsideApex  |                  fc  |              lead inside apex  |                                 0*mm 0*mm 6372*mm  |                                   0 0 0  | 4499ff   |                Tube  |                         140*mm 190*mm 1000*mm 0*deg 360*deg  |               G4_Pb  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
vacuumInPipeToAlcove  |  vacuumPipeToAlcove  |          vacuumInPipeToAlcove  |                                             0 0 0  |                                   0 0 0  | 000000   |                Tube  |                          0*mm 64*mm 1829.4*mm 0*deg 360*deg  |         G4_Galactic  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no 
PbCone1  |                root  |         Moller Shield Pb pipe on beamline, NW80 flange is 2.87 inch innder diameter  |                           0*mm 0.0*mm 796*mm  |                                   0 0 0  | 999966   |                Cons  |                          35*mm 43*mm 35*mm 95.*mm 300.*mm 0.0*deg 360*deg  |          G4_Pb  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                    no
PbCone2  |                root  |         2nd Moller Shield Cone outside beam pipe  |                           0*mm 0.0*mm 1437.0*mm  |                                   0 0 0  | 999966   |                Cons  |                          35.*mm 95*mm 35*mm 110.*mm 341.*mm 0.0*deg 360*deg  |          G4_Pb  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no
FTPreShieldCylinder  |                root  |         Shield before FT on beamline  |                           0*mm 0.0*mm 2020.*mm  |                                   0 0 0  | 999966   |                Cons  |                          35.*mm 110*mm 35.*mm 110.*mm 241.3*mm 0.0*deg 360*deg  |          G4_W  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no
FTflangeShieldCylinder  |                root  |         Shield around beam puipe flange  |                           0*mm 0.0*mm 2300.*mm  |                                   0 0 0  | 999966   |                Cons  |                          125.4*mm 130*mm 125.4*mm 130.*mm 41.3*mm 0.0*deg 360*deg  |          G4_Pb  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no
TorusConnector  |                root  |         Shield around Shield support before FT on beamline  |                           0*mm 0.0*mm 2550.*mm  |                                   0 0 0  | 999966   |                Cons  |                          97*mm 104*mm 97*mm 104.*mm 101.3*mm 0.0*deg 360*deg  |          G4_Pb  |                  no  |     1   |     1   |     1   |   1   |   1   |                  no  |                  no  |                                      no
}

