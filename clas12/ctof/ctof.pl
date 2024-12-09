#!/usr/bin/perl -w

use strict;
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
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# Global pars - these should be read by the load_parameters from file or DB
our %parameters = get_parameters(%configuration);

#system(join(' ', '~kenjo/.groovy/groovy-2.4.12/bin/groovy -cp "../*" factory.groovy', $javaCadDir));

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# sensitive geometry
require "./geometry.pl";

# java geometry
require "./geometry_java.pl";

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
