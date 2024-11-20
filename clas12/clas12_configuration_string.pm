package clas12_configuration_string;
require Exporter;


@ISA = qw(Exporter);
@EXPORT = qw(clas12_configuration_string);


# Initialize hash maps
sub clas12_configuration_string {

    my %configuration = %{+shift};

    my $varia = $configuration{"variation"};
    my $runno = $configuration{"run_number"};

    if ($varia eq "rga_spring18" || $runno eq 3029) {
        return "rga_spring18";
    }
    elsif ($varia eq "rga_fall18" || $runno eq 4763) {
        return "rga_fall18";
    }
    else {
        return "original";
    }
}

1;