declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='CORP_JOB_PROCESS_STUCK';
    if c = 1 then
       execute immediate 'drop table CORP_JOB_PROCESS_STUCK cascade constraints';
    end if;
 end;
 /
declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='CORP_JOB_PROCESS_STUCK_ARCHIVE';
    if c = 1 then
       execute immediate 'drop table CORP_JOB_PROCESS_STUCK_ARCHIVE cascade constraints';
    end if;
 end;
 /


create table corp_job_process_stuck
(
job_name 	varchar2(50) not null
,job_check_file_name varchar2(150)
,job_pid number(9)
,job_action_kill	varchar2(1) default 'N' check (job_action_kill in ('N', 'Y'))
,remove_check_file_only varchar2(1) default 'N' check (remove_check_file_only in ('N', 'Y'))
,created_by 	varchar2(45)
,create_dt		date
,updated_by 	varchar2(45)
,update_dt		date
)
TABLESPACE MAXDAT_DATA ;

alter table corp_job_process_stuck add constraint corp_job_process_stuck_pk primary key (job_name);

create table corp_job_process_stuck_archive
(
job_name 	varchar2(50)
,job_check_file_name varchar2(150)
,job_pid number(9)
,job_action_kill	varchar2(1)
,remove_check_file_only varchar2(1) 
,created_by 	varchar2(45)
,create_dt		date
,updated_by 	varchar2(45)
,update_dt		date
)
TABLESPACE MAXDAT_DATA ;

alter table corp_job_process_stuck_archive add constraint corp_job_process_stuck_archive_pk primary key (job_name,update_dt);

