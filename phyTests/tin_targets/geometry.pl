use strict;
use warnings;

our %configuration;


sub make_test_geo
{
	my $thisVariation = $configuration{"variation"} ;

	my $target_radius="10";

	my $target_thickess="0.01";

    if ($thisVariation eq "20microns") {
        $target_thickess="0.02";
    } else {
        if ($thisVariation eq "100microns") {
            $target_thickess="0.1";
        } else {
		if( $thisVariation eq "180microns"){	
			$target_thickess="0.18";
		} else {
			if( $thisVariation eq "360microns"){
                        	$target_thickess="0.36";
                	} elsif( $thisVariation eq "1microns" ) {
				$target_thickess="0.001";
			}
		}
	}
    }  


	
	my %detector = init_det();
	
	$detector{"name"}        = "target";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tin target";
	$detector{"color"}       = "ff80002";
	$detector{"style"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*cm $target_radius*mm $target_thickess*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Sn";
	print_det(\%configuration, \%detector);


    my $fluxRadius="150";
    my $fluxThickness="1";
    my $fluxLength="150";
    my $fluxOR=$fluxRadius+$fluxThickness;


	%detector = init_det();
	
	$detector{"name"}        = "xray_flux";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Vaccum Flux";
	$detector{"color"}       = "f00000";
	$detector{"style"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$fluxRadius*mm $fluxOR*mm $fluxLength*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_AIR";
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual 1";
	print_det(\%configuration, \%detector);
}


1;


