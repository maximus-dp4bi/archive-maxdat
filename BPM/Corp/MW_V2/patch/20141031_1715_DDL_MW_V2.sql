/*
Created on 11/06/2014 Raj A. 
Description: NYHIX-7711 & MAXDAT-216

1. Renamed dimension table D_Groups to D_Business_Units; View: D_Groups_SV to D_Business_Units_SV; 

Renamed columns: 
Group_ID to Business_Unit_ID
Group_name to Business_Unit_Name
Group_Description to Business_Unit_Description

Removed columns:
PARENT_GROUP_ID
GROUP_SUPERVISOR_STAFF_ID

2. Changes to ETL stage tables, Current dimension, current dimension view and History table:  
Renamed column, Group_ID to Business_Unit_ID, added Source_Process_ID & Source_Process_Instance_ID columns.

Raj A. 11/11/2014 Checking for equal to COMPLETED instead or NOT EQUAL TO.
*/
insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
ref_type,
ref_id,
start_date,
end_date,
comments,
created_ts,
updated_ts
)
values
(
'MW_V2_ADD_TO_WHERE_CLAUSE', --name
'MW_V2_LIST',             --list_type
'AND clause for the INSERT statement', --value
'and not exists (select 1 from step_instance_stg sis where task_id = sis.step_instance_id and sis.status = ''COMPLETED'')',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
sysdate,
SYSDATE
);

delete corp_etl_control where name = 'MW_V2_ADD_TO_WHERE_CLAUSE';

commit;

alter table CORP_ETL_MW_V2 rename column GROUP_ID to BUSINESS_UNIT_ID;
alter table CORP_ETL_MW_V2 add 
(
SOURCE_PROCESS_ID          NUMBER(18),
SOURCE_PROCESS_INSTANCE_ID NUMBER(18)
);

alter table CORP_ETL_MW_V2_WIP rename column GROUP_ID to BUSINESS_UNIT_ID;
alter table CORP_ETL_MW_V2_WIP add 
(
SOURCE_PROCESS_ID          NUMBER(18),
SOURCE_PROCESS_INSTANCE_ID NUMBER(18)
);

alter table D_MW_V2_CURRENT rename column CURR_GROUP_ID to CURR_BUSINESS_UNIT_ID;
alter table D_MW_V2_CURRENT add 
(
SOURCE_PROCESS_ID          NUMBER(18),
SOURCE_PROCESS_INSTANCE_ID NUMBER(18)
);
drop index DMWCUR_V2_CURR_GROUP_ID;
create index DMWCUR_V2_CURR_BUSUNIT_ID on D_MW_V2_CURRENT (CURR_BUSINESS_UNIT_ID) TABLESPACE  MAXDAT_INDX ;

  create or replace view D_MW_V2_CURRENT_SV as
  select
  MW_BI_ID,                       
  AGE_IN_BUSINESS_DAYS,           
  AGE_IN_CALENDAR_DAYS,           
  CANCELLED_BY_STAFF_ID,          
  CANCEL_METHOD,                  
  CANCEL_REASON,                  
  CANCEL_WORK_DATE,               
  CASE_ID,                        
  CLIENT_ID,                      
  COMPLETE_DATE,                  
  CREATE_DATE,                    
  CURR_CREATED_BY_STAFF_ID,	 
  ESCALATED_FLAG,            
  CURR_ESCALATED_TO_STAFF_ID,	 
  CURR_FORWARDED_BY_STAFF_ID,	 
  FORWARDED_FLAG,            
  CURR_BUSINESS_UNIT_ID,
  INSTANCE_START_DATE,            
  INSTANCE_END_DATE,              
  JEOPARDY_FLAG,                  
  CURR_LAST_UPD_BY_STAFF_ID,	 
  CURR_LAST_UPDATE_DATE,
  CURR_OWNER_STAFF_ID,	         
  PARENT_TASK_ID,                 
  SOURCE_REFERENCE_ID,            
  SOURCE_REFERENCE_TYPE,          
  CURR_STATUS_DATE,               
  STATUS_AGE_IN_BUS_DAYS,         
  STATUS_AGE_IN_CAL_DAYS,         
  STG_EXTRACT_DATE,               
  STG_LAST_UPDATE_DATE,           
  STAGE_DONE_DATE,                
  TASK_ID,                        
  TASK_PRIORITY,                  
  CURR_TASK_STATUS,               
  TASK_TYPE_ID,              
  CURR_TEAM_ID,
  TIMELINESS_STATUS,              
  UNIT_OF_WORK,                   
  CURR_WORK_RECEIPT_DATE,
  SOURCE_PROCESS_ID,
  SOURCE_PROCESS_INSTANCE_ID
from D_MW_V2_CURRENT
with read only;

alter table D_MW_V2_HISTORY rename column GROUP_ID to BUSINESS_UNIT_ID;
alter table D_MW_V2_HISTORY rename constraint DMWBD_DMW_GROUP_ID_FK to DMWBD_DMW_BUS_UNIT_ID_FK;
create or replace view D_MW_V2_HISTORY_SV
as
SELECT
  h.DMWBD_ID,
  bdd.D_DATE,
  h.MW_BI_ID,
  h.TASK_STATUS,
  h.BUSINESS_UNIT_ID,
  h.TEAM_ID,
  h.LAST_UPDATE_DATE,
  h.STATUS_DATE,
  h.WORK_RECEIPT_DATE
FROM D_MW_V2_HISTORY h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

rename D_GROUPS to D_BUSINESS_UNITS;

alter table D_BUSINESS_UNITS rename column GROUP_ID to BUSINESS_UNIT_ID;
alter table D_BUSINESS_UNITS rename column GROUP_NAME to BUSINESS_UNIT_NAME;
alter table D_BUSINESS_UNITS rename column GROUP_DESCRIPTION to BUSINESS_UNIT_DESCRIPTION;
alter table D_BUSINESS_UNITS drop column PARENT_GROUP_ID;
alter table D_BUSINESS_UNITS drop column GROUP_SUPERVISOR_STAFF_ID;
alter table D_BUSINESS_UNITS rename constraint PK_GROUP_ID to PK_BUS_UNIT_ID;

rename D_GROUPS_SV to D_BUSINESS_UNITS_SV;
create or replace view D_BUSINESS_UNITS_SV as
select * from D_BUSINESS_UNITS
with read only;