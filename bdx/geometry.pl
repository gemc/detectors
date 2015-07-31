use strict;
use warnings;

our %configuration;




###########################################################################################
###########################################################################################
# Define the relevant parameters of BDX geometry
#
# the BDX geometry will be defined starting from these parameters 
#
# all dimensions are in mm
#


my $degrad = 0.01745329252;
my $cic    = 2.54;

# geom globals
my $TunnDist=400.0;
my $theta3=13.4;
my $x0 = -130 - 227.401;
my $y0 = 50 - 50;
my $z0 = 900 + 1227;
my $TunnISzX=140.0;
my $TunnISzY=177.165;
my $TunnISzZ=720.0;
my $TunnWThS=36.0;
my $TunnWThF=43.0;




###########################################################################################
# Build Crystal Volume and Assemble calorimeter
###########################################################################################


sub make_whole
{
	my %detector = init_det();
	$detector{"name"}        = "bdx_main_volume";
	$detector{"mother"}      = "root";
	$detector{"description"} = "World";
	$detector{"color"}       = "666666";
	$detector{"style"}       = 0;
	$detector{"visible"}     = 0;
	$detector{"type"}        = "Box";
#      my $X = $x0-$TunnDist*sin($DEGRAD*$theta3);
#      my $Y = $y0 + 50.;
#      my $Z = $z0+$TunnDist*cos($DEGRAD*$theta3);
# we don't have Tagger Hall volume - this is the mother
	my $X = 0.;
	my $Y = 0.;
#      my $Z = $cic*($TunnISzZ+2.*$TunnWThF)/2.;
	my $Z = 0.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = 2*$cic*($TunnISzX+2.*$TunnWThS)/2.;
	my $par2 = 2*$cic*($TunnISzY+2.*$TunnWThS)/2.;
	my $par3 = 2*$cic*($TunnISzZ+2.*$TunnWThF)/2.+200.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "G4_Galactic";
	print_det(\%configuration, \%detector);
}

sub make_tunc
{
	my %detector = init_det();
	$detector{"name"}        = "tunc";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "Concrete Box in the Ground (TUNC) - Walls";
	$detector{"color"}       = "E6E6E6";
	$detector{"style"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Box";
#      my $X = $x0-$TunnDist*sin($DEGRAD*$theta3);
#      my $Y = $y0 + 50.;
#      my $Z = $z0+$TunnDist*cos($DEGRAD*$theta3);
# we don't have Tagger Hall volume - this is the mother
	my $X = 0.;
	my $Y = 50.;
#      my $Z = $cic*($TunnISzZ+2.*$TunnWThF)/2.;
	my $Z = 0.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*($TunnISzX+2.*$TunnWThS)/2.;
	my $par2 = $cic*($TunnISzY+2.*$TunnWThS)/2.;
	my $par3 = $cic*($TunnISzZ+2.*$TunnWThF)/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "G4_CONCRETE";
	print_det(\%configuration, \%detector);
}


sub make_tuna
{
	my %detector = init_det();
	$detector{"name"}        = "tuna";
	$detector{"mother"}      = "tunc";
	$detector{"description"} = "Air Box in the TUNC (TUNA) - Air in the Tunnel";
	$detector{"color"}       = "CEF6F5";
	$detector{"type"}        = "Box";
	my $X = 0.;
	my $Y = 0.;
	my $Z = 0.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*$TunnISzX/2.;
	my $par2 = $cic*$TunnISzY/2.;
	my $par3 = $cic*$TunnISzZ/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);

	my $tunc_nflux=6;
	my $tunc_flux_dz=20.;
	my $tunc_flux_lz=0.01;
	for(my $iz=0; $iz<$tunc_nflux; $iz++)
	{
		my %detector = init_det();
		$detector{"name"}        = "tunc_flux_$iz";
		$detector{"mother"}      = "tunc";
		$detector{"description"} = "tunc flux detector $iz ";
		$detector{"color"}       = "cc00ff";
		$detector{"style"}       = 1;
		$detector{"visible"}     = 0;
		$detector{"type"}        = "Box";	
		$X = 0.;
		$Y = 0.;
		$Z=$iz*$tunc_flux_dz+$par3+$tunc_flux_lz+1.;
		$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
		$detector{"dimensions"}  = "$par1*cm $par2*cm $tunc_flux_lz*cm";
		$detector{"material"}    = "G4_CONCRETE"; 
		$detector{"sensitivity"} = "flux";
		$detector{"hit_type"}    = "flux";
		my $nflux=112+$iz;
		$detector{"identifiers"} = "id manual $nflux";
		print_det(\%configuration, \%detector);
	}

}


my $WL1Door=22.0;
my $WLabHgt = $TunnISzY;
my $WLabThk=24.0;
my $WL1Dist=19.0;
my $HousLen=182.0;
my $CWBDDist=179.6;
my $WL2Door=23.0;
my $WL2Dist=56.0;
my $WL3Door=22.0;
my $WL3Dist=56.0;

