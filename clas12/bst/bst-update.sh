#!/bin/bash
# copies geometry files from developement version of gemc/detectors to the experiments folder for use with the release version of gemc
devLoc=~/dev/gemc/detectors/clas12/bst
expLoc=~/Gemc/experiments/clas12/bst

# bst__volumes_java.txt is an intermediate file containing the result of the factory.groovy script
cp $devLoc/bst__geometry_java.txt $expLoc/. # final volumes for gemc
cp $devLoc/bst__parameters_java.txt $expLoc/. # parameters used to generate the volumes

# duplicate hit definitions for now
cp $devLoc/bst__hit_original.txt $expLoc/bst__hit_java.txt