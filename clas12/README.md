# Coatjava installation

The script `install_coatjava.sh` installs the CLAS12 software package coatjava. 

### Prerequisites
  * A Linux or Mac computer
  * Java Development Kit 11 or newer
  * maven


### Usage:

```
Usage: install_coatjava.sh [-d] [-t tag]
  -d: use coatjava development version
  -t tag: use coatjava tag version
  -g github_url: use a custom github url
  ```

### Coatjava environment:

After installation, set the environment accordingly. For example:

```
export COATJAVA=/opt/projects/gemc/detectors/clas12/coatjava
export PATH=$PATH:$COATJAVA/bin
```

### Versions:

 - Clas12Tags 5.10 -> Coatjava 10.0.2
 - Clas12Tags 5.11 -> Coatjava 10.1.1


### SQLite initialization

$GEMC/api/perl/sqlite.py -n clas12.sqlite

		

	