sub make_clab
{
	my %detector = init_det();
	$detector{"name"}        = "clab1";
	$detector{"mother"}      = "tuna";
	$detector{"description"} = "Concrete Boxes in the TUNA (CLAB -1,2,3) - Labyrinth Walls";
	$detector{"color"}       = "666666";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";
	my $X = $cic*$WL1Door/2.;
	my $Y = -$cic*($TunnISzY-$WLabHgt)/2.;
	my $Z = -$cic*$WLabThk/2. - $cic*($WL1Dist + $HousLen - $CWBDDist);
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*($TunnISzX-$WL1Door)/2.;
	my $par2 = $cic*$WLabHgt/2.;
	my $par3 = $cic*$WLabThk/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "G4_CONCRETE";
	print_det(\%configuration, \%detector);

#	my %detector = init_det();
	$detector{"name"}        = "clab2";
	$X = -$cic*$WL2Door/2.;
	$Z = -$par3 - $cic*($WL1Dist + $HousLen - $CWBDDist) - $cic*($WL2Dist + $WLabThk);
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$par1 =  $cic*($TunnISzX-$WL2Door)/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "clab3";
	$X = -$cic*$WL3Door/2.;
	$Z = -$par3 - $cic*($WL1Dist + $HousLen - $CWBDDist) + $cic*($WL3Dist + $WLabThk);
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$par1 = $cic*($TunnISzX-$WL3Door)/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "clab4";
	$detector{"ncopy"}       = 4;
#      $X = $par1-280.;
#      $Y = 0.;
#      $Z = 135.5;
# located in different mother volume - try to fit into TUNA
	$X = -$par1 + $cic*$TunnISzX/2.;
	$Y = -$par2+$cic*$TunnISzY/2.;
	$Z = -$cic*$WLabThk/2. - $cic*($WL1Dist + $HousLen - $CWBDDist) - $cic*($WL2Dist + $WLabThk) - 3.*$par3;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$par1 = 100.;
	$par2 = $cic*$WLabHgt/2.;
	$par3 = 31.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	print_det(\%configuration, \%detector);
}


 
# Beam in the center
my $BeamElev = $TunnISzY/2. - 50./$cic;
my $HousHgt = $BeamElev*2.;

sub make_iron
{
	my %detector = init_det();
	$detector{"name"}        = "iron";
	$detector{"mother"}      = "tuna";
	$detector{"description"} = "iron shield blocks in the TUNA (IRON)";
	$detector{"color"}       = "FF8000";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";
	my $par1 = $cic*$TunnISzX/2.;
	my $par2 = $cic*$HousHgt/2.;
	my $par3 = $cic*$HousLen/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	my $X = 0.;
	my $Y = -$cic*($TunnISzY-$HousHgt)/2.;
	my $Z = -$par3 + $cic*$TunnISzZ/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "bdx_iron";
	print_det(\%configuration, \%detector);
	
	my $iron_nflux=12;
	my $iron_flux_dz=20.;
	my $iron_flux_lz=0.01;
	for(my $iz=0; $iz<$iron_nflux; $iz++)
	{
		my %detector = init_det();
		$detector{"name"}        = "iron_flux_$iz";
		$detector{"mother"}      = "iron";
		$detector{"description"} = "iron flux detector $iz ";
		$detector{"color"}       = "cc00ff";
		$detector{"style"}       = 1;
		$detector{"visible"}     = 0;
		$detector{"type"}        = "Box";	
		$X = 0.;
		$Y = 0.;
		$Z=$iz*$iron_flux_dz+$iron_flux_lz;
		$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
		$detector{"dimensions"}  = "$par1*cm $par2*cm $iron_flux_lz*cm";
		$detector{"material"}    = "bdx_iron"; 
		$detector{"sensitivity"} = "flux";
		$detector{"hit_type"}    = "flux";
		my $nflux=100+$iz;
		$detector{"identifiers"} = "id manual $nflux";
		print_det(\%configuration, \%detector);
	}

}


my $BdholeX=26.0;
my $BdholeY=26.0;
my $BdholeZ=78.0;

sub make_bsyv
{
	my %detector = init_det();
	$detector{"name"}        = "bsyv";
	$detector{"mother"}      = "iron";
	$detector{"description"} = "BD-hole in the iron shield blocks (BSYV)";
	$detector{"color"}       = "33ffff";
	$detector{"type"}        = "Box";
	my $par1 = $cic*$BdholeX/2.;
	my $par2 = $cic*$BdholeY/2.;
	my $par3 = $cic*$BdholeZ/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	my $X = 0.;
	#      my $Y = -$cic*$BeamElev - $cic*$HousHgt/2.;
	#      my $Z = -$par3 - $cic*$HousLen/2.;
	my $Y = 0.;
	my $Z = $par3 - $cic*$HousLen/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);
}



my $CWEnDist=2.00;
my $CWExDist=3.00;
my $CWinDia=1.95;
my $CWoutDia=2.88;
my $shftBSYV = $cic*($HousLen - $CWBDDist) - $cic*$BdholeZ/2.;

sub make_wint
{
	my %detector = init_det();
	$detector{"name"}        = "wint";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Win Section Tube (WINT)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV + $cic*($CWExDist-$CWEnDist)/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	my $par1 = $cic*$CWinDia/2.;
	my $par2 = $cic*$CWoutDia/2.;
	my $par3 = $cic*($CWEnDist+$CWExDist)/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


my $CWFlDi=4.60;
my $CWFlTh=0.625;

sub make_winf
{
	my %detector = init_det();
	$detector{"name"}        = "winf";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Win Section Flange (WINF)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";	
	my $par1 = $cic*$CWoutDia/2.;
	my $par2 = $cic*$CWFlDi/2.;
	my $par3 = $cic*$CWFlTh/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV - $par3 + $cic*$CWExDist;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}



my $CWDiam=1.18;
my $CWThick=0.118;
my $CWWDist=1.25;
my $CW2Th=0.354;

sub make_wind
{
	my %detector = init_det();
	$detector{"name"}        = "wind1";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "copper Windows (WIND)";
	$detector{"color"}       = "ff9933";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV - $cic*$CWWDist;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	my $par1 = 0.;
	my $par2 = $cic*$CWDiam/2.;
	my $par3 = $cic*$CWThick/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_Cu";	
	print_det(\%configuration, \%detector);


	$detector{"name"}        = "wind2";
	$Z = $shftBSYV + $cic*$CWWDist;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";	
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "wind3";
	$Z = $shftBSYV - $cic*$CWWDist;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$par1 = $cic*$CWDiam/2.;
	$par2 = $cic*$CWinDia/2.;
	$par3 = $cic*$CW2Th/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "wind4";
	$Z = $shftBSYV + $cic*$CWWDist;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);
}


