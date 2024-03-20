#commands to generate text files for alert.gcard
cd ahdc
./ahdc.pl config.dat
cd ../atof
./atof.pl config.dat
cd ../ALERT_target
./targets.pl config.dat
cd ../external_shell_nonActif
./alertshell.pl config.dat
cd ../He_bag
./hebag.pl config.dat
