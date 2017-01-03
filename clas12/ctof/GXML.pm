package GXML;

use utils;
use geometry;

sub new
{
	my $class = shift;
	my $self = {
		_dirName => shift,
		_volumes => [],
	};

	bless $self, $class;
	return $self;
}


sub add{
	my $self = shift;
	my %det = %{+shift};

	push(@{$self->{_volumes}}, \%det);

	return %det;
}


sub print {
	my $self = shift;

	open(INFO, ">$self->{_dirName}/cad.gxml");
	printf INFO ("<gxml>\n");
	foreach my $det (@{$self->{_volumes}}){
		printf INFO ("\t<volume name=\"%s\"", $det->{"name"});
		printf INFO (" color=\"%s\"", $det->{"color"});
		printf INFO (" material=\"%s\"", $det->{"material"});
		printf INFO (" position=\"%s\"", $det->{"pos"});
		printf INFO (" rotation=\"%s\"", $det->{"rotation"});
		if($det->{"sensitivity"} ne "no"){
			printf INFO (" sensitivity=\"%s\"", $det->{"sensitivity"});
			printf INFO (" identifiers=\"%s\"", $det->{"identifiers"});
		}
		printf INFO (" />\n");
	}
	printf INFO ("</gxml>\n");
	close(INFO);
}


1;