my $FSinDia=3.0;
my $FSoutDia=6.625;
my $FSLeng=12.188;

sub make_fsst
{
	my %detector = init_det();
	$detector{"name"}        = "fsst";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Front Section Tube (FSST)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";	
	my $par1 = $cic*$FSinDia/2.;
	my $par2 = $cic*$FSoutDia/2.;
	my $par3 = $cic*$FSLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV + $par3 + $cic*$CWExDist;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


my $FSEFlDi=2.50;
my $FSEFlTh=1.628;

sub make_fsef
{
	my %detector = init_det();
	$detector{"name"}        = "fsef";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Front Section Tube entrance flange inside (FSEF)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $par1 = $cic*$FSEFlDi/2.;
	my $par2 = $cic*$FSinDia/2.;
	my $par3 = $cic*$FSEFlTh/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV + $par3 + $cic*$CWExDist;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


my $FSFlDi=9.50;
my $FSFlTh=0.875;

sub make_fssf
{
	my %detector = init_det();
	$detector{"name"}        = "fssf";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Front Section Flange (FSSF)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $par1 = $cic*$FSoutDia/2.;
	my $par2 = $cic*$FSFlDi/2.;
	my $par3 = $cic*$FSFlTh/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV - $par3 + $cic*$FSLeng + $cic*$CWExDist;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}



my $FSWCinD=5.50;
my $FSWCThk=0.25;

sub make_fstw
{
	my %detector = init_det();
	$detector{"name"}        = "fstw";
	$detector{"mother"}      = "acst";
	$detector{"description"} = "Front Section Tube Water (FSTW)";
	$detector{"color"}       = "ffffff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $X = 0.;
	my $Y = 0.;
	my $Z = 0.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	my $par1 = $cic*$FSWCinD/2.;
	my $par2 = $cic*($FSWCinD/2. + $FSWCThk);
	my $par3 = $cic*$FSLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_WATER";
	print_det(\%configuration, \%detector);
}


my $ACSDiam=10.00;
my $ACSLeng=41.50;

sub make_acst
{
	my %detector = init_det();
	$detector{"name"}        = "acst";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Al Center Section Tube (ACST)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $par1 = 0.;
	my $par2 = $cic*$ACSDiam/2.;
	my $par3 = $cic*$ACSLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV + $par3 + $cic*($CWExDist+$FSLeng);	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


my $ACHDiam=2.25;
my $ACHLeng=19.60;

sub make_acht
{
	my %detector = init_det();
	 $detector{"name"}        = "acht";
	$detector{"mother"}      = "acst";
	$detector{"description"} = "Al Center Section Tube (ACHT)";
	$detector{"color"}       = "33ffff";
	$detector{"style"}       = 0;
	$detector{"type"}        = "Tube";	
	my $par1 = 0.;
	my $par2 = $cic*$ACHDiam/2.;
	my $par3 = $cic*$ACHLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $par3 - $cic*$ACSLeng/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);
}


sub make_acct
{
	my %detector = init_det();
	$detector{"name"}        = "acct";
	$detector{"mother"}      = "acht";
	$detector{"description"} = "cone in the Hole in Al Center Section Tube (ACCT)";
	$detector{"color"}       = "999999";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Cons";
	#      my $par1 = $cic*$ACHDiam/4.; Dz/2
	#      my $par2 = $cic*$ACHDiam/2.; R1_min
	#      my $par3 = $cic*$ACHDiam/2.; R1_max
	#      my $par4 = 0.;               R2_min
	#      my $par5 = $cic*$ACHDiam/2.; R2_max
	my $par1 = $cic*$ACHDiam/2.;
	my $par2 = $cic*$ACHDiam/2.;
	my $par3 = 0.;
	my $par4 = $cic*$ACHDiam/2.;
	my $par5 = $cic*$ACHDiam/4.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm $par4*cm $par5*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = - $par1 + $cic*$ACHLeng/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


my $ACWCinD=3.50;
my $ACWCThk=0.25;

sub make_actw
{
	my %detector = init_det();
	$detector{"name"}        = "actw";
	$detector{"mother"}      = "acst"; 
	$detector{"description"} = "Al Center Section Tube Water (ACTW)";
	$detector{"color"}       = "ffffff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $X = 0.;
	my $Y = 0.;
	my $Z = 0.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*$ACWCinD/2.;
	my $par2 = $cic*$ACWCinD/2. + $cic*$ACWCThk;
	my $par3 = $cic*$ACSLeng/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_WATER";
	print_det(\%configuration, \%detector);
}


my $CESDiam=10.0;
my $CESLeng=11.5;
my $CESgap=0.25;

sub make_cest
{
	my %detector = init_det();
	$detector{"name"}        = "cest";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "Copper End Section Tube (CEST)";
	$detector{"color"}       = "ff9933";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";	
	my $par1 = 0.;
	my $par2 = $cic*$CESDiam/2.;
	my $par3 = $cic*$CESLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV + $par3 + $cic*($CWExDist+$FSLeng+$ACSLeng+$CESgap);	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Cu";
	print_det(\%configuration, \%detector);
}


my $CEWCinD=9.00;
my $CEWCThk=0.25;

sub make_cetw
{
	my %detector = init_det();
	$detector{"name"}        = "cetw";
	$detector{"mother"}      = "cest";
	$detector{"description"} = "Copper End Section Tube Water (CETW)";
	$detector{"color"}       = "ffffff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";	
	my $X = 0.;
	my $Y = 0.;
	my $Z = 0.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*$CEWCinD/2.;
	my $par2 = $cic*$CEWCinD/2. + $cic*$CEWCThk;
	my $par3 = $cic*$CESLeng/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_WATER";
	print_det(\%configuration, \%detector);
}


my $SizeBD = 0;

sub make_cmb
{
	my %detector = init_det();
	$detector{"name"}        = "cmb0";
	$detector{"mother"}      = "bsyv";
	$detector{"description"} = "side cyl. outside BD";
	$detector{"color"}       = "0000ff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Tube";
	my $par1 = $cic*$ACSDiam/2.;
	my $par2 = $par1 + 0.5;
	my $par3 = $cic*($CWEnDist+$CWExDist+$FSLeng+$ACSLeng+$CESgap+$CESLeng)/2.;
	my $SizeBD = $par3;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $shftBSYV - $cic*$CWEnDist + $par3;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Galactic";	
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmb1";
	$par1 = 0.;
	$par2 = $cic*$ACSDiam/2. + 0.5;
	$par3 = 0.25;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm 0*deg 360*deg";
	$Z = $shftBSYV - $cic*$CWEnDist + 2.*$SizeBD + $par3;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmb2";
	$Z = $shftBSYV - $cic*$CWEnDist - $par3;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);
}


my $CV_Zsize = $WL1Dist + $HousLen - $CWBDDist  - 300./$cic + $TunnISzZ/2.;

sub make_cmc
{
	my %detector = init_det();
	$detector{"name"}        = "cmc1";
	$detector{"mother"}      = "tunc";
	$detector{"description"} = "Air Plates in the TUNC (entrance from TUNA)";
	$detector{"color"}       = "0000ff";
	$detector{"type"}        = "Box";	
	my $par1 = 0.25;
	my $par2 = $cic*$TunnISzY/2.;
	my $par3 = $cic*$CV_Zsize/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	my $X = $par1 + $cic*$TunnISzX/2.;
	my $Y = 0.;
	my $Z = $cic*$TunnISzZ/2. - $par3;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"material"}    = "G4_Galactic";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmc2";
	$X = - $par1 - $cic*$TunnISzX/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmc3";
	$par1 = 0.5+$cic*$TunnISzX/2.;
	$par2 = 0.25;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$X = 0.;
	$Y = $par2 + $cic*$TunnISzY/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmc4";
	$Y = - $par2 - $cic*$TunnISzY/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmc5";
	$par2 = 0.5+$cic*$TunnISzY/2.;
	$par3 = 0.25;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$X = 0.;
	$Y = 0.;
	$Z = $par3 + $cic*$TunnISzZ/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cmc6";
	$detector{"mother"}      = "tuna";
	$par1 = $cic*$TunnISzX/2.;
	$par2 = $cic*$TunnISzY/2.;
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$Z = $par3 - $cic*($WL1Dist + $HousLen - $CWBDDist - 300./$cic);
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	print_det(\%configuration, \%detector);

}


my $TEwidthX=104.0;
my $TEwidthY=78.75;
my $TElengthZ=259.010+53.0;
my $TEth=13.21;

sub make_tunce
{
	my %detector = init_det();
	$detector{"name"}        = "tunce";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "Extention of Concrete Box in the Ground (TUNCE) - Walls";
	$detector{"color"}       = "336666";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";
	my $X = 0.;
#	my $Y = -$cic*($TunnISzY-$HousHgt)/2.;
	my $Y = 0.;
	my $Z = $cic*($TunnISzZ+2.*$TunnWThF+$TElengthZ+$TEth)/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	my $par1 = $cic*($TEwidthX+2.*$TEth)/2.;
	my $par2 = $cic*($TEwidthY+2.*$TEth)/2.;
	my $par3 = $cic*($TElengthZ+$TEth)/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "G4_CONCRETE";
	print_det(\%configuration, \%detector);
}


sub make_tunae
{
	my %detector = init_det();
	$detector{"name"}        = "tunae";
	$detector{"mother"}      = "tunce";
	$detector{"description"} = "Iron Box in the TUNCE (TUNAE) - Air in the Tunnel";
	$detector{"color"}       = "33ee99";
	$detector{"type"}        = "Box";	
	my $X = 0.;
	my $Y = 0.;
	my $Z = -$TEth/2.;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	my $par1 = $cic*$TEwidthX/2.;
	my $par2 = $cic*$TEwidthY/2.;
	my $par3 = $cic*$TElengthZ/2.;	
	$detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
	$detector{"material"}    = "bdx_iron";
	print_det(\%configuration, \%detector);
	
	my $tunce_nflux=15;
	my $tunce_flux_dz=50.;
	my $tunce_flux_lz=0.01;
	for(my $iz=0; $iz<$tunce_nflux; $iz++)
	{
		my %detector = init_det();
		$detector{"name"}        = "tunce_flux_$iz";
		$detector{"mother"}      = "tunae";
		$detector{"description"} = "tunae flux detector $iz ";
		$detector{"color"}       = "cc00ff";
		$detector{"style"}       = 1;
		$detector{"visible"}     = 0;
		$detector{"type"}        = "Box";	
		$X = 0.;
		$Y = 0.;
		$Z=-$par3+$iz*$tunce_flux_dz+$tunce_flux_lz;
		$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
		$detector{"dimensions"}  = "$par1*cm $par2*cm $tunce_flux_lz*cm";
		$detector{"material"}    = "bdx_iron"; 
		$detector{"sensitivity"} = "flux";
		$detector{"hit_type"}    = "flux";
		my $nflux=200+$iz;
		$detector{"identifiers"} = "id manual $nflux";
		print_det(\%configuration, \%detector);
	}
}





# define cormorino detector geometry
my $cormo_z=2020;
#my $cormo_z=1920;
# detector is a matrix of $cormo_nchannels in Y and $cormo_nchannels in Z
my $cormo_nchannels=3;
# small bar size is (cm):
my $cormo_bar_dx=30./2.;
my $cormo_bar_dy=5./2.;
my $cormo_bar_dz=5./2.;
# scintillator block size is (cm):
my $cormo_block_nbary=2;
my $cormo_block_nbarz=2;
my $cormo_block_dx=5./2.;
# mylar wrapping thickness is (cm):
my $cormo_mylar_tn=0.0025;
# airgap thickness is (cm):
my $cormo_airgap_tn=0.05;
# case thickness is (cm):
my $cormo_box_tn=1.;
# lead planes thicknes
my $cormo_lead_tn=0.02;
# pmt length
my $cormo_pmt_lt=26.;

# calculate all other infos from above parameters:
# wrapped bars:
my $cormo_wrapped_bar_dx=$cormo_bar_dx;
my $cormo_wrapped_bar_dy=$cormo_bar_dy+$cormo_mylar_tn;
my $cormo_wrapped_bar_dz=$cormo_bar_dz+$cormo_mylar_tn;
# wrapped blocks:
my $cormo_wrapped_block_dx=$cormo_block_dx;
my $cormo_wrapped_block_dy=$cormo_wrapped_bar_dy*$cormo_block_nbary+$cormo_airgap_tn*($cormo_block_nbary-1);
my $cormo_wrapped_block_dz=$cormo_wrapped_bar_dz*$cormo_block_nbarz+$cormo_airgap_tn*($cormo_block_nbarz-1);
# blocks
my $cormo_block_dy=$cormo_wrapped_block_dy-$cormo_mylar_tn;
my $cormo_block_dz=$cormo_wrapped_block_dz-$cormo_mylar_tn;
#channels
my $cormo_channel_dx=2*$cormo_wrapped_block_dx+$cormo_wrapped_bar_dx;
my $cormo_channel_dy=$cormo_wrapped_block_dy+$cormo_airgap_tn;
my $cormo_channel_dz=$cormo_wrapped_block_dz+$cormo_airgap_tn;
# box
my $cormo_box_lx=$cormo_channel_dx+$cormo_box_tn;
my $cormo_box_ly=$cormo_channel_dy*$cormo_nchannels+$cormo_box_tn;
my $cormo_box_lz=($cormo_channel_dz+$cormo_lead_tn/2.)*$cormo_nchannels+$cormo_box_tn;
# lead
my $cormo_lead_lx=$cormo_channel_dx;
my $cormo_lead_ly=$cormo_channel_dy*$cormo_nchannels;
my $cormo_lead_lz=$cormo_lead_tn/2.;
# flux
my $cormo_flux_lz =0.02;
# inner veto
my $cormo_iveto_gap=1.;
my $cormo_iveto_tn=1./2.;
my $cormo_iveto_lx=$cormo_box_lx+$cormo_pmt_lt+$cormo_iveto_gap+2*$cormo_iveto_tn;
my $cormo_iveto_ly=$cormo_box_ly+$cormo_iveto_gap;
my $cormo_iveto_lz=$cormo_box_lz+$cormo_iveto_gap+2*$cormo_iveto_tn;

# lead shield
my $cormo_leadshield_tn=5./2.;
my $cormo_leadshield_gap=1.;
my $cormo_leadshield_lx=$cormo_iveto_lx+$cormo_leadshield_gap+2*$cormo_leadshield_tn;
my $cormo_leadshield_ly=$cormo_iveto_ly+$cormo_leadshield_gap+2*$cormo_iveto_tn;	
my $cormo_leadshield_lz=$cormo_iveto_lz+$cormo_leadshield_gap+2*$cormo_leadshield_tn;

# outer veto
my $cormo_oveto_gap=1.;
my $cormo_oveto_tn=1.;
my $cormo_oveto_lx=$cormo_leadshield_lx+$cormo_oveto_gap+2*$cormo_oveto_tn;
my $cormo_oveto_ly=$cormo_leadshield_ly+$cormo_oveto_gap+2*$cormo_leadshield_tn;
my $cormo_oveto_lz=$cormo_leadshield_lz+$cormo_oveto_gap+2*$cormo_oveto_tn;
my $cormo_oveto_dz=$cormo_oveto_lz/2.;

#flux detector around cormorad
#my $cormo_veto_r0=32.0;
#my $cormo_veto_r1=30.0;
#my $cormo_veto_h0=18.0;
#my $cormo_veto_h1=20.0;
my $cormo_veto_r0=49.9;
my $cormo_veto_r1=47.9;
my $cormo_veto_h0=30.0;
my $cormo_veto_h1=32.0;
my $cormo_veto_nplanes=6;

my @cormo_veto_ir = (              0.,              0. , $cormo_veto_r1,   $cormo_veto_r1,              0.,              0.);
my @cormo_veto_or = ( $cormo_veto_r0 , $cormo_veto_r0  , $cormo_veto_r0,   $cormo_veto_r0,   $cormo_veto_r0, $cormo_veto_r0);
my @cormo_veto_z  = (-$cormo_veto_h1 , -$cormo_veto_h0 ,-$cormo_veto_h0,   $cormo_veto_h0,   $cormo_veto_h0, $cormo_veto_h1);


sub make_cormo_flux
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_flux";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "flux detector";
	$detector{"color"}       = "cc00ff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";	
	my $X = 0.;
	my $Y = 0.;
	my $Z = $cormo_z-17.1;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"dimensions"}  = "20*cm 15*cm 1*mm";
	$detector{"material"}    = "ScintillatorB"; #ScintillatorB
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual 0";
#	print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "cormo_veto";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "veto detector";
	$detector{"color"}       = "A9D0F5";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Polycone";	
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "90*deg 0*deg 0*deg";
	my $dimen = "0.0*deg 360*deg $cormo_veto_nplanes*counts";
	for(my $i = 0; $i <$cormo_veto_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_veto_ir[$i]*cm";
	}
	for(my $i = 0; $i <$cormo_veto_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_veto_or[$i]*cm";
	}
	for(my $i = 0; $i <$cormo_veto_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_veto_z[$i]*cm";
	}	
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "ScintillatorB";
	$detector{"sensitivity"}  = "flux";
	$detector{"hit_type"}     = "flux";
	$detector{"identifiers"}  = "id manual 1";
