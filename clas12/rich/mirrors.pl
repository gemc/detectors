use strict;
use warnings;

our %configuration;

sub read_array{
    my ($filename) = @_;
    open(my $fh, '<', $filename);
    my @array;
    
    while (my $line = <$fh>) {
        chomp $line;
        push @array, $line;
    }
    close($fh);
    return @array;
}

# read in reflectivities
# sector 1 - individual mirror measurements
# sector 4 - use average of sector 1 mirror measurements
my @penergy = read_array("reflectivities/phot_ene.txt");

my @reflPlanAvg = read_array("reflectivities/refl_plan_avg.txt");
my @reflSpheAvg = read_array("reflectivities/refl_sphe_avg.txt");

my @reflPlanA1L = read_array("reflectivities/refl_plan_A1L.txt");
my @reflPlanA1R = read_array("reflectivities/refl_plan_A1R.txt");
my @reflPlanA2L = read_array("reflectivities/refl_plan_A2L.txt");
my @reflPlanA2R = read_array("reflectivities/refl_plan_A2R.txt");
my @reflPlanA3 = read_array("reflectivities/refl_plan_A3.txt");
my @reflPlanB1 = read_array("reflectivities/refl_plan_B1.txt");
my @reflPlanB2 = read_array("reflectivities/refl_plan_B2.txt");

my @reflSphe1 = read_array("reflectivities/refl_sph_1.txt");
my @reflSphe2 = read_array("reflectivities/refl_sph_2.txt");
my @reflSphe2C = read_array("reflectivities/refl_sph_2C.txt");
my @reflSphe3 = read_array("reflectivities/refl_sph_3.txt");
my @reflSphe3C = read_array("reflectivities/refl_sph_3C.txt");
my @reflSphe4 = read_array("reflectivities/refl_sph_4.txt");
my @reflSphe4C = read_array("reflectivities/refl_sph_4C.txt");
my @reflSphe5 = read_array("reflectivities/refl_sph_5.txt");
my @reflSphe5C = read_array("reflectivities/refl_sph_5C.txt");
my @reflSphe6 = read_array("reflectivities/refl_sph_6.txt");

my $phot_length = scalar @penergy;
my @specularspike = (0.0) x $phot_length;
my @specularlobe = (1.0) x $phot_length;
my @backscatter = (0.0) x $phot_length;

my $sigmaAlphaPlanar = 0.00025;
my $sigmaAlphaSpherical = 0.00025;

sub buildMirrorsSurfaces
{

        my $sector = shift;
        my $sectorsuffix = "_s" . $sector;

	#my %mat = init_mir();
	#$mat{"name"}         = "rich_AlMgF2";
	#$mat{"description"}  = "rich mirror reflectivity";
	#$mat{"type"}         = "dielectric_metal";
	#$mat{"finish"}       = "polished";
	#$mat{"model"}        = "unified";
	#$mat{"border"}       = "SkinSurface";
	#$mat{"photonEnergy"} = @penergy ;
	#$mat{"reflectivity"} = @creflectivity ;	
	#print_mir(\%configuration, \%mat);

	### Planar mirror properties ###
        my %mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_1";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanA3;
	$mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_2";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanB1;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_3";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanB2;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_4";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanA2R;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_5";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanA2L;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_6";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanA1R;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_planar_comp_7";
	$mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
	$mat{"finish"}       = "ground";#"polished";
        $mat{"model"}        = "unified";
	$mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy;
        $mat{"reflectivity"} = @reflPlanA1L;
        $mat{"sigmaAlhpa"} = $sigmaAlphaPlanar;
        $mat{"specularspike"} = @specularspike;
        $mat{"specularlobe"} = @specularlobe;
        $mat{"backscatter"} = @backscatter;
	print_mir(\%configuration, \%mat);

	### Spherical mirror properties ###
	
	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_1";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe1;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_2";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe2;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_3";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe3;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_4";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe4;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_5";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe2C;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_6";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe3C;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_7";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe4C;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_8";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe5;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_9";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe5C;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

	%mat = init_mir();
        $mat{"name"}         = "rich".$sectorsuffix."_mirror_spherical_10";
        $mat{"description"}  = "rich mirror reflectivity";
        $mat{"type"}         = "dielectric_metal";
        $mat{"finish"}       = "polished";
        $mat{"model"}        = "unified";
        $mat{"border"}       = "SkinSurface";
        $mat{"photonEnergy"} = @penergy ;
        $mat{"reflectivity"} = @reflSphe6;
	$mat{"sigmaAlhpa"} = $sigmaAlphaSpherical;
	$mat{"specularspike"} = @specularspike;
	$mat{"specularlobe"} = @specularlobe;
	$mat{"backscatter"} = @backscatter;
        print_mir(\%configuration, \%mat);

}

#buildMirrorsSurfaces();

1;

