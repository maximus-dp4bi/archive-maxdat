ALTER SESSION SET CURRENT_SCHEMA = FOLSOM_SHARED_CC;

alter table CC_S_TMP_AVY_AGENT
ADD SITE VARCHAR2(50);

CREATE TABLE CC_S_TMP_AVY_AGT_EVENT_DETAIL
(
  AGENT_ID NUMBER(19,0)
 ,ACTIVITY_TYPE_ID NUMBER(19,0)
 ,ACTIVITY_TYPE_NAME VARCHAR2(50)
 ,ACTIVITY_DURATION_SECONDS NUMBER(15,2)
 ,ACTIVITY_DT DATE
)
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;

grant select on CC_S_TMP_AVY_AGT_EVENT_DETAIL to MAXDAT_READ_ONLY; 

CREATE TABLE CC_S_TMP_AVY_AGENT_SUPERVISOR
(
  AGENTLOGINID NVARCHAR2(100)
 ,AGENTFIRSTNAME VARCHAR2(100)
 ,AGENTLASTNAME VARCHAR2(100)
 ,SUPLOGINID NVARCHAR2(100)
 ,SUPFIRSTNAME VARCHAR2(100)
 ,SUPLASTNAME VARCHAR2(100)
 ,DEPARTMENT VARCHAR2(100)
 ,EFFECTIVE_DATE DATE
)
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;

grant select on CC_S_TMP_AVY_AGENT_SUPERVISOR to MAXDAT_READ_ONLY;


CREATE TABLE CC_S_TMP_AVY_AGT_WORK_DAY
(
  AGENT_ID NUMBER(19,0)
 ,EVENT_DT DATE
 ,EVENT_TYPE VARCHAR2(5)
 ,FIRST_EVENT_TIME DATE
 ,EVENT_DURATION_SECONDS NUMBER(15,2)
)
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;

grant select on CC_S_TMP_AVY_AGT_WORK_DAY to MAXDAT_READ_ONLY; 

CREATE TABLE CC_S_TMP_AVY_ACTIVITY_TYPE
(
   ACTIVITY_TYPE_NAME VARCHAR2(30)
 , ACTIVITY_TYPE_DESC VARCHAR2(30)
 )
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;

grant select on CC_S_TMP_AVY_ACTIVITY_TYPE to MAXDAT_READ_ONLY; 

insert into cc_c_activity_type (activity_type_id, activity_type_name, activity_type_description, activity_type_category, is_paid_flag, is_available_flag, is_ready_flag, is_absence_flag, record_eff_dt, record_end_dt)
values (0, 'Unknown', 'Unknown', 'Unknown', 0, 0, 0, 0, to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

commit;

Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Project','AGENT_PROJECT','TennCare','TN ERPC',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Project','AGENT_PROJECT','TN','TN ERPC',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Project','AGENT_PROJECT','MassHealth','MassHealth',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));

Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Program','AGENT_PROGRAM','TennCare','TN ERPC',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Program','AGENT_PROGRAM','TN','TN ERPC',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (seq_cc_cell_id.NEXTVAL,'Agent_Program','AGENT_PROGRAM','MassHealth','MassHealth',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('19-APR-16','DD-MON-RR'));
					
commit;				

alter table cc_a_adhoc_job add (REPORTING_PERIOD_TYPE_PARAM VARCHAR2(50), ACD_SOURCE VARCHAR2(30), WFM_SOURCE VARCHAR2(100));

Insert into CC_D_PROJECT_TARGETS (D_PROJECT_TARGETS_ID,PROJECT_ID,VERSION,AVERAGE_HANDLE_TIME_TARGET,UTILIZATION_TARGET,COST_PER_CALL_TARGET,OCCUPANCY_TARGET,LABOR_COST_PER_CALL_TARGET,RECORD_EFF_DT,RECORD_END_DT) values (0,0,0,0,0,0,0,0,to_date('01/01/1900','MM/DD/YYYY'),to_date('12/31/2999','MM/DD/YYYY'));
COMMIT;

