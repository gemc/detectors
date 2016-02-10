use strict;
use warnings;
use Getopt::Long;
use Math::Trig;

our %configuration;


sub make_BigGasVolume
{
	my %detector = init_det();
	$detector{"name"}        = "htccBigGasVolume";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "ee99ff5";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 0*mm 15.8*mm 91.5*mm 150*mm 1742*mm 2300*mm 2300*mm 1589*mm -275*mm 181*mm 1046*mm 1740*mm";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);
}


# Entry Dish Volume
my $entrydishNumZplanes = 17;
my @entrydishZplanes = ( -276.4122, -178.6222,  -87.1822,    4.2578, 95.6978,
                          187.1378,  278.5778,  370.0178,  461.4578,
                          552.8978,  644.3378,  735.7778,  827.2178,
						  918.6578,  991.378 , 1080.278 , 1107.71 );

my $entrydishRinner = 0;

my @entrydishRouter = ( 1416.05  , 1410.081 , 1404.493 , 1398.905 ,
                        1393.317 , 1387.729 , 1387.729 , 1363.4466,
					    1339.1388, 1305.8648, 1272.5908, 1239.3168,
                        1206.0174, 1158.24  , 1105.408 ,  996.0356,
                         945.896 );

sub make_entrydishvolume
{
	my $dimensions = "0.0*deg 360.0*deg $entrydishNumZplanes*counts";
	for( my $i=0; $i < $entrydishNumZplanes; $i++){ $dimensions = $dimensions ." $entrydishRinner*mm";      }
	for( my $i=0; $i < $entrydishNumZplanes; $i++){ $dimensions = $dimensions ." $entrydishRouter[$i]*mm";  }
	for( my $i=0; $i < $entrydishNumZplanes; $i++){ $dimensions = $dimensions ." $entrydishZplanes[$i]*mm"; }

	my %detector = init_det();
    $detector{"name"}         = "htccEntryDishVolume";
    $detector{"mother"}       = "root";
    $detector{"description"}  = "HTCC entry dish volume";
    $detector{"color"}        = "ee99ff";
    $detector{"type"}         = "Polycone";
    $detector{"dimensions"}   = "$dimensions";
    $detector{"material"}     = "Component";
	print_det(\%configuration, \%detector);
}

# Entry Cone Volume
my $entryconeNumZplanes = 9;
my @entryconeZplanes = ( 380.00, 470.17, 561.61,  653.05,
						 744.49, 835.93, 927.37, 1018.81, 1116.6 );
my $entryconeRinner  = 0;
my @entryconeRouter  = ( 257.505, 323.952, 390.373, 456.819,
                         525.831, 599.872, 673.913, 747.979, 827.151 );


sub make_entryconevolume
{
	my $dimensions = "0.0*deg 360.0*deg $entryconeNumZplanes*counts";
	for( my $i=0; $i < $entryconeNumZplanes; $i++){ $dimensions = $dimensions ." $entryconeRinner*mm";     }
	for( my $i=0; $i < $entryconeNumZplanes; $i++){ $dimensions = $dimensions ." $entryconeRouter[$i]*mm"; }
	for( my $i=0; $i < $entryconeNumZplanes; $i++){ $dimensions = $dimensions ." $entryconeZplanes[$i]*mm";}

	my %detector = init_det();
    $detector{"name"}         = "htccEntryConeVolume";
    $detector{"mother"}       = "root";
    $detector{"description"}  = "HTCC entry cone volume";
	$detector{"color"}        = "ee99ff";
    $detector{"type"}         = "Polycone";
    $detector{"dimensions"}   = "$dimensions";
    $detector{"material"}     = "Component";
	print_det(\%configuration, \%detector);
}



sub make_EntryDishPlusCone
{
	my %detector = init_det();
    $detector{"name"}        = "htccEntryDishCone";
    $detector{"mother"}      = "root";
    $detector{"description"} = "subtraction entry dish - cone";
    $detector{"color"}       = "ee99ff";
    $detector{"type"}        = "Operation:@ htccEntryDishVolume - htccEntryConeVolume";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);
}


sub make_GasVolumeFinal
{
	my %detector = init_det();
	$detector{"name"}        = "htcc";
	$detector{"mother"}      = "root";
	$detector{"description"} = "gas volume for htcc";
	$detector{"color"}       = "0000ff3"; # add a 4 or 5 at the end to make transparent (change visibility above too)
	$detector{"type"}        = "Operation:@ htccBigGasVolume - htccEntryDishCone";
	$detector{"dimensions"}  = "0";
	$detector{"material"}    = "HTCCgas";
    $detector{"style"}       = "1";
	print_det(\%configuration, \%detector);
}



sub build_mother()
{
	make_BigGasVolume();
	make_entrydishvolume();
	make_entryconevolume();
	make_EntryDishPlusCone();
	make_GasVolumeFinal();
}

