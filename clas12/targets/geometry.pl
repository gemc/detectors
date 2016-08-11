use strict;
use warnings;

our %configuration;
our %parameters;


require "./targetRev1.pl";




sub build_targets
{
	my $thisVariation = $configuration{"variation"} ;
	
	if($thisVariation eq "lH2" || $thisVariation eq "lD2")
	{
		# vacuum container
		my $Rout       = 44;
		my $length     = 50;  # half length
		my %detector = init_det();
		$detector{"name"}        = "scatteringChamberVacuum";
		$detector{"mother"}      = "root";
		$detector{"description"} = "clas12 scattering chamber vacuum rohacell container for $thisVariation target";
		$detector{"color"}       = "aaaaaa4";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# rohacell
		$Rout       = 43;
		$length     = 48;  # half length
		%detector = init_det();
		$detector{"name"}        = "scatteringChamber";
		$detector{"mother"}      = "scatteringChamberVacuum";
		$detector{"description"} = "clas12 rohacell scattering chamber for $thisVariation target";
		$detector{"color"}       = "ee3344";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "rohacell";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# vacuum container for aluminum cell
		$Rout       = 40;
		$length     = 45;  # half length
		%detector = init_det();
		$detector{"name"}        = "aluminumCellVacuum";
		$detector{"mother"}      = "scatteringChamber";
		$detector{"description"} = "clas12 rohacell vacuum aluminum container chamber for $thisVariation target";
		$detector{"color"}       = "aaaaaa4";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# aluminum cell
		$Rout       = 5.02;
		$length     = 25.03;  # half length
		%detector = init_det();
		$detector{"name"}        = "aluminumCell";
		$detector{"mother"}      = "aluminumCellVacuum";
		$detector{"description"} = "clas12 aluminum cell for $thisVariation target";
		$detector{"color"}       = "aaaaaa";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# actual target
		$Rout       = 5.00;
		$length     = 25.00;  # half length
		%detector = init_det();
		$detector{"name"}        = $thisVariation;
		$detector{"mother"}      = "aluminumCell";
		$detector{"description"} = "clas12 $thisVariation target";
		$detector{"color"}       = "ee8811Q";
		$detector{"type"}        = "Tube";
		$detector{"style"}       = "1";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		
		if($thisVariation eq "lH2")
		{
			$detector{"material"}    = "G4_lH2";
		}
		if($thisVariation eq "lD2")
		{
			$detector{"material"}    = "LD2";
		}
		print_det(\%configuration, \%detector);
	}
	elsif($thisVariation eq "ND3")
	{
		# vacuum container
		my $Rout       = 44;
		my $length     = 50;  # half length
		my %detector = init_det();
		$detector{"name"}        = "scatteringChamberVacuum";
		$detector{"mother"}      = "root";
		$detector{"description"} = "clas12 scattering chamber vacuum rohacell container for $thisVariation target";
		$detector{"color"}       = "aaaaaa4";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# rohacell
		$Rout       = 43;
		$length     = 48;  # half length
		%detector = init_det();
		$detector{"name"}        = "scatteringChamber";
		$detector{"mother"}      = "scatteringChamberVacuum";
		$detector{"description"} = "clas12 rohacell scattering chamber for $thisVariation target";
		$detector{"color"}       = "ee3344";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "rohacell";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		
		# vacuum container for plastic cell
		$Rout       = 40;
		$length     = 45;  # half length
		%detector = init_det();
		$detector{"name"}        = "plasticCellVacuum";
		$detector{"mother"}      = "scatteringChamber";
		$detector{"description"} = "clas12 rohacell vacuum aluminum container chamber for $thisVariation target";
		$detector{"color"}       = "aaaaaa4";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
  		# helium cylinder
		$Rout       = 12.62;
		$length     = 25.10;  # half length
		%detector = init_det();
		$detector{"name"}        = "HeliumCell";
		$detector{"mother"}      = "plasticCellVacuum";
		$detector{"description"} = "Helium volume for $thisVariation target";
		$detector{"color"}       = "aaaaaa3";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		#$detector{"material"}    = "G4_He";
		$detector{"material"}    = "G4_Galactic";#temporaly replacing with vacuum
		$detector{"style"}       = "1";
		print_det(\%configuration, \%detector);
		
		# plastic cylinder cell
		$Rout       = 12.60;
		$length     = 20.10;  # half length
		%detector = init_det();
		$detector{"name"}        = "plasticCell";
		$detector{"mother"}      = "HeliumCell";
		$detector{"description"} = "clas12 plastic cell for $thisVariation target";
		$detector{"color"}       = "aaaaaa";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_TEFLON"; #using teflon which is similar to the actual cell
		print_det(\%configuration, \%detector);
		
		
		# actual target
		$Rout       = 12.50; # target has a 25mm diamter
		$length     = 20.00;  # half length (target is 4cm long)
		%detector = init_det();
		$detector{"name"}        = $thisVariation;
		$detector{"mother"}      = "plasticCell";
		$detector{"description"} = "clas12 $thisVariation target";
		$detector{"color"}       = "ee8811Q";
		$detector{"type"}        = "Tube";
		$detector{"style"}       = "1";
		$detector{"dimensions"}  = "0*mm $Rout*mm $length*mm 0*deg 360*deg";
		
		$detector{"material"}    = "solidND3";
		print_det(\%configuration, \%detector);
		
	}
	elsif($thisVariation eq "elaborate")
	{
		buildElaborate();
	}
}