#	print_det(\%configuration, \%detector);
}



sub make_cormo_det
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_det";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "cormorad detector";
	$detector{"color"}       = "0000ff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"dimensions"}  = "$cormo_box_lx*cm $cormo_box_ly*cm $cormo_box_lz*cm";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "cormo_flux";
	$detector{"mother"}      = "cormo_det";
	$detector{"description"} = "cormorad flux detector";
	$detector{"color"}       = "cc00ff";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";	
	$X = 0.;
	$Y = 0.;
	$Z=-($cormo_box_lz-$cormo_box_tn)-$cormo_flux_lz;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";	
	$detector{"dimensions"}  = "$cormo_lead_lx*cm $cormo_lead_ly*cm $cormo_flux_lz*cm";
	$detector{"material"}    = "G4_AIR"; 
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual 301";
	print_det(\%configuration, \%detector);
	
	for(my $iz=0; $iz<$cormo_nchannels; $iz++)
	{
		my %detector = init_det();
		$detector{"name"}        = "cormo_lead_$iz";
		$detector{"mother"}      = "cormo_det";
		$detector{"description"} = "cormorad lead plane $iz";
		$X=0;
		$Y=0;
		$Z=-($cormo_box_lz-$cormo_box_tn)+$cormo_lead_lz+2*$iz*($cormo_channel_dz+$cormo_lead_lz);
		$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$cormo_lead_lx*cm $cormo_lead_ly*cm $cormo_lead_lz*cm";
		$detector{"material"}    = "G4_Pb";
		print_det(\%configuration, \%detector);
		for(my $iy=0; $iy<$cormo_nchannels; $iy++)
		{
			my $channel_id=$iz*10+$iy;
			my %detector = init_det();
			$detector{"name"}        = "cormo_channel_$channel_id";
			$detector{"mother"}      = "cormo_det";
			$detector{"description"} = "cormorad channel $channel_id";
			$detector{"color"}       = "00ffff";
			$detector{"style"}       = 1;
			$detector{"type"}        = "Box";
			$X=0;
			$Y=($iy*2-$cormo_nchannels+1)*$cormo_channel_dy;
#			$Z=($iz*2-$cormo_nchannels+1)*$cormo_channel_dz+($iz+1)*$cormo_lead_tn;
			$Z=-($cormo_box_lz-$cormo_box_tn)+($iz+1)*$cormo_lead_tn+(2*$iz+1)*$cormo_channel_dz;
			$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
			$detector{"rotation"}    = "0*deg 0*deg 0*deg";
			$detector{"dimensions"}  = "$cormo_channel_dx*cm $cormo_channel_dy*cm $cormo_channel_dz*cm";
			$detector{"material"}    = "G4_AIR";
			print_det(\%configuration, \%detector);
		
			for(my $iblock=0; $iblock<2; $iblock++)
			{
				my $block_name="left";
				if($iblock==1) {
					$block_name="right";
				}
				my %detector = init_det();
				$detector{"name"}        = "cormo_wrapped_block_$block_name"."_$channel_id";
				$detector{"mother"}      = "cormo_channel_$channel_id";
				$detector{"description"} = "cormorad wrapped $block_name block $channel_id";
				$detector{"color"}       = "A4A4A4";
				$detector{"style"}       = 1;
				$detector{"type"}        = "Box";
				$X=($iblock*2-1)*($cormo_wrapped_bar_dx+$cormo_wrapped_block_dx);
				$Y=0;
				$Z=0;
				$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"dimensions"}  = "$cormo_wrapped_block_dx*cm $cormo_wrapped_block_dy*cm $cormo_wrapped_block_dz*cm";
				$detector{"material"}    = "bdx_mylar";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "cormo_block_$block_name"."_$channel_id";
				$detector{"mother"}      = "cormo_wrapped_block_$block_name"."_$channel_id";
				$detector{"description"} = "cormorad $block_name block $channel_id";
				$detector{"color"}       = "9F81F7";
				$detector{"style"}       = 1;
				$detector{"type"}        = "Box";
				$X=0;
				$Y=0;
				$Z=0;
				$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"dimensions"}  = "$cormo_block_dx*cm $cormo_block_dy*cm $cormo_block_dz*cm";
				$detector{"material"}    = "ScintillatorB";
				$detector{"sensitivity"} = "cormo";
				$detector{"hit_type"}    = "cormo";
				$detector{"identifiers"} = "sector manual 0 layer manual $iz paddle manual $iy";
#				$detector{"identifiers"} = "paddle manual $channel_id";
				print_det(\%configuration, \%detector);
			}

			for(my $ibary=0; $ibary<$cormo_block_nbary; $ibary++)
			{
				for(my $ibarz=0; $ibarz<$cormo_block_nbarz; $ibarz++)
				{
					my %detector = init_det();
					$detector{"name"}        = "cormo_wrapped_bar_$ibary"."_$ibarz"."_$channel_id";
					$detector{"mother"}      = "cormo_channel_$channel_id";
					$detector{"description"} = "cormorad wrapped bar $ibary $ibarz $channel_id";
					$detector{"color"}       = "A4A4A4";
					$detector{"style"}       = 1;
					$detector{"type"}        = "Box";
					$X=0;
					$Y=(2*$ibary-$cormo_block_nbary+1)*$cormo_wrapped_bar_dy+(2*$ibary-$cormo_block_nbary+1)*$cormo_airgap_tn;
					$Z=(2*$ibarz-$cormo_block_nbarz+1)*$cormo_wrapped_bar_dz+(2*$ibarz-$cormo_block_nbarz+1)*$cormo_airgap_tn;
					$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
					$detector{"rotation"}    = "0*deg 0*deg 0*deg";
					$detector{"dimensions"}  = "$cormo_wrapped_bar_dx*cm $cormo_wrapped_bar_dy*cm $cormo_wrapped_bar_dz*cm";
					$detector{"material"}    = "bdx_mylar";
					print_det(\%configuration, \%detector);

					%detector = init_det();
					$detector{"name"}        = "cormo_bar_$ibary"."_$ibarz"."_$channel_id";
					$detector{"mother"}      = "cormo_wrapped_bar_$ibary"."_$ibarz"."_$channel_id";
					$detector{"description"} = "cormorad bar $ibary $ibarz $channel_id";
					$detector{"color"}       = "9F81F7";
					$detector{"style"}       = 1;
					$detector{"type"}        = "Box";
					$X=0;
					$Y=0;
					$Z=0;
					$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
					$detector{"rotation"}    = "0*deg 0*deg 0*deg";
					$detector{"dimensions"}  = "$cormo_bar_dx*cm $cormo_bar_dy*cm $cormo_bar_dz*cm";
					$detector{"material"}    = "ScintillatorB";
					$detector{"sensitivity"} = "cormo";
					$detector{"hit_type"}    = "cormo";
					$detector{"identifiers"} = "sector manual 0 layer manual $iz paddle manual $iy";
#					$detector{"identifiers"} = "paddle manual $channel_id";
					print_det(\%configuration, \%detector);
				}
			}
		}
	}
}

