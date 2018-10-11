#!/bin/sh
rm coat*jar jcsg*jar vecmath*jar
#wget http://clasweb.jlab.org/clas12maven/org/jlab/coat/coat-libs/2.4-SNAPSHOT/coat-libs-2.4-SNAPSHOT.jar
#wget http://userweb.jlab.org/~kenjo/coat-libs-2.4-SNAPSHOT.jar
#wget http://userweb.jlab.org/~kenjo/geom/jcsg-0.3.2.jar
#wget http://userweb.jlab.org/~kenjo/geom/vecmath-1.3.1.jar

#wget http://clasweb.jlab.org/clas12maven/org/jlab/coat/coat-libs/5.1-SNAPSHOT/coat-libs-5.1-SNAPSHOT.jara

#temporary for DC cell shift verion: tag 5c.6.9
wget -O coatjava-5c.6.9.tar.gz --no-check-certificate --trust-server-names https://github.com/JeffersonLab/clas12-offline-software/releases/download/5c.6.9/coatjava-5c.6.9.tar.gz
tar -zxvf coatjava-5c.6.9.tar.gz
cp coatjava/lib/clas/coat-libs-5.1-SNAPSHOT.jar .
rm -rf coatjava coatjava-5c.6.9.tar.gz

#cd javautil
#./mk.sh

