use strict;
use warnings;

our %configuration;


my $Cwidth  =   20.0;    # Crystal width in mm (side of the squared front face)
my $Clength =  200.0;    # Crystal length in mm
my $CZpos   =  500.0;    # Position of the front face of the crystals

my $calIR     = 100;
my $calOR     = 1000;
my $nCristals = ($calOR - $calIR) / $Cwidth;

my $microGap = 0.1;

sub make_mu_cal_crystals_volume
{
   my %detector = init_det();
   $detector{"name"}        = "mucal";
   $detector{"mother"}      = "root";
   $detector{"description"} = "muon calorimeter mother volume";
   $detector{"color"}       = "1437f4";
   $detector{"type"}        = "Tube";
   my $zDim = $microGap*2 + $Clength;
   $detector{"dimensions"}  = "$calIR*mm $calOR*mm $zDim*mm 0*deg 360*deg";
   $detector{"pos"}         = "0*mm 0*mm $CZpos*mm";
   $detector{"material"}    = "Air";
   $detector{"style"}       = 0;
   print_det(\%configuration, \%detector);
   
   
}

# Loop over all crystals and define their positions
sub make_mu_cal_crystals
{
   my $centX = ( int $Nx/2 )+0.5;
   my $centY = ( int $Ny/2 )+0.5;
   my $locX=0.;
   my $locY=0.;
   my $locZ=0.;
   my $dX=0.;
   my $dY=0.;
   my $dZ=0.;
   for ( my $iX = 1; $iX <= $Nx; $iX++ )
   {
      for ( my $iY = 1; $iY <= $Ny; $iY++ )
      {
         $locX=($iX-$centX)*$Vwidth;
         $locY=($iY-$centY)*$Vwidth;
         my $locR=sqrt($locX*$locX+$locY*$locY);
         my $Rmin=$Bdisk_IR+$Vwidth/sqrt(2.);
         my $Rmax=$Bdisk_OR-$Vwidth/sqrt(2.);
         if($locR>$Rmin && $locR<$Rmax)
         {
            # crystal mother volume
            my %detector = init_det();
            $detector{"name"}        = "ft_cr_volume_" . $iX . "_" . $iY ;
            $detector{"mother"}      = "ft_cal_crystal_volume";
            $detector{"description"} = "ft crystal mother volume (h:" . $iX . ", v:" . $iY . ")";
            $locZ = $Vfront+$Vlength/2.;
            $detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
            $detector{"color"}       = "838EDE";
            $detector{"type"}        = "Box" ;
            $dX=$Vwidth/2.0;
            $dY=$Vwidth/2.0;
            $dZ=$Vlength/2.0;
            $detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
            $detector{"material"}    = "G4_AIR";
            $detector{"style"}       = "1" ;
            print_det(\%configuration, \%detector);
            
            # APD housing
            %detector = init_det();
            $detector{"name"}        = "ft_cr_apd_" . $iX . "_" . $iY ;
            $detector{"mother"}      = "ft_cal_crystal_volume";
            $detector{"description"} = "ft crystal apd (h:" . $iX . ", v:" . $iY . ")";
            $locZ=$Sfront+$Slength/2.;
            $detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
            $detector{"color"}       = "99CC66";
            $detector{"type"}        = "Box" ;
            $dX=$Swidth/2.0;
            $dY=$Swidth/2.0;
            $dZ=$Slength/2.0;
            $detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
            $detector{"material"}    = "G4_AIR";
            $detector{"style"}       = "1" ;
            #print_det(\%configuration, \%detector);
            
            # Wrapping Volume;
            %detector = init_det();
            $detector{"name"}        = "ft_cr_wr_" . $iX . "_" . $iY ;
            $detector{"mother"}      = "ft_cr_volume_" . $iX . "_" . $iY ;
            $detector{"description"} = "ft wrapping (h:" . $iX . ", v:" . $iY . ")";
            $detector{"color"}       = "838EDE";
            $detector{"type"}        = "Box" ;
            $dX=$Wwidth/2.0;
            $dY=$Wwidth/2.0;
            $dZ=$Vlength/2.0;
            $detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
            $detector{"material"}    = "G4_MYLAR";
            $detector{"style"}       = "1" ;
            print_det(\%configuration, \%detector);
            
            # PbWO4 Crystal;
            %detector = init_det();
            $detector{"name"}        = "ft_cr_" . $iX . "_" . $iY ;
            $detector{"mother"}      = "ft_cr_wr_" . $iX . "_" . $iY ;
            $detector{"description"} = "ft crystal (h:" . $iX . ", v:" . $iY . ")";
            $locX=0.;
            $locY=0.;
            $locZ=$Flength/2.;
            #$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
            $detector{"color"}       = "836FFF";
            $detector{"type"}        = "Box" ;
            $dX=$Cwidth/2.0;
            $dY=$Cwidth/2.0;
            $dZ=$Clength/2.0;
            $detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
            $detector{"material"}    = "G4_PbWO4";
            $detector{"style"}       = "1" ;
            #				$detector{"sensitivity"} = "ft_cal";
            #				$detector{"hit_type"}    = "ft_cal";
            #				$detector{"identifiers"} = "ih manual $iX iv manual $iY";
            print_det(\%configuration, \%detector);
            
         }
      }
   }
}

sub make_mu_cal
{
   make_mu_cal_crystals_volume();
   make_mu_cal_crystals();
}