# inner veto
sub make_cormo_iveto
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_iveto_top";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "inner veto top";
	$detector{"color"}       = "8A2BE2";
	$detector{"style"}       = 1;
	$detector{"type"}        = "Box";	
	my $X = 0.;
	my $Y = $cormo_box_ly+$cormo_iveto_gap+$cormo_iveto_tn;
	my $Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "$cormo_iveto_lx*cm $cormo_iveto_tn*cm $cormo_iveto_lz*cm";
	$detector{"material"}    = "ScintillatorB"; 
	$detector{"material"}    = "G4_AIR"; 
	$detector{"sensitivity"} = "veto";
	$detector{"hit_type"}    = "veto";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 1";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_iveto_bottom";
	$detector{"description"} = "inner veto bottom";
	$X = 0.;
	$Y = -$cormo_box_ly-$cormo_iveto_gap-$cormo_iveto_tn;
	$Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_iveto_lx*cm $cormo_iveto_tn*cm $cormo_iveto_lz*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 3";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_iveto_upstream";
	$detector{"description"} = "inner veto upstream";
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z-$cormo_box_lz-$cormo_iveto_gap-$cormo_iveto_tn;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_iveto_lx*cm $cormo_iveto_ly*cm $cormo_iveto_tn*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 0";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_iveto_downstream";
	$detector{"description"} = "inner veto downstream";
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z+$cormo_box_lz+$cormo_iveto_gap+$cormo_iveto_tn;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_iveto_lx*cm $cormo_iveto_ly*cm $cormo_iveto_tn*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 2";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_iveto_left";
	$detector{"description"} = "inner veto left";
	$X = -$cormo_iveto_lx+$cormo_iveto_tn;
	$Y = 0.;
	$Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_iveto_tn*cm $cormo_iveto_ly*cm $cormo_iveto_ly*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 4";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_iveto_right";
	$detector{"description"} = "inner veto right";
	$X = $cormo_iveto_lx-$cormo_iveto_tn;
	$Y = 0.;
	$Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_iveto_tn*cm $cormo_iveto_ly*cm $cormo_iveto_ly*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 1 channel manual 5";
	print_det(\%configuration, \%detector);
}


