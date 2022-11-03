package coatjava;

use strict;
use warnings;

use geometry;

my $mothers;
my $positions;
my $rotations;
my $types;
my $dimensions;
my $ids;
my %color = ('kapton' => "bf0000", "Al" => "2a3158", "gas" => " afb0ba", "Cu" => "fd7f00", "dlc" => "14b6ce", "Cr" => "1433ce", "glue" => "14ce3d", "g10" => "aa44d8", "nomex" => "ecdb3a");

my @window = ("kapton", "Al", "gas");
my @cathode = ("kapton", "Al", "gas");
my @muRwell = ("Cu", "kapton", "dlc");
my @capa_sharing_layer1 = ("glue", "Cr", "kapton");
my @capa_sharing_layer2 = ("glue", "Cr", "kapton");
my @readout1 = ("glue", "Cu", "kapton");
my @readout2 = ("glue", "Cu", "kapton");
my @readout3 = ("glue");
my @support_skin1 = ("g10");
my @support_skin2 =("g10");
my @support_honeycomb = ("nomex");

sub make_region
{
	my $iregion = shift;
   # print "$iregion\n";
	my $region = $iregion + 1;
	my $nSectors = 6;
    my $nChambers = 3;
    
	for(my $s=1; $s<=$nSectors; $s++)
	{
		my %detector = init_det();
		my $vname = "region_uRwell_$region"."_s$s";

		$detector{"name"}        = $vname;
		$detector{"mother"}      = $mothers->{$vname};
		$detector{"description"} = "CLAS12 uRwells, Sector $s Region $region";

		$detector{"pos"}            = $positions->{$vname};
		$detector{"rotation"}   = $rotations->{$vname};
		$detector{"type"}           = $types->{$vname};
		$detector{"dimensions"}  = $dimensions->{$vname};

		$detector{"color"}       = "aa0000";
		$detector{"material"}    = "G4_Galactic";
        $detector{"style"}       = 0;
		$detector{"visible"}     = 0;
		print_det(\%main::configuration, \%detector);
        
        make_chamber($s);
    
    }
}

sub make_chamber
{
    my $isector = shift;
    my $nChambers =3;
    for(my $c=1; $c<=$nChambers; $c++){
        my %detector = init_det();
        my $vname = "rg1"."_s$isector"."_c$c";
        
        $detector{"name"}        = $vname;
        $detector{"mother"}      = $mothers->{$vname};
        $detector{"description"} = "Region 1,Sector $isector, Chamber $c";

        $detector{"pos"} = $positions->{$vname};
        $detector{"rotation"} = $rotations->{$vname};
        $detector{"type"} = $types->{$vname};
        $detector{"dimensions"}  = $dimensions->{$vname};
        if($c ==1){
        $detector{"color"}       = "4f84f7";
        }
        if($c ==2){
        $detector{"color"}       = "ff73f3";
        }
        if($c ==3){
        $detector{"color"}       = "f76b4f";
        }
        $detector{"material"}    = "G4_Galactic";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 0;
 #       $detector{"sensitivity"} = "dc";
 #       $detector{"hit_type"}    = "dc";
        print_det(\%main::configuration, \%detector);
        
        # Window
        for(my $ii=0; $ii<=$#window; $ii++) {
        make_layers($isector, $c, "window",$window[$ii]);
        }
        
        # Cathode
        for(my $ii=0; $ii<=$#cathode; $ii++) {
        make_layers($isector, $c, "cathode",$cathode[$ii]);
        }
        
        #muRwell
        for(my $ii=0; $ii<=$#muRwell; $ii++) {
        make_layers($isector, $c, "muRwell",$muRwell[$ii]);
        }
        
        #@capa_sharing_layer1
        for(my $ii=0; $ii<=$#capa_sharing_layer1; $ii++) {
        make_layers($isector, $c, "capa_sharing_layer1",$capa_sharing_layer1[$ii]);
        }
        
        #@capa_sharing_layer2
        for(my $ii=0; $ii<=$#capa_sharing_layer2; $ii++) {
        make_layers($isector, $c, "capa_sharing_layer2",$capa_sharing_layer2[$ii]);
        }
        
        #@readout1
        for(my $ii=0; $ii<=$#readout1; $ii++) {
        make_layers($isector, $c, "readout1",$readout1[$ii]);
        }

        #@readout2
        for(my $ii=0; $ii<=$#readout2; $ii++) {
        make_layers($isector, $c, "readout2",$readout2[$ii]);
        }

        #@readout3
        for(my $ii=0; $ii<=$#readout3; $ii++) {
        make_layers($isector, $c, "readout3",$readout3[$ii]);
        }
        
        #@support_skin1
        for(my $ii=0; $ii<=$#support_skin1; $ii++) {
        make_layers($isector, $c, "support_skin1",$support_skin1[$ii]);
        }

        #@support_skin2
        for(my $ii=0; $ii<=$#support_skin2; $ii++) {
        make_layers($isector, $c, "support_skin2",$support_skin2[$ii]);
        }
        
        #@support_honeycomb
        for(my $ii=0; $ii<=$#support_honeycomb; $ii++) {
        make_layers($isector, $c, "support_honeycomb",$support_honeycomb[$ii]);
        }
        
    }
    
}

# Layers

sub make_layers{
    
    my $isector = $_[0];
    my $nChamber = $_[1];
    my $layer = $_[2];
    my $material = $_[3];
    my %detector = init_det();
    
 #   print "$layer $material\n";

    my $vname = "rg1"."_s$isector"."_c$nChamber"."_$layer"."_$material";
    $detector{"name"}        = $vname;
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"description"} = "Region 1,Sector $isector, Chamber $nChamber, $layer $material";
    $detector{"pos"} = $positions->{$vname};
    $detector{"rotation"} = $rotations->{$vname};
    $detector{"type"} = $types->{$vname};
    $detector{"dimensions"}  = $dimensions->{$vname};
    $detector{"color"}       = $color{$material};
    $detector{"material"}    = $material;
    
    if($layer eq "cathode" && $material eq "gas" ){
        $detector{"sensitivity"} = "urwell";
        $detector{"hit_type"} = "urwell";
        $detector{"identifiers"} ="sector manual $isector chamber manual $nChamber layer manual 1 component manual 1";
    }
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    print_det(\%main::configuration, \%detector);

}





sub makeURWELL
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;

	make_region(0);


}

1;
