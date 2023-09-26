BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;
 
ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (230000) INTO (partition P230000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (260000) INTO (partition P260000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (290000) INTO (partition P290000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (320000) INTO (partition P320000, partition P999999);

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (350000) INTO (partition P350000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (380000) INTO (partition P380000, partition P999999);

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (410000) INTO (partition P410000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (440000) INTO (partition P440000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

ALTER TABLE TX_ETL_L_ELIGIBILITY
SPLIT PARTITION P999999 at (470000) INTO (partition P470000, partition P999999);

BEGIN
 DBMS_STATS.gather_table_stats (ownname => 'MAXDAT', tabname=>'TX_ETL_L_ELIGIBILITY',
 partname => 'P999999',
 granularity => 'PARTITION');
END;

