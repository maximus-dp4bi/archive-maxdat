-- Create Maxdat tablespace, user and developer user.
-- Run as user "sys" as role "sysdba".

declare

  -- Change the values for these 5 variables for each local database deploy.
  v_project_initials varchar2(4) := 'nyec';
  v_developer_initials varchar2(2) := 'rk';
  v_employee_id varchar2(6) := '50472';
  v_maxdat_user_password varchar2(30) := 'maxdat_changeme123';
  v_developer_user_password varchar2(30) := 'developer_changeme123';

  v_project_db varchar2(8) := v_project_initials || 'md' || v_developer_initials;  -- 'md' = Maxdat Development db
  v_developer_username varchar2(8) := v_developer_initials || v_employee_id;

begin

/*
  execute immediate 
    'create tablespace MAXDAT_DATA 
     datafile 
       ''C:\app\' || v_employee_id || '\oradata\' || v_project_db || '\MAXDAT_DATA_01.DBF'' size 128M autoextend on next 1M maxsize 4096M,
       ''C:\app\' || v_employee_id || '\oradata\' || v_project_db || '\MAXDAT_DATA_02.DBF'' size 128M autoextend on next 1M maxsize 4096M
     default nocompress 
     online 
     extent management local autoallocate';
     
  execute immediate 
    'create tablespace MAXDAT_INDX 
     datafile 
       ''C:\app\' || v_employee_id || '\oradata\' || v_project_db || '\MAXDAT_INDX_01.DBF'' size 128M autoextend on next 1M maxsize 4096M,
       ''C:\app\' || v_employee_id || '\oradata\' || v_project_db || '\MAXDAT_INDX_02.DBF'' size 128M autoextend on next 1M maxsize 4096M
     default nocompress 
     online 
     extent management local autoallocate';
*/
  execute immediate 'create user PA_IEB profile DEFAULT identified by "' || v_maxdat_user_password || '" default tablespace MAXDAT_DATA temporary tablespace TEMP account unlock';
-- execute immediate 'create user ' || v_developer_username || ' profile DEFAULT identified by "' || v_developer_user_password || '" default tablespace USERS temporary tablespace TEMP account unlock';
-- execute immediate 'alter user ' ||  v_developer_username || ' grant connect through MAXDAT';
-- execute immediate 'grant connect to ' ||  v_developer_username;
-- execute immediate 'alter user MAXDAT grant connect through ' ||  v_developer_username;
-- execute immediate 'grant create materialized view to ' ||  v_developer_username;
-- execute immediate 'grant create table to ' ||  v_developer_username;
-- execute immediate 'grant create view to ' ||  v_developer_username;
  
end;
/


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
 
grant advisor to PA_IEB;
grant alter any materialized view to PA_IEB;
grant create job to PA_IEB;
grant create materialized view to PA_IEB;
grant create table to PA_IEB;
grant create view to PA_IEB;
grant debug any procedure to PA_IEB;
grant debug connect session to PA_IEB;
grant drop public synonym to PA_IEB;
grant unlimited tablespace to PA_IEB;
grant execute on SYS.DBMS_SNAPSHOT to PA_IEB;
grant DEVELOPER to PA_IEB;

create role MAXDAT_READ_ONLY;

/*
select 'grant select on ' || TABLE_NAME || ' to ' || v_developer_username || ';' from ALL_TABLES  where OWNER = 'MAXDAT';
select 'grant select on ' || VIEW_NAME || ' to ' || v_developer_username || ';' from ALL_VIEWS  where OWNER = 'MAXDAT';
*/