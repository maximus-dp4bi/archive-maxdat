-- Create MAXDat user and developer user.
-- Run as user "sys" as role "sysdba".

create role DEVELOPER;

grant 
  create trigger, 
  create any procedure, 
  select any sequence, 
  create view, 
  insert any table, 
  execute any procedure, 
  create procedure, 
  create sequence, 
  alter any procedure, 
  create synonym, 
  delete any table,
  update any table, 
  select any table, 
  create session, 
  create any sequence, 
  alter session, 
  create public synonym, 
  create table 
to DEVELOPER;
 
grant advisor to MAXDAT_TN;
grant alter any materialized view to MAXDAT_TN;
grant create job to MAXDAT_TN;
grant create materialized view to MAXDAT_TN;
grant create table to MAXDAT_TN;
grant create view to MAXDAT_TN;
grant debug any procedure to MAXDAT_TN;
grant debug connect session to MAXDAT_TN;
grant drop public synonym to MAXDAT_TN;
grant unlimited tablespace to MAXDAT_TN;
grant execute on SYS.DBMS_SNAPSHOT to MAXDAT_TN;
grant DEVELOPER to MAXDAT_TN;

create role MAXDAT_READ_ONLY;