use strict;
use warnings;

our %configuration;

sub build_pipe()
{

# 50micron
	my %detector = init_det();
	$detector{"name"}        = "50micron";
	$detector{"mother"}      = "root";
	$detector{"description"} = "50 micron Al foil on Solid022";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 1017.27*mm";
	$detector{"dimensions"}  = "0*mm 20*mm 25*um 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# basecone
	my %detector = init_det();
	$detector{"name"}        = "basecone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base cone";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 8*counts 11.822*mm 11.6603*mm 11.6603*mm 22.6297*mm 22.6297*mm 22.6297*mm 25.25*mm 25.25*mm 11.822*mm 13.272*mm 14.098*mm 25.070*mm 26.75*mm 26.75*mm 26.75*mm 26.75*mm 1340.84*mm 1342.91*mm 1344.09*mm 1359.76*mm 1362.16*mm 1366.11*mm 1366.11*mm 1372.11*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_cellwall
	my %detector = init_det();
	$detector{"name"}        = "cellwall";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell wall";
	$detector{"color"}       = "aa4400";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 7.49154*mm 11.7216*mm 7.54193*mm 11.7718*mm 1280.68*mm 1342.91*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# cellendcap
	my %detector = init_det();
	$detector{"name"}        = "cellendcap";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell end cap";
	$detector{"color"}       = "aa4400";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 5*counts 5*mm 5*mm 7.4942*mm 7.59083*mm 7.86904*mm 5*mm 5.29445*mm 7.71148*mm 7.71575*mm 7.99374*mm 1279.1*mm 1279.24*mm 1280.62*mm 1280.68*mm 1284.68*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# basering
	my %detector = init_det();
	$detector{"name"}        = "basering";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base Ring";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 11*counts 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 7.75*mm 7.75*mm 8.8*mm 8.8*mm 8.8*mm 25.25*mm 25.25*mm 25.15*mm 25.15*mm 25.25*mm 25.25*mm 29.25*mm 29.25*mm 29.25*mm 29.25*mm 10.3049*mm 1366.11*mm 1367.11*mm 1367.11*mm 1371.11*mm 1371.11*mm 1376.98*mm 1376.98*mm 1388.51*mm 1388.51*mm 1389.26*mm 1389.51*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_basering2
	my %detector = init_det();
	$detector{"name"}        = "basering2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base Ring inner tube";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 7.75*mm 7.75*mm 8.70966*mm 8.70966*mm 1366.11*mm 1376.98*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# basetube
	my %detector = init_det();
	$detector{"name"}        = "basetube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Basetube";
	$detector{"color"}       = "ee3344";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 11*counts 7.6152*mm 5*mm 5*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 7.75*mm 7.75*mm 7.75*mm 7.75*mm 7.75*mm 7.65*mm 7.65*mm 7.75*mm 7.75*mm 8.75*mm 8.75*mm 1325.85*mm 1327.32*mm 1327.91*mm 1327.91*mm 1368.11*mm 1368.11*mm 1387.51*mm 1387.51*mm 1388.51*mm 1388.51*mm 1389.51*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_quartzglasstube
	my %detector = init_det();
	$detector{"name"}        = "quartzglasstube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Quartz Glass Tube";
	$detector{"color"}       = "eeeeee";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 5*mm 5*mm 5.0116*mm 5.0711*mm 5.21108*mm 6.8482*mm 6*mm 6*mm 6*mm 6.09046*mm 6.27527*mm 7.91237*mm 1349.75*mm 1390.03*mm 1390.21*mm 1390.72*mm 1391.23*mm 1395.73*mm";
	$detector{"material"}    = "G4_SILICON_DIOXIDE";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# centeringring
	my %detector = init_det();
	$detector{"name"}        = "centeringring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "centeringring";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 13*mm 13*mm 30*mm 30*mm 1547.88*mm 1559.88*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_centeringringtube
	my %detector = init_det();
	$detector{"name"}        = "fibercollar";
	$detector{"mother"}      = "root";
	$detector{"description"} = "fibercollar";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 800*mm 1553.88*mm";
	$detector{"dimensions"}  = "13*mm 30*mm 6*mm 0*deg 360*deg";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# condenser
	my %detector = init_det();
	$detector{"name"}        = "condenser";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Condenser";
	$detector{"color"}       = "cc5500";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 34.8806*mm 34.8806*mm 34.8806*mm 35.8771*mm 67.9999*mm 69.8815*mm 69.8815*mm 68.9999*mm 2259.19*mm 2261.19*mm 2340.19*mm 2341.19*mm";
	$detector{"material"}    = "G4_Cu";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# cryotube
	my %detector = init_det();
	$detector{"name"}        = "cryotube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cryotube";
	$detector{"color"}       = "888888";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 123.825*mm 123.825*mm 123.825*mm 123.825*mm 123.825*mm 123.825*mm 152.4*mm 152.4*mm 127*mm 127*mm 152.4*mm 152.4*mm 2648.71*mm 2667.76*mm 2667.76*mm 4329.69*mm 4329.69*mm 4348.74*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# distributiontube001_1
	my %detector = init_det();
	$detector{"name"}        = "distributiontube001_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 001";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"rotation"}    = "-0.62*deg -0.36*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 1377.05*mm 2115.9*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube001_2
	my %detector = init_det();
	$detector{"name"}        = "distributiontube001_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 001";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "-355*mm 1388*mm 129*mm";
	$detector{"rotation"}    = "-17*deg -10*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2123.81*mm 2169.74*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube001_3
	my %detector = init_det();
	$detector{"name"}        = "distributiontube001_3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution Tube 001";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "23*mm 760*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2177.95*mm 2235.7*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_celladapter001
	my %detector = init_det();
	$detector{"name"}        = "celladapter001";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell adapter 001";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "23*mm 760*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 14*counts 4.8625*mm 4.8625*mm 4.8625*mm 4.8625*mm 4.1275*mm 4.1257*mm 4.1275*mm 4.1275*mm 4.1275*mm 4.1275*mm 3.9687*mm 3.9687*mm 3.9687*mm 3.9687*mm 5.7785*mm 5.7785*mm 8.249*mm 8.249*mm 8.249*mm 8.249*mm 8.2022*mm 8.2022*mm 10.9855*mm 10.9855*mm 10.9855*mm 10.9855*mm 5*mm 5*mm 2190.76*mm 2232.29*mm 2232.29*mm 2235.7*mm 2235.7*mm 2238.64*mm 2238.64*mm 2239.69*mm 2239.69*mm 2243.78*mm 2243.78*mm 2250.74*mm 2250.74*mm 2259.19*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# distributiontube002_1
	my %detector = init_det();
	$detector{"name"}        = "distributiontube002_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 002";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0.72*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 1377.05*mm 2115.9*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube002_2
	my %detector = init_det();
	$detector{"name"}        = "distributiontube002_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 002";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "698*mm 800*mm 130*mm";
	$detector{"rotation"}    = "0*deg 20.0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2123.81*mm 2169.74*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube002_3
	my %detector = init_det();
	$detector{"name"}        = "distributiontube002_3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 002";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "-46*mm 800*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2177.95*mm 2235.7*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_celladapter002
	my %detector = init_det();
	$detector{"name"}        = "celladapter002";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell adapter 002";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "-46*mm 800*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 14*counts 4.8625*mm 4.8625*mm 4.8625*mm 4.8625*mm 4.1275*mm 4.1257*mm 4.1275*mm 4.1275*mm 4.1275*mm 4.1275*mm 3.9687*mm 3.9687*mm 3.9687*mm 3.9687*mm 5.7785*mm 5.7785*mm 8.249*mm 8.249*mm 8.249*mm 8.249*mm 8.2022*mm 8.2022*mm 10.9855*mm 10.9855*mm 10.9855*mm 10.9855*mm 5*mm 5*mm 2190.76*mm 2232.29*mm 2232.29*mm 2235.7*mm 2235.7*mm 2238.64*mm 2238.64*mm 2239.69*mm 2239.69*mm 2243.78*mm 2243.78*mm 2250.74*mm 2250.74*mm 2259.19*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# distributiontube003_1
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 003";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"rotation"}    = "0.62*deg -0.36*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 1377.05*mm 2115.9*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube003_2
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 003";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "-355*mm 212*mm 129*mm";
	$detector{"rotation"}    = "17*deg -10*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2123.81*mm 2169.74*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_distributiontube003_3
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution Tube 003";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "23*mm 840*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2177.95*mm 2235.7*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# build_celladapter003
	my %detector = init_det();
	$detector{"name"}        = "celladapter003";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell adapter 003";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "23*mm 840*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 14*counts 4.8625*mm 4.8625*mm 4.8625*mm 4.8625*mm 4.1275*mm 4.1257*mm 4.1275*mm 4.1275*mm 4.1275*mm 4.1275*mm 3.9687*mm 3.9687*mm 3.9687*mm 3.9687*mm 5.7785*mm 5.7785*mm 8.249*mm 8.249*mm 8.249*mm 8.249*mm 8.2022*mm 8.2022*mm 10.9855*mm 10.9855*mm 10.9855*mm 10.9855*mm 5*mm 5*mm 2190.76*mm 2232.29*mm 2232.29*mm 2235.7*mm 2235.7*mm 2238.64*mm 2238.64*mm 2239.69*mm 2239.69*mm 2243.78*mm 2243.78*mm 2250.74*mm 2250.74*mm 2259.19*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# extensiontube
	my %detector = init_det();
	$detector{"name"}        = "extensiontube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Extension Tube";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 49.2*mm 49.2*mm 50.8*mm 50.8*mm 1409.33*mm 2058.92*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# forwardretainingring

	my %detector = init_det();
	$detector{"name"}        = "forwardretainingring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "forwardretainingring";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 6.27451*mm 7.91238*mm 12*mm 12*mm 1391.23*mm 1395.73*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


# build_fibercollar

	my %detector = init_det();
	$detector{"name"}        = "fibercollar";
	$detector{"mother"}      = "root";
	$detector{"description"} = "fibercollar";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 6.00001*mm 6.00001*mm 12*mm 12*mm 1395.73*mm 1400.73*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# flange

	my %detector = init_det();
	$detector{"name"}        = "flange";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flange";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 400*mm 2250.11*mm";
	$detector{"dimensions"}  = "85.03*mm 87.37*mm 26*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);



}

