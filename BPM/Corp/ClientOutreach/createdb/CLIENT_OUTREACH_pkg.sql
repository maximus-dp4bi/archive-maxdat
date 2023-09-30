alter session set plsql_code_type = native;
 
create or replace package CLIENT_OUTREACH as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DCORCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;
 
  function GET_SLA_DAYS
    (p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2,
     p_outreach_step in varchar2)
    return varchar2 result_cache;
 
  function GET_SLA_DAYS_TYPE
    return varchar2 result_cache;
 
  function JEOPARDY_DAYS
    (p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2)
    return number result_cache; 
    
  function GET_JEOPARDY_DATE
    (p_create_date in date,
     p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2)
    return date;
    
  function GET_JEOPARDY_FLAG
    (p_create_date    in date,
     p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2)
   return varchar2;
    
  function GET_TIMELINE_STATUS
    (p_create_date in date,
     p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2,            
     p_ased_outreach_step1 in date,      
     p_ased_outreach_step2 in date,      
     p_ased_outreach_step3 in date,      
     p_ased_outreach_step4 in date,      
     p_ased_outreach_step5 in date,
     p_outreach_step6 in varchar2,
     p_ased_outreach_step6 in date,
     p_reminder_appt_dt in date,
     p_complete_date in date,
    p_outreach_status in varchar2)
  return varchar2;
    
  function GET_CYCLE_TIME
    (p_create_date   in date,
     p_complete_date in date)
    return number;
    
  /*
  Include
    CECO_ID
    STG_LAST_UPDATE_DATE
  Exclude
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  type T_INS_COR_XML is record 
    (
     ASED_NOTIFY_CLIENT varchar2(19),
     ASED_NOTIFY_SOURCE varchar2(19),
     ASED_OUTREACH_STEP1 varchar2(19),
     ASED_OUTREACH_STEP2 varchar2(19),
     ASED_OUTREACH_STEP3 varchar2(19),
     ASED_OUTREACH_STEP4 varchar2(19),
     ASED_OUTREACH_STEP5 varchar2(19),
     ASED_OUTREACH_STEP6 varchar2(19),
     ASED_PERFORM_HOME_VISIT varchar2(19),
     ASED_PERFORM_OUTREACH varchar2(19),
     ASED_TERMINATION_TIMER varchar2(19),
     ASED_VALIDATE_OUTREACH_REQ varchar2(19),
     ASF_NOTIFY_CLIENT varchar2(1),
     ASF_NOTIFY_SOURCE varchar2(1),
     ASF_OUTREACH_STEP1 varchar2(1),
     ASF_OUTREACH_STEP2 varchar2(1),
     ASF_OUTREACH_STEP3 varchar2(1),
     ASF_OUTREACH_STEP4 varchar2(1),
     ASF_OUTREACH_STEP5 varchar2(1),
     ASF_OUTREACH_STEP6 varchar2(1),
     ASF_PERFORM_HOME_VISIT varchar2(1),
     ASF_PERFORM_OUTREACH varchar2(1),
     ASF_TERMINATION_TIMER varchar2(1),
     ASF_VALIDATE_OUTREACH_REQ varchar2(1),
     ASPB_NOTIFY_CLIENT varchar2(100),
     ASPB_NOTIFY_SOURCE varchar2(100),
     ASPB_OUTREACH_STEP1 varchar2(100),
     ASPB_OUTREACH_STEP2 varchar2(100),
     ASPB_OUTREACH_STEP3 varchar2(100),
     ASPB_OUTREACH_STEP4 varchar2(100),
     ASPB_OUTREACH_STEP5 varchar2(100),
     ASPB_OUTREACH_STEP6 varchar2(100),
     ASPB_PERFORM_HOME_VISIT varchar2(100),
     ASPB_PERFORM_OUTREACH varchar2(100),
     ASPB_VALIDATE_OUTREACH_REQ varchar2(100),
     ASSD_NOTIFY_CLIENT varchar2(19),
     ASSD_NOTIFY_SOURCE varchar2(19),
     ASSD_OUTREACH_STEP1 varchar2(19),
     ASSD_OUTREACH_STEP2 varchar2(19),
     ASSD_OUTREACH_STEP3 varchar2(19),
     ASSD_OUTREACH_STEP4 varchar2(19),
     ASSD_OUTREACH_STEP5 varchar2(19),
     ASSD_OUTREACH_STEP6 varchar2(19),
     ASSD_PERFORM_HOME_VISIT varchar2(19),
     ASSD_PERFORM_OUTREACH varchar2(19),
     ASSD_TERMINATION_TIMER varchar2(19),
     ASSD_VALIDATE_OUTREACH_REQ varchar2(19),
     CANCEL_BY varchar2(100),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(100),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),
     CECO_ID varchar2(100),
     CHECKUP_CARETAKER_REPORT varchar2(4000),
     CHECKUP_DT varchar2(4000),
     CHECKUP_PROVIDER_NAME varchar2(4000),
     CHECKUP_TX_WORKS_ADVISOR varchar2(4000),
     CHECKUP_TYPE varchar2(4000),
     CLIENT_ID varchar2(100),
     CLIENT_NOTIFICATION_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY varchar2(64),
     CPW_CALL_BACK_IND varchar2(4000),
     CPW_REFERRAL_DT varchar2(4000),
     CPW_REFERRAL_PRIORITY_STATUS varchar2(4000),
     CPW_REFERRAL_REASON varchar2(4000),
     CPW_REFERRAL_SOURCE_NAME varchar2(4000),
     CPW_REFERRAL_SOURCE_TYPE varchar2(4000),
     CREATED_BY varchar2(100),
     CREATE_DT varchar2(19),
     CURR_TASK_ID varchar2(100),
     CURR_TASK_STATUS varchar2(32),
     CURR_TASK_TYPE varchar2(50),
     DELAY_DAYS1 varchar2(100),
     DELAY_DAYS1_UNIT varchar2(32),
     DELAY_DAYS2 varchar2(100),
     DELAY_DAYS2_UNIT varchar2(32),
     DELAY_DAYS3 varchar2(100),
     DELAY_DAYS3_UNIT varchar2(32),
     EXEFF_HELP_FIND_PROV_IND varchar2(4000),
     EXEFF_HOME_VISIT_IND varchar2(4000),
     EXEFF_INTERPRETER_IND varchar2(4000),
     EXEFF_LANGUAGE varchar2(4000),
     EXEFF_MAIL_IND varchar2(4000),
     EXEFF_MORE_INFO_CASEMGMT_IND varchar2(4000),
     EXEFF_MORE_INFO_DENT_IND varchar2(4000),
     EXEFF_MORE_INFO_IND varchar2(4000),
     EXEFF_MORE_INFO_MED_IND varchar2(4000),
     EXEFF_OTHER_IND varchar2(4000),
     EXEFF_OTHER_LANGUAGE_IND varchar2(4000),
     EXEFF_PHONE_IND varchar2(4000),
     EXEFF_SCHEDULE_APPT_IND varchar2(4000),
     EXEFF_TRANSPORT_IND varchar2(4000),
     FINAL_WAIT_DAYS varchar2(100),
     FINAL_WAIT_IND varchar2(10),
     FINAL_WAIT_UNIT varchar2(32),
     GENERIC_FIELD1 varchar2(50),
     GENERIC_FIELD2 varchar2(50),
     GENERIC_FIELD3 varchar2(50),
     GENERIC_FIELD4 varchar2(50),
     GENERIC_FIELD5 varchar2(50),
     GWF_FINAL_WAIT varchar2(1),
     GWF_INVALID varchar2(1),
     GWF_NOTIFY_CLIENT varchar2(1),
     GWF_NOTIFY_SOURCE varchar2(1),
     GWF_STEP2_REQUIRED varchar2(1),
     GWF_STEP3_REQUIRED varchar2(1),
     GWF_STEP4_REQUIRED varchar2(1),
     GWF_STEP5_REQUIRED varchar2(1),
     GWF_STEP6_REQUIRED varchar2(1),
     GWF_UNSUCCESSFUL varchar2(1),
     HOME_VISIT_INTERPRETER_IND varchar2(4000),
     HOME_VISIT_LANGUAGE varchar2(4000),
     HOME_VISIT_NOT_ENG_IND varchar2(4000),
     HOME_VISIT_REASON varchar2(4000),
     HUMAN_TASK_TYPE1 varchar2(32),
     HUMAN_TASK_TYPE2 varchar2(32),
     IMAGE_REFERENCE_ID varchar2(100),
     INSTANCE_STATUS varchar2(32),
     LAST_UPDATE_BY varchar2(100),
     LAST_UPDATE_DT varchar2(19),
     LETTER_DEFINITION_ID1 varchar2(100),
     LETTER_DEFINITION_ID2 varchar2(100),
     LETTER_DEFINITION_ID3 varchar2(100),
     NOTIFY_INVALID_IND varchar2(1),
     NOTIFY_OUTCOME_IND varchar2(1),
     ORIGIN varchar2(30),
     ORIGIN_ID varchar2(100),
     OUTCOME_NOTIFICATION_TASK_ID varchar2(100),
     OUTREACH_ID varchar2(100),
     OUTREACH_REQ_CATEGORY varchar2(128),
     OUTREACH_REQ_TYPE varchar2(128),
     OUTREACH_STATUS varchar2(128),
     OUTREACH_STATUS_DT varchar2(19),
     OUTREACH_STEP1_TYPE varchar2(30),
     OUTREACH_STEP2_TYPE varchar2(30),
     OUTREACH_STEP3_TYPE varchar2(30),
     OUTREACH_STEP4_TYPE varchar2(30),
     OUTREACH_STEP5_TYPE varchar2(30),
     OUTREACH_STEP6_TYPE varchar2(30),
     PRIORITY varchar2(80),
     PROGRAM_TYPE varchar2(30),
     PROVREF_FOLLOWUP_LEAD_TEST varchar2(4000),
     PROVREF_MISSED_APPT_DT varchar2(4000),
     PROVREF_MISSED_APPT_IND varchar2(4000),
     PROVREF_MISSED_APPT_OUTCOME varchar2(4000),
     PROVREF_MISSED_APPT_REASON varchar2(4000),
     PROVREF_MISSED_APPT_TYPE varchar2(4000),
     PROVREF_OTHER_COMMENT varchar2(4000),
     PROVREF_OTHER_IND varchar2(4000),
     PROVREF_PROVIDER_CITY varchar2(4000),
     PROVREF_PROVIDER_CLINIC_NAME varchar2(4000),
     PROVREF_PROVIDER_COUNTY varchar2(4000),
     PROVREF_PROVIDER_DT_REFERRED varchar2(4000),
     PROVREF_PROVIDER_TYPE varchar2(4000),
     PROVREF_PROVIDER_ZIP varchar2(4000),
     PROVREF_SCHEDULE_ASSIST varchar2(4000),
     PROVREF_TRANSPORT_ASSIST varchar2(4000),
     PROVREF_UPDATE_ADDRESS varchar2(4000),
     RECEIPT_DT varchar2(19),
     REMINDER_APPT_DT varchar2(4000),
     REMINDER_APPT_TYPE varchar2(4000),
     REMINDER_PROVIDER_NAME varchar2(4000),
     SERVICE_AREA varchar2(32),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM_TYPE varchar2(30),
     SURVEY_ID varchar2(100),
     SURVEY_NAME varchar2(256),
     TRACKING_NUMBER varchar2(32),
     VALIDATION_ERROR varchar2(50),
     CPW_NAME_OF_REFERRER VARCHAR2(4000),
     CPW_REFERRAL_SOURCE_PHONE VARCHAR2(4000)
    );
      
  /* 
  Include  
    STG_LAST_UPDATE_DATE
  Exclude
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
    */
  type T_UPD_COR_XML is record
    (
               ASED_NOTIFY_CLIENT varchar2(19),
     ASED_NOTIFY_SOURCE varchar2(19),
     ASED_OUTREACH_STEP1 varchar2(19),
     ASED_OUTREACH_STEP2 varchar2(19),
     ASED_OUTREACH_STEP3 varchar2(19),
     ASED_OUTREACH_STEP4 varchar2(19),
     ASED_OUTREACH_STEP5 varchar2(19),
     ASED_OUTREACH_STEP6 varchar2(19),
     ASED_PERFORM_HOME_VISIT varchar2(19),
     ASED_PERFORM_OUTREACH varchar2(19),
     ASED_TERMINATION_TIMER varchar2(19),
     ASED_VALIDATE_OUTREACH_REQ varchar2(19),
     ASF_NOTIFY_CLIENT varchar2(1),
     ASF_NOTIFY_SOURCE varchar2(1),
     ASF_OUTREACH_STEP1 varchar2(1),
     ASF_OUTREACH_STEP2 varchar2(1),
     ASF_OUTREACH_STEP3 varchar2(1),
     ASF_OUTREACH_STEP4 varchar2(1),
     ASF_OUTREACH_STEP5 varchar2(1),
     ASF_OUTREACH_STEP6 varchar2(1),
     ASF_PERFORM_HOME_VISIT varchar2(1),
     ASF_PERFORM_OUTREACH varchar2(1),
     ASF_TERMINATION_TIMER varchar2(1),
     ASF_VALIDATE_OUTREACH_REQ varchar2(1),
     ASPB_NOTIFY_CLIENT varchar2(100),
     ASPB_NOTIFY_SOURCE varchar2(100),
     ASPB_OUTREACH_STEP1 varchar2(100),
     ASPB_OUTREACH_STEP2 varchar2(100),
     ASPB_OUTREACH_STEP3 varchar2(100),
     ASPB_OUTREACH_STEP4 varchar2(100),
     ASPB_OUTREACH_STEP5 varchar2(100),
     ASPB_OUTREACH_STEP6 varchar2(100),
     ASPB_PERFORM_HOME_VISIT varchar2(100),
     ASPB_PERFORM_OUTREACH varchar2(100),
     ASPB_VALIDATE_OUTREACH_REQ varchar2(100),
     ASSD_NOTIFY_CLIENT varchar2(19),
     ASSD_NOTIFY_SOURCE varchar2(19),
     ASSD_OUTREACH_STEP1 varchar2(19),
     ASSD_OUTREACH_STEP2 varchar2(19),
     ASSD_OUTREACH_STEP3 varchar2(19),
     ASSD_OUTREACH_STEP4 varchar2(19),
     ASSD_OUTREACH_STEP5 varchar2(19),
     ASSD_OUTREACH_STEP6 varchar2(19),
     ASSD_PERFORM_HOME_VISIT varchar2(19),
     ASSD_PERFORM_OUTREACH varchar2(19),
     ASSD_TERMINATION_TIMER varchar2(19),
     ASSD_VALIDATE_OUTREACH_REQ varchar2(19),
     CANCEL_BY varchar2(100),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(100),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),
     CHECKUP_CARETAKER_REPORT varchar2(4000),
     CHECKUP_DT varchar2(4000),
     CHECKUP_PROVIDER_NAME varchar2(4000),
     CHECKUP_TX_WORKS_ADVISOR varchar2(4000),
     CHECKUP_TYPE varchar2(4000),
     CLIENT_ID varchar2(100),
     CLIENT_NOTIFICATION_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY varchar2(64),
     CPW_CALL_BACK_IND varchar2(4000),
     CPW_REFERRAL_DT varchar2(4000),
     CPW_REFERRAL_PRIORITY_STATUS varchar2(4000),
     CPW_REFERRAL_REASON varchar2(4000),
     CPW_REFERRAL_SOURCE_NAME varchar2(4000),
     CPW_REFERRAL_SOURCE_TYPE varchar2(4000),
     CREATED_BY varchar2(100),
     CREATE_DT varchar2(19),
     CURR_TASK_ID varchar2(100),
     CURR_TASK_STATUS varchar2(32),
     CURR_TASK_TYPE varchar2(50),
     DELAY_DAYS1 varchar2(100),
     DELAY_DAYS1_UNIT varchar2(32),
     DELAY_DAYS2 varchar2(100),
     DELAY_DAYS2_UNIT varchar2(32),
     DELAY_DAYS3 varchar2(100),
     DELAY_DAYS3_UNIT varchar2(32),
     EXEFF_HELP_FIND_PROV_IND varchar2(4000),
     EXEFF_HOME_VISIT_IND varchar2(4000),
     EXEFF_INTERPRETER_IND varchar2(4000),
     EXEFF_LANGUAGE varchar2(4000),
     EXEFF_MAIL_IND varchar2(4000),
     EXEFF_MORE_INFO_CASEMGMT_IND varchar2(4000),
     EXEFF_MORE_INFO_DENT_IND varchar2(4000),
     EXEFF_MORE_INFO_IND varchar2(4000),
     EXEFF_MORE_INFO_MED_IND varchar2(4000),
     EXEFF_OTHER_IND varchar2(4000),
     EXEFF_OTHER_LANGUAGE_IND varchar2(4000),
     EXEFF_PHONE_IND varchar2(4000),
     EXEFF_SCHEDULE_APPT_IND varchar2(4000),
     EXEFF_TRANSPORT_IND varchar2(4000),
     FINAL_WAIT_DAYS varchar2(100),
     FINAL_WAIT_IND varchar2(10),
     FINAL_WAIT_UNIT varchar2(32),
     GENERIC_FIELD1 varchar2(50),
     GENERIC_FIELD2 varchar2(50),
     GENERIC_FIELD3 varchar2(50),
     GENERIC_FIELD4 varchar2(50),
     GENERIC_FIELD5 varchar2(50),
     GWF_FINAL_WAIT varchar2(1),
     GWF_INVALID varchar2(1),
     GWF_NOTIFY_CLIENT varchar2(1),
     GWF_NOTIFY_SOURCE varchar2(1),
     GWF_STEP2_REQUIRED varchar2(1),
     GWF_STEP3_REQUIRED varchar2(1),
     GWF_STEP4_REQUIRED varchar2(1),
     GWF_STEP5_REQUIRED varchar2(1),
     GWF_STEP6_REQUIRED varchar2(1),
     GWF_UNSUCCESSFUL varchar2(1),
     HOME_VISIT_INTERPRETER_IND varchar2(4000),
     HOME_VISIT_LANGUAGE varchar2(4000),
     HOME_VISIT_NOT_ENG_IND varchar2(4000),
     HOME_VISIT_REASON varchar2(4000),
     HUMAN_TASK_TYPE1 varchar2(32),
     HUMAN_TASK_TYPE2 varchar2(32),
     IMAGE_REFERENCE_ID varchar2(100),
     INSTANCE_STATUS varchar2(32),
     LAST_UPDATE_BY varchar2(100),
     LAST_UPDATE_DT varchar2(19),
     LETTER_DEFINITION_ID1 varchar2(100),
     LETTER_DEFINITION_ID2 varchar2(100),
     LETTER_DEFINITION_ID3 varchar2(100),
     NOTIFY_INVALID_IND varchar2(1),
     NOTIFY_OUTCOME_IND varchar2(1),
     ORIGIN varchar2(30),
     ORIGIN_ID varchar2(100),
     OUTCOME_NOTIFICATION_TASK_ID varchar2(100),
     OUTREACH_ID varchar2(100),
     OUTREACH_REQ_CATEGORY varchar2(128),
     OUTREACH_REQ_TYPE varchar2(128),
     OUTREACH_STATUS varchar2(128),
     OUTREACH_STATUS_DT varchar2(19),
     OUTREACH_STEP1_TYPE varchar2(30),
     OUTREACH_STEP2_TYPE varchar2(30),
     OUTREACH_STEP3_TYPE varchar2(30),
     OUTREACH_STEP4_TYPE varchar2(30),
     OUTREACH_STEP5_TYPE varchar2(30),
     OUTREACH_STEP6_TYPE varchar2(30),
     PRIORITY varchar2(80),
     PROGRAM_TYPE varchar2(30),
     PROVREF_FOLLOWUP_LEAD_TEST varchar2(4000),
     PROVREF_MISSED_APPT_DT varchar2(4000),
     PROVREF_MISSED_APPT_IND varchar2(4000),
     PROVREF_MISSED_APPT_OUTCOME varchar2(4000),
     PROVREF_MISSED_APPT_REASON varchar2(4000),
     PROVREF_MISSED_APPT_TYPE varchar2(4000),
     PROVREF_OTHER_COMMENT varchar2(4000),
     PROVREF_OTHER_IND varchar2(4000),
     PROVREF_PROVIDER_CITY varchar2(4000),
     PROVREF_PROVIDER_CLINIC_NAME varchar2(4000),
     PROVREF_PROVIDER_COUNTY varchar2(4000),
     PROVREF_PROVIDER_DT_REFERRED varchar2(4000),
     PROVREF_PROVIDER_TYPE varchar2(4000),
     PROVREF_PROVIDER_ZIP varchar2(4000),
     PROVREF_SCHEDULE_ASSIST varchar2(4000),
     PROVREF_TRANSPORT_ASSIST varchar2(4000),
     PROVREF_UPDATE_ADDRESS varchar2(4000),
     RECEIPT_DT varchar2(19),
     REMINDER_APPT_DT varchar2(4000),
     REMINDER_APPT_TYPE varchar2(4000),
     REMINDER_PROVIDER_NAME varchar2(4000),
     SERVICE_AREA varchar2(32),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM_TYPE varchar2(30),
     SURVEY_ID varchar2(100),
     SURVEY_NAME varchar2(256),
     TRACKING_NUMBER varchar2(32),
     VALIDATION_ERROR varchar2(50),
     CPW_NAME_OF_REFERRER VARCHAR2(4000),
     CPW_REFERRAL_SOURCE_PHONE VARCHAR2(4000)
    );
    
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
     
     
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
    