# inner veto
sub make_cormo_oveto
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_oveto_top_upstream";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "outer veto top upstream";
	$detector{"color"}       = "8A2BE2";
	$detector{"style"}       = 0;
	$detector{"type"}        = "Box";	
	my $X = 0.;
	my $Y = $cormo_oveto_ly+$cormo_oveto_tn;
	my $Z = $cormo_z-$cormo_oveto_dz;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_tn*cm $cormo_oveto_dz*cm";
	$detector{"material"}    = "ScintillatorB"; 
	$detector{"sensitivity"} = "veto";
	$detector{"hit_type"}    = "veto";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 1";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_top_downstream";
	$detector{"description"} = "outer veto top downstream";
	$X = 0.;
	$Y = $cormo_oveto_ly+$cormo_oveto_tn;
	$Z = $cormo_z+$cormo_oveto_lz/2.;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_tn*cm $cormo_oveto_dz*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 2";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_bottom_upstream";
	$detector{"description"} = "outer veto bottom upstream";
	$X = 0.;
	$Y = -$cormo_oveto_ly-$cormo_oveto_tn;
	$Z = $cormo_z-$cormo_oveto_dz;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_tn*cm $cormo_oveto_dz*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 5";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_bottom_downstream";
	$detector{"description"} = "outer veto bottom downstream";
	$X = 0.;
	$Y = -$cormo_oveto_ly-$cormo_oveto_tn;
	$Z = $cormo_z+$cormo_oveto_dz;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_tn*cm $cormo_oveto_dz*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 4";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_upstream";
	$detector{"description"} = "outer veto upstream";
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z-$cormo_oveto_lz+$cormo_oveto_tn;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_ly*cm $cormo_oveto_tn*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 0";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_downstream";
	$detector{"description"} = "outer veto downstream";
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z+$cormo_oveto_lz-$cormo_oveto_tn;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_lx*cm $cormo_oveto_ly*cm $cormo_oveto_tn*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 3";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_left";
	$detector{"description"} = "outer veto left";
	$X = -$cormo_oveto_lx+$cormo_oveto_tn;
	$Y = 0.;
	$Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_tn*cm $cormo_oveto_ly*cm $cormo_oveto_ly*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 6";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_oveto_right";
	$detector{"description"} = "outer veto right";
	$X = $cormo_oveto_lx-$cormo_oveto_tn;
	$Y = 0.;
	$Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_oveto_tn*cm $cormo_oveto_ly*cm $cormo_oveto_ly*cm";
	$detector{"identifiers"} = "sector manual 0 veto manual 2 channel manual 7";
	print_det(\%configuration, \%detector);
}

