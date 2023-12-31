
--create the tablespaces for the test data
CREATE SMALLFILE TABLESPACE TEST
    DATAFILE 
        'TEST.dbf' SIZE 7 M AUTOEXTEND ON NEXT 1024 K MAXSIZE UNLIMITED 
    BLOCKSIZE 8192 
    LOGGING 
    ONLINE 
    PERMANENT 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
    SEGMENT SPACE MANAGEMENT AUTO
    FLASHBACK ON 
;
