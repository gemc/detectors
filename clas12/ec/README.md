To build the geometry:


````./ec.pl config.dat````


This will:

1. create the text based DB geometry files, with variation in the filenames
2. add ec run entries to the ../clas12.sqlite database


## Consistency check method 1: compare parameters

To compare the two databases (TEXT and SQLITE) the 
script ` $GEMC/api/perl/db_compare.py` can be used. For example:

````
$GEMC/api/perl/db_compare.py ec__geometry_default.txt      ../clas12.sqlite ec  11 default
$GEMC/api/perl/db_compare.py ec__geometry_rga_fall2018.txt ../clas12.sqlite ec 101 default
````

<br/>

---

```
gemc -USE_GUI=0 ec.gcard -N=100 
```

```azure
```

## Consistency check method 2: run gemc with both databases



