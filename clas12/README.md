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

		
### CLAS12 Run numbers vs Run groups

Source: [calcom run groups](https://clasweb.jlab.org/wiki/index.php/CLAS12_Calibration_and_Commissioning)

|                    |               | 
|--------------------|---------------|
| rga_spring2018     | 2366-4325     |
| rga_fall2018       | 4763-5666     |
| rgk_fall2018_FTOn  | 5681-5749     |
| rgk_fall2018_FTOff | 5875-6000     |
| rga_spring2019     | 6608-6783     |
| rgb_spring2019     | 6132 – 6603   |
| rgb_fall2019       | 11093 – 11571 |
| rgf_spring2020     |               |
| rgm_fall2021       | 15015 - 15884 |
| rgc_summer2022     | 16042-16755   |
| rgc_fall2022       | 16843-17408   |
| rge_spring2024     |               |


