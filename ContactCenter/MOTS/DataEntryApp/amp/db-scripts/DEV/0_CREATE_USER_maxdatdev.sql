/*
SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND';

ALTER SYSTEM KILL SESSION '33,3497'; --sid, serial
*/

DROP USER maxdatdev CASCADE;

CREATE USER maxdatdev
  IDENTIFIED BY max1mu$
  DEFAULT TABLESPACE users
  QUOTA 1G on users
  TEMPORARY TABLESPACE temp;
  
  
GRANT CONNECT TO maxdatdev;
GRANT CREATE TABLE to maxdatdev;
GRANT CREATE SEQUENCE to maxdatdev;
GRANT CREATE VIEW TO maxdatdev;
GRANT CREATE PROCEDURE TO maxdatdev;
GRANT CREATE TRIGGER TO maxdatdev;

--GRANT EXECUTE ON maxdatdev_PROCS TO maxdatdev;