end;
/


create or replace 
package body CLIENT_OUTREACH as

  v_bem_id number := 15; -- 'Client Outreach'
  v_bil_id number := 15; -- 'Outreach Request ID'
  v_bsl_id number := 15; -- 'CORP_ETL_CLNT_OUTREACH'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dcorcur_job_name varchar2(30) := 'CALC_DCORCUR';
  
  
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
    
       
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
  
  
  function GET_SLA_DAYS
    (p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2,
     p_outreach_step in varchar2)
    return varchar2 result_cache
  is
    v_sla_days varchar(30);
  begin
  
    begin
    
      if p_process IN('OUTREACH_REQUEST_9','OUTREACH_REQUEST_12','OUTREACH_REQUEST_13') then 
     
        select TIMELINESS
        into v_sla_days 
        from CORP_CLNT_OUTREACH_NOTIFY_LKUP
        where 
          OUTREACH_CATEGORY_DESC = p_outreach_category
          and OUTREACH_TYPE_DESC = p_outreach_type  
          and OUTREACH_ACTIVITY = p_outreach_step;
       
      else
     
        select MAX(TIMELINESS)
        into v_sla_days 
        from CORP_CLNT_OUTREACH_NOTIFY_LKUP
        where 
          OUTREACH_CATEGORY_DESC = p_outreach_category
          and OUTREACH_TYPE_DESC = p_outreach_type  
          and TIMELINESS is not null;
       
      end if;
     
    exception
    
      when no_data_found then
        v_sla_days := null;
        
    end;
   
    return v_sla_days;
    
  end;
  
  
  function GET_SLA_DAYS_TYPE
    return varchar2 result_cache
  is
    v_sla_days_type varchar(10);
  begin 
  
    select VALUE
    into v_sla_days_type 
    from CORP_ETL_CONTROL
    where NAME = 'CLIENT_OUTREACH_SLA_DAYS_TYPE';
  
    return v_sla_days_type;
   
  end;
  
  
  function jeopardy_days
    (p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2)
   return number result_cache
  is
    v_jeopardy_days number;
  begin
 
   begin
   
     select JEOPARDY 
     into v_jeopardy_days 
     from CORP_CLNT_OUTREACH_NOTIFY_LKUP
     where 
       OUTREACH_CATEGORY_DESC = p_outreach_category
       and OUTREACH_TYPE_DESC = p_outreach_type  
       and JEOPARDY is not null;
    
   exception
   
     when no_data_found then
       v_jeopardy_days := null;
       
   end;        
   
   return v_jeopardy_days;
    
  end;


FUNCTION GET_JEOPARDY_DATE(
      p_create_date    IN DATE,
      p_process IN VARCHAR2,
      p_outreach_category IN VARCHAR2,
      p_outreach_type IN VARCHAR2 
      )
    RETURN date
 IS
  v_jeopardy_days number;
  BEGIN
   
   v_jeopardy_days := JEOPARDY_DAYS(p_process,p_outreach_category,p_outreach_type);
   
   IF v_jeopardy_days IS NOT NULL THEN
      RETURN get_bus_date(p_create_date,v_jeopardy_days);
   ELSE
      RETURN null ;
   END IF;    
  END;
  
  
  function GET_JEOPARDY_FLAG     
    (p_create_date in date,
     p_process in varchar2,
     p_outreach_category in varchar2,
     p_outreach_type in varchar2)
    return varchar2
  is
    v_jeopardy_date date;
  begin
  
    v_jeopardy_date := GET_JEOPARDY_DATE(p_create_date,p_process,p_outreach_category,p_outreach_type);
    
    if v_jeopardy_date is not null and sysdate >= v_jeopardy_date then
      return 'Y';
    else
      return 'N' ;
    end if;
    
  end;
  
  
  function GET_CYCLE_TIME
    (p_create_date   in date,
     p_complete_date in date)
    return number
  as
  begin
  
  if p_complete_date is not null then
    return trunc(p_complete_date) - trunc(p_create_date);
  else 
    return null;
  end if;
  
end;


FUNCTION GET_TIMELINE_STATUS(
      p_create_date    IN DATE,
      p_process IN VARCHAR2,
      p_outreach_category IN VARCHAR2,
      p_outreach_type IN VARCHAR2,            
      p_ased_outreach_step1 IN DATE,      
      p_ased_outreach_step2 IN DATE,      
      p_ased_outreach_step3 IN DATE,      
      p_ased_outreach_step4 IN DATE,      
      p_ased_outreach_step5 IN DATE,
      p_outreach_step6 IN VARCHAR2,
      p_ased_outreach_step6 IN DATE,
      p_reminder_appt_dt IN DATE,
      p_complete_date IN DATE,
      p_outreach_status IN VARCHAR2
     )
    RETURN VARCHAR2
  IS    
  v_timeliness   varchar(50) ;  
  v_sla_days1 NUMBER;
  v_sla_days2 NUMBER;
  v_sla_days3 NUMBER;
  v_sla_date DATE;
