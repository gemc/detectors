#!/bin/tcsh -f

rm -rf coat*jar jcsg*jar vecmath*jar

set COATJAVA = 5b.7.1

#temporary for DC cell shift verion: tag 5c.6.9
wget --show-progress --no-check-certificate --trust-server-names https://github.com/JeffersonLab/clas12-offline-software/releases/download/$COATJAVA/coatjava-$COATJAVA".tar.gz" -O coatjava-$COATJAVA".tar.gz"
tar -zxvf coatjava-$COATJAVA".tar.gz"
cp coatjava/lib/clas/coat-libs-5.1-SNAPSHOT.jar .

