/*
Created on 24-Jan-2014 by Raj A.
Description:
While working on the TX process Incidents changes, realized these are missing in TX.

team involved while these changes were made: Raj A., Sara, Devin and Gary.
*/

--Disabling Process Incidents BPM queue jobs until ETL table is validated.
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(10,1,'ENABLED','N');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(10,2,'ENABLED','N');

alter table corp_etl_process_incidents
add (
COUNTY_CODE    Varchar2(32),            
COUNTY_NAME    Varchar2(64),          
ENROLLEE_RIN   Varchar2(30),         
REPORTER_NAME  Varchar2(80)
);

alter table d_pi_current
add (
"COUNTY_CODE"    Varchar2(32),
"COUNTY_NAME"    Varchar2(64),
"ACTION_COMMENTS"  Varchar2(4000),
"INCIDENT_DESCRIPTION" Varchar2(4000),
"RESOLUTION_DESCRIPTION" Varchar2(4000)
);

alter table corp_etl_process_incidents
 drop column action_comments; 
  
 alter table PROCESS_INCIDENTS_OLTP
 drop column action_comments;

 alter table PROCESS_INCIDENTS_WIP_BPM
 drop column action_comments; 

 alter table corp_etl_process_incidents
add action_comments varchar2(4000);

 alter table PROCESS_INCIDENTS_OLTP
add action_comments varchar2(4000);

 alter table PROCESS_INCIDENTS_WIP_BPM
add action_comments varchar2(4000);

ALTER PACKAGE dpy_process_incidents COMPILE PACKAGE;  
 
 --Backing up ETL and semantic table.
 create table corp_etl_pi_01312014 as
 select * from corp_etl_process_incidents;
 
 create table d_pi_current_01312014 as
 select * from d_pi_current;
 
 create index MAXDAT.IDX_STEP_INST_STG_Comp_dt on MAXDAT.STEP_INSTANCE_STG (COMPLETED_TS)
  tablespace MAXDAT_INDX;
create index MAXDAT.IDX_STEP_INST_STG_def_id on MAXDAT.STEP_INSTANCE_STG (STEP_DEFINITION_ID)
  tablespace MAXDAT_INDX;
  
update corp_etl_job_statistics
   set job_start_date = to_date('2013/09/01','yyyy/mm/dd'),
       job_end_date = to_date('2013/09/01','yyyy/mm/dd')
 where  job_id = (select max(job_id)            
                    from corp_etl_job_statistics
                   where job_status_cd = 'COMPLETED'
                     and job_name = 'Process_Incidents_RUN_ALL');
commit;     