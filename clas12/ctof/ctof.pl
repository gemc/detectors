#!/usr/bin/perl -w

use strict;
use warnings;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;
use materials;

use Math::Trig;

# Help Message
sub help() {
    print "\n Usage: \n";
    print "   ctof.pl <configuration filename>\n";
    print "   Will create the CLAS12 CTOF geometry, materials, bank and hit definitions\n";
    print "   Note: if the sqlite file does not exist, create one with:  \$GEMC/api/perl/sqlite.py -n ../clas12.sqlite\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file and parameters
our %configuration = load_configuration($ARGV[0]);

our %parameters = get_parameters(%configuration);

# import scripts
require "./materials.pl";
require "./bank.pl";
require "./hit.pl";
require "./geometry.pl";
require "./geometry_java.pl";


# subroutines create_system with arguments (variation, run number)
sub create_system {
    my $variation = shift;
    my $runNumber = shift;

    # materials
    materials();
    define_hit();

    makeHTCC();
    buildMirrorsSurfaces();

    if ($configuration{"factory"} eq "SQLITE") {
        define_cads();
    }
}

# all the scripts must be run for every configuration
#my @allConfs = ("original", "cad", "java");
my @allConfs = ("default", "rga_spring2018", "rga_fall2018");

# bank definitions
define_bank();

foreach my $conf (@allConfs) {

    $configuration{"variation"} = $conf;

    my $javaCadDir = "javacad_$conf";

    system(join(' ', "groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11", $javaCadDir));

    our @volumes = get_volumes(%configuration);
    coatjava::makeCTOF($javaCadDir);

    # materials
    materials();

    # hits
    define_hit();

    # create an empty ctof__geometry_variation.txt so the banks are correctly loaded
    my $filename = "ctof__geometry_$conf.txt";

    open(my $fh, '>', $filename) or die "Could not create file: $filename";
    close($fh);
    print "File '$filename' has been re-created and is now empty.\n";
}

use File::Copy;
use File::Path qw(make_path remove_tree);

# Create directories
make_path('cad');
make_path('cad_upstream');

# Copy STL files from javacad_default to cad_ctof
my $javacad_default = 'javacad_default';
my $cad_ctof = 'cad';

opendir(my $dh, $javacad_default) or die "Cannot open directory $javacad_default: $!";
while (my $file = readdir($dh)) {
    if ($file =~ /\.stl$/) {
        copy("$javacad_default/$file", "$cad_ctof/$file") or die "Copy failed: $!";
    }
}
closedir($dh);

# Copy STL files from javacad_default_upstream to cad_ctof_upstream
my $javacad_default_upstream = 'javacad_default_upstream';
my $cad_ctof_upstream = 'cad_upstream';

opendir($dh, $javacad_default_upstream) or die "Cannot open directory $javacad_default_upstream: $!";
while (my $file = readdir($dh)) {
    if ($file =~ /\.stl$/) {
        copy("$javacad_default_upstream/$file", "$cad_ctof_upstream/$file") or die "Copy failed: $!";
    }
}
closedir($dh);

# Copy specific GXML files
copy("$javacad_default/cad.gxml", "$cad_ctof/cad_default.gxml") or die "Copy failed: $!";
copy("javacad_rga_spring2018/cad.gxml", "$cad_ctof/cad_rga_spring2018.gxml") or die "Copy failed: $!";
copy("javacad_rga_fall2018/cad.gxml", "$cad_ctof/cad_rga_fall2018.gxml") or die "Copy failed: $!";
copy("$javacad_default_upstream/cad.gxml", "$cad_ctof_upstream/cad_default.gxml") or die "Copy failed: $!";
copy("javacad_rga_spring2018_upstream/cad.gxml", "$cad_ctof_upstream/cad_rga_spring2018.gxml") or die "Copy failed: $!";
copy("javacad_rga_fall2018_upstream/cad.gxml", "$cad_ctof_upstream/cad_rga_fall2018.gxml") or die "Copy failed: $!";


# Remove javacad directories created with the geometry service
remove_tree($javacad_default);
remove_tree($javacad_default_upstream);
remove_tree('javacad_rga_spring2018');
remove_tree('javacad_rga_fall2018');
remove_tree('javacad_rga_spring2018_upstream');
remove_tree('javacad_rga_fall2018_upstream');
