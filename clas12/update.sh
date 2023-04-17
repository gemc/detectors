#!/bin/tcsh -f

# Notice: no need to set COATJAVA env as the groovy script will pick up the relative location
# To install maven: brew install maven (it will instal openjdk 19 and other dependencies)
# 

# Linux: -c = do not get file if already done.
if (`uname` == "Linux") then
	set mwget = "wget -c -nv --no-check-certificate"
# Mac: makes it quite and show nice progress
else if (`uname` == "Darwin") then
	set mwget = "wget -qc --show-progress --no-check-certificate"
endif


rm -rf coat*jar jcsg*jar vecmath*jar


# development. Set to no to use coajava distribution instead
set USEDEVEL = "yes"
set BRANCH   = development

# coajava distribution
set COATJAVA = 8.7.1


rm -rf clas12-offline-software

if ($USEDEVEL == "yes") then
	# DEVELOPMENT, CLONING REPO AND USING BRANCH
	# Make sure maven is installed
	set githubRepo = https://github.com/jeffersonlab/clas12-offline-software
	echo Cloning $githubRepo and building coatjava

	git clone $githubRepo
	cd clas12-offline-software
	git checkout $BRANCH
	echo
	echo Using branch $BRANCH
	echo
	./build-coatjava.sh
	cp coatjava/lib/clas/* ..

else
	# NOT DEVELOPMENT, DOWNOADING COATJAVA TAGGED RELEASE
	set coatJavaDist = https://clasweb.jlab.org/clas12offline/distribution/coatjava/coatjava-$COATJAVA".tar.gz"
	set coatJavaFileName = coatjava-$COATJAVA".tar.gz"

	echo Dowloading coatjava version $COATJAVA from $coatJavaDist

	$mwget  --trust-server-names $coatJavaDist -O $coatJavaFileName

	echo Unpacking $coatJavaFileName

	tar -xf $coatJavaFileName
	
	cp coatjava/lib/clas/* .
endif

