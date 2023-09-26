alter session set plsql_code_type = native;	

create or replace package PKG_HCO_V2_CALL as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/ContactCenter/trunk/kettle/MAXDAT/product/main/scripts/versions/Enhancements-Defects/MAXDAT-8474/004_Update_HCO_V2_Call.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 14422 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-12-10 15:15:32 -0700 (Mon, 10 Dec 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: lg74078 $';

  procedure INSERT_UPDATE_HCO_V2_CALL ;
  procedure PROC_CREATE_SCHEDULER_JOB;
   
  end;
  /
  
  create or replace package body PKG_HCO_V2_CALL as
  
  -- Initialize global variables
  
  g_err_date date := sysdate;	
  g_err_level varchar2(10) := 'Critical';	
  g_create_ts date := sysdate;		
  g_update_ts date := sysdate;
  g_process_name varchar2(30) := 'INSERT_UPDATE_HCO_V2_CALL';
  g_driver_table1_name varchar2(50):= 'CC_HCO_F_V2_CALL';
  g_driver_table2_name varchar2(50):= 'DB_SCHEDULER';
  
  procedure INSERT_UPDATE_HCO_V2_CALL
  as
  
  update_dt date;
  
  begin
  
  select trunc(to_date(out_var)) into update_dt from cc_a_list_lkup
   where name = 'CAHCO_V2_CALL_UPDATE_DATE'
   and list_type = 'CAHCO_V2_CALL_UPDATE_DATE'
   and value = 'CA HCO';
   
  delete from cc_hco_f_v2_call
      where trunc(datetime) in (select distinct trunc(datetime)  from cc_f_v2_call_sv a, cc_d_project b
                  where trunc(a.last_update_date) = update_dt
                  and a.d_project_id = b.project_id
                  and b.project_name = 'CA HCO');
                  
 insert into cc_hco_f_v2_call(F_V2_CALL_ID,
                  ACTIVITY_ID,
                  AGENT_LOGIN_ID,
                  ANI_PHONE_NUMBER,
                  CALLGUID,
                  CALLTYPE_REPORTING_DATETIME,
                  CALL_ABANDONED_FLAG,
                  CALL_ANSWERED_FLAG,
                  CALL_BUSY_FLAG,
                  CALL_DIAL_METHOD,
                  CALL_DISPOSITION,
                  CALL_DISPOSITION_DESC,
                  CALL_DISPOSITION_FLAG,
                  CALL_DISPOSITION_FLG_DESC,
                  CALL_DROPPED_FLAG,
                  CALL_DURATION,
                  CALL_HANDLE_METHOD,
                  CALL_OFFERED_FLAG,
                  CALL_REFERENCE_ID,
                  CALL_SEGMENT_END_DT,
                  CALL_SEGMENT_ID,
                  CREATE_DATE,
                  CUSTOMER_ACCOUNT_NUMBER,
                  DATETIME,
                  DELAY_TIME_SECONDS,
                  DIGITS_DIALED,
                  DNIS,
                  D_AGENT_ID,
                  D_CONTACT_QUEUE_ID,
                  D_DATE_ID,
                  D_PROGRAM_ID,
                  D_PROJECT_ID,
                  HOLD_TIME_SECONDS,
                  IVR_TIME_SECONDS,
                  LANGUAGE,
                  LAST_UPDATED_BY,
                  LAST_UPDATE_DATE,
                  LOCAL_Q_TIME_SECONDS,
                  NETWORK_TIME_SECONDS,
                  PERIPHERAL_CALL_KEY,
                  PERIPHERAL_CALL_TYPE,
                  PERIPHERAL_ID,
                  PRECISION_QUEUE_ID,
                  QUEUE_NUMBER,
                  QUEUE_TIME_SECONDS,
                  RING_TIME_SECONDS,
                  ROUTER_CALL_KEY,
                  ROUTER_CALL_KEY_DAY,
                  SKILL_GROUP_ID,
                  SOURCE_AGENT_LOGIN_ID,
                  SOURCE_CALL_ID,
                  SOURCE_D_AGENT_ID,
                  TALK_TIME_SECONDS,
                  TIME_TO_ABAND_SECONDS,
                  TRANSFER_TO,
                  VOICEMAIL_FLAG,
                  WORK_TIME_SECONDS,
                  XFERRED_OUT_FLAG)
    select F_V2_CALL_ID,
                  ACTIVITY_ID,
                  AGENT_LOGIN_ID,
                  ANI_PHONE_NUMBER,
                  CALLGUID,
                  CALLTYPE_REPORTING_DATETIME,
                  CALL_ABANDONED_FLAG,
                  CALL_ANSWERED_FLAG,
                  CALL_BUSY_FLAG,
                  CALL_DIAL_METHOD,
                  CALL_DISPOSITION,
                  CALL_DISPOSITION_DESC,
                  CALL_DISPOSITION_FLAG,
                  CALL_DISPOSITION_FLG_DESC,
                  CALL_DROPPED_FLAG,
                  CALL_DURATION,
                  CALL_HANDLE_METHOD,
                  CALL_OFFERED_FLAG,
                  CALL_REFERENCE_ID,
                  CALL_SEGMENT_END_DT,
                  CALL_SEGMENT_ID,
                  CREATE_DATE,
                  CUSTOMER_ACCOUNT_NUMBER,
                  DATETIME,
                  DELAY_TIME_SECONDS,
                  DIGITS_DIALED,
                  DNIS,
                  D_AGENT_ID,
                  D_CONTACT_QUEUE_ID,
                  D_DATE_ID,
                  D_PROGRAM_ID,
                  D_PROJECT_ID,
                  HOLD_TIME_SECONDS,
                  IVR_TIME_SECONDS,
                  LANGUAGE,
                  LAST_UPDATED_BY,
                  LAST_UPDATE_DATE,
                  LOCAL_Q_TIME_SECONDS,
                  NETWORK_TIME_SECONDS,
                  PERIPHERAL_CALL_KEY,
                  PERIPHERAL_CALL_TYPE,
                  PERIPHERAL_ID,
                  PRECISION_QUEUE_ID,
                  QUEUE_NUMBER,
                  QUEUE_TIME_SECONDS,
                  RING_TIME_SECONDS,
                  ROUTER_CALL_KEY,
                  ROUTER_CALL_KEY_DAY,
                  SKILL_GROUP_ID,
                  SOURCE_AGENT_LOGIN_ID,
                  SOURCE_CALL_ID,
                  SOURCE_D_AGENT_ID,
                  TALK_TIME_SECONDS,
                  TIME_TO_ABAND_SECONDS,
                  TRANSFER_TO,
                  VOICEMAIL_FLAG,
                  WORK_TIME_SECONDS,
                  XFERRED_OUT_FLAG from cc_f_v2_call_sv, cc_d_project b
                  where trunc(last_update_date) = update_dt
                  and d_project_id = b.project_id
                  and b.project_name = 'CA HCO';
                                        
                
  update CC_A_LIST_LKUP
  set OUT_VAR = sysdate
  where   name = 'CAHCO_V2_CALL_UPDATE_DATE'
  and list_type = 'CAHCO_V2_CALL_UPDATE_DATE'
  and value = 'CA HCO';
              
commit;

exception
		when others then
		insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME) 
		      values (g_process_name, g_err_date, g_driver_table1_name, g_driver_table1_name );
		      
		      COMMIT;


  end;
  
  procedure PROC_CREATE_SCHEDULER_JOB
  as 
  v_schedule_name varchar2(50) := 'cc_hco_v2_call_schedule';
  v_package_name varchar2(50) := 'PKG_HCO_V2_CALL';
  v_procedure_name varchar2(61) := 'INSERT_UPDATE_HCO_V2_CALL';
  v_job_type varchar2(50) := 'STORED_PROCEDURE';
   
  begin

  DBMS_SCHEDULER.CREATE_SCHEDULE (
    schedule_name     => v_schedule_name,
    start_date        => systimestamp,
    repeat_interval   => 'freq=daily; byhour=6; byminute=0; bysecond=0;',
    comments          => 'Every day');
    
    DBMS_SCHEDULER.CREATE_JOB (
            job_name   => v_procedure_name,
            job_type   => v_job_type,
            job_action => v_package_name ||'.' || v_procedure_name,
            schedule_name => v_schedule_name);
            
    DBMS_SCHEDULER.ENABLE(name=>v_procedure_name);
    
     DBMS_SCHEDULER.SET_ATTRIBUTE(
            name => v_procedure_name,
            attribute => 'RESTARTABLE',
        value => TRUE);
      
 
  exception
     		when others then
     		insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME) 
		      values (g_process_name, g_err_date, g_driver_table2_name, g_driver_table2_name );
		      
		      COMMIT;
		      
  end;
  


end;
/

alter session set plsql_code_type = interpreted;