use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;
use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";
my $DetectorName = 'det1_rich_modular_eleside';
my $hittype="eic_rich";

require "det1_rich_modular_eleside_module.pl";

sub det1_rich_modular_eleside
{
#modular RICH size in X, Y
my $box_half = 56.25;

my @quard=("XpYp","XmYp","XpYm","XmYm");
my @sign_X=(1,-1,1,-1);
my @sign_Y=(1,1,-1,-1);
# my @count=(12,14,13,12,11,10,9,8,6,4);
# my @count=(9,11,10,9,8,7,5,3,1);
my @count=(5,7,6,5,4,3,1,0,0);
for(my $m=1; $m<5; $m++){
for(my $n=0; $n<$count[0]; $n++){
	modular_rich($quard[$m-1], $n, 0, $sign_X[$m-1]*(6.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*0)*$box_half );
	modular_rich($quard[$m-1], $n, 1, $sign_X[$m-1]*(6.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*1.)*$box_half );
}
for(my $n=0; $n<$count[1]; $n++){
	modular_rich($quard[$m-1], $n, 2, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*2.)*$box_half);
	modular_rich($quard[$m-1], $n, 3, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*3.)*$box_half);
}
for(my $n=0; $n<$count[2]; $n++){
	modular_rich($quard[$m-1], $n, 4, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*4)*$box_half);
	modular_rich($quard[$m-1], $n, 5, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*5)*$box_half);
}
for(my $n=0; $n<$count[3]; $n++){
	modular_rich($quard[$m-1], $n, 6, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*6)*$box_half);
	modular_rich($quard[$m-1], $n, 7, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*7)*$box_half);
}
for(my $n=0; $n<$count[4]; $n++){
	modular_rich($quard[$m-1], $n, 8, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*8)*$box_half);
}
for(my $n=0; $n<$count[5]; $n++){
	modular_rich($quard[$m-1], $n, 9, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*9)*$box_half);
}
for(my $n=0; $n<$count[6]; $n++){
	modular_rich($quard[$m-1], $n, 10, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*10)*$box_half);
}
for(my $n=0; $n<$count[7]; $n++){
	modular_rich($quard[$m-1], $n, 11, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*11)*$box_half);
}
for(my $n=0; $n<$count[8]; $n++){
	modular_rich($quard[$m-1], $n, 12, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*12)*$box_half);
}
for(my $n=0; $n<$count[9]; $n++){
	modular_rich($quard[$m-1], $n, 13, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*13)*$box_half);
}
}

# # my @quard=("upperleft","upperright","lowerleft","lowerright");
# my @quard=("XmYm","XpYp","XmYp","XmYp");
# my @sign_X=(1,-1,1,-1);
# my @sign_Y=(1,1,-1,-1);
# for(my $m=3; $m<4; $m++){
# for(my $n=0; $n<12; $n++){
# 	modular_rich($quard[$m-1], $n, 0, $sign_X[$m-1]*(6.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*0)*$box_half );
# 	modular_rich($quard[$m-1], $n, 1, $sign_X[$m-1]*(6.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*1.)*$box_half );
# }
# for(my $n=0; $n<14; $n++){
# 	modular_rich($quard[$m-1], $n, 2, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*2.)*$box_half);
# 	modular_rich($quard[$m-1], $n, 3, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*3.)*$box_half);
# }
# for(my $n=0; $n<13; $n++){
# 	modular_rich($quard[$m-1], $n, 4, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*4)*$box_half);
# 	modular_rich($quard[$m-1], $n, 5, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*5)*$box_half);
# }
# for(my $n=0; $n<12; $n++){
# 	modular_rich($quard[$m-1], $n, 6, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*6)*$box_half);
# 	modular_rich($quard[$m-1], $n, 7, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*7)*$box_half);
# }
# for(my $n=0; $n<11; $n++){
# 	modular_rich($quard[$m-1], $n, 8, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*8)*$box_half);
# }
# for(my $n=0; $n<10; $n++){
# 	modular_rich($quard[$m-1], $n, 9, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*9)*$box_half);
# }
# for(my $n=0; $n<9; $n++){
# 	modular_rich($quard[$m-1], $n, 10, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*10)*$box_half);
# }
# for(my $n=0; $n<8; $n++){
# 	modular_rich($quard[$m-1], $n, 11, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*11)*$box_half);
# }
# for(my $n=0; $n<6; $n++){
# 	modular_rich($quard[$m-1], $n, 12, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*12)*$box_half);
# }
# for(my $n=0; $n<4; $n++){
# 	modular_rich($quard[$m-1], $n, 13, $sign_X[$m-1]*(1.25+2.5*$n)*$box_half, $sign_Y[$m-1]*(1.25+2.5*13)*$box_half);
# }
# }

}