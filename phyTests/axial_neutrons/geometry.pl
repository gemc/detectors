use strict;
use warnings;

our %configuration;

sub make_materials {
    # Scintillator
    my %mat = init_mat();
    $mat{"name"} = "scintillator";
    $mat{"description"} = "slabs scintillator material";
    $mat{"density"} = "1.032";
    $mat{"ncomponents"} = "2";
    $mat{"components"} = "C 9 H 10";
    print_mat(\%configuration, \%mat);

}

sub make_test_geo {

    my $slab_side = 150.;      # 3x3 meters slabs
    my $slabs_separation = 200.; # 200 cm
    my $slab1_zpos = 50.;
    my $slab2_zpos = $slab1_zpos + $slabs_separation;
    my $slabs_thickness = 3;
    my $flux_thickness = 0.1;
    my $flux1_zpos = $slab1_zpos + $slabs_thickness + 5*$flux_thickness;
    my $flux2_zpos = $slab2_zpos + $slabs_thickness + 5*$flux_thickness;

    my %detector = init_det();

    $detector{"name"} = "slab1";
    $detector{"mother"} = "root";
    $detector{"description"} = "slab1 scintillator";
    $detector{"color"} = "ff0000";
    $detector{"style"} = 1;
    $detector{"visible"} = 1;
    $detector{"type"} = "Box";
    $detector{"dimensions"} = "$slab_side*cm $slab_side*cm $slabs_thickness*cm";
    $detector{"material"} = "scintillator";
    $detector{"pos"} = "0*mm 0*mm $slab1_zpos*cm";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"} = "flux";
    $detector{"identifiers"} = "id manual 10";
    print_det(\%configuration, \%detector);
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"} = "slab2";
    $detector{"mother"} = "root";
    $detector{"description"} = "slab2 scintillator";
    $detector{"color"} = "ff0000";
    $detector{"style"} = 1;
    $detector{"visible"} = 1;
    $detector{"type"} = "Box";
    $detector{"dimensions"} = "$slab_side*cm $slab_side*cm $slabs_thickness*cm";
    $detector{"material"} = "scintillator";
    $detector{"pos"} = "0*mm 0*mm $slab2_zpos*cm";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"} = "flux";
    $detector{"identifiers"} = "id manual 20";
    print_det(\%configuration, \%detector);
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"} = "slab1_flux";
    $detector{"mother"} = "root";
    $detector{"description"} = "Slub1 Flux Detector";
    $detector{"color"} = "ff80002";
    $detector{"style"} = 1;
    $detector{"visible"} = 1;
    $detector{"type"} = "Box";
    $detector{"dimensions"} = "$slab_side*cm $slab_side*cm $flux_thickness*cm";
    $detector{"material"} = "G4_Galactic";
    $detector{"pos"} = "0*mm 0*mm $flux1_zpos*cm";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"} = "flux";
    $detector{"identifiers"} = "id manual 1";
    print_det(\%configuration, \%detector);

        %detector = init_det();
    $detector{"name"} = "slab2_flux";
    $detector{"mother"} = "root";
    $detector{"description"} = "Slub2 Flux Detector";
    $detector{"color"} = "ff80002";
    $detector{"style"} = 1;
    $detector{"visible"} = 1;
    $detector{"type"} = "Box";
    $detector{"dimensions"} = "$slab_side*cm $slab_side*cm $flux_thickness*cm";
    $detector{"material"} = "G4_Galactic";
    $detector{"pos"} = "0*mm 0*mm $flux2_zpos*cm";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"} = "flux";
    $detector{"identifiers"} = "id manual 2";
    print_det(\%configuration, \%detector);
}

1;


