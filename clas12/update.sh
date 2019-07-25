#!/bin/tcsh -f

# Linux: -c = do not get file if already done.
if (`uname` == "Linux") then
	set mwget = "wget -c -nv --no-check-certificate"
# Mac: makes it quite and show nice progress
else if (`uname` == "Darwin") then
	set mwget = "wget -qc --show-progress --no-check-certificate"
endif


rm -rf coat*jar jcsg*jar vecmath*jar


set USEDEVEL = "no"

set COATJAVA = 6b.3.0
set BRANCH   = gemcPrecision
rm -rf clas12-offline-software

if ($USEDEVEL == "yes") then
	# DEVELOPMENT, CLONING REPO AND USING BRANCH
	echo Cloning https://github.com/jeffersonlab/clas12-offline-software and building coatjava

	# assuming maven is installed
	git clone https://github.com/JeffersonLab/clas12-offline-software
	cd clas12-offline-software
	git checkout $BRANCH
	echo
	echo Using branch $BRANCH
	echo
	./build-coatjava.sh
	cp coatjava/lib/clas/* ..

else
	# NOT DEVELOPMENT, DOWNOADING COATJAVA TAGGED RELEASE
	echo Dowloading coatjava version $COATJAVA from: https://github.com/JeffersonLab/clas12-offline-software/releases/download/$COATJAVA/coatjava-$COATJAVA".tar.gz"

	$mwget  --trust-server-names https://github.com/JeffersonLab/clas12-offline-software/releases/download/$COATJAVA/coatjava-$COATJAVA".tar.gz" -O coatjava-$COATJAVA".tar.gz"
	tar -xvf coatjava-$COATJAVA".tar.gz"
	cp coatjava/lib/clas/* .
endif

