#!/bin/zsh

# Linux: -c = do not get file if already done.
if [[ $(uname) == "Linux" ]]; then
  mwget="wget -c -nv --no-check-certificate"
# Mac: makes it quiet and shows nice progress
elif [[ $(uname) == "Darwin" ]]; then
  mwget="wget -qc --show-progress --no-check-certificate"
fi

rm -rf coat*jar jcsg*jar vecmath*jar


# development. Set to no to use coatjava distribution instead
USEDEVEL="no"
githubRepo="https://github.com/JeffersonLab/coatjava"
COATJAVA_TAG="10.0.2" # coatjava distribution - overwritten if USEDEVEL="yes"

# if the argument '-d' is given, set USEDEVEL="yes"
if [[ $1 == "-d" ]]; then
  USEDEVEL="yes"
fi

# if the -t option is given, set the coatjava tag accordingly
if [[ $1 == "-t" ]]; then
  COATJAVA_TAG=$2
fi
tag_gz="https://github.com/JeffersonLab/coatjava/releases/tag/$COATJAVA_TAGtar.gz"

# print help if -h is given
if [[ $1 == "-h" ]]; then
  echo "Usage: update.sh [-d] [-t tag]"
  echo "  -d: use coatjava development version"
  echo "  -t tag: use coatjava tag version"
  exit 0
fi

rm -rf coatjava

if [[ $USEDEVEL == "yes" ]]; then

  echo
  echo "Cloning $githubRepo and building coatjava"
  echo
  git clone $githubRepo
  cd coatjava
  ./build-coatjava.sh
  cp coatjava/lib/clas/* ..

else

  echo "Downloading coatjava version $tag_gz "

  # extract filename from $tag_gz
  coatJavaFileName=$(echo $tag_gz | sed 's/.*\///')

  $mwget --trust-server-names $tag_gz -O $coatJavaFileName

  echo "Unpacking...$coatJavaFileName"

  tar -xf $coatJavaFileName

  cp coatjava/lib/clas/* .
fi
