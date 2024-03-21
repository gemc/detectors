#commands to generate text files for alert.gcard
cd ahdc
run-groovy factory.groovy --variation default --runnumber 11
run-groovy factory.groovy --variation rga_fall2018 --runnumber 11
./ahdc.pl config.dat
cd ../atof
run-groovy factory.groovy --variation default --runnumber 11
run-groovy factory.groovy --variation rga_fall2018 --runnumber 11
./atof.pl config.dat
cd ../ALERT_target
./targets.pl config.dat
cd ../external_shell_nonActif
./alertshell.pl config.dat
cd ../He_bag
./hebag.pl config.dat
cd ..
