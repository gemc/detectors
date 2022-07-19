use strict;
use warnings;

our %configuration;

sub rghline()
{

	my $pipeLength = 72.5;
	my $zpos = 727.5;
	my $firstVacuumIR = 0.;
	my $firstVacuumOR = 34.925;

	my %detector = init_det();
	$detector{"name"}        = "vacuumPipe1_1";
	$detector{"mother"}      = "hdIce_mother";
	$detector{"description"} = "straightVacuumPipe 2.75 inch OD 0.065 thick ";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 0;
	$pipeLength = 72.5;
	$firstVacuumIR = 0;
	$firstVacuumOR = 33.325;
	
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe1_1";
	$detector{"mother"}      = "vacuumPipe1_1";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$firstVacuumIR*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$pipeLength = 728.4;
	$zpos = 1528.4;
	$firstVacuumIR = 0.;
	$firstVacuumOR = 34.925;

	%detector = init_det();
	$detector{"name"}        = "vacuumPipe1_2";
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
	$pipeLength = 728.4;
	$firstVacuumIR = 0;
	$firstVacuumOR = 33.325;

	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe1_2";
	$detector{"mother"}      = "vacuumPipe1_2";
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

	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
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

	# $zpos = 796;
	# $firstVacuumIR = 0;
	# $firstVacuumOR = 64;
	# $pipeLength = 1829.4;
	%detector = init_det();
	$detector{"name"}        = "Airpipe";
	$detector{"mother"}      = "hdIce_mother";
	$detector{"description"} = "Air Pipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0.0*deg 360*deg 4*counts 0.0*mm 0.0*mm 0.0*mm 0.0*mm 30.*mm 30*mm 25.46*mm 41.2*mm 280.71*mm 384.98*mm 384.98*mm 570*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 643.21;
	%detector = init_det();
	$detector{"name"}        = "Tungstentip";
	$detector{"mother"}      = "hdIce_mother";
	$detector{"description"} = "AngelaBrenna Tungsten Tip";
	$detector{"color"}       = "f69552";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "39*mm 41.2*mm 39*mm 54.02*mm 73.21*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 758.21;
	%detector = init_det();
	$detector{"name"}        = "Cone1_1";
	$detector{"mother"}      = "hdIce_mother";
	$detector{"description"} = "AngelaBrenna Tungsten Tip";
	$detector{"color"}       = "dd8648";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "38.1*mm 54.02*mm 38.1*mm 61.3313*mm 41.79*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zpos = 1013.25;
	%detector = init_det();
	$detector{"name"}        = "Cone1_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "AngelaBrenna Tungsten Tip";
	$detector{"color"}       = "dd8648";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "38.1*mm 61.3313*mm 38.1*mm 98.64*mm 213.25*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


	$zpos = 1290.05;
	%detector = init_det();
	$detector{"name"}        = "Cone2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "AngelaBrenna Tungsten Tip";
	$detector{"color"}       = "dd8648";
	$detector{"type"}        = "Cons";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "47.62*mm 98.64*mm 47.62*mm 109.76*mm 63.55*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	if( $configuration{"variation"} eq "rghFTOut") {
		$zpos = 1797.755;
		%detector = init_det();
		$detector{"name"}        = "Cylinder";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Moller Shield Pb pipe on beamline, NW80 flange is 2.87 inch inner diameter";
		$detector{"color"}       = "c57742";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "47.63*mm 109.76*mm 47.63*mm 109.76*mm 444.155*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$zpos = 1743.2;
		%detector = init_det();
		$detector{"name"}        = "SupportTube";
		$detector{"mother"}      = "root";
		$detector{"description"} = "2nd Moller Shield Cone outside beam pipe  ";
		$detector{"color"}       = "ac6839";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "38.1*mm 47.6*mm 38.1*mm 47.6*mm 516.7*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$zpos = 2018.765;
		%detector = init_det();
		$detector{"name"}        = "FTPreShieldCylinder";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Shield before FT on beamline";
		$detector{"color"}       = "945931";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "35.*mm 108.5*mm 35.*mm 108.5*mm 241.135*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
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

	}

	if( $configuration{"variation"} eq "rghFTOn") {
		$zpos = 1556.8;
		%detector = init_det();
		$detector{"name"}        = "Cylinder";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Moller Shield Pb pipe on beamline, NW80 flange is 2.87 inch inner diameter";
		$detector{"color"}       = "c57742";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "47.63*mm 109.76*mm 47.63*mm 109.76*mm 203.2*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$zpos = 1493.25;
		%detector = init_det();
		$detector{"name"}        = "SupportTube";
		$detector{"mother"}      = "root";
		$detector{"description"} = "2nd Moller Shield Cone outside beam pipe  ";
		$detector{"color"}       = "ac6839";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "38.1*mm 47.6*mm 38.1*mm 47.6*mm 266.75*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$zpos = 2305.45;
		%detector = init_det();
		$detector{"name"}        = "FTflangeShieldCylinder";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Shield around beam puipe flange";
		$detector{"color"}       = "999966";
		$detector{"type"}        = "Cons";
		$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
		$detector{"dimensions"}  = "125.4*mm 130*mm 125.4*mm 130.*mm 35.85*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}

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