# define cormorino shield geometry
# all sizes are in cm
my $cormo_hole_r=50.;
my $cormo_hole_h=50.;

my $cormo_shield_tn_r=100.;
my $cormo_shield_tn_h=100.;

my $cormo_shield_r=$cormo_hole_r+$cormo_shield_tn_r;
my $cormo_shield_h=$cormo_hole_h+$cormo_shield_tn_h;

my $cormo_shield_nplanes=6;
my @cormo_shield_ir = (              0.,              0.,   $cormo_hole_r,   $cormo_hole_r,              0.,              0.);
my @cormo_shield_or = ( $cormo_shield_r, $cormo_shield_r, $cormo_shield_r, $cormo_shield_r, $cormo_shield_r, $cormo_shield_r);
my @cormo_shield_z  = (-$cormo_shield_h,  -$cormo_hole_h,  -$cormo_hole_h,   $cormo_hole_h,   $cormo_hole_h, $cormo_shield_h);

sub make_cormo_shield
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_shield";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "cormorad shield";
	$detector{"color"}       = "BDBDBD";
	$detector{"style"}       = 0;
	$detector{"type"}        = "Polycone";
	my $X = 0.;
	my $Y = 0.;
	my $Z = $cormo_z;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "90*deg 0*deg 0*deg";
	my $dimen = "0.0*deg 360*deg $cormo_shield_nplanes*counts";
	for(my $i = 0; $i <$cormo_shield_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_shield_ir[$i]*cm";
	}
	for(my $i = 0; $i <$cormo_shield_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_shield_or[$i]*cm";
	}
	for(my $i = 0; $i <$cormo_shield_nplanes ; $i++)
	{
	$dimen = $dimen ." $cormo_shield_z[$i]*cm";
	}
	$detector{"dimensions"} = $dimen;
	$detector{"material"}    = "bdx_iron";
	print_det(\%configuration, \%detector);
}


