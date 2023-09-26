-- Create PP_WFM_ACTUALS 
show errors;

ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_ACTUALS';
   if c = 1 then
      execute immediate 'drop table PP_WFM_ACTUALS cascade constraints';
   end if;
end;
/
  GRANT select on maxdat.pp_wfm_staff_sv to DP_SCORECARD;
  GRANT select on maxdat.pp_wfm_supervisor_to_staff_sv to DP_SCORECARD;


CREATE TABLE PP_WFM_ACTUALS 
( RT_ACTUALS_ID NUMBER NOT NULL 
, STAFF_ID NUMBER NOT NULL 
, EVENT_ID NUMBER NOT NULL 
, SOURCE_ID NUMBER NOT NULL 
, TASK_START DATE NOT NULL 
, TASK_CATEGORY_ID NUMBER NOT NULL 
, TASK_END DATE 
, WORK_ACTIVITY VARCHAR2(4000 BYTE) 
, ANNOTATION VARCHAR2(4000 BYTE) 
, CREATE_DATE DATE NOT NULL 
, CREATE_STAFF_ID NUMBER NOT NULL 
, MODIFY_DATE DATE 
, MODIFY_STAFF_ID NUMBER 
, QUEUE_ID NUMBER 
, EXCLUSION_FLAG VARCHAR2(1)
, WORK_SUBACTIVITY VARCHAR2(4000)
,  CONSTRAINT PP_WFM_ACTUALS_pk primary key
 (
  RT_ACTUALS_ID
)
enable
)
tablespace MAXDAT_DATA ;

COMMENT ON COLUMN PP_WFM_ACTUALS.RT_ACTUALS_ID IS 'Internal identifier for a RT_ACTUALS record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.STAFF_ID IS 'Internal identifier for a STAFF record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.EVENT_ID IS 'Internal identifier for a EVENT record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.SOURCE_ID IS 'Identifier of the source of the unprocessed data (1 = Notify Manual RTA screen).';
COMMENT ON COLUMN PP_WFM_ACTUALS.TASK_START IS 'Is the date and time at which the task commences.';
COMMENT ON COLUMN PP_WFM_ACTUALS.TASK_CATEGORY_ID IS 'Internal identifier for the TASK CATEGORY record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.TASK_END IS 'Is the date and time at which the task ends.';
COMMENT ON COLUMN PP_WFM_ACTUALS.WORK_ACTIVITY IS 'A note of work description or detail added to the data.';
COMMENT ON COLUMN PP_WFM_ACTUALS.ANNOTATION IS 'A note of explanation or comment added to the data.';
COMMENT ON COLUMN PP_WFM_ACTUALS.CREATE_DATE IS 'Records the date when the record was created.';
COMMENT ON COLUMN PP_WFM_ACTUALS.CREATE_STAFF_ID IS 'Internal identifier for a STAFF record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.MODIFY_DATE IS 'Records the date when the record was last edited.';
COMMENT ON COLUMN PP_WFM_ACTUALS.MODIFY_STAFF_ID IS 'Internal identifier for a STAFF record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.QUEUE_ID IS 'Internal identifier for a QUEUE record.';
COMMENT ON COLUMN PP_WFM_ACTUALS.EXCLUSION_FLAG IS 'Has this record been excluded.';
COMMENT ON COLUMN PP_WFM_ACTUALS.WORK_SUBACTIVITY IS 'A note of sub-work description or detail added to the data.';

grant select on PP_WFM_ACTUALS to MAXDAT_READ_ONLY; 
grant select on PP_WFM_ACTUALS to DP_SCORECARD; 
grant select, insert, update, delete on PP_WFM_ACTUALS to MAXDAT_MSTR_TRX_RPT;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','PP_WFM_ACTUALS',4);

--create view PP_WFM_ACTUALS_SV

  CREATE OR REPLACE FORCE VIEW "MAXDAT"."PP_WFM_ACTUALS_SV" 
  (RT_ACTUALS_ID
  , STAFF_ID
  , EVENT_ID
  , SOURCE_ID
  , TASK_START
  , TASK_CATEGORY_ID
  , TASK_END
  , WORK_ACTIVITY
  , ANNOTATION
  , CREATE_DATE
  , CREATE_STAFF_ID
  , MODIFY_DATE
  , MODIFY_STAFF_ID
  , QUEUE_ID
  , EXCLUSION_FLAG
  , WORK_SUBACTIVITY
  , HANDLE_TIME
  ) AS 
  select 
RT_ACTUALS_ID
,STAFF_ID
,EVENT_ID
,SOURCE_ID
,TASK_START
,TASK_CATEGORY_ID
,TASK_END
,WORK_ACTIVITY
,ANNOTATION
,CREATE_DATE
,CREATE_STAFF_ID
,MODIFY_DATE
,MODIFY_STAFF_ID
,QUEUE_ID
,EXCLUSION_FLAG
,WORK_SUBACTIVITY
,round(((task_end-task_start) * 24 * 60),2) as HANDLE_TIME
from PP_WFM_ACTUALS
WITH READ ONLY;

grant select on PP_WFM_ACTUALS_SV to MAXDAT_READ_ONLY; 
grant select on PP_WFM_ACTUALS_SV to DP_SCORECARD; 
grant select on PP_WFM_ACTUALS to MAXDAT_MSTR_TRX_RPT;