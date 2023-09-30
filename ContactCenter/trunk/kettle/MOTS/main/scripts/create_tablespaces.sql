--create tablespace(s)

--optional:  set the default location for datafile creation
/*
  --default location currently set to '$ORACLE_HOME/database' upon installation
  ALTER SYSTEM 
  SET DB_CREATE_FILE_DEST = '$ORACLE_HOME/rdbms/dbs';
*/



--create the tablespaces for the corporate presentation table data and indexes
CREATE SMALLFILE TABLESPACE CORP_PRES
    DATAFILE 
        'CORP_PRES.dbf' SIZE 7 M AUTOEXTEND ON NEXT 1024 K MAXSIZE UNLIMITED 
    BLOCKSIZE 8192 
    LOGGING 
    ONLINE 
    PERMANENT 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
    SEGMENT SPACE MANAGEMENT AUTO
    FLASHBACK ON 
;


-- Generated by Oracle SQL Developer Data Modeler 3.1.4.710
--   at:        2014-06-04 11:35:05 EDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE BIGFILE TABLESPACE MOTS_DATA 
    DATAFILE 
        'MOTS_DATA.dbf' SIZE 7 M AUTOEXTEND ON NEXT 1024 K MAXSIZE UNLIMITED 
    BLOCKSIZE 8192 
    LOGGING 
    ONLINE 
    PERMANENT 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
    SEGMENT SPACE MANAGEMENT AUTO
    FLASHBACK ON 
;

CREATE BIGFILE TABLESPACE MOTS_INDX 
    DATAFILE 
        'MOTS_INDX.dbf' SIZE 7 M AUTOEXTEND ON NEXT 1024 K MAXSIZE UNLIMITED 
    BLOCKSIZE 8192 
    LOGGING 
    ONLINE 
    PERMANENT 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
    SEGMENT SPACE MANAGEMENT AUTO
    FLASHBACK ON 
;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             0
-- CREATE INDEX                             0
-- ALTER TABLE                              0
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        2
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0