sub make_cormo_lead
{
	my %detector = init_det();
	$detector{"name"}        = "cormo_lead_upstream";
	$detector{"mother"}      = "bdx_main_volume";
	$detector{"description"} = "lead shield";
	$detector{"color"}       = "088A4B";
	$detector{"style"}       = 0;
	$detector{"type"}        = "Box";	
	my $X = 0.;
	my $Y = 0.;
	my $Z = $cormo_z-$cormo_leadshield_lz+$cormo_leadshield_tn;
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "$cormo_leadshield_lx*cm $cormo_leadshield_ly*cm $cormo_leadshield_tn*cm";
	$detector{"material"}    = "G4_Pb"; 
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_lead_downstream";	
	$X = 0.;
	$Y = 0.;
	$Z = $cormo_z+$cormo_leadshield_lz-$cormo_leadshield_tn;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_leadshield_lx*cm $cormo_leadshield_ly*cm $cormo_leadshield_tn*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_lead_top";	
	$X = 0.;
	$Y = $cormo_leadshield_ly+$cormo_leadshield_tn;
	$Z = $cormo_z;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_leadshield_lx*cm $cormo_leadshield_tn*cm $cormo_leadshield_lz*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_lead_left";	
	$X = -$cormo_leadshield_lx+$cormo_leadshield_tn;
	$Y = 0.;
	$Z = $cormo_z;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_leadshield_tn*cm $cormo_leadshield_ly*cm $cormo_leadshield_ly*cm";
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "cormo_lead_right";	
	$X = $cormo_leadshield_lx-$cormo_leadshield_tn;
	$Y = 0.;
	$Z = $cormo_z;	
	$detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	$detector{"dimensions"}  = "$cormo_leadshield_tn*cm $cormo_leadshield_ly*cm $cormo_leadshield_ly*cm";
	print_det(\%configuration, \%detector);
}

sub make_beamdump
{
	make_whole();
	make_tunc();
	make_tuna();
	make_clab();
	make_iron();
	make_bsyv();
	make_wint();
	make_winf();
	make_wind();
	make_fsst();
	make_fsef();
	make_fssf();
	make_fstw();
	make_acst();
	make_acht();
	make_acct();
	make_actw();
	make_cest();
	make_cetw();
	make_cmb();
	make_cmc();
	make_tunce();
	make_tunae();
}



sub make_cormo
{
	make_cormo_flux();
	make_cormo_det();
	make_cormo_iveto;
	make_cormo_oveto;
	make_cormo_lead();
# 	make_cormo_shield();
}
