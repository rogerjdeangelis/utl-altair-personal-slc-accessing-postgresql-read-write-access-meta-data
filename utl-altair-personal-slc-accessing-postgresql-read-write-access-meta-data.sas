%let pgm=utl-altair-personal-slc-accessing-postgresql-read-write-access-meta-data;

%stop_submission;

Altair personal slc accessing- postgresql read write access meta data

Too long to post in a listserve, see github

github
https://github.com/rogerjdeangelis/utl-altair-personal-slc-accessing-postgresql-read-write-access-meta-data

CONTENTS (altair personal slc and postgresql - no access product needed)

   1 creating postgresql table classage
   2 print postgresql table
     slc proc print does not heading=vertical
   3 create a wpd file from a postgresql table (convert to sas7bdat later?)
   4 access postgresql dictionary
   5 log on end

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utlfkil(%sysfunc(pathname(WPSWBHTM))); /*-- disable precode --*/
&_init_;

libname psdb postgres
  database="template1"
  server="localhost"
  port=5432
  user="postgres"
  password="Sas2@rlx"
  preserve_tab_names=YES;

proc datasets lib=psdb;
  delete classage;
run;quit;

* LOG: NOTE: DELETING "MYDB.CLASSAGE" (MEMTYPE="DATA");

data psdb.classage;
  input
    name$
    sex$ age;
cards4;
Alfred  M 14
Alice   F 11
Barbara F 15
Carol   F 17
Henry   M 11
James   M 18
;;;;
run;quit;

proc print data=psdb.classage;
run;

/*---
Altair SLC

Obs    NAME        SEX         AGE

 1     Alfred      M            14
 2     Alice       F            11
 3     Barbara     F            15
 4     Carol       F            17
 5     Henry       M            11
 6     James       M            18
---*/

proc sql;
  connect using psdb;

  create table work.classage_metadata as
  select * from connection to psdb
    (select
        table_schema,
        table_name,
        column_name,
        data_type,
        character_maximum_length as char_length,
        numeric_precision,
        numeric_scale,
        is_nullable,
        column_default,
        ordinal_position
     from information_schema.columns
     where table_name = 'classage'
     order by ordinal_position);
  disconnect from psdb;
quit;

proc print data=classage_metadata ;
run;quit;


/*---
Altair SLC

Obs    TABLE_SCHEMA   TABLE_NAME  COLUMN_NAME  DATA_TYPE          CHAR_LENGTH    NUMERIC_PRECISION    NUMERIC_SCALE    IS_NULLABLE

 1     public         classage    name         character varying            8                 .                  .         YES
 2     public         classage    sex          character varying            8                 .                  .         YES
 3     public         classage    age          double precision             .                53                  .         YES
---*/



libname wd1x wpd "d:/sd1";
data wd1x.wd1_classages;
  set psdb.classage;
run;quit;

* LOG: NOTE: DATA SET "SD1X.SD1_CLASSAGESQLITE" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);

libname sd1x sas7bdat "d:/sd1";
data sd1x.sd1_classages;
  set psdb.classage;
run;quit;

* LOG: NOTE: DATA SET "WD1X.WD1_CLASSAGES" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);

libname dic wpd (wpshelp);

options nolabel;
proc sql;
  select libname, memname from dic.vtable where
    libname in ("WD1X", "SD1X", "MYDB") and memname contains ("CLASSAGE")
;quit;

* SAS AND THE SLC DO NOT PROVIDE DICTIONARY INFORMATION ON EXTERNAL DATABASES;
* YOU NEED TO QUERY THE DATABASE DICTIONARY TABES. THIS IS NORMAL.

/*---
Altair SLC

  LIBNAME   MEMNAME
  ------------------------------------------
  SD1X      SD1_CLASSAGES
  WD1X      WD1_CLASSAGES
----*/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
