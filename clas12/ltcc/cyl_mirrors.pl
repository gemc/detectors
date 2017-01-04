 use strict;
 use warnings;

 our %configuration;
 our %parameters;

 our $startS;
 our $endS;
 our $startN;
 our $endN;
 
 my @innerr = ();
 my @outerr = ();
 my @length = ();
 my @hp_min = ();
 my @cyl_x0 = ();

 # number of mirrors
 my $nmirrors = $parameters{"nmirrors"} ;

 my $mirrors_thickness = 12.7; #cm 

 sub  buildCylMirrors
 {
	cyl_mirrors_pars();
	cyl_mirrors();
 }


 sub  cyl_mirrors_pars 
 {
	for(my $n = 0; $n < $nmirrors; $n++)
	{
		my $s = $n +1;
       
		$innerr[$n] = $parameters{"ltcc.cyl_mirrors_par.s$s.r0"}; 
		$outerr[$n] = $parameters{"ltcc.cyl_mirrors_par.s$s.r1"}; 
		$length[$n] = $parameters{"ltcc.cyl_mirrors_par.s$s.r2"};
		$hp_min[$n] = $parameters{"ltcc.hy.s$s"."_xmin"};
		$cyl_x0[$n] = 2*$hp_min[$n];
        }
 }

 
 sub  cyl_mirrors
 {
	for(my $n = $startN; $n < $endN; $n ++)
	{
		for(my $s = $startS; $s < $endS; $s ++)
		{

  			my %detector = init_det();

			$detector{"name"} = "cyl_mirror_s$s"."right_$n";
			$detector{"mother"} = "segment_pmt_s$s.$n";
			$detector{"description"} = "cyl_mirror_right$n";
			$detector{"pos"} = "$cyl_x0[$n-1]*cm 0*cm 0*cm";
			$detector{"rotation"} = "0*deg 0*deg 0*deg";
			$detector{"color"} = "aaffff";
			$detector{"type"} = "Tube";
			$detector{"dimensions"} = "1*cm 3*cm 5*cm 0*deg 180*deg";
			$detector{"material"} = "G4Air";
			$detector{"style"} = 1;
			$detector{"visible"} = 1;
			$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
			$detector{"hit_type"} = "mirror";
			$detector{"identifiers"} = "sector manual $s type manual 3  side manual 1 segment manual $n";
			print_det(\%configuration, \%detector);
		
		
		        %detector = init_det();
			$detector{"name"} = "cyl_mirror_s$s"."left_$n";
			$detector{"mother"} = "segment_pmt_s$s.$n";
			$detector{"description"} = "cyl_mirror_left$n";
			$detector{"pos"} = "-$cyl_x0[$n-1]*cm 0*cm 0*cm";
			$detector{"rotation"} = "0*deg 0*deg 0*deg";
			$detector{"color"} = "aaffff";
			$detector{"type"} = "Tube";
			$detector{"dimensions"} = "1*cm 3*cm 5*cm 0*deg 180*deg";
			$detector{"material"} = "G4Air";
			$detector{"style"} = 1;
			$detector{"visible"} = 1;
			$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
			$detector{"hit_type"} = "mirror";
			$detector{"identifiers"} = "sector manual $s type manual 3  side manual 2 segment manual $n";
			print_det(\%configuration, \%detector);
		}

	}

}
		
1;			