BEGIN
    -- Timeliness for Process 9
    IF p_process = 'OUTREACH_REQUEST_9' THEN      
       BEGIN
       
        SELECT /*+ RESULT_CACHE +*/ timeliness
        INTO v_sla_days1 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Automated Call 1';
        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days1 := NULL;
       END;
      
       --BEGIN       
        --SELECT /*+ RESULT_CACHE +*/ timeliness
        /* INTO v_sla_days2 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Automated Call 2';
        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days2 := NULL;
       END; */
      
       BEGIN
       
        SELECT /*+ RESULT_CACHE +*/ timeliness
        INTO v_sla_days3 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = p_outreach_step6;
        
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           v_sla_days3 := NULL;
       END;
       -- check timeliness for first step 
       IF v_sla_days1 IS NOT NULL THEN
         IF p_ased_outreach_step2 IS NOT NULL THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step2) <=  v_sla_days1 THEN
             v_timeliness := 'Timely';
           ELSE
             v_timeliness := 'Untimely';
           END IF;
         ELSE
           v_timeliness := 'Not Processed';
         END IF;
       ELSE
         v_timeliness := 'Not Required';
       END IF;
      
       IF v_timeliness = 'Timely' THEN
       --check timeliness for second step.  first step should have already been completed at this time.
       /*  IF v_sla_days2 IS NOT NULL THEN
           IF p_ased_outreach_step5 IS NOT NULL THEN
             IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step5) <=  v_sla_days2 THEN
               v_timeliness := 'Timely';
             ELSE
               v_timeliness := 'Untimely';
             END IF;
           END IF;
         ELSE
           v_timeliness := 'Not Required';
         END IF;  */
         
         IF v_timeliness = 'Timely' THEN
           --check timeliness for third step.  second step should have already been completed at this time.
           IF v_sla_days3 IS NOT NULL THEN
             IF p_ased_outreach_step3 IS NOT NULL THEN
               IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  v_sla_days3 THEN
                 v_timeliness := 'Timely';
               ELSE
                 v_timeliness := 'Untimely';
               END IF;
             END IF;
           ELSE
             v_timeliness := 'Not Required';
           END IF;   
         END IF;
       END IF;
      
       -- just a catchall in case outreach is already completed, Outreach is successful but end dates are null (this should not happen)
       IF p_complete_date IS NOT NULL THEN
         IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
            v_timeliness := 'Not Applicable';
         ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_complete_date) <= v_sla_days3 THEN
             v_timeliness := 'Timely';    
           ELSE
             v_timeliness := 'Untimely';    
           END IF;
         END IF;
       END IF;       
    
    ELSIF p_process IN('OUTREACH_REQUEST_12','OUTREACH_REQUEST_13')  THEN   
    -- Process 12 and 13
       BEGIN       
        SELECT /*+ RESULT_CACHE +*/ timeliness
        INTO v_sla_days1 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Letter';        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days1 := NULL;
       END;
      
       BEGIN       
        SELECT /*+ RESULT_CACHE +*/ timeliness
        INTO v_sla_days2 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity IN('Phone Call2','Phone Call3');
        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days2 := NULL;
       END;
      
       BEGIN       
        SELECT /*+ RESULT_CACHE +*/ timeliness
        INTO v_sla_days3 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Home Visit';
        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days3 := NULL;
       END;
    
       -- check timeliness for first step 
       IF v_sla_days1 IS NOT NULL THEN
         IF p_ased_outreach_step1 IS NOT NULL THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  v_sla_days1 THEN
             v_timeliness := 'Timely';
           ELSE
             v_timeliness := 'Untimely';
           END IF;
         ELSE
           v_timeliness := 'Not Processed';
         END IF;
       ELSE
         v_timeliness := 'Not Required';
       END IF;
      
       IF v_timeliness = 'Timely' THEN
       --check timeliness for second step.  first step should have already been completed at this time.
         IF v_sla_days2 IS NOT NULL THEN
           IF p_ased_outreach_step3 IS NOT NULL THEN
             IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  v_sla_days2 THEN
               v_timeliness := 'Timely';
             ELSE
               v_timeliness := 'Untimely';
             END IF;
           END IF;
         ELSE
           v_timeliness := 'Not Required';
         END IF;  
         IF p_process = 'OUTREACH_REQUEST_13' THEN
           --applies only to Process 13
           IF v_timeliness = 'Timely' THEN
             --check timeliness for third step.  second step should have already been completed at this time.
             IF v_sla_days3 IS NOT NULL THEN 
               IF p_ased_outreach_step4 IS NOT NULL THEN
                 IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step4) <=  v_sla_days3 THEN
                   v_timeliness := 'Timely';
                 ELSE
                   v_timeliness := 'Untimely';
                 END IF;
               END IF;
             ELSE
               v_timeliness := 'Not Required';
             END IF;   
           END IF;  
         END IF;
                
         IF v_timeliness = 'Timely' THEN
           --check timeliness for third/fourth step.  second/third step should have already been completed at this time.
           IF v_sla_days1 IS NOT NULL THEN
             IF p_ased_outreach_step5 IS NOT NULL THEN
               IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step5) <=  v_sla_days1 THEN
                 v_timeliness := 'Timely';
               ELSE
                 v_timeliness := 'Untimely';
               END IF;
             END IF;
           ELSE
             v_timeliness := 'Not Required';
           END IF;   
         END IF;
       END IF;
      
       -- just a catchall in case outreach is already completed, Outreach is successful but end dates are null (this should not happen)
       IF p_complete_date IS NOT NULL THEN
         IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
            v_timeliness := 'Not Applicable';
         ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_complete_date) <= v_sla_days1 THEN
             v_timeliness := 'Timely';    
           ELSE
             v_timeliness := 'Untimely';    
           END IF;
         END IF;
       END IF;     
    --end Process 12 and 13       
    ELSE
      BEGIN
      
        SELECT /*+ RESULT_CACHE +*/ MAX(timeliness)
        INTO v_sla_days1 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type;
        
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days1 := NULL;
      END;
        
      IF v_sla_days1 IS NOT NULL THEN
        --Timeliness for Process 1
        IF p_process = 'OUTREACH_REQUEST_1' THEN               
          IF p_ased_outreach_step1 IS NOT NULL THEN       
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  v_sla_days1 THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF; 
        --TXEB-5438 8/17 process 11 separated from process 1
        ELSIF p_process = 'OUTREACH_REQUEST_11' THEN               
          IF p_ased_outreach_step3 IS NOT NULL THEN       
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  v_sla_days1 THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;           
        --Timeliness for Process2
        ELSIF p_process IN('OUTREACH_REQUEST_2','OUTREACH_REQUEST_4') THEN        
          IF p_ased_outreach_step3 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  v_sla_days1 THEN
              v_timeliness := 'Timely';           
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step4 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step4) <=  v_sla_days1 THEN
                v_timeliness := 'Timely';           
              ELSE
                v_timeliness := 'Untimely';
              END IF;
            END IF;                
          END IF;
        --Timeliness for Process 3
        ELSIF p_process = 'OUTREACH_REQUEST_3' THEN  
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF p_reminder_appt_dt IS NOT NULL THEN
              IF p_ased_outreach_step1 <= get_bus_date(p_reminder_appt_dt, -1*v_sla_days1) THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF;
            ELSE
              v_timeliness := 'Not Required'; --appointment date missing
            END IF;
          ELSE
            v_timeliness := 'Not Processed';  -- if step1 is not done yet, then the following steps are also not done
          END IF;
          
          IF v_timeliness = 'Timely' THEN
            --only check the rest of the steps if step 1 is Timely
            IF p_ased_outreach_step2 IS NOT NULL THEN
              IF p_ased_outreach_step2 <= get_bus_date(p_reminder_appt_dt, -1*v_sla_days1) THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF;          
            END IF;          
            
            IF v_timeliness = 'Timely' THEN
              IF p_ased_outreach_step3 IS NOT NULL THEN
                IF p_ased_outreach_step3 <= get_bus_date(p_reminder_appt_dt, -1*v_sla_days1) THEN
                  v_timeliness := 'Timely';
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            END IF;  
          END IF;          
          
          -- just a catchall in case outreach is already completed, Outreach is successful but end dates are null (this should not happen)
          IF p_complete_date IS NOT NULL THEN
            IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
              v_timeliness := 'Not Applicable';
            ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' AND p_reminder_appt_dt is not null THEN      
              IF p_complete_date <=  get_bus_date(p_reminder_appt_dt, -1*v_sla_days1) THEN
                v_timeliness := 'Timely';              
              ELSE
                v_timeliness := 'Untimely';              
              END IF;
            ELSE
              v_timeliness := null;    
            END IF;
          END IF;          
       
        --Timeliness for Process 5
        ELSIF p_process = 'OUTREACH_REQUEST_5' THEN          
        --  v_sla_date := TO_DATE('10-'||TO_CHAR(p_assd_outreach_step1,'MON-YY'),'DD-MON-YY');
          v_sla_date := get_bus_date(p_create_date,v_sla_days1);                                    

          IF p_ased_outreach_step1 IS NOT NULL THEN            
            IF p_ased_outreach_step1 <= v_sla_date THEN
              v_timeliness := 'Timely';          
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            IF p_complete_date IS NOT NULL THEN              
              IF p_outreach_status IN('Withdrawn','Outreach No Longer Required') THEN
                v_timeliness := 'Not Applicable';
              ELSIF p_outreach_status = 'Outreach Successful' THEN
                IF p_complete_date <= v_sla_date THEN
                  v_timeliness := 'Timely'; 
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            ELSE
              v_timeliness := 'Not Processed';
            END IF;
          END IF;           
          
       --Timeliness for Process 6 or 7
        ELSIF p_process IN('OUTREACH_REQUEST_6','OUTREACH_REQUEST_7') THEN  
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  v_sla_days1 THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
          
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step3 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  v_sla_days1 THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF;
            END IF;
          END IF;       
         
          IF p_process = 'OUTREACH_REQUEST_6' THEN
            IF v_timeliness = 'Timely' THEN
              IF p_ased_outreach_step5 IS NOT NULL THEN
                IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step5) <=  v_sla_days1 THEN
                  v_timeliness := 'Timely';
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            END IF;         
          END IF;  
        --Timeliness for Process 8 or 10
        ELSIF p_process IN('OUTREACH_REQUEST_8','OUTREACH_REQUEST_10') THEN
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  v_sla_days1 THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
         
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step2 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step2) <=  v_sla_days1 THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF; 
            END IF;
          END IF;
        END IF;        
        
        --catch all for other processes to check if timeliness still needs to be calculated
        IF p_process NOT IN('OUTREACH_REQUEST_3','OUTREACH_REQUEST_5') THEN
          IF p_complete_date IS NOT NULL THEN
            IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
              v_timeliness := 'Not Applicable';
            ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_complete_date) <= v_sla_days1 THEN
                v_timeliness := 'Timely';    
              ELSE
                v_timeliness := 'Untimely';    
              END IF;
            END IF;
          END IF;
        END IF;
                
      ELSE  
        --no sla days found for the particular outreach category/type
        v_timeliness := 'Not Required';
      END IF;  
            
    END IF;    
    
    RETURN v_timeliness;   
 END;   


  -- Calculate column values in BPM Semantic table D_COR_CURRENT.
  procedure CALC_DCORCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DCORCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
    
  begin
  
    update D_COR_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      SLA_DAYS = GET_SLA_DAYS(GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE,OUTREACH_STEP_6_TYPE),
      SLA_DAYS_TYPE = GET_SLA_DAYS_TYPE,
      SLA_JEOPARDY_DAYS = JEOPARDY_DAYS(GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE),
      SLA_JEOPARDY_DATE = GET_JEOPARDY_DATE(CREATE_DATE,GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(CREATE_DATE,GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE),
      TIMELINESS_STATUS = GET_TIMELINE_STATUS(CREATE_DATE,GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE,
                                              PERFORM_OR_STEP1_END_DATE,PERFORM_OR_STEP2_END_DATE,
                                              PERFORM_OR_STEP3_END_DATE,PERFORM_OR_STEP4_END_DATE,PERFORM_OR_STEP5_END_DATE,
                                              OUTREACH_STEP_3_TYPE,PERFORM_OR_STEP6_END_DATE,
                                              to_date(REMINDER_APPOINTMENT_DATE,'mm/dd/yy'),COMPLETE_DATE,OUTREACH_REQUEST_STATUS),
      CYCLE_TIME = GET_CYCLE_TIME(CREATE_DATE,COMPLETE_DATE)
    where 
      COMPLETE_DATE is null 
      and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
    
    commit;

    v_log_message := v_num_rows_updated  || ' D_COR_CURRENT rows updated with calculated attributes by CALC_DCORCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
    
  exception
  
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;


  -- Get dimension ID for BPM Semantic model - Client Outreach process - COUNTY.
  procedure GET_DCORCI_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_county in varchar2,
      p_dcorci_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCORCI_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DCORCI_ID
     into p_dcorci_id
     from D_COR_COUNTY
     where 
       COUNTY = p_county 
       or (COUNTY is null and p_county is null);
      
   exception

     when NO_DATA_FOUND then

       p_dcorci_id := SEQ_DCORCI_ID.nextval;
       begin
         insert into D_COR_COUNTY (DCORCI_ID,COUNTY)
         values (p_dcorci_id,p_county);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DCORCI_ID into p_dcorci_id
           from D_COR_COUNTY
           where 
             COUNTY = p_county 
       or (COUNTY is null and p_county is null);
             
         when OTHERS then

           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
           raise;

       end;

     when OTHERS then
     
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
       raise;
       
  end;
    
  -- Get dimension ID for BPM Semantic model - Client Outreach process - SURVEY_ID.
  procedure GET_DCORSI_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_survey_id in number,
      p_dcorsi_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCORSI_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DCORSI_ID
     into p_dcorsi_id
     from D_COR_SURVEY_ID
     where 
       SURVEY_ID = p_survey_id 
       or (SURVEY_ID is null and p_survey_id is null);
      
   exception

     when NO_DATA_FOUND then

       p_dcorsi_id := SEQ_DCORSI_ID.nextval;
       begin
         insert into D_COR_SURVEY_ID (DCORSI_ID,SURVEY_ID)
         values (p_dcorsi_id,p_survey_id);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DCORSI_ID into p_dcorsi_id
           from D_COR_SURVEY_ID
           where 
             SURVEY_ID = p_survey_id 
       or (SURVEY_ID is null and p_survey_id is null);
             
         when OTHERS then

           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
           raise;

       end;

     when OTHERS then
     
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
       raise;
       
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Client Outreach process - REQUEST_STATUS.
  procedure GET_DCORRS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_outreach_request_status in varchar2,
      p_dcorrs_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCORRS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DCORRS_ID
     into p_dcorrs_id
     from D_COR_REQUEST_STATUS
     where 
       OUTREACH_REQUEST_STATUS = p_outreach_request_status 
       or (OUTREACH_REQUEST_STATUS is null and p_outreach_request_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dcorrs_id := SEQ_DCORRS_ID.nextval;
       begin
         insert into D_COR_REQUEST_STATUS (DCORRS_ID,OUTREACH_REQUEST_STATUS)
         values (p_dcorrs_id,p_outreach_request_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DCORRS_ID into p_dcorrs_id
           from D_COR_REQUEST_STATUS
           where 
             OUTREACH_REQUEST_STATUS = p_outreach_request_status 
       or (OUTREACH_REQUEST_STATUS is null and p_outreach_request_status is null);
             
         when OTHERS then

           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
           raise;

       end;

     when OTHERS then
     
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
       raise;
       
  end;
  
  
  -- Get record for Client Outreach insert XML.
  procedure GET_INS_COR_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_COR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_COR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  

    select
          extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_CLIENT') "ASED_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_SOURCE') "ASED_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP1') "ASED_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP2') "ASED_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP3') "ASED_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP4') "ASED_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP5') "ASED_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP6') "ASED_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_HOME_VISIT') "ASED_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_OUTREACH') "ASED_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TERMINATION_TIMER') "ASED_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_VALIDATE_OUTREACH_REQ') "ASED_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT') "ASF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_SOURCE') "ASF_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP1') "ASF_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP2') "ASF_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP3') "ASF_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP4') "ASF_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP5') "ASF_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP6') "ASF_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_HOME_VISIT') "ASF_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_OUTREACH') "ASF_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TERMINATION_TIMER') "ASF_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_VALIDATE_OUTREACH_REQ') "ASF_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_CLIENT') "ASPB_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_SOURCE') "ASPB_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP1') "ASPB_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP2') "ASPB_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP3') "ASPB_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP4') "ASPB_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP5') "ASPB_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP6') "ASPB_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_HOME_VISIT') "ASPB_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_OUTREACH') "ASPB_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_OUTREACH_REQ') "ASPB_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT') "ASSD_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_SOURCE') "ASSD_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP1') "ASSD_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP2') "ASSD_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP3') "ASSD_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP4') "ASSD_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP5') "ASSD_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP6') "ASSD_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_HOME_VISIT') "ASSD_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_OUTREACH') "ASSD_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TERMINATION_TIMER') "ASSD_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_VALIDATE_OUTREACH_REQ') "ASSD_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CECO_ID') "CEPA_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_CARETAKER_REPORT') "CHECKUP_CARETAKER_REPORT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_DT') "CHECKUP_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_PROVIDER_NAME') "CHECKUP_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_TX_WORKS_ADVISOR') "CHECKUP_TX_WORKS_ADVISOR",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_TYPE') "CHECKUP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_NOTIFICATION_ID') "CLIENT_NOTIFICATION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY') "COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_CALL_BACK_IND') "CPW_CALL_BACK_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_DT') "CPW_REFERRAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_PRIORITY_STATUS') "CPW_REFERRAL_PRIORITY_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_REASON') "CPW_REFERRAL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_NAME') "CPW_REFERRAL_SOURCE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_TYPE') "CPW_REFERRAL_SOURCE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_ID') "CURR_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_STATUS') "CURR_TASK_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_TYPE') "CURR_TASK_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS1') "DELAY_DAYS1",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS1_UNIT') "DELAY_DAYS1_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS2') "DELAY_DAYS2",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS2_UNIT') "DELAY_DAYS2_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS3') "DELAY_DAYS3",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS3_UNIT') "DELAY_DAYS3_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_HELP_FIND_PROV_IND') "EXEFF_HELP_FIND_PROV_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_HOME_VISIT_IND') "EXEFF_HOME_VISIT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_INTERPRETER_IND') "EXEFF_INTERPRETER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_LANGUAGE') "EXEFF_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MAIL_IND') "EXEFF_MAIL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_CASEMGMT_IND') "EXEFF_MORE_INFO_CASEMGMT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_DENT_IND') "EXEFF_MORE_INFO_DENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_IND') "EXEFF_MORE_INFO_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_MED_IND') "EXEFF_MORE_INFO_MED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_OTHER_IND') "EXEFF_OTHER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_OTHER_LANGUAGE_IND') "EXEFF_OTHER_LANGUAGE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_PHONE_IND') "EXEFF_PHONE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_SCHEDULE_APPT_IND') "EXEFF_SCHEDULE_APPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_TRANSPORT_IND') "EXEFF_TRANSPORT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_DAYS') "FINAL_WAIT_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_IND') "FINAL_WAIT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_UNIT') "FINAL_WAIT_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD1') "GENERIC_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD2') "GENERIC_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD3') "GENERIC_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD4') "GENERIC_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD5') "GENERIC_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FINAL_WAIT') "GWF_FINAL_WAIT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_INVALID') "GWF_INVALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_CLIENT') "GWF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_SOURCE') "GWF_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP2_REQUIRED') "GWF_STEP2_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP3_REQUIRED') "GWF_STEP3_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP4_REQUIRED') "GWF_STEP4_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP5_REQUIRED') "GWF_STEP5_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP6_REQUIRED') "GWF_STEP6_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_UNSUCCESSFUL') "GWF_UNSUCCESSFUL",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_INTERPRETER_IND') "HOME_VISIT_INTERPRETER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_LANGUAGE') "HOME_VISIT_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_NOT_ENG_IND') "HOME_VISIT_NOT_ENG_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_REASON') "HOME_VISIT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/HUMAN_TASK_TYPE1') "HUMAN_TASK_TYPE1",
      extractValue(p_data_xml,'/ROWSET/ROW/HUMAN_TASK_TYPE2') "HUMAN_TASK_TYPE2",
      extractValue(p_data_xml,'/ROWSET/ROW/IMAGE_REFERENCE_ID') "IMAGE_REFERENCE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY') "LAST_UPDATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID1') "LETTER_DEFINITION_ID1",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID2') "LETTER_DEFINITION_ID2",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID3') "LETTER_DEFINITION_ID3",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_INVALID_IND') "NOTIFY_INVALID_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_OUTCOME_IND') "NOTIFY_OUTCOME_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN') "ORIGIN",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN_ID') "ORIGIN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_NOTIFICATION_TASK_ID') "OUTCOME_NOTIFICATION_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_ID') "OUTREACH_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_REQ_CATEGORY') "OUTREACH_REQ_CATEGORY",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_REQ_TYPE') "OUTREACH_REQ_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STATUS') "OUTREACH_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STATUS_DT') "OUTREACH_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP1_TYPE') "OUTREACH_STEP1_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP2_TYPE') "OUTREACH_STEP2_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP3_TYPE') "OUTREACH_STEP3_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP4_TYPE') "OUTREACH_STEP4_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP5_TYPE') "OUTREACH_STEP5_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP6_TYPE') "OUTREACH_STEP6_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_FOLLOWUP_LEAD_TEST') "PROVREF_FOLLOWUP_LEAD_TEST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_DT') "PROVREF_MISSED_APPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_IND') "PROVREF_MISSED_APPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_OUTCOME') "PROVREF_MISSED_APPT_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_REASON') "PROVREF_MISSED_APPT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_TYPE') "PROVREF_MISSED_APPT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_OTHER_COMMENT') "PROVREF_OTHER_COMMENT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_OTHER_IND') "PROVREF_OTHER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_CITY') "PROVREF_PROVIDER_CITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_CLINIC_NAME') "PROVREF_PROVIDER_CLINIC_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_COUNTY') "PROVREF_PROVIDER_COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_DT_REFERRED') "PROVREF_PROVIDER_DT_REFERRED",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_TYPE') "PROVREF_PROVIDER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_ZIP') "PROVREF_PROVIDER_ZIP",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_SCHEDULE_ASSIST') "PROVREF_SCHEDULE_ASSIST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_TRANSPORT_ASSIST') "PROVREF_TRANSPORT_ASSIST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_UPDATE_ADDRESS') "PROVREF_UPDATE_ADDRESS",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_APPT_DT') "REMINDER_APPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_APPT_TYPE') "REMINDER_APPT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_PROVIDER_NAME') "REMINDER_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SERVICE_AREA') "SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM_TYPE') "SUBPROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_ID') "SURVEY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_NAME') "SURVEY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/VALIDATION_ERROR') "VALIDATION_ERROR",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_NAME_OF_REFERRER') "CPW_NAME_OF_REFERRER",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_PHONE') "CPW_REFERRAL_SOURCE_PHONE"
    into p_data_record
    from dual;
  
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise; 
      
  end;
    
    
  -- Get record for Client Outreach update XML. 
  procedure GET_UPD_COR_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_COR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_COR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
  
    select
           extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_CLIENT') "ASED_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_SOURCE') "ASED_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP1') "ASED_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP2') "ASED_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP3') "ASED_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP4') "ASED_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP5') "ASED_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_OUTREACH_STEP6') "ASED_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_HOME_VISIT') "ASED_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_OUTREACH') "ASED_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TERMINATION_TIMER') "ASED_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_VALIDATE_OUTREACH_REQ') "ASED_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT') "ASF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_SOURCE') "ASF_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP1') "ASF_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP2') "ASF_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP3') "ASF_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP4') "ASF_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP5') "ASF_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_OUTREACH_STEP6') "ASF_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_HOME_VISIT') "ASF_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_OUTREACH') "ASF_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TERMINATION_TIMER') "ASF_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_VALIDATE_OUTREACH_REQ') "ASF_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_CLIENT') "ASPB_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_SOURCE') "ASPB_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP1') "ASPB_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP2') "ASPB_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP3') "ASPB_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP4') "ASPB_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP5') "ASPB_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_OUTREACH_STEP6') "ASPB_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_HOME_VISIT') "ASPB_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_OUTREACH') "ASPB_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_OUTREACH_REQ') "ASPB_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT') "ASSD_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_SOURCE') "ASSD_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP1') "ASSD_OUTREACH_STEP1",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP2') "ASSD_OUTREACH_STEP2",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP3') "ASSD_OUTREACH_STEP3",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP4') "ASSD_OUTREACH_STEP4",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP5') "ASSD_OUTREACH_STEP5",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_OUTREACH_STEP6') "ASSD_OUTREACH_STEP6",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_HOME_VISIT') "ASSD_PERFORM_HOME_VISIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_OUTREACH') "ASSD_PERFORM_OUTREACH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TERMINATION_TIMER') "ASSD_TERMINATION_TIMER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_VALIDATE_OUTREACH_REQ') "ASSD_VALIDATE_OUTREACH_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_CARETAKER_REPORT') "CHECKUP_CARETAKER_REPORT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_DT') "CHECKUP_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_PROVIDER_NAME') "CHECKUP_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_TX_WORKS_ADVISOR') "CHECKUP_TX_WORKS_ADVISOR",
      extractValue(p_data_xml,'/ROWSET/ROW/CHECKUP_TYPE') "CHECKUP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_NOTIFICATION_ID') "CLIENT_NOTIFICATION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY') "COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_CALL_BACK_IND') "CPW_CALL_BACK_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_DT') "CPW_REFERRAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_PRIORITY_STATUS') "CPW_REFERRAL_PRIORITY_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_REASON') "CPW_REFERRAL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_NAME') "CPW_REFERRAL_SOURCE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_TYPE') "CPW_REFERRAL_SOURCE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_ID') "CURR_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_STATUS') "CURR_TASK_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_TASK_TYPE') "CURR_TASK_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS1') "DELAY_DAYS1",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS1_UNIT') "DELAY_DAYS1_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS2') "DELAY_DAYS2",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS2_UNIT') "DELAY_DAYS2_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS3') "DELAY_DAYS3",
      extractValue(p_data_xml,'/ROWSET/ROW/DELAY_DAYS3_UNIT') "DELAY_DAYS3_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_HELP_FIND_PROV_IND') "EXEFF_HELP_FIND_PROV_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_HOME_VISIT_IND') "EXEFF_HOME_VISIT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_INTERPRETER_IND') "EXEFF_INTERPRETER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_LANGUAGE') "EXEFF_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MAIL_IND') "EXEFF_MAIL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_CASEMGMT_IND') "EXEFF_MORE_INFO_CASEMGMT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_DENT_IND') "EXEFF_MORE_INFO_DENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_IND') "EXEFF_MORE_INFO_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_MORE_INFO_MED_IND') "EXEFF_MORE_INFO_MED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_OTHER_IND') "EXEFF_OTHER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_OTHER_LANGUAGE_IND') "EXEFF_OTHER_LANGUAGE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_PHONE_IND') "EXEFF_PHONE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_SCHEDULE_APPT_IND') "EXEFF_SCHEDULE_APPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/EXEFF_TRANSPORT_IND') "EXEFF_TRANSPORT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_DAYS') "FINAL_WAIT_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_IND') "FINAL_WAIT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/FINAL_WAIT_UNIT') "FINAL_WAIT_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD1') "GENERIC_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD2') "GENERIC_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD3') "GENERIC_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD4') "GENERIC_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD5') "GENERIC_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FINAL_WAIT') "GWF_FINAL_WAIT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_INVALID') "GWF_INVALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_CLIENT') "GWF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_SOURCE') "GWF_NOTIFY_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP2_REQUIRED') "GWF_STEP2_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP3_REQUIRED') "GWF_STEP3_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP4_REQUIRED') "GWF_STEP4_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP5_REQUIRED') "GWF_STEP5_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STEP6_REQUIRED') "GWF_STEP6_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_UNSUCCESSFUL') "GWF_UNSUCCESSFUL",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_INTERPRETER_IND') "HOME_VISIT_INTERPRETER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_LANGUAGE') "HOME_VISIT_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_NOT_ENG_IND') "HOME_VISIT_NOT_ENG_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HOME_VISIT_REASON') "HOME_VISIT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/HUMAN_TASK_TYPE1') "HUMAN_TASK_TYPE1",
      extractValue(p_data_xml,'/ROWSET/ROW/HUMAN_TASK_TYPE2') "HUMAN_TASK_TYPE2",
      extractValue(p_data_xml,'/ROWSET/ROW/IMAGE_REFERENCE_ID') "IMAGE_REFERENCE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY') "LAST_UPDATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID1') "LETTER_DEFINITION_ID1",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID2') "LETTER_DEFINITION_ID2",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_DEFINITION_ID3') "LETTER_DEFINITION_ID3",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_INVALID_IND') "NOTIFY_INVALID_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_OUTCOME_IND') "NOTIFY_OUTCOME_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN') "ORIGIN",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN_ID') "ORIGIN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_NOTIFICATION_TASK_ID') "OUTCOME_NOTIFICATION_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_ID') "OUTREACH_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_REQ_CATEGORY') "OUTREACH_REQ_CATEGORY",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_REQ_TYPE') "OUTREACH_REQ_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STATUS') "OUTREACH_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STATUS_DT') "OUTREACH_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP1_TYPE') "OUTREACH_STEP1_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP2_TYPE') "OUTREACH_STEP2_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP3_TYPE') "OUTREACH_STEP3_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP4_TYPE') "OUTREACH_STEP4_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP5_TYPE') "OUTREACH_STEP5_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_STEP6_TYPE') "OUTREACH_STEP6_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_FOLLOWUP_LEAD_TEST') "PROVREF_FOLLOWUP_LEAD_TEST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_DT') "PROVREF_MISSED_APPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_IND') "PROVREF_MISSED_APPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_OUTCOME') "PROVREF_MISSED_APPT_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_REASON') "PROVREF_MISSED_APPT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_MISSED_APPT_TYPE') "PROVREF_MISSED_APPT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_OTHER_COMMENT') "PROVREF_OTHER_COMMENT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_OTHER_IND') "PROVREF_OTHER_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_CITY') "PROVREF_PROVIDER_CITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_CLINIC_NAME') "PROVREF_PROVIDER_CLINIC_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_COUNTY') "PROVREF_PROVIDER_COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_DT_REFERRED') "PROVREF_PROVIDER_DT_REFERRED",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_TYPE') "PROVREF_PROVIDER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_PROVIDER_ZIP') "PROVREF_PROVIDER_ZIP",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_SCHEDULE_ASSIST') "PROVREF_SCHEDULE_ASSIST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_TRANSPORT_ASSIST') "PROVREF_TRANSPORT_ASSIST",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVREF_UPDATE_ADDRESS') "PROVREF_UPDATE_ADDRESS",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_APPT_DT') "REMINDER_APPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_APPT_TYPE') "REMINDER_APPT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/REMINDER_PROVIDER_NAME') "REMINDER_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SERVICE_AREA') "SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM_TYPE') "SUBPROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_ID') "SURVEY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_NAME') "SURVEY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/VALIDATION_ERROR') "VALIDATION_ERROR",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_NAME_OF_REFERRER') "CPW_NAME_OF_REFERRER",
      extractValue(p_data_xml,'/ROWSET/ROW/CPW_REFERRAL_SOURCE_PHONE') "CPW_REFERRAL_SOURCE_PHONE"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;
  
  
  -- Insert fact for BPM Semantic model - Client Outreach process. 
    procedure INS_FCORBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dcorci_id in number,
       p_dcorrs_id in number,
       p_dcorsi_id in number,
       p_outreach_request_status_date varchar2,
       --p_stg_last_update_date in varchar2,
       p_fcorbd_id out number) 
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FCORBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      --v_stg_last_update_date date := null;
      v_outreach_request_status_date date := null;
    begin
    
      --v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_outreach_request_status_date := to_date(p_outreach_request_status_date,BPM_COMMON.DATE_FMT);
      p_fcorbd_id := SEQ_FCORBD_ID.nextval;
      
      v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
      if p_end_date is null then
        v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      else 
        v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      end if;
      
      -- Validate fact date ranges.
      if p_start_date < v_bucket_start_date
        or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_bucket_end_date
        or v_bucket_start_date > v_bucket_end_date
        or v_bucket_end_date < v_bucket_start_date
      then
        v_sql_code := -20030;
        v_log_message := 'Attempted to insert invalid fact date range.  ' || 
          'D_DATE = ' || p_start_date || 
          ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
          ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
      insert into F_COR_BY_DATE
        (FCORBD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         COR_BI_ID,
         DCORCI_ID,
         DCORRS_ID,
         DCORSI_ID,
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT,
         OUTREACH_REQUEST_STATUS_DATE)
      values
        (p_fcorbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dcorci_id,
         p_dcorrs_id,
         p_dcorsi_id,
         1,
         case 
         when p_end_date is null then 1
         else 0
         end,
         case 
           when p_end_date is null then 0
           else 1
           end,
         v_outreach_request_status_date
        );
        
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
 
  
  -- Insert or update dimension for BPM Semantic model - Client Outreach process - Current.
  procedure SET_DCORCUR
    (p_set_type in varchar2,
     p_identifier  in varchar2,
     p_bi_id in number,
     p_outreach_request_id	in number,
     p_tracking_number	in varchar2,
     p_receipt_date	in varchar2,
     p_origin	in varchar2,
     p_origin_id	in number,
     p_create_date	in varchar2,
     p_created_by	in varchar2,
     p_outreach_request_category	in varchar2,
     p_outreach_request_type	in varchar2,
     p_priority	in varchar2,
     p_case_id	in number,
     p_client_id	in number,
     p_service_area	in varchar2,
     p_county	in varchar2,
     p_program_type	in varchar2,
     p_subprogram_type	in varchar2,
     p_outreach_request_status	in varchar2,
     p_outreach_request_status_date	in varchar2,
     p_validation_error	in varchar2,
     p_notify_invalid_indicator	in varchar2,
     p_outreach_step_1_type	in varchar2,
     p_outreach_step_2_type	in varchar2,
     p_outreach_step_3_type	in varchar2,
     p_outreach_step_4_type	in varchar2,
     p_outreach_step_5_type	in varchar2,
     p_outreach_step_6_type	in varchar2,
     p_current_task_id	in number,
     p_current_task_type	in varchar2,
     p_current_task_status	in varchar2,
     p_survey_id	in number,
     p_survey_template_name	in varchar2,
     p_cpw_referral_date	in varchar2,
     p_cpw_referral_source_type	in varchar2,
     p_cpw_referral_source_name	in varchar2,
     p_cpw_referral_reason	in varchar2,
     p_cpw_call_back_indicator	in varchar2,
     p_cpw_priority_status_referral	in varchar2,
     p_provref_provider_type	in varchar2,
     p_provref_provider_clinic_name	in varchar2,
     p_provref_provider_city	in varchar2,
     p_provref_provider_county	in varchar2,
     p_provref_provider_zip_code	in varchar2,
     p_provref_prov_date_referred	in varchar2,
     p_provref_missed_appt_ind	in varchar2,
     p_provref_missed_appt_date	in varchar2,
     p_provref_missed_appt_type	in varchar2,
     p_provref_missed_appt_outcome	in varchar2,
     p_provref_missed_appt_reason	in varchar2,
     p_provref_lead_test_ind	in varchar2,
     p_provref_assist_with_trans	in varchar2,
     p_provref_asst_scheduling_appt	in varchar2,
     p_provref_upd_patient_address	in varchar2,
     p_provref_other	in varchar2,
     p_provref_other_comment	in varchar2,
     p_checkup_type	in varchar2,
     p_checkup_texas_works_adv_name	in varchar2,
     p_checkup_caretaker_rpts_chkup	in varchar2,
     p_checkup_provider_name	in varchar2,
     p_checkup_date_reported_chkp	in varchar2,
     p_ee_schedule_thsteps_appt_ind	in varchar2,
     p_ee_transportation_indicator	in varchar2,
     p_ee_need_more_info_indicator	in varchar2,
     p_ee_need_more_info_medical	in varchar2,
     p_ee_need_more_info_dental	in varchar2,
     p_ee_need_more_info_case_mgmt	in varchar2,
     p_ee_help_finding_provider_ind	in varchar2,
     p_ee_phone_indicator	in varchar2,
     p_ee_hv_indicator	in varchar2,
     p_ee_mail_indicator	in varchar2,
     p_ee_other_language_indicator	in varchar2,
     p_ee_interpreter_needed_ind	in varchar2,
     p_ee_language	in varchar2,
     p_hv_request_reason	in varchar2,
     p_hv_lang_other_than_eng_ind	in varchar2,
     p_hv_interpreter_needed_ind	in varchar2,
     p_hv_language	in varchar2,
     p_reminder_appointment_type	in varchar2,
     p_reminder_appointment_date	in varchar2,
     p_reminder_prov_clinic_name	in varchar2,
     p_delay_days_1	in number,
     p_delay_days_1_unit	in varchar2,
     p_delay_days_2	in number,
     p_delay_days_2_unit	in varchar2,
     p_delay_days_3	in number,
     p_delay_days_3_unit	in varchar2,
     p_letter_definition_1	in number,
     p_letter_definition_2	in number,
     p_letter_definition_3	in number,
     p_human_task_type_1	in varchar2,
     p_human_task_type_2	in varchar2,
     p_generic_field_1	in varchar2,
     p_generic_field_2	in varchar2,
     p_generic_field_3	in varchar2,
     p_generic_field_4	in varchar2,
     p_generic_field_5	in varchar2,
     p_notify_outcome_indicator	in varchar2,
     p_client_notification_id	in number,
     p_outcome_notification_task_id	in number,
     p_last_update_date	in varchar2,
     p_last_update_by	in varchar2,
     p_final_wait_indicator	in varchar2,
     p_final_wait	in number,
     p_final_wait_unit	in varchar2,
     p_complete_date	in varchar2,
     p_cancel_date	in varchar2,
     p_cancel_by	in varchar2,
     p_cancel_reason	in varchar2,
     p_cancel_method	in varchar2,
     p_instance_status	in varchar2,
     p_validate_or_start_date	in varchar2,
     p_validate_or_end_date	in varchar2,
     p_validate_or_perform_by	in varchar2,
     p_perform_outreach_start_date	in varchar2,
     p_perform_outreach_end_date	in varchar2,
     p_perform_outreach_perform_by	in varchar2,
     p_perform_or_step1_start_date	in varchar2,
     p_perform_or_step1_end_date	in varchar2,
     p_perform_or_step1_perform_by	in varchar2,
     p_perform_or_step2_start_date	in varchar2,
     p_perform_or_step2_end_date	in varchar2,
     p_perform_or_step2_perform_by	in varchar2,
     p_perform_or_step3_start_date	in varchar2,
     p_perform_or_step3_end_date	in varchar2,
     p_perform_or_step3_perform_by	in varchar2,
     p_perform_or_step4_start_date	in varchar2,
     p_perform_or_step4_end_date	in varchar2,
     p_perform_or_step4_perform_by	in varchar2,
     p_perform_or_step5_start_date	in varchar2,
     p_perform_or_step5_end_date	in varchar2,
     p_perform_or_step5_perform_by	in varchar2,
     p_perform_or_step6_start_date	in varchar2,
     p_perform_or_step6_end_date	in varchar2,
     p_perform_or_step6_perform_by	in varchar2,
     p_perform_hv_start_date	in varchar2,
     p_perform_hv_end_date	in varchar2,
     p_perform_hv_perform_by	in varchar2,
     p_wait_for_tt_start_date	in varchar2,
     p_wait_for_tt_end_date	in varchar2,
     p_notify_client_start_date	in varchar2,
     p_notify_client_end_date	in varchar2,
     p_notify_client_perform_by	in varchar2,
     p_notify_ref_source_start_date	in varchar2,
     p_notify_ref_source_end_date	in varchar2,
     p_notify_ref_source_perform_by	in varchar2,
     p_invalid_flag	in varchar2,
     p_outreach_step_2_flag	in varchar2,
     p_outreach_step_3_flag	in varchar2,
     p_outreach_step_4_flag	in varchar2,
     p_outreach_step_5_flag	in varchar2,
     p_outreach_step_6_flag	in varchar2,
     p_unsuccessful_flag	in varchar2,
     p_final_wait_flag	in varchar2,
     p_send_client_notfication_flag	in varchar2,
     p_notify_source_flag	in varchar2,
     p_validate_request_flag	in varchar2,
     p_perform_outreach_flag	in varchar2,
     p_notify_client_flag	in varchar2,
     p_notify_referral_source_flag	in varchar2,
     p_perform_or_step1_flag	in varchar2,
     p_perform_or_step2_flag	in varchar2,
     p_perform_or_step3_flag	in varchar2,
     p_perform_or_step4_flag	in varchar2,
     p_perform_or_step5_flag	in varchar2,
     p_perform_or_step6_flag	in varchar2,
     p_home_visit_flag	in varchar2,
     p_termination_timer_flag	in varchar2,
     p_ee_other_indicator	in varchar2,
     p_cpw_name_of_referrer      IN VARCHAR2,
     p_cpw_referral_source_phone IN VARCHAR2,
     p_image_reference_id in number 
    )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DCORCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dcorcur D_COR_CURRENT%rowtype := null;
    --v_jeopardy_flag varchar2(1) := null; 
  begin
    r_dcorcur.COR_BI_ID := p_bi_id;
    r_dcorcur.OUTREACH_REQUEST_ID	:=	p_outreach_request_id	;
    r_dcorcur.TRACKING_NUMBER	:=	p_tracking_number	;
    r_dcorcur.RECEIPT_DATE	:=	to_date(p_receipt_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.ORIGIN	:=	p_origin	;
    r_dcorcur.ORIGIN_ID	:=	p_origin_id	;
    r_dcorcur.CREATE_DATE	:=	to_date(p_create_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.CREATED_BY	:=	p_created_by	;
    r_dcorcur.OUTREACH_REQUEST_CATEGORY	:=	p_outreach_request_category	;
    r_dcorcur.OUTREACH_REQUEST_TYPE	:=	p_outreach_request_type	;
    r_dcorcur.PRIORITY	:=	p_priority	;
    r_dcorcur.CASE_ID	:=	p_case_id	;
    r_dcorcur.CLIENT_ID	:=	p_client_id	;
    r_dcorcur.SERVICE_AREA	:=	p_service_area	;
    r_dcorcur.COUNTY	:=	p_county	;
    r_dcorcur.PROGRAM_TYPE	:=	p_program_type	;
    r_dcorcur.SUBPROGRAM_TYPE	:=	p_subprogram_type	;
    r_dcorcur.OUTREACH_REQUEST_STATUS	:=	p_outreach_request_status	;
    r_dcorcur.OUTREACH_REQUEST_STATUS_DATE	:=	to_date(p_outreach_request_status_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.VALIDATION_ERROR	:=	p_validation_error	;
    r_dcorcur.NOTIFY_INVALID_INDICATOR	:=	p_notify_invalid_indicator	;
    r_dcorcur.OUTREACH_STEP_1_TYPE	:=	p_outreach_step_1_type	;
    r_dcorcur.OUTREACH_STEP_2_TYPE	:=	p_outreach_step_2_type	;
    r_dcorcur.OUTREACH_STEP_3_TYPE	:=	p_outreach_step_3_type	;
    r_dcorcur.OUTREACH_STEP_4_TYPE	:=	p_outreach_step_4_type	;
    r_dcorcur.OUTREACH_STEP_5_TYPE	:=	p_outreach_step_5_type	;
    r_dcorcur.OUTREACH_STEP_6_TYPE	:=	p_outreach_step_6_type	;
    r_dcorcur.CURRENT_TASK_ID	:=	p_current_task_id	;
    r_dcorcur.CURRENT_TASK_TYPE	:=	p_current_task_type	;
    r_dcorcur.CURRENT_TASK_STATUS	:=	p_current_task_status	;
    r_dcorcur.SURVEY_ID	:=	p_survey_id	;
    r_dcorcur.SURVEY_TEMPLATE_NAME	:=	p_survey_template_name	;
    r_dcorcur.CPW_REFERRAL_DATE	:=	p_cpw_referral_date	;
    r_dcorcur.CPW_REFERRAL_SOURCE_TYPE	:=	p_cpw_referral_source_type	;
    r_dcorcur.CPW_REFERRAL_SOURCE_NAME	:=	p_cpw_referral_source_name	;
    r_dcorcur.CPW_REFERRAL_REASON	:=	p_cpw_referral_reason	;
    r_dcorcur.CPW_CALL_BACK_INDICATOR	:=	p_cpw_call_back_indicator	;
    r_dcorcur.CPW_PRIORITY_STATUS_REFERRAL	:=	p_cpw_priority_status_referral	;
    r_dcorcur.PROVREF_PROVIDER_TYPE	:=	p_provref_provider_type	;
    r_dcorcur.PROVREF_PROVIDER_CLINIC_NAME	:=	p_provref_provider_clinic_name	;
    r_dcorcur.PROVREF_PROVIDER_CITY	:=	p_provref_provider_city	;
    r_dcorcur.PROVREF_PROVIDER_COUNTY	:=	p_provref_provider_county	;
    r_dcorcur.PROVREF_PROVIDER_ZIP_CODE	:=	p_provref_provider_zip_code	;
    r_dcorcur.PROVREF_PROV_DATE_REFERRED	:=	p_provref_prov_date_referred	;
    r_dcorcur.PROVREF_MISSED_APPT_IND	:=	p_provref_missed_appt_ind	;
    r_dcorcur.PROVREF_MISSED_APPT_DATE	:=	p_provref_missed_appt_date	;
    r_dcorcur.PROVREF_MISSED_APPT_TYPE	:=	p_provref_missed_appt_type	;
    r_dcorcur.PROVREF_MISSED_APPT_OUTCOME	:=	p_provref_missed_appt_outcome	;
    r_dcorcur.PROVREF_MISSED_APPT_REASON	:=	p_provref_missed_appt_reason	;
    r_dcorcur.PROVREF_LEAD_TEST_IND	:=	p_provref_lead_test_ind	;
    r_dcorcur.PROVREF_ASSIST_WITH_TRANS	:=	p_provref_assist_with_trans	;
    r_dcorcur.PROVREF_ASST_SCHEDULING_APPT	:=	p_provref_asst_scheduling_appt	;
    r_dcorcur.PROVREF_UPD_PATIENT_ADDRESS	:=	p_provref_upd_patient_address	;
    r_dcorcur.PROVREF_OTHER	:=	p_provref_other	;
    r_dcorcur.PROVREF_OTHER_COMMENT	:=	p_provref_other_comment	;
    r_dcorcur.CHECKUP_TYPE	:=	p_checkup_type	;
    r_dcorcur.CHECKUP_TEXAS_WORKS_ADV_NAME	:=	p_checkup_texas_works_adv_name	;
    r_dcorcur.CHECKUP_CARETAKER_RPTS_CHKUP	:=	p_checkup_caretaker_rpts_chkup	;
    r_dcorcur.CHECKUP_PROVIDER_NAME	:=	p_checkup_provider_name	;
    r_dcorcur.CHECKUP_DATE_REPORTED_CHKP	:=	p_checkup_date_reported_chkp	;
    r_dcorcur.EE_SCHEDULE_THSTEPS_APPT_IND	:=	p_ee_schedule_thsteps_appt_ind	;
    r_dcorcur.EE_TRANSPORTATION_INDICATOR	:=	p_ee_transportation_indicator	;
    r_dcorcur.EE_NEED_MORE_INFO_INDICATOR	:=	p_ee_need_more_info_indicator	;
    r_dcorcur.EE_NEED_MORE_INFO_MEDICAL	:=	p_ee_need_more_info_medical	;
    r_dcorcur.EE_NEED_MORE_INFO_DENTAL	:=	p_ee_need_more_info_dental	;
    r_dcorcur.EE_NEED_MORE_INFO_CASE_MGMT	:=	p_ee_need_more_info_case_mgmt	;
    r_dcorcur.EE_HELP_FINDING_PROVIDER_IND	:=	p_ee_help_finding_provider_ind	;
    r_dcorcur.EE_PHONE_INDICATOR	:=	p_ee_phone_indicator	;
    r_dcorcur.EE_HV_INDICATOR	:=	p_ee_hv_indicator	;
    r_dcorcur.EE_MAIL_INDICATOR	:=	p_ee_mail_indicator	;
    r_dcorcur.EE_OTHER_LANGUAGE_INDICATOR	:=	p_ee_other_language_indicator	;
    r_dcorcur.EE_INTERPRETER_NEEDED_IND	:=	p_ee_interpreter_needed_ind	;
    r_dcorcur.EE_LANGUAGE	:=	p_ee_language	;
    r_dcorcur.HV_REQUEST_REASON	:=	p_hv_request_reason	;
    r_dcorcur.HV_LANG_OTHER_THAN_ENG_IND	:=	p_hv_lang_other_than_eng_ind	;
    r_dcorcur.HV_INTERPRETER_NEEDED_IND	:=	p_hv_interpreter_needed_ind	;
    r_dcorcur.HV_LANGUAGE	:=	p_hv_language	;
    r_dcorcur.REMINDER_APPOINTMENT_TYPE	:=	p_reminder_appointment_type	;
    r_dcorcur.REMINDER_APPOINTMENT_DATE	:=	p_reminder_appointment_date	;
    r_dcorcur.REMINDER_PROV_CLINIC_NAME	:=	p_reminder_prov_clinic_name	;
    r_dcorcur.DELAY_DAYS_1	:=	p_delay_days_1	;
    r_dcorcur.DELAY_DAYS_1_UNIT	:=	p_delay_days_1_unit	;
    r_dcorcur.DELAY_DAYS_2	:=	p_delay_days_2	;
    r_dcorcur.DELAY_DAYS_2_UNIT	:=	p_delay_days_2_unit	;
    r_dcorcur.DELAY_DAYS_3	:=	p_delay_days_3	;
    r_dcorcur.DELAY_DAYS_3_UNIT	:=	p_delay_days_3_unit	;
    r_dcorcur.LETTER_DEFINITION_1	:=	p_letter_definition_1	;
    r_dcorcur.LETTER_DEFINITION_2	:=	p_letter_definition_2	;
    r_dcorcur.LETTER_DEFINITION_3	:=	p_letter_definition_3	;
    r_dcorcur.HUMAN_TASK_TYPE_1	:=	p_human_task_type_1	;
    r_dcorcur.HUMAN_TASK_TYPE_2	:=	p_human_task_type_2	;
    r_dcorcur.GENERIC_FIELD_1	:=	p_generic_field_1	;
    r_dcorcur.GENERIC_FIELD_2	:=	p_generic_field_2	;
    r_dcorcur.GENERIC_FIELD_3	:=	p_generic_field_3	;
    r_dcorcur.GENERIC_FIELD_4	:=	p_generic_field_4	;
    r_dcorcur.GENERIC_FIELD_5	:=	p_generic_field_5	;
    r_dcorcur.NOTIFY_OUTCOME_INDICATOR	:=	p_notify_outcome_indicator	;
    r_dcorcur.CLIENT_NOTIFICATION_ID	:=	p_client_notification_id	;
    r_dcorcur.OUTCOME_NOTIFICATION_TASK_ID	:=	p_outcome_notification_task_id	;
    r_dcorcur.LAST_UPDATE_DATE	:=	to_date(p_last_update_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.LAST_UPDATE_BY	:=	p_last_update_by	;
    r_dcorcur.FINAL_WAIT_INDICATOR	:=	p_final_wait_indicator	;
    r_dcorcur.FINAL_WAIT	:=	p_final_wait	;
    r_dcorcur.FINAL_WAIT_UNIT	:=	p_final_wait_unit	;
    r_dcorcur.COMPLETE_DATE	:=	to_date(p_complete_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.CANCEL_DATE	:=	to_date(p_cancel_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.CANCEL_BY	:=	p_cancel_by	;
    r_dcorcur.CANCEL_REASON	:=	p_cancel_reason	;
    r_dcorcur.CANCEL_METHOD	:=	p_cancel_method	;
    r_dcorcur.INSTANCE_STATUS	:=	p_instance_status	;
    r_dcorcur.VALIDATE_OR_START_DATE	:=	to_date(p_validate_or_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.VALIDATE_OR_END_DATE	:=	to_date(p_validate_or_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.VALIDATE_OR_PERFORM_BY	:=	p_validate_or_perform_by	;
    r_dcorcur.PERFORM_OUTREACH_START_DATE	:=	to_date(p_perform_outreach_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OUTREACH_END_DATE	:=	to_date(p_perform_outreach_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OUTREACH_PERFORM_BY	:=	p_perform_outreach_perform_by	;
    r_dcorcur.PERFORM_OR_STEP1_START_DATE	:=	to_date(p_perform_or_step1_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP1_END_DATE	:=	to_date(p_perform_or_step1_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP1_PERFORM_BY	:=	p_perform_or_step1_perform_by	;
    r_dcorcur.PERFORM_OR_STEP2_START_DATE	:=	to_date(p_perform_or_step2_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP2_END_DATE	:=	to_date(p_perform_or_step2_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP2_PERFORM_BY	:=	p_perform_or_step2_perform_by	;
    r_dcorcur.PERFORM_OR_STEP3_START_DATE	:=	to_date(p_perform_or_step3_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP3_END_DATE	:=	to_date(p_perform_or_step3_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP3_PERFORM_BY	:=	p_perform_or_step3_perform_by	;
    r_dcorcur.PERFORM_OR_STEP4_START_DATE	:=	to_date(p_perform_or_step4_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP4_END_DATE	:=	to_date(p_perform_or_step4_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP4_PERFORM_BY	:=	p_perform_or_step4_perform_by	;
    r_dcorcur.PERFORM_OR_STEP5_START_DATE	:=	to_date(p_perform_or_step5_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP5_END_DATE	:=	to_date(p_perform_or_step5_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP5_PERFORM_BY	:=	p_perform_or_step5_perform_by	;
    r_dcorcur.PERFORM_OR_STEP6_START_DATE	:=	to_date(p_perform_or_step6_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP6_END_DATE	:=	to_date(p_perform_or_step6_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_OR_STEP6_PERFORM_BY	:=	p_perform_or_step6_perform_by	;
    r_dcorcur.PERFORM_HV_START_DATE	:=	to_date(p_perform_hv_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_HV_END_DATE	:=	to_date(p_perform_hv_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.PERFORM_HV_PERFORM_BY	:=	p_perform_hv_perform_by	;
    r_dcorcur.WAIT_FOR_TT_START_DATE	:=	to_date(p_wait_for_tt_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.WAIT_FOR_TT_END_DATE	:=	to_date(p_wait_for_tt_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.NOTIFY_CLIENT_START_DATE	:=	to_date(p_notify_client_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.NOTIFY_CLIENT_END_DATE	:=	to_date(p_notify_client_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.NOTIFY_CLIENT_PERFORM_BY	:=	p_notify_client_perform_by	;
    r_dcorcur.NOTIFY_REF_SOURCE_START_DATE	:=	to_date(p_notify_ref_source_start_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.NOTIFY_REF_SOURCE_END_DATE	:=	to_date(p_notify_ref_source_end_date,BPM_COMMON.DATE_FMT)	;
    r_dcorcur.NOTIFY_REF_SOURCE_PERFORM_BY	:=	p_notify_ref_source_perform_by	;
    
    r_dcorcur.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_dcorcur.CREATE_DATE,r_dcorcur.COMPLETE_DATE);
    r_dcorcur.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_dcorcur.CREATE_DATE,r_dcorcur.COMPLETE_DATE);
    r_dcorcur.SLA_DAYS := GET_SLA_DAYS(p_generic_field_2,p_outreach_request_category,p_outreach_request_type,p_outreach_step_6_type);
    r_dcorcur.SLA_DAYS_TYPE := GET_SLA_DAYS_TYPE;
    r_dcorcur.SLA_JEOPARDY_DAYS := JEOPARDY_DAYS(p_generic_field_2,p_outreach_request_category,p_outreach_request_type);
    r_dcorcur.SLA_JEOPARDY_DATE := GET_JEOPARDY_DATE(r_dcorcur.CREATE_DATE,p_generic_field_2,p_outreach_request_category,p_outreach_request_type);
    r_dcorcur.JEOPARDY_FLAG := GET_JEOPARDY_FLAG(r_dcorcur.CREATE_DATE,p_generic_field_2,p_outreach_request_category,p_outreach_request_type);
    r_dcorcur.TIMELINESS_STATUS := GET_TIMELINE_STATUS(r_dcorcur.CREATE_DATE,p_generic_field_2,p_outreach_request_category,p_outreach_request_type,
                                                       r_dcorcur.PERFORM_OR_STEP1_END_DATE, r_dcorcur.PERFORM_OR_STEP2_END_DATE,
                                                       r_dcorcur.PERFORM_OR_STEP3_END_DATE, r_dcorcur.PERFORM_OR_STEP4_END_DATE,
                                                       r_dcorcur.PERFORM_OR_STEP5_END_DATE, p_outreach_step_6_type,r_dcorcur.PERFORM_OR_STEP6_END_DATE,
                                                       TO_DATE(r_dcorcur.REMINDER_APPOINTMENT_DATE,'mm/dd/yy'),r_dcorcur.COMPLETE_DATE,p_outreach_request_status);
    r_dcorcur.CYCLE_TIME := GET_CYCLE_TIME(r_dcorcur.CREATE_DATE,r_dcorcur.COMPLETE_DATE);
    
    r_dcorcur.INVALID_FLAG	:=	p_invalid_flag	;
    r_dcorcur.OUTREACH_STEP_2_FLAG	:=	p_outreach_step_2_flag	;
    r_dcorcur.OUTREACH_STEP_3_FLAG	:=	p_outreach_step_3_flag	;
    r_dcorcur.OUTREACH_STEP_4_FLAG	:=	p_outreach_step_4_flag	;
    r_dcorcur.OUTREACH_STEP_5_FLAG	:=	p_outreach_step_5_flag	;
    r_dcorcur.OUTREACH_STEP_6_FLAG	:=	p_outreach_step_6_flag	;
    r_dcorcur.UNSUCCESSFUL_FLAG	:=	p_unsuccessful_flag	;
    r_dcorcur.FINAL_WAIT_FLAG	:=	p_final_wait_flag	;
    r_dcorcur.SEND_CLIENT_NOTFICATION_FLAG	:=	p_send_client_notfication_flag	;
    r_dcorcur.NOTIFY_SOURCE_FLAG	:=	p_notify_source_flag	;
    r_dcorcur.VALIDATE_REQUEST_FLAG	:=	p_validate_request_flag	;
    r_dcorcur.PERFORM_OUTREACH_FLAG	:=	p_perform_outreach_flag	;
    r_dcorcur.NOTIFY_CLIENT_FLAG	:=	p_notify_client_flag	;
    r_dcorcur.NOTIFY_REFERRAL_SOURCE_FLAG	:=	p_notify_referral_source_flag	;
    r_dcorcur.PERFORM_OR_STEP1_FLAG	:=	p_perform_or_step1_flag	;
    r_dcorcur.PERFORM_OR_STEP2_FLAG	:=	p_perform_or_step2_flag	;
    r_dcorcur.PERFORM_OR_STEP3_FLAG	:=	p_perform_or_step3_flag	;
    r_dcorcur.PERFORM_OR_STEP4_FLAG	:=	p_perform_or_step4_flag	;
    r_dcorcur.PERFORM_OR_STEP5_FLAG	:=	p_perform_or_step5_flag	;
    r_dcorcur.PERFORM_OR_STEP6_FLAG	:=	p_perform_or_step6_flag	;
    r_dcorcur.HOME_VISIT_FLAG	:=	p_home_visit_flag	;
    r_dcorcur.TERMINATION_TIMER_FLAG	:=	p_termination_timer_flag	;
    r_dcorcur.EE_OTHER_INDICATOR	:=	p_ee_other_indicator	;
    r_dcorcur.CPW_NAME_OF_REFERRER	:=	p_cpw_name_of_referrer ;
    r_dcorcur.CPW_REFERRAL_SOURCE_PHONE	:=	p_cpw_referral_source_phone ;
    r_dcorcur.IMAGE_REFERENCE_ID	:=	p_image_reference_id	;
      
    if p_set_type = 'INSERT' then
      insert into D_COR_CURRENT
      values r_dcorcur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_COR_CURRENT
        set row = r_dcorcur
        where COR_BI_ID = p_bi_id;
      end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
      
  exception
    
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end;
  
  
  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_new_data T_INS_COR_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dcorci_id number := null; 
    v_dcorrs_id number := null;
    v_dcorsi_id number := null;
    v_fcorbd_id number := null;   
  begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for  Client Outreach in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_COR_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.OUTREACH_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    v_bi_id := SEQ_BI_ID.nextval;
  
    GET_DCORCI_ID(v_identifier,v_bi_id,v_new_data.COUNTY,v_dcorci_id);
    GET_DCORRS_ID(v_identifier,v_bi_id,v_new_data.OUTREACH_STATUS,v_dcorrs_id);
    GET_DCORSI_ID(v_identifier,v_bi_id,v_new_data.SURVEY_ID,v_dcorsi_id);
       
    -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
         
      SET_DCORCUR
        ('INSERT',v_identifier,v_bi_id,
         v_new_data.OUTREACH_ID,
v_new_data.TRACKING_NUMBER,
v_new_data.RECEIPT_DT,
v_new_data.ORIGIN,
v_new_data.ORIGIN_ID,
v_new_data.CREATE_DT,
v_new_data.CREATED_BY,
v_new_data.OUTREACH_REQ_CATEGORY,
v_new_data.OUTREACH_REQ_TYPE,
v_new_data.PRIORITY,
v_new_data.CASE_ID,
v_new_data.CLIENT_ID,
v_new_data.SERVICE_AREA,
v_new_data.COUNTY,
v_new_data.PROGRAM_TYPE,
v_new_data.SUBPROGRAM_TYPE,
v_new_data.OUTREACH_STATUS,
v_new_data.OUTREACH_STATUS_DT,
v_new_data.VALIDATION_ERROR,
v_new_data.NOTIFY_INVALID_IND,
v_new_data.OUTREACH_STEP1_TYPE,
v_new_data.OUTREACH_STEP2_TYPE,
v_new_data.OUTREACH_STEP3_TYPE,
v_new_data.OUTREACH_STEP4_TYPE,
v_new_data.OUTREACH_STEP5_TYPE,
v_new_data.OUTREACH_STEP6_TYPE,
v_new_data.CURR_TASK_ID,
v_new_data.CURR_TASK_TYPE,
v_new_data.CURR_TASK_STATUS,
v_new_data.SURVEY_ID,
v_new_data.SURVEY_NAME,
v_new_data.CPW_REFERRAL_DT,
v_new_data.CPW_REFERRAL_SOURCE_TYPE,
v_new_data.CPW_REFERRAL_SOURCE_NAME,
v_new_data.CPW_REFERRAL_REASON,
v_new_data.CPW_CALL_BACK_IND,
v_new_data.CPW_REFERRAL_PRIORITY_STATUS,
v_new_data.PROVREF_PROVIDER_TYPE,
v_new_data.PROVREF_PROVIDER_CLINIC_NAME,
v_new_data.PROVREF_PROVIDER_CITY,
v_new_data.PROVREF_PROVIDER_COUNTY,
v_new_data.PROVREF_PROVIDER_ZIP,
v_new_data.PROVREF_PROVIDER_DT_REFERRED,
v_new_data.PROVREF_MISSED_APPT_IND,
v_new_data.PROVREF_MISSED_APPT_DT,
v_new_data.PROVREF_MISSED_APPT_TYPE,
v_new_data.PROVREF_MISSED_APPT_OUTCOME,
v_new_data.PROVREF_MISSED_APPT_REASON,
v_new_data.PROVREF_FOLLOWUP_LEAD_TEST,
v_new_data.PROVREF_TRANSPORT_ASSIST,
v_new_data.PROVREF_SCHEDULE_ASSIST,
v_new_data.PROVREF_UPDATE_ADDRESS,
v_new_data.PROVREF_OTHER_IND,
v_new_data.PROVREF_OTHER_COMMENT,
v_new_data.CHECKUP_TYPE,
v_new_data.CHECKUP_TX_WORKS_ADVISOR,
v_new_data.CHECKUP_CARETAKER_REPORT,
v_new_data.CHECKUP_PROVIDER_NAME,
v_new_data.CHECKUP_DT,
v_new_data.EXEFF_SCHEDULE_APPT_IND,
v_new_data.EXEFF_TRANSPORT_IND,
v_new_data.EXEFF_MORE_INFO_IND,
v_new_data.EXEFF_MORE_INFO_MED_IND,
v_new_data.EXEFF_MORE_INFO_DENT_IND,
v_new_data.EXEFF_MORE_INFO_CASEMGMT_IND,
v_new_data.EXEFF_HELP_FIND_PROV_IND,
v_new_data.EXEFF_PHONE_IND,
v_new_data.EXEFF_HOME_VISIT_IND,
v_new_data.EXEFF_MAIL_IND,
v_new_data.EXEFF_OTHER_LANGUAGE_IND,
v_new_data.EXEFF_INTERPRETER_IND,
v_new_data.EXEFF_LANGUAGE,
v_new_data.HOME_VISIT_REASON,
v_new_data.HOME_VISIT_NOT_ENG_IND,
v_new_data.HOME_VISIT_INTERPRETER_IND,
v_new_data.HOME_VISIT_LANGUAGE,
v_new_data.REMINDER_APPT_TYPE,
v_new_data.REMINDER_APPT_DT,
v_new_data.REMINDER_PROVIDER_NAME,
v_new_data.DELAY_DAYS1,
v_new_data.DELAY_DAYS1_UNIT,
v_new_data.DELAY_DAYS2,
v_new_data.DELAY_DAYS2_UNIT,
v_new_data.DELAY_DAYS3,
v_new_data.DELAY_DAYS3_UNIT,
v_new_data.LETTER_DEFINITION_ID1,
v_new_data.LETTER_DEFINITION_ID2,
v_new_data.LETTER_DEFINITION_ID3,
v_new_data.HUMAN_TASK_TYPE1,
v_new_data.HUMAN_TASK_TYPE2,
v_new_data.GENERIC_FIELD1,
v_new_data.GENERIC_FIELD2,
v_new_data.GENERIC_FIELD3,
v_new_data.GENERIC_FIELD4,
v_new_data.GENERIC_FIELD5,
v_new_data.NOTIFY_OUTCOME_IND,
v_new_data.CLIENT_NOTIFICATION_ID,
v_new_data.OUTCOME_NOTIFICATION_TASK_ID,
v_new_data.LAST_UPDATE_DT,
v_new_data.LAST_UPDATE_BY,
v_new_data.FINAL_WAIT_IND,
v_new_data.FINAL_WAIT_DAYS,
v_new_data.FINAL_WAIT_UNIT,
v_new_data.COMPLETE_DT,
v_new_data.CANCEL_DT,
v_new_data.CANCEL_BY,
v_new_data.CANCEL_REASON,
v_new_data.CANCEL_METHOD,
v_new_data.INSTANCE_STATUS,
v_new_data.ASSD_VALIDATE_OUTREACH_REQ,
v_new_data.ASED_VALIDATE_OUTREACH_REQ,
v_new_data.ASPB_VALIDATE_OUTREACH_REQ,
v_new_data.ASSD_PERFORM_OUTREACH,
v_new_data.ASED_PERFORM_OUTREACH,
v_new_data.ASPB_PERFORM_OUTREACH,
v_new_data.ASSD_OUTREACH_STEP1,
v_new_data.ASED_OUTREACH_STEP1,
v_new_data.ASPB_OUTREACH_STEP1,
v_new_data.ASSD_OUTREACH_STEP2,
v_new_data.ASED_OUTREACH_STEP2,
v_new_data.ASPB_OUTREACH_STEP2,
v_new_data.ASSD_OUTREACH_STEP3,
v_new_data.ASED_OUTREACH_STEP3,
v_new_data.ASPB_OUTREACH_STEP3,
v_new_data.ASSD_OUTREACH_STEP4,
v_new_data.ASED_OUTREACH_STEP4,
v_new_data.ASPB_OUTREACH_STEP4,
v_new_data.ASSD_OUTREACH_STEP5,
v_new_data.ASED_OUTREACH_STEP5,
v_new_data.ASPB_OUTREACH_STEP5,
v_new_data.ASSD_OUTREACH_STEP6,
v_new_data.ASED_OUTREACH_STEP6,
v_new_data.ASPB_OUTREACH_STEP6,
v_new_data.ASSD_PERFORM_HOME_VISIT,
v_new_data.ASED_PERFORM_HOME_VISIT,
v_new_data.ASPB_PERFORM_HOME_VISIT,
v_new_data.ASSD_TERMINATION_TIMER,
v_new_data.ASED_TERMINATION_TIMER,
v_new_data.ASSD_NOTIFY_CLIENT,
v_new_data.ASED_NOTIFY_CLIENT,
v_new_data.ASPB_NOTIFY_CLIENT,
v_new_data.ASSD_NOTIFY_SOURCE,
v_new_data.ASED_NOTIFY_SOURCE,
v_new_data.ASPB_NOTIFY_SOURCE,
v_new_data.GWF_INVALID,
v_new_data.GWF_STEP2_REQUIRED,
v_new_data.GWF_STEP3_REQUIRED,
v_new_data.GWF_STEP4_REQUIRED,
v_new_data.GWF_STEP5_REQUIRED,
v_new_data.GWF_STEP6_REQUIRED,
v_new_data.GWF_UNSUCCESSFUL,
v_new_data.GWF_FINAL_WAIT,
v_new_data.GWF_NOTIFY_CLIENT,
v_new_data.GWF_NOTIFY_SOURCE,
v_new_data.ASF_VALIDATE_OUTREACH_REQ,
v_new_data.ASF_PERFORM_OUTREACH,
v_new_data.ASF_NOTIFY_CLIENT,
v_new_data.ASF_NOTIFY_SOURCE,
v_new_data.ASF_OUTREACH_STEP1,
v_new_data.ASF_OUTREACH_STEP2,
v_new_data.ASF_OUTREACH_STEP3,
v_new_data.ASF_OUTREACH_STEP4,
v_new_data.ASF_OUTREACH_STEP5,
v_new_data.ASF_OUTREACH_STEP6,
v_new_data.ASF_PERFORM_HOME_VISIT,
v_new_data.ASF_TERMINATION_TIMER,
v_new_data.EXEFF_OTHER_IND,
v_new_data.CPW_NAME_OF_REFERRER,
v_new_data.CPW_REFERRAL_SOURCE_PHONE,
v_new_data.IMAGE_REFERENCE_ID
         
        ); 
        
      INS_FCORBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dcorci_id,v_dcorrs_id,v_dcorsi_id,v_new_data.OUTREACH_STATUS_DT,v_fcorbd_id);
      
      commit;
            
    exception
          
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
        raise;
      
    end;
      
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
      raise; 
      
  end;
  
   
  -- Update fact for BPM Semantic model -  Client Outreach process. 
  procedure UPD_FCORBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dcorci_id in number,
     p_dcorrs_id in number,
     p_dcorsi_id in number,
     p_outreach_request_status_date varchar2,
     p_stg_last_update_date in varchar2,
     p_fcorbd_id out number) 
     
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FCORBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fcorbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_outreach_request_status_date date := null;
    v_event_date date := null;
    
    v_dcorci_id number := null;
    v_dcorrs_id number := null;
    v_dcorsi_id number := null;
    v_fcorbd_id number := null;

    r_fcorbd F_COR_BY_DATE%rowtype := null;
  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_outreach_request_status_date := to_date(p_outreach_request_status_date,BPM_COMMON.DATE_FMT);
    
    v_dcorci_id := p_dcorci_id;
    v_dcorrs_id := p_dcorrs_id;
    v_dcorsi_id := p_dcorsi_id;
    v_fcorbd_id := p_fcorbd_id;
    with most_recent_fact_bi_id as
      (select 
         max(FCORBD_ID) max_fcorbd_id,
         max(D_DATE) max_d_date
       from F_COR_BY_DATE
       where COR_BI_ID = p_bi_id) 
    select 
      fcorbd.FCORBD_ID,
      fcorbd.D_DATE,
      fcorbd.CREATION_COUNT,
      fcorbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fcorbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_COR_BY_DATE fcorbd,
      most_recent_fact_bi_id 
    where
      fcorbd.FCORBD_ID = max_fcorbd_id
      and fcorbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
      
    if p_end_date is null then
      r_fcorbd.D_DATE := v_event_date;
      r_fcorbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcorbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcorbd.INVENTORY_COUNT := 1;
      r_fcorbd.COMPLETION_COUNT := 0;
    else
      
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_COR_BY_DATE
        where 
          COR_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        with most_recent_fact_bi_id as
          (select 
             max(FCORBD_ID) max_fcorbd_id,
             max(D_DATE) max_d_date
           from F_COR_BY_DATE
           where COR_BI_ID = p_bi_id) 
        select 
          fcorbd.FCORBD_ID,
          fcorbd.D_DATE,
          fcorbd.CREATION_COUNT,
          fcorbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fcorbd.DCORCI_ID,
          fcorbd.DCORRS_ID,
          fcorbd.DCORSI_ID,
          fcorbd.OUTREACH_REQUEST_STATUS_DATE
        into 
          v_fcorbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dcorci_id,
          v_dcorrs_id,
          v_dcorsi_id,
          v_outreach_request_status_date 
        from 
          F_COR_BY_DATE fcorbd,
          most_recent_fact_bi_id 
        where
          fcorbd.FCORBD_ID = max_fcorbd_id
          and fcorbd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
      r_fcorbd.D_DATE := p_end_date;
      r_fcorbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcorbd.BUCKET_END_DATE := r_fcorbd.BUCKET_START_DATE;
      r_fcorbd.INVENTORY_COUNT := 0;
      r_fcorbd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fcorbd_id := SEQ_FCORBD_ID.nextval;
    r_fcorbd.FCORBD_ID := p_fcorbd_id;
    r_fcorbd.COR_BI_ID := p_bi_id;
    r_fcorbd.DCORCI_ID := v_dcorci_id;
    r_fcorbd.DCORRS_ID := v_dcorrs_id;
    r_fcorbd.DCORSI_ID := v_dcorsi_id;
    r_fcorbd.CREATION_COUNT := 0;
    r_fcorbd.OUTREACH_REQUEST_STATUS_DATE := v_outreach_request_status_date;
    
    -- Validate fact date ranges.
    if r_fcorbd.D_DATE < r_fcorbd.BUCKET_START_DATE
      or to_date(to_char(r_fcorbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fcorbd.BUCKET_END_DATE
      or r_fcorbd.BUCKET_START_DATE > r_fcorbd.BUCKET_END_DATE
      or r_fcorbd.BUCKET_END_DATE < r_fcorbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fcorbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fcorbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fcorbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fcorbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fcorbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_COR_BY_DATE
      set row = r_fcorbd
      where FCORBD_ID = v_fcorbd_id_old;
        
    else
    
      -- Different bucket time.
    
      update F_COR_BY_DATE
      set BUCKET_END_DATE = r_fcorbd.BUCKET_START_DATE
      where FCORBD_ID = v_fcorbd_id_old;
        
      insert into F_COR_BY_DATE
      values r_fcorbd;
      
    end if;
    
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);  
      raise; 
      
  end; 
  
  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_old_data T_UPD_COR_XML := null;
    v_new_data T_UPD_COR_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dcorci_id number := null;
    v_dcorrs_id number := null;
    v_dcorsi_id number := null;
    v_fcorbd_id number := null;
      
   
      
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Client Outreach in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_COR_XML(p_old_data_xml,v_old_data);
    GET_UPD_COR_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.OUTREACH_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT); 

    select COR_BI_ID 
    into v_bi_id
    from D_COR_CURRENT
    where OUTREACH_REQUEST_ID = v_identifier;

    GET_DCORCI_ID(v_identifier,v_bi_id,v_new_data.COUNTY,v_dcorci_id);
    GET_DCORRS_ID(v_identifier,v_bi_id,v_new_data.OUTREACH_STATUS,v_dcorrs_id);
    GET_DCORSI_ID(v_identifier,v_bi_id,v_new_data.SURVEY_ID,v_dcorsi_id);
    
    -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
         
      SET_DCORCUR
        ('UPDATE',v_identifier,v_bi_id,
                 v_new_data.OUTREACH_ID,
v_new_data.TRACKING_NUMBER,
v_new_data.RECEIPT_DT,
v_new_data.ORIGIN,
v_new_data.ORIGIN_ID,
v_new_data.CREATE_DT,
v_new_data.CREATED_BY,
v_new_data.OUTREACH_REQ_CATEGORY,
v_new_data.OUTREACH_REQ_TYPE,
v_new_data.PRIORITY,
v_new_data.CASE_ID,
v_new_data.CLIENT_ID,
v_new_data.SERVICE_AREA,
v_new_data.COUNTY,
v_new_data.PROGRAM_TYPE,
v_new_data.SUBPROGRAM_TYPE,
v_new_data.OUTREACH_STATUS,
v_new_data.OUTREACH_STATUS_DT,
v_new_data.VALIDATION_ERROR,
v_new_data.NOTIFY_INVALID_IND,
v_new_data.OUTREACH_STEP1_TYPE,
v_new_data.OUTREACH_STEP2_TYPE,
v_new_data.OUTREACH_STEP3_TYPE,
v_new_data.OUTREACH_STEP4_TYPE,
v_new_data.OUTREACH_STEP5_TYPE,
v_new_data.OUTREACH_STEP6_TYPE,
v_new_data.CURR_TASK_ID,
v_new_data.CURR_TASK_TYPE,
v_new_data.CURR_TASK_STATUS,
v_new_data.SURVEY_ID,
v_new_data.SURVEY_NAME,
v_new_data.CPW_REFERRAL_DT,
v_new_data.CPW_REFERRAL_SOURCE_TYPE,
v_new_data.CPW_REFERRAL_SOURCE_NAME,
v_new_data.CPW_REFERRAL_REASON,
v_new_data.CPW_CALL_BACK_IND,
v_new_data.CPW_REFERRAL_PRIORITY_STATUS,
v_new_data.PROVREF_PROVIDER_TYPE,
v_new_data.PROVREF_PROVIDER_CLINIC_NAME,
v_new_data.PROVREF_PROVIDER_CITY,
v_new_data.PROVREF_PROVIDER_COUNTY,
v_new_data.PROVREF_PROVIDER_ZIP,
v_new_data.PROVREF_PROVIDER_DT_REFERRED,
v_new_data.PROVREF_MISSED_APPT_IND,
v_new_data.PROVREF_MISSED_APPT_DT,
v_new_data.PROVREF_MISSED_APPT_TYPE,
v_new_data.PROVREF_MISSED_APPT_OUTCOME,
v_new_data.PROVREF_MISSED_APPT_REASON,
v_new_data.PROVREF_FOLLOWUP_LEAD_TEST,
v_new_data.PROVREF_TRANSPORT_ASSIST,
v_new_data.PROVREF_SCHEDULE_ASSIST,
v_new_data.PROVREF_UPDATE_ADDRESS,
v_new_data.PROVREF_OTHER_IND,
v_new_data.PROVREF_OTHER_COMMENT,
v_new_data.CHECKUP_TYPE,
v_new_data.CHECKUP_TX_WORKS_ADVISOR,
v_new_data.CHECKUP_CARETAKER_REPORT,
v_new_data.CHECKUP_PROVIDER_NAME,
v_new_data.CHECKUP_DT,
v_new_data.EXEFF_SCHEDULE_APPT_IND,
v_new_data.EXEFF_TRANSPORT_IND,
v_new_data.EXEFF_MORE_INFO_IND,
v_new_data.EXEFF_MORE_INFO_MED_IND,
v_new_data.EXEFF_MORE_INFO_DENT_IND,
v_new_data.EXEFF_MORE_INFO_CASEMGMT_IND,
v_new_data.EXEFF_HELP_FIND_PROV_IND,
v_new_data.EXEFF_PHONE_IND,
v_new_data.EXEFF_HOME_VISIT_IND,
v_new_data.EXEFF_MAIL_IND,
v_new_data.EXEFF_OTHER_LANGUAGE_IND,
v_new_data.EXEFF_INTERPRETER_IND,
v_new_data.EXEFF_LANGUAGE,
v_new_data.HOME_VISIT_REASON,
v_new_data.HOME_VISIT_NOT_ENG_IND,
v_new_data.HOME_VISIT_INTERPRETER_IND,
v_new_data.HOME_VISIT_LANGUAGE,
v_new_data.REMINDER_APPT_TYPE,
v_new_data.REMINDER_APPT_DT,
v_new_data.REMINDER_PROVIDER_NAME,
v_new_data.DELAY_DAYS1,
v_new_data.DELAY_DAYS1_UNIT,
v_new_data.DELAY_DAYS2,
v_new_data.DELAY_DAYS2_UNIT,
v_new_data.DELAY_DAYS3,
v_new_data.DELAY_DAYS3_UNIT,
v_new_data.LETTER_DEFINITION_ID1,
v_new_data.LETTER_DEFINITION_ID2,
v_new_data.LETTER_DEFINITION_ID3,
v_new_data.HUMAN_TASK_TYPE1,
v_new_data.HUMAN_TASK_TYPE2,
v_new_data.GENERIC_FIELD1,
v_new_data.GENERIC_FIELD2,
v_new_data.GENERIC_FIELD3,
v_new_data.GENERIC_FIELD4,
v_new_data.GENERIC_FIELD5,
v_new_data.NOTIFY_OUTCOME_IND,
v_new_data.CLIENT_NOTIFICATION_ID,
v_new_data.OUTCOME_NOTIFICATION_TASK_ID,
v_new_data.LAST_UPDATE_DT,
v_new_data.LAST_UPDATE_BY,
v_new_data.FINAL_WAIT_IND,
v_new_data.FINAL_WAIT_DAYS,
v_new_data.FINAL_WAIT_UNIT,
v_new_data.COMPLETE_DT,
v_new_data.CANCEL_DT,
v_new_data.CANCEL_BY,
v_new_data.CANCEL_REASON,
v_new_data.CANCEL_METHOD,
v_new_data.INSTANCE_STATUS,
v_new_data.ASSD_VALIDATE_OUTREACH_REQ,
v_new_data.ASED_VALIDATE_OUTREACH_REQ,
v_new_data.ASPB_VALIDATE_OUTREACH_REQ,
v_new_data.ASSD_PERFORM_OUTREACH,
v_new_data.ASED_PERFORM_OUTREACH,
v_new_data.ASPB_PERFORM_OUTREACH,
v_new_data.ASSD_OUTREACH_STEP1,
v_new_data.ASED_OUTREACH_STEP1,
v_new_data.ASPB_OUTREACH_STEP1,
v_new_data.ASSD_OUTREACH_STEP2,
v_new_data.ASED_OUTREACH_STEP2,
v_new_data.ASPB_OUTREACH_STEP2,
v_new_data.ASSD_OUTREACH_STEP3,
v_new_data.ASED_OUTREACH_STEP3,
v_new_data.ASPB_OUTREACH_STEP3,
v_new_data.ASSD_OUTREACH_STEP4,
v_new_data.ASED_OUTREACH_STEP4,
v_new_data.ASPB_OUTREACH_STEP4,
v_new_data.ASSD_OUTREACH_STEP5,
v_new_data.ASED_OUTREACH_STEP5,
v_new_data.ASPB_OUTREACH_STEP5,
v_new_data.ASSD_OUTREACH_STEP6,
v_new_data.ASED_OUTREACH_STEP6,
v_new_data.ASPB_OUTREACH_STEP6,
v_new_data.ASSD_PERFORM_HOME_VISIT,
v_new_data.ASED_PERFORM_HOME_VISIT,
v_new_data.ASPB_PERFORM_HOME_VISIT,
v_new_data.ASSD_TERMINATION_TIMER,
v_new_data.ASED_TERMINATION_TIMER,
v_new_data.ASSD_NOTIFY_CLIENT,
v_new_data.ASED_NOTIFY_CLIENT,
v_new_data.ASPB_NOTIFY_CLIENT,
v_new_data.ASSD_NOTIFY_SOURCE,
v_new_data.ASED_NOTIFY_SOURCE,
v_new_data.ASPB_NOTIFY_SOURCE,
v_new_data.GWF_INVALID,
v_new_data.GWF_STEP2_REQUIRED,
v_new_data.GWF_STEP3_REQUIRED,
v_new_data.GWF_STEP4_REQUIRED,
v_new_data.GWF_STEP5_REQUIRED,
v_new_data.GWF_STEP6_REQUIRED,
v_new_data.GWF_UNSUCCESSFUL,
v_new_data.GWF_FINAL_WAIT,
v_new_data.GWF_NOTIFY_CLIENT,
v_new_data.GWF_NOTIFY_SOURCE,
v_new_data.ASF_VALIDATE_OUTREACH_REQ,
v_new_data.ASF_PERFORM_OUTREACH,
v_new_data.ASF_NOTIFY_CLIENT,
v_new_data.ASF_NOTIFY_SOURCE,
v_new_data.ASF_OUTREACH_STEP1,
v_new_data.ASF_OUTREACH_STEP2,
v_new_data.ASF_OUTREACH_STEP3,
v_new_data.ASF_OUTREACH_STEP4,
v_new_data.ASF_OUTREACH_STEP5,
v_new_data.ASF_OUTREACH_STEP6,
v_new_data.ASF_PERFORM_HOME_VISIT,
v_new_data.ASF_TERMINATION_TIMER,
v_new_data.EXEFF_OTHER_IND,
v_new_data.CPW_NAME_OF_REFERRER,
v_new_data.CPW_REFERRAL_SOURCE_PHONE,
v_new_data.IMAGE_REFERENCE_ID
        );
        
      UPD_FCORBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dcorci_id,v_dcorrs_id,v_dcorsi_id,v_new_data.OUTREACH_STATUS_DT,v_new_data.stg_last_update_date, v_fcorbd_id);
      
      commit;
            
    exception
          
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
        raise;
      
    end;
      
  exception
  
    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
      raise; 
        
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
      raise;
  
  end;
  
end;

/

alter session set plsql_code_type = interpreted;