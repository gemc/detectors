# Run Configurations

The first CLAS12 Run was 2366. Historically we have been using the 'rga_fall2018' variation that start with Run 4763.
Here we use Run 2366 to apply rga_fall2018 also to rga_spring2018.

| variation    | SQL / CCDB Run | 
|--------------|----------------|
| default      | 11             | 
| rga_fall2018 | 2366           | 

To build the geometry:

````./pcal.pl config.dat````

This will:

1. create the text based DB geometry files, with variation in the filenames
2. add detector run entries to the ../clas12.sqlite database

## Consistency check method 1: compare parameters

To compare the two databases (TEXT and SQLITE) the script ` $GEMC/api/perl/db_compare.py` can be used:

````
$GEMC/api/perl/db_compare.py pcal__geometry_default.txt      ../clas12.sqlite pcal  11   default
$GEMC/api/perl/db_compare.py pcal__geometry_rga_fall2018.txt ../clas12.sqlite pcal  2366 default
````

<br/>

---

## Consistency check method 2: run gemc with both databases

Run 11:

```
gemc -USE_GUI=0 pcal_sqlite.gcard       -N=10 -OUTPUT="hipo, sql_11.hipo" -RANDOM=123 -RUNNO=11  
gemc -USE_GUI=0 pcal_text_default.gcard -N=10 -OUTPUT="hipo, txt_11.hipo" -RANDOM=123 -RUNNO=11  
```

Run 2366:

```
gemc -USE_GUI=0 pcal_sqlite.gcard            -N=10 -OUTPUT="hipo, sql_2366.hipo" -RANDOM=123 -RUNNO=2366
gemc -USE_GUI=0 pcal_text_rga_fall2018.gcard -N=10 -OUTPUT="hipo, txt_2366.hipo" -RANDOM=123 -RUNNO=2366
```

Then compare the two hipo files with hipo-utils (upcoming comparison by Gagik)
