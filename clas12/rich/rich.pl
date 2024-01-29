#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use mirrors;
use math;
use materials;
use POSIX;
use File::Copy;
# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   rich.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Ring Imaging Cherenkov (rich) using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1) 
{
	help();
	exit;
}

# stop and exit if $COATJAVA env variable is not set
if( !defined $ENV{COATJAVA} ) {
    print "\n*** ERROR *** ERROR *** ERROR *** ERROR *** ERROR *** ERROR ***\n";
    print "FATAL: COATJAVA environment variable is not set. \n";
    print "Please set the COATJAVA variable to the coatjava installation directory.\n";
    print "Example: export COATJAVA=../coatjava \n";
    print "*** ERROR *** ERROR *** ERROR *** ERROR *** ERROR *** ERROR ***\n\n";
    exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# geometry                                                                                                                                                                    
require "./geometry.pl";

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

#mirror material
require "./mirrors.pl";

my @allConfs = ("default","rga_fall2018","rgc_summer2022");
foreach my $variation (@allConfs){
    print("variation: " );
    print($variation);
    print("\n");

    $configuration{"variation"} = $variation;
    system(join(' ', 'groovy -cp "$COATJAVA/lib/clas/*" factory.groovy', $variation));
    our @volumes = get_volumes(%configuration);    

    coatjava::makeRICHcad($variation);

    my @sectors = ();
    if ($variation eq "rga_fall2018"){
        push(@sectors,"4");
    }
    if ($variation eq "default"){
        push(@sectors,("1","4"));
    }
    if ($variation eq "rgc_summer2022"){
        push(@sectors,("1","4"));
    }
    define_MAPMT();
    define_CFRP();
    define_hit();
    foreach my $sector (@sectors){
	define_aerogels($sector);
	buildMirrorsSurfaces($sector);
	coatjava::makeRICHtext($sector);
	print("temporary: copying RICH mother volume stl file \n");
	copy("cadTemp/RICH_mother_corrected.stl","cad_".$variation."/RICH_s".$sector.".stl");

    }
}

