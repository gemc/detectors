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

	my $pipeLength = 800.9;
	my $zpos = 1455.9;
	my $firstVacuumIR = 0.;
	my $firstVacuumOR = 34.925;

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

 	$zpos = 0;
	$pipeLength = 800.9;
	$firstVacuumIR = 0;
	my $firstVacuumOR = 33.275;

	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe1";
	$detector{"mother"}      = "vacuumPipe1";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

#	$zpos = 225.9;
#	$firstVacuumIR = 30.;
#	$firstVacuumOR = 33.275;
#	$pipeLength = 575.;
#	%detector = init_det();
#	$detector{"name"}        = "InnerWcone";
#	$detector{"mother"}      = "root";
#	$detector{"description"} = "Tungsten Cone inside beam pipe";
#	$detector{"color"}       = "999966";
#	$detector{"type"}        = "Cons";
#	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
#	$detector{"dimensions"}  = "30.0*mm $firstVacuumOR*mm 25.4*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
#	$detector{"material"}    = "G4_W";
#	$detector{"style"}       = 1;
#	print_det(\%configuration, \%detector);

#	$zpos = 225.9;
#	$firstVacuumIR = 25.3;
#	$firstVacuumOR = 29.9;
#	$pipeLength = 575.;
#	%detector = init_det();
#	$detector{"name"}        = "vacuumInPipe1Con2";
#	$detector{"mother"}      = "root";
#	$detector{"description"} = "vacuum in Pipe1 cone 2";
#	$detector{"color"}       = "000000";
#	$detector{"type"}        = "Cons";
#	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
#	$detector{"dimensions"}  = "0.*mm $firstVacuumOR*mm 0*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
#	$detector{"material"}    = "G4_Galactic";
#	$detector{"style"}       = 1;
#	print_det(\%configuration, \%detector);

	$zpos = 2621.735;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 34.925;
	$pipeLength = 132.235;
	%detector = init_det();
	$detector{"name"}        = "vacuumPipe2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 0.;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 33.275;
	$pipeLength = 132.235;
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe2";
	$detector{"mother"}      = "vacuumPipe2";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 2451.15;
	$firstVacuumIR = 33.375;
	$firstVacuumOR = 34.925;
	$pipeLength = 38.15;
	%detector = init_det();
	$detector{"name"}        = "vacuumPipe3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 2451.15;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 28.52;
	$pipeLength = 38.15;
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 0.;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 28.52;
	$pipeLength = 38.15;
	%detector = init_det();
	$detector{"name"}        = "vacuumPipe";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "vacuumPipe beampipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0.0*deg 360*deg 4*counts 0.0*mm 0.0*mm 0.0*mm 0.0*mm 34.925*mm 34.925*mm 63.5*mm 63.5*mm 2754.17*mm 5016*mm 5064*mm 5732*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 0.;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 28.52;
	$pipeLength = 38.15;
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe";
	$detector{"mother"}      = "vacuumPipe";
	$detector{"description"} = "vacuum inside vacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0.0*deg 360*deg 4*counts 0.0*mm 0.0*mm 0.0*mm 0.0*mm 33.274*mm 33.274*mm 60.325*mm 60.325*mm 2754.17*mm 5016*mm 5064*mm 5732*mm";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 7570.4;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 68.;
	$pipeLength = 1829.4;
	%detector = init_det();
	$detector{"name"}        = "vacuumPipeToAlcove";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 6372;
	$firstVacuumIR = 140;
	$firstVacuumOR = 190;
	$pipeLength = 1000;
	%detector = init_det();
	$detector{"name"}        = "leadInsideApex";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "lead inside apex";
	$detector{"color"}       = "4499ff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 0;
	$firstVacuumIR = 0;
	$firstVacuumOR = 64;
	$pipeLength = 1829.4;
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipeToAlcove";
	$detector{"mother"}      = "vacuumPipeToAlcove";
	$detector{"description"} = "vacuumInPipeToAlcove";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 796;
	$firstVacuumIR = 0;
	$firstVacuumOR = 64;
	$pipeLength = 1829.4;
	%detector = init_det();
	$detector{"name"}        = "PbCone1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Moller Shield Pb pipe on beamline, NW80 flange is 2.87 inch inner diameter";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "35*mm 43*mm 35*mm 95.*mm 300.*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 1437.0;
	%detector = init_det();
	$detector{"name"}        = "PbCone2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "2nd Moller Shield Cone outside beam pipe";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "35.*mm 95*mm 35*mm 110.*mm 341.*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 2020.0;
	%detector = init_det();
	$detector{"name"}        = "FTPreShieldCylinder";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shield before FT on beamline";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "35.*mm 110*mm 35.*mm 110.*mm 241.3*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 2300.0;
	%detector = init_det();
	$detector{"name"}        = "FTflangeShieldCylinder";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shield around beam puipe flange";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "125.4*mm 130*mm 125.4*mm 130.*mm 41.3*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 2550.0;
	%detector = init_det();
	$detector{"name"}        = "TorusConnector";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shield around Shield support before FT on beamline";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "97*mm 104*mm 97*mm 104.*mm 101.3*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

