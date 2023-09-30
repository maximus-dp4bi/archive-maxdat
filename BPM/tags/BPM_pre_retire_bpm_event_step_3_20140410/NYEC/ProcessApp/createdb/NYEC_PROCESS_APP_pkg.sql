alter session set plsql_code_type = native;

create or replace package NYEC_PROCESS_APP as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DNPACUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;
     
  function GET_APP_CYCLE_BUS_DAYS
    (p_receipt_date in date,
     p_complete_date in date)
    return number;
  
  function GET_APP_CYCLE_CAL_DAYS
    (p_receipt_date in date,
     p_complete_date in date)
    return number;  
  
  function GET_JEOPARDY_FLAG
    (p_receipt_date in date,  
     p_complete_date in date,
     p_sla_days_type in varchar,
     p_sla_jeopardy_days in number,
     p_jeopardy_flag in varchar2)
    return varchar2;
     
  function GET_TIMELINESS_STATUS
    (p_receipt_date in date, 
     p_complete_date in date,
     p_sla_days_type in varchar2,
     p_sla_days in number)
    return varchar2;
     
  function GET_DAYS_UNTIL_TIMEOUT
    (p_app_cycle_end_date in date)
    return number;
    
  /*
  select '     '|| 'CEPA_ID varchar2(100),' attr_element from dual  
  union 
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
  union
  select 
    case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 2
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
  order by attr_element asc;
  */
  type T_INS_PA_XML is record 
    (
     APPLICANT_ID varchar2(100),
     APP_COMPLETE_RESULT varchar2(50),
     APP_CYCLE_END_DT varchar2(19),
     APP_CYCLE_START_DT varchar2(19),
     APP_ID varchar2(100),
     APP_STATUS varchar2(50),
     APP_STATUS_GROUP varchar2(30),
     APP_TYPE varchar2(30),
     ASF_CANCEL_APP varchar2(1),
     ASF_CLOSE_APP varchar2(1),
     ASF_COMPLETE_APP varchar2(1),
     ASF_NOTIFY_CLIENT_PENDED_APP varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_PERFORM_RESEARCH varchar2(1),
     ASF_PROCESS_APP_INFO varchar2(1),
     ASF_RECEIVE_APP varchar2(1),
     ASF_RECEIVE_PROCESS_MI varchar2(1),
     ASF_REVIEW_ENTER_DATA varchar2(1),
     ASF_WAIT_STATE_APPROVAL varchar2(1),
     ASPB_CANCEL_APP varchar2(100),
     ASPB_CLOSE_APP varchar2(100),
     ASPB_COMPLETE_APP varchar2(100),
     ASPB_NOTIFY_CLIENT_PENDED_APP varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_QC_REG varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_PROCESS_APP_INFO varchar2(100),
     ASPB_REG_ENTER_DATA varchar2(100),
     ASPB_RVW_ENTER_DATA varchar2(100),
     ASPB_WAIT_STATE_APPROVAL varchar2(100),
     ASSD_NOTIFY_CLIENT_PENDED_APP varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_QC_REG varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_PROCESS_APP_INFO varchar2(19),
     ASSD_REG_ENTER_DATA varchar2(19),
     ASSD_RVW_ENTER_DATA varchar2(19),
     ASSD_WAIT_STATE_APPROVAL varchar2(19),
     AUTO_REPROCESS_FLAG varchar2(1),
     CANCEL_DATE varchar2(19),
     CEPA_ID varchar2(100),
     CHANNEL varchar2(20),
     CIN varchar2(30),
     CIN_DT varchar2(19),
     CLOCKDOWN_INDICATOR varchar2(1),
     COMPLETE_DT varchar2(19),
     COUNTY varchar2(60),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     CURR_MODE_CD varchar2(2),
     CURR_MODE_LABEL varchar2(50),
     DE_TASK_ID varchar2(100),
     ELIGIBILITY_ACTION varchar2(20),
     FPBP_TYPE varchar2(30),
     GWF_MISSING_INFO varchar2(1),
     GWF_NEW_MI varchar2(1),
     GWF_OUTCM_NOTIFY_RQRD varchar2(1),
     GWF_PEND_NOTIFY_RQRD varchar2(1),
     GWF_QC_OUTCOME varchar2(1),
     GWF_QC_RQRD varchar2(1),
     GWF_RESEARCH varchar2(1),
     HEART_APP_STATUS varchar2(50),
     HEART_CASE_STATUS varchar2(50),
     HEART_INCMPLT_APP_IND varchar2(1),
     HEART_REPROCESS_STATUS varchar2(50),
     HEART_REPROCESS_STATUS_DT varchar2(19),
     HEART_SYNCH_FLAG varchar2(1),
     INVOICE_READY_DT varchar2(19),
     LAST_MAIL_DT varchar2(19),
     MA_REASON varchar2(50),
     MI_RECEIVED_TASK_COUNT varchar2(100),
     NOTIFY_CLIENT_PENDED_APP_DT varchar2(19),
     NUMBER_OF_APPLICANTS varchar2(100),
     OFFICE_ID varchar2(100),
     OUTCOME_LTR_CREATE_DT varchar2(19),
     OUTCOME_LTR_ID varchar2(100),
     OUTCOME_LTR_SENT_DT varchar2(19),
     OUTCOME_LTR_STATUS varchar2(32),
     OUTCOME_LTR_TYPE varchar2(100),
     OUTCOME_NOTIFY_RQRD_FLAG varchar2(1),
     PERFORM_QC_DT varchar2(19),
     PERFORM_QC_REG_DT varchar2(19),
     PERFORM_RESEARCH_DT varchar2(19),
     PROCESS_APP_INFO_DT varchar2(19),
     PROVIDER_NAME varchar2(80),
     QC_IND varchar2(1),
     QC_REG_TASK_ID varchar2(100),
     QC_TASK_ID varchar2(100),
     REACTIVATED_BY varchar2(100),
     REACTIVATION_DT varchar2(19),
     REACTIVATION_IND varchar2(100),
     REACTIVATION_NBR varchar2(100),
     REACTIVATION_REASON varchar2(64),
     RECEIPT_DT varchar2(19),
     REFER_LDSS_FLAG varchar2(1),
     REG_ENTER_DATA_DT varchar2(19),
     REG_TASK_ID varchar2(100),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     REV_CLEAR_IND varchar2(22),
     REV_CLEAR_IND_DT varchar2(19),
     REV_CLEAR_OUTCOME varchar2(22),
     REV_CLEAR_REASON varchar2(50),
     RVW_ENTER_DATA_DT varchar2(19),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STATE_CASE_IDEN varchar2(30),
     STATE_REVIEW_TASK_COUNT varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19),
     STOP_APP_REASON varchar2(100),
     UPSTATE_INDICATOR varchar2(20),
     WAIT_STATE_APPROVAL_DT varchar2(19),
     WMS_REASON varchar2(50),
     WORKFLOW_REACT_IND varchar2(1)
);
      
  /* 
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
  union
  select 
    case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 2
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
  order by attr_element asc;
  */
  type T_UPD_PA_XML is record
    (
     APPLICANT_ID varchar2(100),
     APP_COMPLETE_RESULT varchar2(50),
     APP_CYCLE_END_DT varchar2(19),
     APP_CYCLE_START_DT varchar2(19),
     APP_ID varchar2(100),
     APP_STATUS varchar2(50),
     APP_STATUS_GROUP varchar2(30),
     APP_TYPE varchar2(30),
     ASF_CANCEL_APP varchar2(1),
     ASF_CLOSE_APP varchar2(1),
     ASF_COMPLETE_APP varchar2(1),
     ASF_NOTIFY_CLIENT_PENDED_APP varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_PERFORM_RESEARCH varchar2(1),
     ASF_PROCESS_APP_INFO varchar2(1),
     ASF_RECEIVE_APP varchar2(1),
     ASF_RECEIVE_PROCESS_MI varchar2(1),
     ASF_REVIEW_ENTER_DATA varchar2(1),
     ASF_WAIT_STATE_APPROVAL varchar2(1),
     ASPB_CANCEL_APP varchar2(100),
     ASPB_CLOSE_APP varchar2(100),
     ASPB_COMPLETE_APP varchar2(100),
     ASPB_NOTIFY_CLIENT_PENDED_APP varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_QC_REG varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_PROCESS_APP_INFO varchar2(100),
     ASPB_REG_ENTER_DATA varchar2(100),
     ASPB_RVW_ENTER_DATA varchar2(100),
     ASPB_WAIT_STATE_APPROVAL varchar2(100),
     ASSD_NOTIFY_CLIENT_PENDED_APP varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_QC_REG varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_PROCESS_APP_INFO varchar2(19),
     ASSD_REG_ENTER_DATA varchar2(19),
     ASSD_RVW_ENTER_DATA varchar2(19),
     ASSD_WAIT_STATE_APPROVAL varchar2(19),
     AUTO_REPROCESS_FLAG varchar2(1),
     CANCEL_DATE varchar2(19),
     CHANNEL varchar2(20),
     CIN varchar2(30),
     CIN_DT varchar2(19),
     CLOCKDOWN_INDICATOR varchar2(1),
     COMPLETE_DT varchar2(19),
     COUNTY varchar2(60),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     CURR_MODE_CD varchar2(2),
     CURR_MODE_LABEL varchar2(50),
     DE_TASK_ID varchar2(100),
     ELIGIBILITY_ACTION varchar2(20),
     FPBP_TYPE varchar2(30),
     GWF_MISSING_INFO varchar2(1),
     GWF_NEW_MI varchar2(1),
     GWF_OUTCM_NOTIFY_RQRD varchar2(1),
     GWF_PEND_NOTIFY_RQRD varchar2(1),
     GWF_QC_OUTCOME varchar2(1),
     GWF_QC_RQRD varchar2(1),
     GWF_RESEARCH varchar2(1),
     HEART_APP_STATUS varchar2(50),
     HEART_CASE_STATUS varchar2(50),
     HEART_INCMPLT_APP_IND varchar2(1),
     HEART_REPROCESS_STATUS varchar2(50),
     HEART_REPROCESS_STATUS_DT varchar2(19),
     HEART_SYNCH_FLAG varchar2(1),
     INVOICE_READY_DT varchar2(19),
     LAST_MAIL_DT varchar2(19),
     MA_REASON varchar2(50),
     MI_RECEIVED_TASK_COUNT varchar2(100),
     NOTIFY_CLIENT_PENDED_APP_DT varchar2(19),
     NUMBER_OF_APPLICANTS varchar2(100),
     OFFICE_ID varchar2(100),
     OUTCOME_LTR_CREATE_DT varchar2(19),
     OUTCOME_LTR_ID varchar2(100),
     OUTCOME_LTR_SENT_DT varchar2(19),
     OUTCOME_LTR_STATUS varchar2(32),
     OUTCOME_LTR_TYPE varchar2(100),
     OUTCOME_NOTIFY_RQRD_FLAG varchar2(1),
     PERFORM_QC_DT varchar2(19),
     PERFORM_QC_REG_DT varchar2(19),
     PERFORM_RESEARCH_DT varchar2(19),
     PROCESS_APP_INFO_DT varchar2(19),
     PROVIDER_NAME varchar2(80),
     QC_IND varchar2(1),
     QC_REG_TASK_ID varchar2(100),
     QC_TASK_ID varchar2(100),
     REACTIVATED_BY varchar2(100),
     REACTIVATION_DT varchar2(19),
     REACTIVATION_IND varchar2(100),
     REACTIVATION_NBR varchar2(100),
     REACTIVATION_REASON varchar2(64),
     RECEIPT_DT varchar2(19),
     REFER_LDSS_FLAG varchar2(1),
     REG_ENTER_DATA_DT varchar2(19),
     REG_TASK_ID varchar2(100),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     REV_CLEAR_IND varchar2(22),
     REV_CLEAR_IND_DT varchar2(19),
     REV_CLEAR_OUTCOME varchar2(22),
     REV_CLEAR_REASON varchar2(50),
     RVW_ENTER_DATA_DT varchar2(19),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STATE_CASE_IDEN varchar2(30),
     STATE_REVIEW_TASK_COUNT varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19),
     STOP_APP_REASON varchar2(100),
     UPSTATE_INDICATOR varchar2(20),
     WAIT_STATE_APPROVAL_DT varchar2(19),
     WMS_REASON varchar2(50),
     WORKFLOW_REACT_IND varchar2(1)
     );
    
  procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
     
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
     
end;
/


create or replace package body NYEC_PROCESS_APP as

  v_bem_id number := 2; -- 'NYEC OPS Process App'
  v_bil_id number := 2; -- 'Application ID'
  v_bsl_id number := 2; -- 'NYEC_ETL_PROCESS_APP'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DNPACUR';
  
  
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
  
     
  function GET_APP_CYCLE_BUS_DAYS
    (p_receipt_date in date,
     p_complete_date in date)
    return number
  as
  begin
    if p_receipt_date is not null and p_complete_date is not null then 
      return BPM_COMMON.BUS_DAYS_BETWEEN(p_receipt_date,nvl(p_complete_date,sysdate));
    else
      return null;
    end if;
  end;
  
  
  function GET_APP_CYCLE_CAL_DAYS
    (p_receipt_date in date,
     p_complete_date in date)
    return number
  as
  begin
    if p_receipt_date is not null then 
      return trunc(nvl(p_complete_date,sysdate)) - trunc(p_receipt_date);
    else
      return null;
    end if;
  end;
  
  
  function GET_JEOPARDY_FLAG
    (p_receipt_date in date,  
     p_complete_date in date,
     p_sla_days_type in varchar,
     p_sla_jeopardy_days in number,
     p_jeopardy_flag in varchar2)
    return varchar2
  as
  begin
    if p_sla_jeopardy_days is null then
      return 'N';
    elsif  p_complete_date is not null then
      return p_jeopardy_flag;
    elsif p_sla_days_type = 'B' and p_receipt_date is not null 
       and BPM_COMMON.GET_BUS_DATE(trunc(p_receipt_date),p_sla_jeopardy_days) <= trunc(sysdate) then
      return 'Y';
    elsif p_sla_days_type = 'C' and p_receipt_date is not null 
       and trunc(p_receipt_date) + p_sla_jeopardy_days <= trunc(sysdate) then
      return 'Y';
    else
       return 'N';
    end if;
  end;


  function GET_TIMELINESS_STATUS
    (p_receipt_date in date,  
     p_complete_date in date,
     p_sla_days_type in varchar2,
     p_sla_days in number)
    return varchar2
  as
  begin
    if p_complete_date is null then
      return 'Not Complete';
    elsif p_sla_days is null then
      return 'Not Required';
    elsif p_sla_days_type = 'B' and p_receipt_date  is not null
      and BPM_COMMON.BUS_DAYS_BETWEEN(p_receipt_date,nvl(p_complete_date,sysdate)) >  p_sla_days then
      return 'Untimely';
    elsif p_sla_days_type = 'C' and p_receipt_date  is not null
      and  trunc(NVL(p_complete_date,sysdate)) - trunc(p_receipt_date) >  p_sla_days then
      return 'Untimely';
    else 
      return 'Timely';
    end if;
  end;


  function GET_DAYS_UNTIL_TIMEOUT
    (p_app_cycle_end_date in date)
    return number
  as
  begin 
    return trunc(p_app_cycle_end_date) - trunc(sysdate);
  end;
  
  
  -- Calculate column values in BPM Semantic table D_NYEC_PA_CURRENT.
  procedure CALC_DNPACUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DNPACUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
    update D_NYEC_PA_CURRENT
    set
      "Age in Business Days" = GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
      "Age in Calendar Days" = GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
      "KPR App Cycle Business Days" = GET_APP_CYCLE_BUS_DAYS("Cur Receipt Date","Complete Date"),
      "KPR App Cycle Calendar Days" = GET_APP_CYCLE_CAL_DAYS("Cur Receipt Date","Complete Date"),
      "Jeopardy Flag" = GET_JEOPARDY_FLAG("Cur Receipt Date","Complete Date","SLA Days Type","SLA Jeopardy Days","Jeopardy Flag"),
      "Timeliness Status" = GET_TIMELINESS_STATUS("Cur Receipt Date","Complete Date","SLA Days Type","SLA Days"),
      "Days To Timeout" = GET_DAYS_UNTIL_TIMEOUT("KPR App Cycle End Date")
    where 
      "Complete Date" is null 
      and "Cancel Date" is null;
    
    v_num_rows_updated := sql%rowcount;
    
    commit;

    v_log_message := v_num_rows_updated  || ' D_NYEC_PA_CURRENT rows updated with calculated attributes by CALC_DNPACUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
    
  exception
  
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

  end;


  -- Get dimension ID for BPM Semantic model - Process App process - County.
  procedure GET_DNPACOU_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_county in varchar2,
      p_dnpacou_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPACOU_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DNPACOU_ID
     into p_dnpacou_id
     from D_NYEC_PA_COUNTY
     where 
       "County" = p_county 
       or ("County" is null and p_county is null);
      
   exception

     when NO_DATA_FOUND then

       p_dnpacou_id := SEQ_DNPACOU_ID.nextval;
       begin
         insert into D_NYEC_PA_COUNTY (DNPACOU_ID,"County")
         values (p_dnpacou_id,p_county);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DNPACOU_ID into p_dnpacou_id
           from D_NYEC_PA_COUNTY
           where 
             "County" = p_county 
             or ("County" is null and p_county is null);
             
         when OTHERS then

           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
           raise;

       end;

     when OTHERS then
     
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
       raise;
       
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - HEART Case Status.
  procedure GET_DNPAHCS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_HEART_case_status in varchar2,
     p_dnpahcs_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAHCS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DNPAHCS_ID
    into p_dnpahcs_id
    from D_NYEC_PA_HEART_CASE_STATUS
    where 
      "HEART Case Status" = p_HEART_case_status 
      or ("HEART Case Status" is null and p_HEART_case_status is null);
      
  exception
  
    when NO_DATA_FOUND then
      p_dnpahcs_id := SEQ_DNPAHCS_ID.nextval;
      begin
        insert into D_NYEC_PA_HEART_CASE_STATUS (DNPAHCS_ID,"HEART Case Status")
        values (p_dnpahcs_id,p_HEART_case_status);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAHCS_ID into p_dnpahcs_id
          from D_NYEC_PA_HEART_CASE_STATUS
          where 
            "HEART Case Status" = p_HEART_case_status 
            or ("HEART Case Status" is null and p_HEART_case_status is null);
             
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Heart Synch.
  procedure GET_DNPAHS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_HEART_synch_flag in varchar2,
     p_dnpahs_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAHS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAHS_ID
    into p_dnpahs_id
    from D_NYEC_PA_HEART_SYNCH
    where 
      "HEART Synch Flag" = p_HEART_synch_flag 
      or ("HEART Synch Flag" is null and p_HEART_synch_flag is null);
        
  exception
  
    when NO_DATA_FOUND then
      p_dnpahs_id := SEQ_DNPAHS_ID.nextval;
      
      begin
        insert into D_NYEC_PA_HEART_SYNCH (DNPAHS_ID,"HEART Synch Flag")
        values (p_dnpahs_id,p_HEART_synch_flag);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAHS_ID into p_dnpahs_id
          from D_NYEC_PA_HEART_SYNCH
          where 
            "HEART Synch Flag" = p_HEART_synch_flag
            or ("HEART Synch Flag" is null and p_HEART_synch_flag is null);
         
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
        
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
        
  end;
  
  -- Get dimension ID for BPM Semantic model - Process App process - App Status
  procedure GET_DNPAAS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_app_status in varchar2,
     p_app_status_group in varchar2,
     p_HEART_app_status in varchar2,
     p_refer_to_LDSS_flag in varchar2,
     p_dnpaas_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAAS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
      select DNPAAS_ID
      into p_dnpaas_id
      from D_NYEC_PA_APP_STATUS
      where 
        ("App Status" = p_app_status or ("App Status" is null and p_app_status is null))
        and ("App Status Group" = p_app_status_group or ("App Status Group" is null and p_app_status_group is null))
        and ("Heart App Status" = p_HEART_app_status or ("Heart App Status" is null and p_HEART_app_status is null))
        and ("Refer to LDSS Flag" = p_refer_to_LDSS_flag or ("Refer to LDSS Flag" is null and p_refer_to_LDSS_flag is null));
        
  exception
  
    when NO_DATA_FOUND then
      p_dnpaas_id := SEQ_DNPAAS_ID.nextval;
      
      begin
        insert into D_NYEC_PA_APP_STATUS 
          (DNPAAS_ID,"App Status","App Status Group","Heart App Status","Refer to LDSS Flag")
        values 
          (p_dnpaas_id,p_app_status,p_app_status_group,p_HEART_app_status,p_refer_to_LDSS_flag);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAAS_ID into p_dnpaas_id
          from D_NYEC_PA_APP_STATUS
          where 
            ("App Status" = p_app_status or ("App Status" is null and p_app_status is null))
	          and ("App Status Group" = p_app_status_group or ("App Status Group" is null and p_app_status_group is null))
	          and ("Heart App Status" = p_HEART_app_status or ("Heart App Status" is null and p_HEART_app_status is null))
            and ("Refer to LDSS Flag" = p_refer_to_LDSS_flag or ("Refer to LDSS Flag" is null and p_refer_to_LDSS_flag is null));
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  -- Get dimension ID for BPM Semantic model - Process App process - CIN.
  procedure GET_DNPACIN_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_CIN in varchar2,
     p_dnpacin_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPACIN_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPACIN_ID
    into p_dnpacin_id
    from D_NYEC_PA_CIN
    where 
      "CIN" = p_CIN
      or ("CIN" is null and p_CIN is null);
           
  exception
    
    when NO_DATA_FOUND then
      p_dnpacin_id := SEQ_DNPACIN_ID.nextval;
        
      begin
        
        insert into D_NYEC_PA_CIN (DNPACIN_ID,"CIN")
        values (p_dnpacin_id,p_CIN);
        commit;
          
      exception
        
        when DUP_VAL_ON_INDEX then
          select DNPACIN_ID into p_dnpacin_id
          from D_NYEC_PA_CIN
          where 
            "CIN" = p_CIN 
            or ("CIN" is null and p_CIN is null);
            
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
            
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;


  -- Get dimension ID for BPM Semantic model - Process App process - Subtype. 
  procedure GET_DNPAFPBPST_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_FPBP_Sub_type in varchar2,
     p_dnpafpbpst_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAFPBPST_ID';
    v_sql_code number := null;
    v_log_message clob := null; 
  begin
  
    select DNPAFPBPST_ID
    into p_dnpafpbpst_id
    from D_NYEC_PA_FPBP_SUBTYPE
    where 
      "FPBP Sub-type" = p_FPBP_Sub_type
      or ("FPBP Sub-type" is null and p_FPBP_Sub_type is null);
                 
  exception
  
    when NO_DATA_FOUND then
      p_dnpafpbpst_id := SEQ_DNPAFPBPST_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_FPBP_SUBTYPE (DNPAFPBPST_ID,"FPBP Sub-type")
        values (p_dnpafpbpst_id,p_FPBP_Sub_type);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAFPBPST_ID into p_dnpafpbpst_id
          from D_NYEC_PA_FPBP_SUBTYPE
          where 
            "FPBP Sub-type" = p_FPBP_Sub_type
            or ("FPBP Sub-type" is null and p_FPBP_Sub_type is null);
                  
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
            raise;
            
          end;
          
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;


  -- Get dimension ID for BPM Semantic model - Process App process - Heart App ind. 
  procedure GET_DNPAHIAI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_HEART_inc_app_ind in varchar2,
     p_dnpahiai_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAHIAI_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAHIAI_ID
    into p_dnpahiai_id
    from D_NYEC_PA_HEART_INC_APP_IND
    where 
      "HEART Incomplete App Ind" = p_HEART_inc_app_ind
       or ("HEART Incomplete App Ind" is null and p_HEART_inc_app_ind is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpahiai_id := SEQ_DNPAHIAI_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_HEART_INC_APP_IND (DNPAHIAI_ID,"HEART Incomplete App Ind")
        values (p_dnpahiai_id,p_HEART_inc_app_ind);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAHIAI_ID into p_dnpahiai_id
          from D_NYEC_PA_HEART_INC_APP_IND
          where 
            "HEART Incomplete App Ind" = p_HEART_inc_app_ind
            or ("HEART Incomplete App Ind" is null and p_HEART_inc_app_ind is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  -- Get dimension ID for BPM Semantic model - Process App process - MA Reason
  procedure GET_DNPAMAR_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_ma_reason in varchar2,
     p_dnpamar_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAMAR_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAMAR_ID 
    into p_dnpamar_id
    from D_NYEC_PA_MA_REASON  
    where 
      MA_REASON = p_ma_reason
       or (MA_REASON is null and p_ma_reason is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpamar_id := SEQ_DNPAMAR_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_MA_REASON (DNPAMAR_ID,MA_REASON)
        values (p_dnpamar_id,p_ma_reason);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAMAR_ID into p_dnpamar_id
          from D_NYEC_PA_MA_REASON
          where 
            MA_REASON = p_ma_reason
            or (MA_REASON is null and p_ma_reason is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;

  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Mode Code 
  procedure GET_DNPAMC_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_mode_code in varchar2,
     p_dnpamc_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAMC_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAMC_ID 
    into p_dnpamc_id
    from D_NYEC_PA_MODE_CODE 
    where 
      "Mode Code" = p_mode_code
       or ("Mode Code" is null and p_mode_code is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpamc_id := SEQ_DNPAMC_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_MODE_CODE (DNPAMC_ID,"Mode Code")
        values (p_dnpamc_id,p_mode_code);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAMC_ID into p_dnpamc_id
          from D_NYEC_PA_MODE_CODE
          where 
            "Mode Code" = p_mode_code
            or ("Mode Code" is null and p_mode_code is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Mode Label 
  procedure GET_DNPAML_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_mode_label in varchar2,
     p_dnpaml_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAML_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAML_ID 
    into p_dnpaml_id
    from D_NYEC_PA_MODE_LABEL 
    where 
      "Mode Label" = p_mode_label
       or ("Mode Label" is null and p_mode_label is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpaml_id := SEQ_DNPAML_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_MODE_LABEL (DNPAML_ID,"Mode Label")
        values (p_dnpaml_id,p_mode_label);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAML_ID into p_dnpaml_id
          from D_NYEC_PA_MODE_LABEL
          where 
            "Mode Label" = p_mode_label
            or ("Mode Label" is null and p_mode_label is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Outcome Notification Required Flag 
  procedure GET_DNPAONF_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_outcome_notif_req_flag in varchar2,
     p_dnpaonf_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAONF_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAONF_ID 
    into p_dnpaonf_id
    from D_NYEC_PA_OUTCOME_NOTF_FLAG 
    where 
      "Outcome Notif Req Flag" = p_outcome_notif_req_flag
       or ("Outcome Notif Req Flag" is null and p_outcome_notif_req_flag is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpaonf_id := SEQ_DNPAONF_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_OUTCOME_NOTF_FLAG (DNPAONF_ID,"Outcome Notif Req Flag")
        values (p_dnpaonf_id,p_outcome_notif_req_flag);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAONF_ID into p_dnpaonf_id
          from D_NYEC_PA_OUTCOME_NOTF_FLAG
          where 
            "Outcome Notif Req Flag" = p_outcome_notif_req_flag
            or ("Outcome Notif Req Flag" is null and p_outcome_notif_req_flag is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Outcome Letter Status 
  procedure GET_DNPAOLS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_outcome_letter_status in varchar2,
     p_dnpaols_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAOLS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAOLS_ID 
    into p_dnpaols_id
    from D_NYEC_PA_OUTCOM_LTR_STATUS  
    where 
      "Outcome Letter Status" = p_outcome_letter_status
       or ("Outcome Letter Status" is null and p_outcome_letter_status is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpaols_id := SEQ_DNPAOLS_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_OUTCOM_LTR_STATUS (DNPAOLS_ID,"Outcome Letter Status")
        values (p_dnpaols_id,p_outcome_letter_status);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAOLS_ID into p_dnpaols_id
          from D_NYEC_PA_OUTCOM_LTR_STATUS 
          where 
            "Outcome Letter Status" = p_outcome_letter_status
            or ("Outcome Letter Status" is null and p_outcome_letter_status is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - QC Indicator
  procedure GET_DNPAQI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_qc_indicator in varchar2,
     p_dnpaqi_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAQI_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAQI_ID 
    into p_dnpaqi_id
    from D_NYEC_PA_QC_INDICATOR  
    where 
      "QC Indicator" = p_qc_indicator
       or ("QC Indicator" is null and p_qc_indicator is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpaqi_id := SEQ_DNPAQI_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_QC_INDICATOR (DNPAQI_ID,"QC Indicator")
        values (p_dnpaqi_id,p_qc_indicator);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAQI_ID into p_dnpaqi_id
          from D_NYEC_PA_QC_INDICATOR
          where 
            "QC Indicator" = p_qc_indicator
            or ("QC Indicator" is null and p_qc_indicator is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  

  -- Get dimension ID for BPM Semantic model - Process App process - Reactivated By 
  procedure GET_DNPARB_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_reactivated_by in varchar2,
     p_dnparb_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPARB_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPARB_ID 
    into p_dnparb_id
    from D_NYEC_PA_REACTIVATED_BY 
    where 
      "Reactivated By" = p_reactivated_by
       or ("Reactivated By" is null and p_reactivated_by is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnparb_id := SEQ_DNPARB_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_REACTIVATED_BY (DNPARB_ID,"Reactivated By")
        values (p_dnparb_id,p_reactivated_by);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPARB_ID into p_dnparb_id
          from D_NYEC_PA_REACTIVATED_BY
          where 
            "Reactivated By" = p_reactivated_by
            or ("Reactivated By" is null and p_reactivated_by is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Reactivation Indicator 
  procedure GET_DNPARI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_reactivation_indicator in varchar2,
     p_dnpari_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPARI_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPARI_ID 
    into p_dnpari_id
    from D_NYEC_PA_REACTIVATION_IND 
    where 
      "Reactivation Indicator" = p_reactivation_indicator
       or ("Reactivation Indicator" is null and p_reactivation_indicator is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpari_id := SEQ_DNPARI_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_REACTIVATION_IND (DNPARI_ID,"Reactivation Indicator")
        values (p_dnpari_id,p_reactivation_indicator);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPARI_ID into p_dnpari_id
          from D_NYEC_PA_REACTIVATION_IND
          where 
            "Reactivation Indicator" = p_reactivation_indicator
            or ("Reactivation Indicator" is null and p_reactivation_indicator is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
    -- Get dimension ID for BPM Semantic model - Process App process - Reactivation Number 
  procedure GET_DNPARN_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_reactivation_number in varchar2,
     p_dnparn_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPARN_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPARN_ID 
    into p_dnparn_id
    from D_NYEC_PA_REACTIVATION_NUM
    where 
      "Reactivation Number" = p_reactivation_number
       or ("Reactivation Number" is null and p_reactivation_number is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnparn_id := SEQ_DNPARN_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_REACTIVATION_NUM (DNPARN_ID,"Reactivation Number")
        values (p_dnparn_id,p_reactivation_number);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPARN_ID into p_dnparn_id
          from D_NYEC_PA_REACTIVATION_NUM
          where 
            "Reactivation Number" = p_reactivation_number
            or ("Reactivation Number" is null and p_reactivation_number is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
     

  -- Get dimension ID for BPM Semantic model - Process App process - Reactivation Reason 
  procedure GET_DNPARR_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_reactivation_reason in varchar2,
     p_dnparr_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPARR_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPARR_ID 
    into p_dnparr_id
    from D_NYEC_PA_REACTIVATE_REASON 
    where 
      "Reactivation Reason" = p_reactivation_reason
       or ("Reactivation Reason" is null and p_reactivation_reason is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnparr_id := SEQ_DNPARR_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_REACTIVATE_REASON (DNPARR_ID,"Reactivation Reason")
        values (p_dnparr_id,p_reactivation_reason);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPARR_ID into p_dnparr_id
          from D_NYEC_PA_REACTIVATE_REASON
          where 
            "Reactivation Reason" = p_reactivation_reason
            or ("Reactivation Reason" is null and p_reactivation_reason is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process App process - Reverse Clearance Reason
  procedure GET_DNPARCR_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_rev_clear_reason in varchar2,
     p_dnparcr_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPARCR_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPARCR_ID 
    into p_dnparcr_id
    from D_NYEC_PA_REV_CLEAR_REASON  
    where 
      REVERSE_CLEARANCE_REASON = p_rev_clear_reason
       or (REVERSE_CLEARANCE_REASON is null and p_rev_clear_reason is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnparcr_id := SEQ_DNPARCR_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_REV_CLEAR_REASON (DNPARCR_ID,REVERSE_CLEARANCE_REASON)
        values (p_dnparcr_id,p_rev_clear_reason);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPARCR_ID into p_dnparcr_id
          from D_NYEC_PA_REV_CLEAR_REASON
          where 
            REVERSE_CLEARANCE_REASON = p_rev_clear_reason
            or (REVERSE_CLEARANCE_REASON is null and p_rev_clear_reason is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;


  -- Get dimension ID for BPM Semantic model - Process App process - Workflow Reactivation Ind 
  procedure GET_DNPAWRI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_workflow_reactivation_ind in varchar2,
     p_dnpawri_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAWRI_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select DNPAWRI_ID 
    into p_dnpawri_id
    from D_NYEC_PA_WORKFLOW_REAC_IND  
    where 
      "Workflow Reactivation Ind" = p_workflow_reactivation_ind
       or ("Workflow Reactivation Ind" is null and p_workflow_reactivation_ind is null);
               
  exception
  
    when NO_DATA_FOUND then
      p_dnpawri_id := SEQ_DNPAWRI_ID.nextval;
      
      begin
      
        insert into D_NYEC_PA_WORKFLOW_REAC_IND (DNPAWRI_ID,"Workflow Reactivation Ind")
        values (p_dnpawri_id,p_workflow_reactivation_ind);
        commit;
        
      exception
      
        when DUP_VAL_ON_INDEX then
          select DNPAWRI_ID into p_dnpawri_id
          from D_NYEC_PA_WORKFLOW_REAC_IND 
          where 
            "Workflow Reactivation Ind" = p_workflow_reactivation_ind
            or ("Workflow Reactivation Ind" is null and p_workflow_reactivation_ind is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
          
      end;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
      raise;
      
  end;
  
  
  -- Get record for Process App insert XML.
  procedure GET_INS_PA_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PA_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PA_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/CEPA_ID'') "' || 'CEPA_ID'|| '",' attr_element from dual
    union 
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union 
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
      bast.BSL_ID = 2
      and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP'
      and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
        'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/APPLICANT_ID') "APPLICANT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_COMPLETE_RESULT') "APP_COMPLETE_RESULT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_CYCLE_END_DT') "APP_CYCLE_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_CYCLE_START_DT') "APP_CYCLE_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS') "APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS_GROUP') "APP_STATUS_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_TYPE') "APP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_APP') "ASF_CANCEL_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLOSE_APP') "ASF_CLOSE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_COMPLETE_APP') "ASF_COMPLETE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT_PENDED_APP') "ASF_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_RESEARCH') "ASF_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_APP_INFO') "ASF_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_APP') "ASF_RECEIVE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_PROCESS_MI') "ASF_RECEIVE_PROCESS_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_ENTER_DATA') "ASF_REVIEW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_STATE_APPROVAL') "ASF_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CANCEL_APP') "ASPB_CANCEL_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CLOSE_APP') "ASPB_CLOSE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_COMPLETE_APP') "ASPB_COMPLETE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_CLIENT_PENDED_APP') "ASPB_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC_REG') "ASPB_PERFORM_QC_REG",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_RESEARCH') "ASPB_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_APP_INFO') "ASPB_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REG_ENTER_DATA') "ASPB_REG_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RVW_ENTER_DATA') "ASPB_RVW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_WAIT_STATE_APPROVAL') "ASPB_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT_PENDED_APP') "ASSD_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC_REG') "ASSD_PERFORM_QC_REG",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_RESEARCH') "ASSD_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_APP_INFO') "ASSD_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REG_ENTER_DATA') "ASSD_REG_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RVW_ENTER_DATA') "ASSD_RVW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_STATE_APPROVAL') "ASSD_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTO_REPROCESS_FLAG') "AUTO_REPROCESS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPA_ID') "CEPA_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CIN') "CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CIN_DT') "CIN_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CLOCKDOWN_INDICATOR') "CLOCKDOWN_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY') "COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_MODE_CD') "CURR_MODE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_MODE_LABEL') "CURR_MODE_LABEL",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ELIGIBILITY_ACTION') "ELIGIBILITY_ACTION",
      extractValue(p_data_xml,'/ROWSET/ROW/FPBP_TYPE') "FPBP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MISSING_INFO') "GWF_MISSING_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NEW_MI') "GWF_NEW_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTCM_NOTIFY_RQRD') "GWF_OUTCM_NOTIFY_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PEND_NOTIFY_RQRD') "GWF_PEND_NOTIFY_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_OUTCOME') "GWF_QC_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_RQRD') "GWF_QC_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESEARCH') "GWF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_APP_STATUS') "HEART_APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_CASE_STATUS') "HEART_CASE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_INCMPLT_APP_IND') "HEART_INCMPLT_APP_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_REPROCESS_STATUS') "HEART_REPROCESS_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_REPROCESS_STATUS_DT') "HEART_REPROCESS_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_SYNCH_FLAG') "HEART_SYNCH_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/INVOICE_READY_DT') "INVOICE_READY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_MAIL_DT') "LAST_MAIL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MA_REASON') "MA_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_RECEIVED_TASK_COUNT') "MI_RECEIVED_TASK_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_CLIENT_PENDED_APP_DT') "NOTIFY_CLIENT_PENDED_APP_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/NUMBER_OF_APPLICANTS') "NUMBER_OF_APPLICANTS",
      extractValue(p_data_xml,'/ROWSET/ROW/OFFICE_ID') "OFFICE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_CREATE_DT') "OUTCOME_LTR_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_ID') "OUTCOME_LTR_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_SENT_DT') "OUTCOME_LTR_SENT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_STATUS') "OUTCOME_LTR_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_TYPE') "OUTCOME_LTR_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_NOTIFY_RQRD_FLAG') "OUTCOME_NOTIFY_RQRD_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_QC_DT') "PERFORM_QC_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_QC_REG_DT') "PERFORM_QC_REG_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_RESEARCH_DT') "PERFORM_RESEARCH_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_APP_INFO_DT') "PROCESS_APP_INFO_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_NAME') "PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_IND') "QC_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_REG_TASK_ID') "QC_REG_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_TASK_ID') "QC_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATED_BY') "REACTIVATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_DT') "REACTIVATION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_IND') "REACTIVATION_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_NBR') "REACTIVATION_NBR",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_REASON') "REACTIVATION_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REFER_LDSS_FLAG') "REFER_LDSS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/REG_ENTER_DATA_DT') "REG_ENTER_DATA_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REG_TASK_ID') "REG_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REASON') "RESEARCH_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_IND') "REV_CLEAR_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_IND_DT') "REV_CLEAR_IND_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_OUTCOME') "REV_CLEAR_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_REASON') "REV_CLEAR_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RVW_ENTER_DATA_DT') "RVW_ENTER_DATA_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_CASE_IDEN') "STATE_CASE_IDEN",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_COUNT') "STATE_REVIEW_TASK_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/STOP_APP_REASON') "STOP_APP_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/UPSTATE_INDICATOR') "UPSTATE_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/WAIT_STATE_APPROVAL_DT') "WAIT_STATE_APPROVAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/WMS_REASON') "WMS_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/WORKFLOW_REACT_IND') "WORKFLOW_REACT_IND"
     into p_data_record
    from dual;
  
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise; 
      
  end;
    
    
  -- Get record for Process App update XML. 
  procedure GET_UPD_PA_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_PA_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PA_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
  
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union 
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
      bast.BSL_ID = 2
      and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP'
      and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
        'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/APPLICANT_ID') "APPLICANT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_COMPLETE_RESULT') "APP_COMPLETE_RESULT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_CYCLE_END_DT') "APP_CYCLE_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_CYCLE_START_DT') "APP_CYCLE_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS') "APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS_GROUP') "APP_STATUS_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_TYPE') "APP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_APP') "ASF_CANCEL_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLOSE_APP') "ASF_CLOSE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_COMPLETE_APP') "ASF_COMPLETE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT_PENDED_APP') "ASF_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_RESEARCH') "ASF_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_APP_INFO') "ASF_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_APP') "ASF_RECEIVE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_PROCESS_MI') "ASF_RECEIVE_PROCESS_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_ENTER_DATA') "ASF_REVIEW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_STATE_APPROVAL') "ASF_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CANCEL_APP') "ASPB_CANCEL_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CLOSE_APP') "ASPB_CLOSE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_COMPLETE_APP') "ASPB_COMPLETE_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NOTIFY_CLIENT_PENDED_APP') "ASPB_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC_REG') "ASPB_PERFORM_QC_REG",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_RESEARCH') "ASPB_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_APP_INFO') "ASPB_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REG_ENTER_DATA') "ASPB_REG_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RVW_ENTER_DATA') "ASPB_RVW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_WAIT_STATE_APPROVAL') "ASPB_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT_PENDED_APP') "ASSD_NOTIFY_CLIENT_PENDED_APP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC_REG') "ASSD_PERFORM_QC_REG",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_RESEARCH') "ASSD_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_APP_INFO') "ASSD_PROCESS_APP_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REG_ENTER_DATA') "ASSD_REG_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RVW_ENTER_DATA') "ASSD_RVW_ENTER_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_STATE_APPROVAL') "ASSD_WAIT_STATE_APPROVAL",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTO_REPROCESS_FLAG') "AUTO_REPROCESS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CIN') "CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CIN_DT') "CIN_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CLOCKDOWN_INDICATOR') "CLOCKDOWN_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY') "COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_MODE_CD') "CURR_MODE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/CURR_MODE_LABEL') "CURR_MODE_LABEL",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ELIGIBILITY_ACTION') "ELIGIBILITY_ACTION",
      extractValue(p_data_xml,'/ROWSET/ROW/FPBP_TYPE') "FPBP_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MISSING_INFO') "GWF_MISSING_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NEW_MI') "GWF_NEW_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTCM_NOTIFY_RQRD') "GWF_OUTCM_NOTIFY_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PEND_NOTIFY_RQRD') "GWF_PEND_NOTIFY_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_OUTCOME') "GWF_QC_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_RQRD') "GWF_QC_RQRD",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESEARCH') "GWF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_APP_STATUS') "HEART_APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_CASE_STATUS') "HEART_CASE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_INCMPLT_APP_IND') "HEART_INCMPLT_APP_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_REPROCESS_STATUS') "HEART_REPROCESS_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_REPROCESS_STATUS_DT') "HEART_REPROCESS_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_SYNCH_FLAG') "HEART_SYNCH_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/INVOICE_READY_DT') "INVOICE_READY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_MAIL_DT') "LAST_MAIL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MA_REASON') "MA_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_RECEIVED_TASK_COUNT') "MI_RECEIVED_TASK_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTIFY_CLIENT_PENDED_APP_DT') "NOTIFY_CLIENT_PENDED_APP_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/NUMBER_OF_APPLICANTS') "NUMBER_OF_APPLICANTS",
      extractValue(p_data_xml,'/ROWSET/ROW/OFFICE_ID') "OFFICE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_CREATE_DT') "OUTCOME_LTR_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_ID') "OUTCOME_LTR_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_SENT_DT') "OUTCOME_LTR_SENT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_STATUS') "OUTCOME_LTR_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_LTR_TYPE') "OUTCOME_LTR_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTCOME_NOTIFY_RQRD_FLAG') "OUTCOME_NOTIFY_RQRD_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_QC_DT') "PERFORM_QC_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_QC_REG_DT') "PERFORM_QC_REG_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PERFORM_RESEARCH_DT') "PERFORM_RESEARCH_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_APP_INFO_DT') "PROCESS_APP_INFO_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_NAME') "PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_IND') "QC_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_REG_TASK_ID') "QC_REG_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_TASK_ID') "QC_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATED_BY') "REACTIVATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_DT') "REACTIVATION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_IND') "REACTIVATION_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_NBR') "REACTIVATION_NBR",
      extractValue(p_data_xml,'/ROWSET/ROW/REACTIVATION_REASON') "REACTIVATION_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REFER_LDSS_FLAG') "REFER_LDSS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/REG_ENTER_DATA_DT') "REG_ENTER_DATA_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REG_TASK_ID') "REG_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REASON') "RESEARCH_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_IND') "REV_CLEAR_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_IND_DT') "REV_CLEAR_IND_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_OUTCOME') "REV_CLEAR_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/REV_CLEAR_REASON') "REV_CLEAR_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RVW_ENTER_DATA_DT') "RVW_ENTER_DATA_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_CASE_IDEN') "STATE_CASE_IDEN",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_COUNT') "STATE_REVIEW_TASK_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/STOP_APP_REASON') "STOP_APP_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/UPSTATE_INDICATOR') "UPSTATE_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/WAIT_STATE_APPROVAL_DT') "WAIT_STATE_APPROVAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/WMS_REASON') "WMS_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/WORKFLOW_REACT_IND') "WORKFLOW_REACT_IND"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  
  end;
  
  
  -- Insert fact for BPM Semantic model - Process App process. 
    procedure INS_FNPABD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dnpacou_id in number,
       p_dnpahs_id in number,
       p_dnpaas_id in number,
       p_receipt_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_invoiceable_date in varchar2,
       p_dnpacin_id in number,
       p_dnpafpbpst_id in number,
       p_dnpahiai_id in number,
       p_dnpahcs_id in number,
       p_dnpari_id number,
       p_dnparr_id number,
       p_dnparb_id number,
       p_dnparn_id number,
       p_dnpamc_id number,
       p_dnpaml_id number,
       p_dnpaonf_id number,
       p_dnpaols_id number,
       p_dnpawri_id number,
       p_dnpaqi_id number,
       p_reactivation_date varchar2,
       p_dnpamar_id number,
       p_dnparcr_id number,
       p_fnpabd_id out number) 
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FNPABD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
      v_receipt_date date := null;
      v_invoiceable_date date := null;
      v_reactivation_date date := null;
    begin
    
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_receipt_date := to_date(p_receipt_date,BPM_COMMON.DATE_FMT);
      v_invoiceable_date := to_date(p_invoiceable_date,BPM_COMMON.DATE_FMT);
      v_reactivation_date := to_date(p_reactivation_date,BPM_COMMON.DATE_FMT);
      p_fnpabd_id := SEQ_FNPABD_ID.nextval;
      
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
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
      insert into F_NYEC_PA_BY_DATE
        (FNPABD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         NYEC_PA_BI_ID,
         DNPACOU_ID,
         DNPAHS_ID,
         DNPAAS_ID,
         "Receipt Date",
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT,
         "Invoiceable Date",
         DNPACIN_ID,
         DNPAFPBPST_ID,
         DNPAHIAI_ID,
         DNPAHCS_ID,
         DNPARI_ID,
         DNPARR_ID,
         DNPARB_ID,
         DNPARN_ID,
         DNPAMC_ID,
         DNPAML_ID,
         DNPAONF_ID,
         DNPAOLS_ID,
         DNPAWRI_ID,
         DNPAQI_ID,
         "Reactivation Date",
         DNPAMAR_ID,
         DNPARCR_ID)
      values
        (p_fnpabd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dnpacou_id,
         p_dnpahs_id,
         p_dnpaas_id,
         v_receipt_date,
         1,
         case 
         when p_end_date is null then 1
         else 0
         end,
         case 
           when p_end_date is null then 0
           else 1
           end,
         v_invoiceable_date,
         p_dnpacin_id,
         p_dnpafpbpst_id,
         p_dnpahiai_id,
         p_dnpahcs_id,
         p_dnpari_id,
         p_dnparr_id,
         p_dnparb_id,
         p_dnparn_id,
         p_dnpamc_id,
         p_dnpaml_id,
         p_dnpaonf_id,
         p_dnpaols_id,
         p_dnpawri_id,
         p_dnpaqi_id,
         v_reactivation_date,
         p_dnpamar_id,
         p_dnparcr_id
        );
        
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
      
  end; 
  
  
  -- Insert BPM Event model data.
  procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number)
  as
    
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_bi_id number := null;
    v_bue_id number := null;
    
    v_identifier varchar2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_new_data T_INS_PA_XML := null;
      
  begin
  
    if p_data_version != 4 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_PA_XML(p_new_data_xml,v_new_data);
  
    v_bi_id := SEQ_BI_ID.nextval;
    v_identifier := v_new_data.APP_ID || '_' || to_char(v_new_data.REACTIVATION_NBR);
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    insert into BPM_INSTANCE 
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.CEPA_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
  
    commit;
    
    v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
    
    BPM_EVENT.INSERT_BIA(v_bi_id,37,2,v_new_data.APP_COMPLETE_RESULT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,38,2,v_new_data.APP_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,39,2,v_new_data.APP_STATUS_GROUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,40,1,v_new_data.APP_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,41,2,v_new_data.APP_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,42,2,v_new_data.AUTO_REPROCESS_FLAG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,44,2,v_new_data.ASF_CANCEL_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,45,2,v_new_data.ASPB_CANCEL_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,47,3,v_new_data.CANCEL_DATE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,49,2,v_new_data.CHANNEL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,50,2,v_new_data.CLOCKDOWN_INDICATOR,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,52,2,v_new_data.ASF_CLOSE_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,53,2,v_new_data.ASPB_CLOSE_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,56,2,v_new_data.ASF_COMPLETE_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,57,2,v_new_data.ASPB_COMPLETE_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,59,2,v_new_data.COUNTY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,60,1,v_new_data.CURRENT_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,61,1,v_new_data.DE_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,62,2,v_new_data.ELIGIBILITY_ACTION,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,63,2,v_new_data.HEART_APP_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,64,2,v_new_data.HEART_SYNCH_FLAG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,69,3,v_new_data.APP_CYCLE_END_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,70,3,v_new_data.APP_CYCLE_START_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,71,3,v_new_data.LAST_MAIL_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,72,1,v_new_data.MI_RECEIVED_TASK_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,73,2,v_new_data.GWF_MISSING_INFO,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,74,2,v_new_data.GWF_NEW_MI,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,75,3,v_new_data.NOTIFY_CLIENT_PENDED_APP_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,77,2,v_new_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,78,2,v_new_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,79,3,v_new_data.ASSD_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,80,2,v_new_data.GWF_OUTCM_NOTIFY_RQRD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,81,2,v_new_data.GWF_PEND_NOTIFY_RQRD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,82,3,v_new_data.PERFORM_QC_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,84,2,v_new_data.ASF_PERFORM_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,85,2,v_new_data.ASPB_PERFORM_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,86,3,v_new_data.ASSD_PERFORM_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,87,3,v_new_data.PERFORM_RESEARCH_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,89,2,v_new_data.ASF_PERFORM_RESEARCH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,90,2,v_new_data.ASPB_PERFORM_RESEARCH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,91,3,v_new_data.ASSD_PERFORM_RESEARCH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,92,3,v_new_data.PROCESS_APP_INFO_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,94,2,v_new_data.ASF_PROCESS_APP_INFO,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,95,2,v_new_data.ASPB_PROCESS_APP_INFO,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,96,3,v_new_data.ASSD_PROCESS_APP_INFO,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,97,2,v_new_data.GWF_QC_OUTCOME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,98,2,v_new_data.GWF_QC_RQRD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,99,1,v_new_data.QC_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,100,3,v_new_data.RECEIPT_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,102,2,v_new_data.ASF_RECEIVE_PROCESS_MI,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,106,2,v_new_data.ASF_RECEIVE_APP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,109,2,v_new_data.REFER_LDSS_FLAG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,110,2,v_new_data.GWF_RESEARCH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,111,2,v_new_data.RESEARCH_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,112,1,v_new_data.RESEARCH_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,113,3,v_new_data.RVW_ENTER_DATA_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,115,2,v_new_data.ASF_REVIEW_ENTER_DATA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,116,2,v_new_data.ASPB_RVW_ENTER_DATA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,117,3,v_new_data.ASSD_RVW_ENTER_DATA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,123,3,v_new_data.SLA_JEOPARDY_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,124,1,v_new_data.STATE_REVIEW_TASK_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,125,1,v_new_data.STATE_REVIEW_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,126,3,v_new_data.WAIT_STATE_APPROVAL_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,128,2,v_new_data.ASPB_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,129,3,v_new_data.ASSD_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,130,2,v_new_data.ASF_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,133,3,v_new_data.COMPLETE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,134,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,136,1,v_new_data.SLA_DAYS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,137,2,v_new_data.SLA_DAYS_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,138,1,v_new_data.SLA_JEOPARDY_DAYS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,139,1,v_new_data.SLA_TARGET_DAYS,v_start_date,v_bue_id);
        
    -- r3
    BPM_EVENT.INSERT_BIA(v_bi_id,405,2,v_new_data.CIN,v_start_date,v_bue_id);               
    BPM_EVENT.INSERT_BIA(v_bi_id,406,3,v_new_data.CIN_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,407,2,v_new_data.PROVIDER_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,409,2,v_new_data.FPBP_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,410,2,v_new_data.REV_CLEAR_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,411,3,v_new_data.REV_CLEAR_IND_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,412,2,v_new_data.REV_CLEAR_OUTCOME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,413,2,v_new_data.UPSTATE_INDICATOR,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,414,3,v_new_data.INVOICE_READY_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,415,2,v_new_data.HEART_INCMPLT_APP_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,417,2,v_new_data.WMS_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,418,2,v_new_data.HEART_REPROCESS_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,419,3,v_new_data.HEART_REPROCESS_STATUS_DT,v_start_date,v_bue_id);
        
    -- r4
    BPM_EVENT.INSERT_BIA(v_bi_id,425,2,v_new_data.HEART_CASE_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,426,2,v_new_data.STATE_CASE_IDEN,v_start_date,v_bue_id);
    
    -- Reactivation
    BPM_EVENT.INSERT_BIA(v_bi_id,481,2,v_new_data.STOP_APP_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,482,2,v_new_data.REACTIVATION_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,483,1,v_new_data.REACTIVATION_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,484,1,v_new_data.REACTIVATION_NBR,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,485,2,v_new_data.WORKFLOW_REACT_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,486,2,v_new_data.CURR_MODE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,487,2,v_new_data.CURR_MODE_LABEL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,488,2,v_new_data.OUTCOME_LTR_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,489,2,v_new_data.OUTCOME_LTR_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,490,1,v_new_data.OUTCOME_LTR_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,491,3,v_new_data.OUTCOME_LTR_CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,492,3,v_new_data.OUTCOME_LTR_SENT_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,493,2,v_new_data.REACTIVATED_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,494,3,v_new_data.REACTIVATION_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,495,2,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,496,2,v_new_data.QC_IND,v_start_date,v_bue_id);

    --v4
    BPM_EVENT.INSERT_BIA(v_bi_id,1592,2,v_new_data.REV_CLEAR_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1593,2,v_new_data.MA_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1594,1,v_new_data.OFFICE_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1595,1,v_new_data.APPLICANT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1596,1,v_new_data.REG_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1597,1,v_new_data.QC_REG_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1598,3,v_new_data.PERFORM_QC_REG_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1599,3,v_new_data.ASSD_REG_ENTER_DATA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1600,3,v_new_data.ASSD_PERFORM_QC_REG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1601,2,v_new_data.ASPB_REG_ENTER_DATA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1602,2,v_new_data.ASPB_PERFORM_QC_REG,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1603,1,v_new_data.NUMBER_OF_APPLICANTS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id,1604,3,v_new_data.REG_ENTER_DATA_DT,v_start_date,v_bue_id);
    
    commit;
    
    p_bue_id := v_bue_id;
    
  exception
     
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
    
  end;
  
  
  -- Insert or update dimension for BPM Semantic model - Process App process - Current.
  procedure SET_DNPACUR
    (p_set_type in varchar2,
     p_identifier in varchar2,
     p_bi_id in number,
     p_application_id in varchar2,
     p_app_complete_result in varchar2,
     p_application_type in varchar2,
     p_auto_reprocess_flag in varchar2,
     p_cancel_app_flag in varchar2,
     p_cancel_app_performed_by in varchar2,
     p_cancel_date in varchar2,
     p_channel in varchar2,
     p_close_app_flag in varchar2,
     p_close_app_performed_by in varchar2,
     p_complete_app_flag in varchar2,
     p_complete_app_performed_by in varchar2,
     p_complete_date in varchar2,
     p_create_date in varchar2,
     p_current_task_id in varchar2,
     p_data_entry_task_id in varchar2,
     p_eligibility_action in varchar2,
     p_kpr_app_cycle_end_date in varchar2,
     p_kpr_app_cycle_start_date in varchar2,
     p_last_mail_date in varchar2,
     p_mi_received_task_count in varchar2,
     p_missing_information_flag in varchar2,
     p_new_mi_flag in varchar2,
     p_notify_clnt_pend_app_date in varchar2,
     p_notify_clnt_pend_app_flag in varchar2,
     p_notfy_clnt_pnd_app_prfmd_by in varchar2,
     p_notfy_clnt_pnd_app_srt_date in varchar2,
     p_outcome_notif_req_gate_flag in varchar2,
     p_pend_notification_rqrd_flag in varchar2,
     p_perform_qc_date in varchar2,
     p_perform_qc_performed_by in varchar2,
     p_perform_qc_flag in varchar2,
     p_perform_qc_start_date in varchar2,
     p_perform_research_date in varchar2,
     p_perfrm_reserch_perfrmd_by in varchar2,
     p_perform_research_flag in varchar2,
     p_perform_research_start_date in varchar2,
     p_process_app_info_date in varchar2,	  
     p_process_app_info_flag in varchar2,
     p_proces_app_info_perfrmd_by in varchar2,
     p_process_app_info_start_date in varchar2,
     p_qc_outcome_flag in varchar2,
     p_qc_required_flag in varchar2,
     p_qc_task_id in varchar2,
     p_receive_and_process_mi_flag in varchar2,
     p_receive_app_flag in varchar2,
     p_research_flag in varchar2,
     p_research_reason in varchar2,
     p_research_task_id in varchar2,
     p_review_enter_data_date in varchar2,
     p_revw_entr_data_perfrmd_by in varchar2,
     p_review_enter_data_flag in varchar2,
     p_revw_entr_data_strt_date in varchar2,
     p_sla_days in varchar2,
     p_sla_days_type in varchar2,
     p_sla_jeopardy_days in varchar2,
     p_sla_jeopardy_date in varchar2,
     p_sla_target_days in varchar2,
     p_state_review_task_count in varchar2,
     p_state_review_task_id in varchar2,
     p_wait_state_approval_date in varchar2,
     p_wait_state_approval_flag in varchar2,
     p_wait_state_aprvl_prfrmd_by in varchar2,
     p_wait_state_aprvl_strt_date in varchar2,
     p_cur_app_status in varchar2,
     p_cur_app_status_group in varchar2,
     p_cur_county in varchar2,
     p_cur_heart_app_status in varchar2,
     p_cur_heart_synch_flag in varchar2,
     p_cur_receipt_date in varchar2,
     p_cur_refer_to_ldss_flag in varchar2,
         
     -- r3
     p_cin in varchar2,
     p_cin_date in varchar2,
     p_provider_name in varchar2,
     p_fpbp_sub_type in varchar2,
     p_revrse_clernce_ind in varchar2,
     p_revrse_clernce_ind_date in varchar2,
     p_revrse_clernce_outcm in varchar2,
     p_upstat_dwnstat_ind in varchar2,
     p_invoiceable_date in varchar2,
     p_HEART_incmplte_app_ind in varchar2,
                 
     -- r4
     p_HEART_case_status in varchar2,
     p_state_case_iden in varchar2,
     
     -- Reactivation
     p_stop_app_reason in varchar2,
     p_reactivation_reason in varchar2,
     p_reactivation_ind in number,
     p_reactivation_nbr in number,
     p_workflow_react_ind in varchar2,
     p_curr_mode_cd in varchar2,
     p_curr_mode_label in varchar2,
     p_outcome_ltr_type in varchar2,
     p_outcome_ltr_status in varchar2,
     p_outcome_ltr_id in number,
     p_outcome_ltr_create_dt in varchar2,
     p_outcome_ltr_sent_dt in varchar2,
     p_reactivated_by in varchar2,
     p_reactivation_dt in varchar2,
     p_outcome_notify_rqrd_flag in varchar2,
     p_qc_ind in varchar2,
     
     --v4
     p_rcr_id in varchar2,
     p_mar_id in varchar2,
     p_applicant_id in varchar2,
     p_office_id in varchar2,
     p_reg_task_id in varchar2,
     p_qc_reg_task_id in varchar2,
     p_perform_qc_reg_dt in varchar2,
     p_assd_reg_enter_date in varchar2,
     p_assd_perform_qc_reg in varchar2,
     p_aspb_reg_enter_data in varchar2,
     p_aspb_perform_qc_reg in varchar2,
     p_number_of_applicants in varchar2,
     p_reg_enter_data_dt in varchar2
    )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DNPACUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dnpacur D_NYEC_PA_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(1) := null; 
  begin
    
    r_dnpacur."Complete Date" := to_date(p_complete_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Create Date" := to_date(p_create_date,BPM_COMMON.DATE_FMT);
      
    r_dnpacur."Cur Receipt Date" := to_date(p_cur_receipt_date,BPM_COMMON.DATE_FMT); 
    r_dnpacur."KPR App Cycle End Date" := to_date(p_kpr_app_cycle_end_date,BPM_COMMON.DATE_FMT);	
    r_dnpacur."KPR App Cycle Start Date" := to_date(p_kpr_app_cycle_start_date,BPM_COMMON.DATE_FMT);
      
    r_dnpacur."SLA Days Type" := p_sla_days_type;
    r_dnpacur."SLA Days" := p_sla_days;
    r_dnpacur."SLA Jeopardy Days" := p_sla_jeopardy_days;
    r_dnpacur."SLA Target Days" := p_sla_target_days;
    r_dnpacur."Cur App Status Group" := p_cur_app_status_group;
      
      
    r_dnpacur.NYEC_PA_BI_ID := p_bi_id;
    r_dnpacur."Application ID" := p_application_id; 
    
    r_dnpacur."Age in Business Days" := GET_AGE_IN_BUSINESS_DAYS(r_dnpacur."Create Date",r_dnpacur."Complete Date");
    r_dnpacur."KPR App Cycle Business Days" := GET_APP_CYCLE_BUS_DAYS(r_dnpacur."Cur Receipt Date",r_dnpacur."Complete Date");
    r_dnpacur."Age in Calendar Days" := GET_AGE_IN_CALENDAR_DAYS(r_dnpacur."Create Date",r_dnpacur."Complete Date");
    r_dnpacur."KPR App Cycle Calendar Days" := GET_APP_CYCLE_CAL_DAYS(r_dnpacur."Cur Receipt Date",r_dnpacur."Complete Date");
    r_dnpacur."App Age in Calendar Days" := trunc(sysdate)-trunc(r_dnpacur."Cur Receipt Date");	  

    begin
      select "Jeopardy Flag"
      into v_jeopardy_flag
      from D_NYEC_PA_CURRENT
      where NYEC_PA_BI_ID = p_bi_id;
    exception
      when others then
        null; -- ignore    
    end;
      
    r_dnpacur."Jeopardy Flag" := GET_JEOPARDY_FLAG(r_dnpacur."Cur Receipt Date",r_dnpacur."Complete Date",p_sla_days_type,p_sla_jeopardy_days,v_jeopardy_flag);
    r_dnpacur."Timeliness Status" := GET_TIMELINESS_STATUS(r_dnpacur."Cur Receipt Date",r_dnpacur."Complete Date",p_sla_days_type,p_sla_days);
    r_dnpacur."Days To Timeout" := GET_DAYS_UNTIL_TIMEOUT(r_dnpacur."KPR App Cycle End Date");
     
    r_dnpacur."SLA Jeopardy Date" := to_date(p_sla_jeopardy_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."App Complete Result" := p_app_complete_result;
	  r_dnpacur."Application Type" := p_application_type;
	  r_dnpacur."Auto Reprocess Flag" := p_auto_reprocess_flag;
	  r_dnpacur."Cancel App Flag" := p_cancel_app_flag;
	  r_dnpacur."Cancel App Performed By" := p_cancel_app_performed_by;
    r_dnpacur."Cancel Date" := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Channel" := p_channel;
    r_dnpacur."Close App Flag" := p_close_app_flag;
    r_dnpacur."Close App Performed By" := p_close_app_performed_by;
    r_dnpacur."Complete App Flag" := p_complete_app_flag;
    r_dnpacur."Complete App Performed By" := p_complete_app_performed_by;
    r_dnpacur."Current Task ID" := p_current_task_id;
    r_dnpacur."Data Entry Task ID" := p_data_entry_task_id;
    r_dnpacur."Eligibility Action" := p_eligibility_action;
	 
    r_dnpacur."Last Mail Date" := to_date(p_last_mail_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."MI Received Task Count" := p_mi_received_task_count;
    r_dnpacur."Missing Information Flag" := p_missing_information_flag; 
    r_dnpacur."New MI Flag" := p_new_mi_flag; 
    r_dnpacur."Notify Clnt Pend App Date" := to_date(p_notify_clnt_pend_app_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Notify Clnt Pend App Flag" := p_notify_clnt_pend_app_flag;
    r_dnpacur."Notify Clnt Pend App Prfrmd By" := p_notfy_clnt_pnd_app_prfmd_by;
    r_dnpacur."Notify Clnt Pend App Strt Date" := to_date(p_notfy_clnt_pnd_app_srt_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Outcome Notif Req Gateway Flag" := p_outcome_notif_req_gate_flag;
    r_dnpacur."Pend Notification Rqrd Flag" := p_pend_notification_rqrd_flag;
    r_dnpacur."Perform QC Date" := to_date(p_perform_qc_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Perform QC Performed By" := p_perform_qc_performed_by;
    r_dnpacur."Perform QC Flag" := p_perform_qc_flag;
    r_dnpacur."Perform QC Start Date" := to_date(p_perform_qc_start_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Perform Research Date" := to_date(p_perform_research_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Perform Research Performed By" := p_perfrm_reserch_perfrmd_by;
    r_dnpacur."Perform Research Flag" := p_perform_research_flag;
    r_dnpacur."Perform Research Start Date" := to_date(p_perform_research_start_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Process App Info Date" := to_date(p_process_app_info_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Process App Info Flag" := p_process_app_info_flag;
    r_dnpacur."Process App Info Performed By" := p_proces_app_info_perfrmd_by;
    r_dnpacur."Process App Info Start Date" := to_date(p_process_app_info_start_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."QC Outcome Flag" := p_qc_outcome_flag; 
    r_dnpacur."QC Required Flag" :=  p_qc_required_flag;
    r_dnpacur."QC Task ID" := p_qc_task_id;
    r_dnpacur."Receive and Process MI Flag" := p_receive_and_process_mi_flag;
    r_dnpacur."Receive App Flag" := p_receive_app_flag;
    r_dnpacur."Research Flag" := p_research_flag;
    r_dnpacur."Research Reason" := p_research_reason;
    r_dnpacur."Research Task ID" := p_research_task_id;
    r_dnpacur."Review Enter Data Date" := to_date(p_review_enter_data_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Review Enter Data Performed By" := p_revw_entr_data_perfrmd_by;
    r_dnpacur."Review Enter Data Flag" := p_review_enter_data_flag;
    r_dnpacur."Review Enter Data Start Date" := to_date(p_revw_entr_data_strt_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."State Review Task Count" := p_state_review_task_count;
    r_dnpacur."State Review Task ID" := p_state_review_task_id;
    r_dnpacur."Wait State Approval Date" := to_date(p_wait_state_approval_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Wait State Approval Flag" := p_wait_state_approval_flag;
    r_dnpacur."Wait State Approval Prfrmd By" := p_wait_state_aprvl_prfrmd_by;
    r_dnpacur."Wait State Approval Start Date" := to_date(p_wait_state_aprvl_strt_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Cur App Status" := p_cur_app_status;
	 
    r_dnpacur."Cur County" := p_cur_county;
    r_dnpacur."Cur HEART App Status" := p_cur_heart_app_status;
    r_dnpacur."Cur HEART Synch Flag" := p_cur_heart_synch_flag;
    r_dnpacur."Cur Refer to LDSS Flag" := p_cur_refer_to_ldss_flag;
    
    -- r3
    r_dnpacur."Cur CIN" := p_cin;
    r_dnpacur."CIN Date" := to_date(p_cin_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Provider Name" := p_provider_name ;
    r_dnpacur."Cur FPBP Sub-type" := p_fpbp_sub_type;
    r_dnpacur."Reverse Clearance Indictr" := p_revrse_clernce_ind ;
    r_dnpacur."Reverse Clearance Indictr Date" := to_date(p_revrse_clernce_ind_date,BPM_COMMON.DATE_FMT) ;
    r_dnpacur."Reverse Clearance Outcome" := p_revrse_clernce_outcm ;
    r_dnpacur."Upstate/Downstate Indictr" := p_upstat_dwnstat_ind;
    r_dnpacur."Invoiceable Date" := to_date(p_invoiceable_date,BPM_COMMON.DATE_FMT);
    r_dnpacur."Cur HEART Incomplete App Ind" := p_HEART_incmplte_app_ind;
    
    -- r4 
    r_dnpacur."Cur HEART Case Status" := p_HEART_case_status;
    r_dnpacur."State Case Identifier" := p_state_case_iden;
    
    -- Reactivation
    r_dnpacur."Stop Application Reason" := p_stop_app_reason;
    r_dnpacur."Cur Reactivation Reason" := p_reactivation_reason;
    r_dnpacur."Cur Reactivation Indicator" := p_reactivation_ind;
    r_dnpacur."Cur Reactivation Number" := p_reactivation_nbr;
    r_dnpacur."Cur Workflow Reactivation Ind" := p_workflow_react_ind;
    r_dnpacur."Cur Mode Code" := p_curr_mode_cd;
    r_dnpacur."Cur Mode Label" := p_curr_mode_label;
    r_dnpacur."Outcome Letter Type" := p_outcome_ltr_type;
    r_dnpacur."Cur Outcome Letter Status" := p_outcome_ltr_status;
    r_dnpacur."Outcome Letter ID" := p_outcome_ltr_id;
    r_dnpacur."Outcome Letter Create Date" := to_date(p_outcome_ltr_create_dt,BPM_COMMON.DATE_FMT);
    r_dnpacur."Outcome Letter Send Date" := to_date(p_outcome_ltr_sent_dt,BPM_COMMON.DATE_FMT);    
    r_dnpacur."Cur Reactivated By" := p_reactivated_by;
    r_dnpacur."Cur Reactivation Date" := to_date(p_reactivation_dt,BPM_COMMON.DATE_FMT);
    r_dnpacur."Cur Outcome Notif Req Flag" := p_outcome_notify_rqrd_flag;
    r_dnpacur."Cur QC Indicator" := p_qc_ind;

    --v4
    r_dnpacur.CUR_MA_REASON := p_mar_id;
    r_dnpacur.CUR_REVERSE_CLEARANCE_REASON := p_rcr_id;
    r_dnpacur.APPLICANT_ID := p_applicant_id;
    r_dnpacur.PROVIDER_ID := p_office_id;
    r_dnpacur.REGISTRATION_TASK_ID := p_reg_task_id;
    r_dnpacur.QC_REGISTRATION_TASK_ID := p_qc_reg_task_id;
    r_dnpacur.PERFORM_QC_REG_START_DATE := to_date(p_perform_qc_reg_dt,BPM_COMMON.DATE_FMT);
    r_dnpacur.REG_AND_ENTER_DATA_START_DATE := to_date(p_assd_reg_enter_date,BPM_COMMON.DATE_FMT);
    r_dnpacur.PERFORM_QC_REG_START_DATE := to_date(p_assd_perform_qc_reg,BPM_COMMON.DATE_FMT);
    r_dnpacur.REG_AND_ENTER_DATA_PERFORM_BY := p_aspb_reg_enter_data;
    r_dnpacur.PERFORM_QC_REG_PERFORMED_BY := p_aspb_perform_qc_reg;
    r_dnpacur.PERFORM_QC_REG_DATE := to_date(p_assd_perform_qc_reg,BPM_COMMON.DATE_FMT);
    r_dnpacur.NUMBER_OF_APPLICANTS := p_number_of_applicants;
    r_dnpacur.PERFORM_REG_ENTER_DATA_DATE := to_date(p_reg_enter_data_dt,BPM_COMMON.DATE_FMT);
      
    if p_set_type = 'INSERT' then
      insert into D_NYEC_PA_CURRENT
      values r_dnpacur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_NYEC_PA_CURRENT
        set row = r_dnpacur
        where NYEC_PA_BI_ID = p_bi_id;
      end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
      
  exception
    
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
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
      
    v_new_data T_INS_PA_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dnpacou_id number := null;  
    v_dnpahs_id number := null;
    v_dnpaas_id number := null;
    v_fnpabd_id number := null;
    v_dnpacin_id number := null;
    v_dnpafpbpst_id number := null;
    v_dnpahiai_id number := null;
    v_dnpahcs_id number := null;   
    v_dnpari_id number := null;
    v_dnparr_id number := null;
    v_dnparb_id number := null;
    v_dnparn_id number := null;
    v_dnpamc_id number := null;
    v_dnpaml_id number := null;
    v_dnpaonf_id number := null;
    v_dnpaols_id number := null;
    v_dnpasar_id number := null;
    v_dnpawri_id number := null;
    v_dnpaqi_id number := null;
    v_dnpamar_id number := null;
    v_dnparcr_id number := null;
       
  begin
  
    if p_data_version != 4 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_PA_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.APP_ID || '_' || to_char(v_new_data.REACTIVATION_NBR);
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;
  
    GET_DNPACOU_ID(v_identifier,v_bi_id,v_new_data.COUNTY,v_dnpacou_id);
    GET_DNPAHS_ID(v_identifier,v_bi_id,v_new_data.HEART_SYNCH_FLAG,v_dnpahs_id);
    GET_DNPAAS_ID(v_identifier,v_bi_id,v_new_data.APP_STATUS,v_new_data.APP_STATUS_GROUP,v_new_data.HEART_APP_STATUS,v_new_data.REFER_LDSS_FLAG,v_dnpaas_id);
      
    GET_DNPACIN_ID(v_identifier,v_bi_id,v_new_data.CIN,v_dnpacin_id );
    GET_DNPAFPBPST_ID(v_identifier,v_bi_id,v_new_data.FPBP_TYPE,v_dnpafpbpst_id );
    GET_DNPAHIAI_ID(v_identifier,v_bi_id,v_new_data.HEART_INCMPLT_APP_IND,v_dnpahiai_id);
    GET_DNPAHCS_ID(v_identifier,v_bi_id,v_new_data.HEART_CASE_STATUS,v_dnpahcs_id);

    GET_DNPARI_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_IND,v_dnpari_id);    
    GET_DNPARR_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_REASON,v_dnparr_id);
    GET_DNPARB_ID(v_identifier,v_bi_id,v_new_data.REACTIVATED_BY,v_dnparb_id);
    GET_DNPARN_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_NBR,v_dnparn_id);
    GET_DNPAMC_ID(v_identifier,v_bi_id,v_new_data.CURR_MODE_CD,v_dnpamc_id);
    GET_DNPAML_ID(v_identifier,v_bi_id,v_new_data.CURR_MODE_LABEL,v_dnpaml_id);
    GET_DNPAONF_ID(v_identifier,v_bi_id,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_dnpaonf_id);
    GET_DNPAOLS_ID(v_identifier,v_bi_id,v_new_data.OUTCOME_LTR_STATUS,v_dnpaols_id);
    GET_DNPAWRI_ID(v_identifier,v_bi_id,v_new_data.WORKFLOW_REACT_IND,v_dnpawri_id);
    GET_DNPAQI_ID(v_identifier,v_bi_id,v_new_data.QC_IND,v_dnpaqi_id);

    GET_DNPAMAR_ID(v_identifier,v_bi_id,v_new_data.MA_REASON,v_dnpamar_id);
    GET_DNPARCR_ID(v_identifier,v_bi_id,v_new_data.REV_CLEAR_REASON,v_dnparcr_id);
       
    -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
         
      SET_DNPACUR
        ('INSERT',v_identifier,v_bi_id,
         v_new_data.APP_ID,v_new_data.APP_COMPLETE_RESULT,v_new_data.APP_TYPE,
         v_new_data.AUTO_REPROCESS_FLAG,v_new_data.ASF_CANCEL_APP,v_new_data.ASPB_CANCEL_APP,v_new_data.CANCEL_DATE,
         v_new_data.CHANNEL,v_new_data.ASF_CLOSE_APP,v_new_data.ASPB_CLOSE_APP,v_new_data.ASF_COMPLETE_APP,v_new_data.ASPB_COMPLETE_APP,
         v_new_data.COMPLETE_DT,v_new_data.CREATE_DT,v_new_data.CURRENT_TASK_ID,v_new_data.DE_TASK_ID,v_new_data.ELIGIBILITY_ACTION,
         v_new_data.APP_CYCLE_END_DT,v_new_data.APP_CYCLE_START_DT,v_new_data.LAST_MAIL_DT,
         v_new_data.MI_RECEIVED_TASK_COUNT,v_new_data.GWF_MISSING_INFO,v_new_data.GWF_NEW_MI,v_new_data.NOTIFY_CLIENT_PENDED_APP_DT,
         v_new_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASSD_NOTIFY_CLIENT_PENDED_APP,
         v_new_data.GWF_OUTCM_NOTIFY_RQRD,v_new_data.GWF_PEND_NOTIFY_RQRD,v_new_data.PERFORM_QC_DT,v_new_data.ASPB_PERFORM_QC,
         v_new_data.ASF_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.PERFORM_RESEARCH_DT,v_new_data.ASPB_PERFORM_RESEARCH,v_new_data.ASF_PERFORM_RESEARCH,
         v_new_data.ASSD_PERFORM_RESEARCH,v_new_data.PROCESS_APP_INFO_DT,v_new_data.ASF_PROCESS_APP_INFO,v_new_data.ASPB_PROCESS_APP_INFO,v_new_data.ASSD_PROCESS_APP_INFO,
         v_new_data.GWF_QC_OUTCOME,v_new_data.GWF_QC_RQRD,v_new_data.QC_TASK_ID,v_new_data.ASF_RECEIVE_PROCESS_MI,v_new_data.ASF_RECEIVE_APP,
         v_new_data.GWF_RESEARCH,v_new_data.RESEARCH_REASON,v_new_data.RESEARCH_TASK_ID,v_new_data.RVW_ENTER_DATA_DT,v_new_data.ASPB_RVW_ENTER_DATA,
         v_new_data.ASF_REVIEW_ENTER_DATA,v_new_data.ASSD_RVW_ENTER_DATA,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DT,
         v_new_data.SLA_TARGET_DAYS,v_new_data.STATE_REVIEW_TASK_COUNT,v_new_data.STATE_REVIEW_TASK_ID,v_new_data.WAIT_STATE_APPROVAL_DT,
         v_new_data.ASF_WAIT_STATE_APPROVAL,v_new_data.ASPB_WAIT_STATE_APPROVAL,v_new_data.ASSD_WAIT_STATE_APPROVAL,v_new_data.APP_STATUS,v_new_data.APP_STATUS_GROUP,
         v_new_data.COUNTY,v_new_data.HEART_APP_STATUS,v_new_data.HEART_SYNCH_FLAG,v_new_data.RECEIPT_DT,v_new_data.REFER_LDSS_FLAG,    
         v_new_data.CIN,v_new_data.CIN_DT,v_new_data.PROVIDER_NAME,v_new_data.FPBP_TYPE,v_new_data.REV_CLEAR_IND,	
         v_new_data.REV_CLEAR_IND_DT,v_new_data.REV_CLEAR_OUTCOME,v_new_data.UPSTATE_INDICATOR,v_new_data.INVOICE_READY_DT,v_new_data.HEART_INCMPLT_APP_IND,	                    
         v_new_data.HEART_CASE_STATUS,v_new_data.STATE_CASE_IDEN,
         v_new_data.STOP_APP_REASON, v_new_data.REACTIVATION_REASON,v_new_data.REACTIVATION_IND,v_new_data.REACTIVATION_NBR,
         v_new_data.WORKFLOW_REACT_IND,v_new_data.CURR_MODE_CD,v_new_data.CURR_MODE_LABEL,v_new_data.OUTCOME_LTR_TYPE,
         v_new_data.OUTCOME_LTR_STATUS,v_new_data.OUTCOME_LTR_ID,v_new_data.OUTCOME_LTR_CREATE_DT,v_new_data.OUTCOME_LTR_SENT_DT,
         v_new_data.REACTIVATED_BY,v_new_data.REACTIVATION_DT,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_new_data.QC_IND,
         v_new_data.REV_CLEAR_REASON,v_new_data.MA_REASON,v_new_data.APPLICANT_ID,v_new_data.OFFICE_ID,
         v_new_data.REG_TASK_ID,v_new_data.QC_REG_TASK_ID,v_new_data.PERFORM_QC_REG_DT,v_new_data.ASSD_REG_ENTER_DATA,v_new_data.ASSD_PERFORM_QC_REG,
         v_new_data.ASPB_REG_ENTER_DATA,v_new_data.ASPB_PERFORM_QC_REG,v_new_data.NUMBER_OF_APPLICANTS,v_new_data.REG_ENTER_DATA_DT
        ); 
        
      INS_FNPABD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dnpacou_id,v_dnpahs_id,v_dnpaas_id,v_new_data.RECEIPT_DT,v_new_data.STG_LAST_UPDATE_DATE,
         v_new_data.INVOICE_READY_DT,v_dnpacin_id,v_dnpafpbpst_id,v_dnpahiai_id,v_dnpahcs_id,
         v_dnpari_id,v_dnparr_id,v_dnparb_id,v_dnparn_id,v_dnpamc_id,v_dnpaml_id,
         v_dnpaonf_id,v_dnpaols_id,v_dnpawri_id,v_dnpaqi_id,v_new_data.REACTIVATION_DT,v_dnpamar_id,v_dnparcr_id,
         v_fnpabd_id);
      
      commit;
            
    exception
          
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
        raise;
      
    end;
      
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
      raise; 
      
  end;
  
   
  -- Update fact for BPM Semantic model - NYEC Process App process. 
  procedure UPD_FNPABD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dnpacou_id in number,
     p_dnpahs_id in number,
     p_dnpaas_id in number,
     p_receipt_date in varchar2,
     p_stg_last_update_date in varchar2,
     p_invoiceable_date in varchar2,
     p_dnpacin_id in number,
     p_dnpafpbpst_id in number,
     p_dnpahiai_id in number,
     p_dnpahcs_id in number,
     p_dnpari_id in number,
     p_dnparr_id in number,
     p_dnparb_id in number,
     p_dnparn_id in number,
     p_dnpamc_id in number,
     p_dnpaml_id in number,
     p_dnpaonf_id in number,
     p_dnpaols_id in number,
     p_dnpawri_id in number,
     p_dnpaqi_id in number,
     p_reactivation_date in varchar2,
     p_dnpamar_id in number,
     p_dnparcr_id in number,
     p_fnpabd_id out number) 
     
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FNPABD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fnpabd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_invoiceable_date date := null;
    v_event_date date := null;
    
    v_dnpacou_id number := null;
    v_dnpahs_id number := null;
    v_dnpaas_id number := null;
    v_dnpacin_id number := null;
    v_dnpafpbpst_id number := null;
    v_dnpahiai_id number := null;
    v_dnpahcs_id number := null;
    v_fnpabd_id number := null;
    
    v_dnpari_id number := null;
    v_dnparr_id number := null;
    v_dnparb_id number := null;
    v_dnparn_id number := null;
    v_dnpamc_id number := null;
    v_dnpaml_id number := null;
    v_dnpaonf_id number := null;
    v_dnpaols_id number := null;
    v_dnpawri_id number := null;
    v_dnpaqi_id number := null;
    v_reactivation_date date := null;
    
    v_dnpamar_id number := null;
    v_dnparcr_id number := null;

    r_fnpabd F_NYEC_PA_BY_DATE%rowtype := null;
    r_fnpabd_precreate_complete F_NYEC_PA_BY_DATE%rowtype := null;
    
  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_receipt_date := to_date(p_receipt_date,BPM_COMMON.DATE_FMT);
    v_invoiceable_date := to_date(p_invoiceable_date,BPM_COMMON.DATE_FMT);
    v_reactivation_date := to_date(p_reactivation_date,BPM_COMMON.DATE_FMT);
    
    v_dnpacou_id := p_dnpacou_id;
    v_dnpahs_id := p_dnpahs_id;
    v_dnpaas_id := p_dnpaas_id;
    v_dnpacin_id := p_dnpacin_id;
    v_dnpafpbpst_id := p_dnpafpbpst_id;
    v_dnpahiai_id := p_dnpahiai_id;
    v_dnpahcs_id := p_dnpahcs_id;
    v_fnpabd_id := p_fnpabd_id;

    v_dnpari_id := p_dnpari_id;
    v_dnparr_id := p_dnparr_id;
    v_dnparb_id := p_dnparb_id;
    v_dnparn_id := p_dnparn_id;
    v_dnpamc_id := p_dnpamc_id;
    v_dnpaml_id := p_dnpaml_id;
    v_dnpaonf_id := p_dnpaonf_id;
    v_dnpaols_id := p_dnpaols_id;
    v_dnpawri_id := p_dnpawri_id;
    v_dnpaqi_id := p_dnpaqi_id;
    v_dnpamar_id := p_dnpamar_id;
    v_dnparcr_id := p_dnparcr_id;

    with most_recent_fact_bi_id as
      (select 
         max(FNPABD_ID) max_fnpabd_id,
         max(D_DATE) max_d_date
       from F_NYEC_PA_BY_DATE
       where NYEC_PA_BI_ID = p_bi_id) 
    select 
      fnpabd.FNPABD_ID,
      fnpabd.D_DATE,
      fnpabd.CREATION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fnpabd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_max_d_date
    from 
      F_NYEC_PA_BY_DATE fnpabd,
      most_recent_fact_bi_id 
    where
      fnpabd.FNPABD_ID = max_fnpabd_id
      and fnpabd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
    select sum(COMPLETION_COUNT)
    into v_completion_count_old
    from F_NYEC_PA_BY_DATE
    where NYEC_PA_BI_ID = p_bi_id;
      
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
      
    -- Instance not yet completed.
    if p_end_date is null then
    
      r_fnpabd.D_DATE := v_event_date;
      r_fnpabd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpabd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpabd.INVENTORY_COUNT := 1;
      r_fnpabd.COMPLETION_COUNT := 0;
     
    -- Instance completed. 
    -- Handle case with complete date before create date.
    elsif to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) then
    
      v_log_message := 'Complete date before create date.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,v_bsl_id,v_bil_id,null,p_bi_id,null,v_log_message,v_sql_code);  
   
      -- Write isolated fact for complete date.
      r_fnpabd_precreate_complete.FNPABD_ID := SEQ_FNPABD_ID.nextval;
      r_fnpabd_precreate_complete.NYEC_PA_BI_ID := p_bi_id;
      r_fnpabd_precreate_complete.DNPACOU_ID := v_dnpacou_id;
      r_fnpabd_precreate_complete.DNPAHS_ID := v_dnpahs_id;
      r_fnpabd_precreate_complete.DNPAAS_ID := v_dnpaas_id;
      r_fnpabd_precreate_complete."Receipt Date" := v_receipt_date;
      r_fnpabd_precreate_complete.CREATION_COUNT := 0;
      r_fnpabd_precreate_complete."Invoiceable Date" := v_invoiceable_date;
      r_fnpabd_precreate_complete.DNPACIN_ID := v_dnpacin_id;
      r_fnpabd_precreate_complete.DNPAFPBPST_ID := v_dnpafpbpst_id;
      r_fnpabd_precreate_complete.DNPAHIAI_ID := v_dnpahiai_id;
      r_fnpabd_precreate_complete.DNPAHCS_ID := v_dnpahcs_id;
 
      r_fnpabd_precreate_complete.DNPARI_ID := v_dnpari_id;
      r_fnpabd_precreate_complete.DNPARR_ID := v_dnparr_id;
      r_fnpabd_precreate_complete.DNPARB_ID := v_dnparb_id;
      r_fnpabd_precreate_complete.DNPARN_ID := v_dnparn_id;
      r_fnpabd_precreate_complete.DNPAMC_ID := v_dnpamc_id;
      r_fnpabd_precreate_complete.DNPAML_ID := v_dnpaml_id;
      r_fnpabd_precreate_complete.DNPAONF_ID := v_dnpaonf_id;
      r_fnpabd_precreate_complete.DNPAOLS_ID := v_dnpaols_id;
      r_fnpabd_precreate_complete.DNPAWRI_ID := v_dnpawri_id;
      r_fnpabd_precreate_complete.DNPAQI_ID := v_dnpaqi_id;
      r_fnpabd_precreate_complete.DNPAMAR_ID := v_dnpamar_id;
      r_fnpabd_precreate_complete.DNPARCR_ID := v_dnparcr_id;

      r_fnpabd_precreate_complete."Reactivation Date" := v_reactivation_date;
      
      r_fnpabd_precreate_complete.D_DATE := p_end_date;
      r_fnpabd_precreate_complete.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpabd_precreate_complete.BUCKET_END_DATE := r_fnpabd_precreate_complete.BUCKET_START_DATE;
      r_fnpabd_precreate_complete.INVENTORY_COUNT := 0;
      r_fnpabd_precreate_complete.COMPLETION_COUNT := 1;   
      
      insert into F_NYEC_PA_BY_DATE
      values r_fnpabd_precreate_complete;
      
      -- End existing facts.
      r_fnpabd.D_DATE := v_event_date;
      r_fnpabd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpabd.BUCKET_END_DATE := r_fnpabd.BUCKET_START_DATE;
      r_fnpabd.INVENTORY_COUNT := 1;
      r_fnpabd.COMPLETION_COUNT := 0;     

    -- Instance completed.
    else
    
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_NYEC_PA_BY_DATE
        where 
          NYEC_PA_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        with most_recent_fact_bi_id as
          (select 
             max(FNPABD_ID) max_fnpabd_id,
             max(D_DATE) max_d_date
           from F_NYEC_PA_BY_DATE
           where NYEC_PA_BI_ID = p_bi_id) 
        select 
          fnpabd.FNPABD_ID,
          fnpabd.D_DATE,
          fnpabd.CREATION_COUNT,
          fnpabd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnpabd.DNPACOU_ID,
          fnpabd.DNPAHS_ID,
          fnpabd.DNPAAS_ID,
          fnpabd.DNPACIN_ID,
          fnpabd.DNPAFPBPST_ID,
          fnpabd.DNPAHIAI_ID,
          fnpabd.DNPAHCS_ID,
          fnpabd.DNPARI_ID,
          fnpabd.DNPARR_ID,
          fnpabd.DNPARB_ID,
          fnpabd.DNPARN_ID,
          fnpabd.DNPAMC_ID,
          fnpabd.DNPAML_ID,
          fnpabd.DNPAONF_ID,
          fnpabd.DNPAOLS_ID,
          fnpabd.DNPAWRI_ID,
          fnpabd.DNPAQI_ID,
          fnpabd.DNPAMAR_ID,
          fnpabd.DNPARCR_ID,          
          fnpabd."Receipt Date",
          fnpabd."Invoiceable Date",
          fnpabd."Reactivation Date"
        into 
          v_fnpabd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dnpacou_id,
          v_dnpahs_id,
          v_dnpaas_id,
          v_dnpacin_id,
          v_dnpafpbpst_id,
          v_dnpahiai_id,
          v_dnpahcs_id,
          v_dnpari_id,
          v_dnparr_id,
          v_dnparb_id,
          v_dnparn_id,
          v_dnpamc_id,
          v_dnpaml_id,
          v_dnpaonf_id,
          v_dnpaols_id,
          v_dnpawri_id,
          v_dnpaqi_id,
          v_dnpamar_id,
          v_dnparcr_id,
          v_receipt_date,
          v_invoiceable_date,
          v_reactivation_date 
        from 
          F_NYEC_PA_BY_DATE fnpabd,
          most_recent_fact_bi_id 
        where
          fnpabd.FNPABD_ID = max_fnpabd_id
          and fnpabd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
      r_fnpabd.D_DATE := p_end_date;
      r_fnpabd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpabd.BUCKET_END_DATE := r_fnpabd.BUCKET_START_DATE;
      r_fnpabd.INVENTORY_COUNT := 0;
      r_fnpabd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fnpabd_id := SEQ_FNPABD_ID.nextval;
    r_fnpabd.FNPABD_ID := p_fnpabd_id;
    r_fnpabd.NYEC_PA_BI_ID := p_bi_id;
    r_fnpabd.DNPACOU_ID := v_dnpacou_id;
    r_fnpabd.DNPAHS_ID := v_dnpahs_id;
    r_fnpabd.DNPAAS_ID := v_dnpaas_id;
    r_fnpabd."Receipt Date" := v_receipt_date;
    r_fnpabd.CREATION_COUNT := 0;
    r_fnpabd."Invoiceable Date" := v_invoiceable_date;
    r_fnpabd.DNPACIN_ID := v_dnpacin_id;
    r_fnpabd.DNPAFPBPST_ID := v_dnpafpbpst_id;
    r_fnpabd.DNPAHIAI_ID := v_dnpahiai_id;
    r_fnpabd.DNPAHCS_ID := v_dnpahcs_id;
 
    r_fnpabd.DNPARI_ID := v_dnpari_id;
    r_fnpabd.DNPARR_ID := v_dnparr_id;
    r_fnpabd.DNPARB_ID := v_dnparb_id;
    r_fnpabd.DNPARN_ID := v_dnparn_id;
    r_fnpabd.DNPAMC_ID := v_dnpamc_id;
    r_fnpabd.DNPAML_ID := v_dnpaml_id;
    r_fnpabd.DNPAONF_ID := v_dnpaonf_id;
    r_fnpabd.DNPAOLS_ID := v_dnpaols_id;
    r_fnpabd.DNPAWRI_ID := v_dnpawri_id;
    r_fnpabd.DNPAQI_ID := v_dnpaqi_id;
    r_fnpabd."Reactivation Date" := v_reactivation_date;
    r_fnpabd.DNPAMAR_ID := v_dnpamar_id;
    r_fnpabd.DNPARCR_ID := v_dnparcr_id;
    
    -- Validate fact date ranges.
    if r_fnpabd.D_DATE < r_fnpabd.BUCKET_START_DATE
      or to_date(to_char(r_fnpabd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnpabd.BUCKET_END_DATE
      or r_fnpabd.BUCKET_START_DATE > r_fnpabd.BUCKET_END_DATE
      or r_fnpabd.BUCKET_END_DATE < r_fnpabd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnpabd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnpabd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnpabd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpabd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fnpabd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_NYEC_PA_BY_DATE
      set row = r_fnpabd
      where FNPABD_ID = v_fnpabd_id_old;
        
    else
    
      -- Different bucket time.
    
      update F_NYEC_PA_BY_DATE
      set BUCKET_END_DATE = r_fnpabd.BUCKET_START_DATE
      where FNPABD_ID = v_fnpabd_id_old;
        
      insert into F_NYEC_PA_BY_DATE
      values r_fnpabd;
      
    end if;
    
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);  
      raise; 
      
  end; 


 -- Update BPM Event model data.
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';  
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_be_id number := null;
    v_bi_id number := null;
    v_bue_id number := null;
  
    v_identifier varchar2(35) := null;
  
    v_start_date date := null;
    v_end_date date := null;
    v_stg_last_update_date date := null;

    v_old_data T_UPD_PA_XML := null;
    v_new_data T_UPD_PA_XML := null;
  begin

    if p_data_version != 4 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYEC Process App in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if; 

    GET_UPD_PA_XML(p_old_data_xml,v_old_data);
    GET_UPD_PA_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.APP_ID || '_' || to_char(v_new_data.REACTIVATION_NBR);
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_stg_last_update_date := to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
  
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = to_char(v_identifier)
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;

    if v_end_date is not null then
    
      update BPM_INSTANCE
      set
        END_DATE = v_end_date,
        LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
      
    else
    
      update BPM_INSTANCE
      set LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
      
    end if;

    commit;

    v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT(BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_date,'N');
  
    BPM_EVENT.UPDATE_BIA(v_bi_id,37,2,'N',v_old_data.APP_COMPLETE_RESULT,v_new_data.APP_COMPLETE_RESULT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,38,2,'Y',v_old_data.APP_STATUS,v_new_data.APP_STATUS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,39,2,'Y',v_old_data.APP_STATUS_GROUP,v_new_data.APP_STATUS_GROUP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,41,2,'N',v_old_data.APP_TYPE,v_new_data.APP_TYPE,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,42,2,'N',v_old_data.AUTO_REPROCESS_FLAG,v_new_data.AUTO_REPROCESS_FLAG,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,44,2,'N',v_old_data.ASF_CANCEL_APP,v_new_data.ASF_CANCEL_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,45,2,'N',v_old_data.ASPB_CANCEL_APP,v_new_data.ASPB_CANCEL_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,47,3,'N',v_old_data.CANCEL_DATE,v_new_data.CANCEL_DATE,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,49,2,'N',v_old_data.CHANNEL,v_new_data.CHANNEL,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,50,2,'Y',v_old_data.CLOCKDOWN_INDICATOR,v_new_data.CLOCKDOWN_INDICATOR,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,52,2,'N',v_old_data.ASF_CLOSE_APP,v_new_data.ASF_CLOSE_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,53,2,'N',v_old_data.ASPB_CLOSE_APP,v_new_data.ASPB_CLOSE_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,56,2,'N',v_old_data.ASF_COMPLETE_APP,v_new_data.ASF_COMPLETE_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,57,2,'N',v_old_data.ASPB_COMPLETE_APP,v_new_data.ASPB_COMPLETE_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,59,2,'Y',v_old_data.COUNTY,v_new_data.COUNTY,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,60,1,'N',v_old_data.CURRENT_TASK_ID,v_new_data.CURRENT_TASK_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,61,1,'N',v_old_data.DE_TASK_ID,v_new_data.DE_TASK_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,62,2,'N',v_old_data.ELIGIBILITY_ACTION,v_new_data.ELIGIBILITY_ACTION,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,63,2,'Y',v_old_data.HEART_APP_STATUS,v_new_data.HEART_APP_STATUS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,64,2,'Y',v_old_data.HEART_SYNCH_FLAG,v_new_data.HEART_SYNCH_FLAG,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,69,3,'N',v_old_data.APP_CYCLE_END_DT,v_new_data.APP_CYCLE_END_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,70,3,'N',v_old_data.APP_CYCLE_START_DT,v_new_data.APP_CYCLE_START_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,71,3,'N',v_old_data.LAST_MAIL_DT,v_new_data.LAST_MAIL_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,72,1,'N',v_old_data.MI_RECEIVED_TASK_COUNT,v_new_data.MI_RECEIVED_TASK_COUNT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,73,2,'N',v_old_data.GWF_MISSING_INFO,v_new_data.GWF_MISSING_INFO,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,74,2,'N',v_old_data.GWF_NEW_MI,v_new_data.GWF_NEW_MI,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,75,3,'N',v_old_data.NOTIFY_CLIENT_PENDED_APP_DT,v_new_data.NOTIFY_CLIENT_PENDED_APP_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,77,2,'N',v_old_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,78,2,'N',v_old_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,79,3,'N',v_old_data.ASSD_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASSD_NOTIFY_CLIENT_PENDED_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,80,2,'N',v_old_data.GWF_OUTCM_NOTIFY_RQRD,v_new_data.GWF_OUTCM_NOTIFY_RQRD,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,81,2,'N',v_old_data.GWF_PEND_NOTIFY_RQRD,v_new_data.GWF_PEND_NOTIFY_RQRD,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,82,3,'N',v_old_data.PERFORM_QC_DT,v_new_data.PERFORM_QC_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,84,2,'N',v_old_data.ASF_PERFORM_QC,v_new_data.ASF_PERFORM_QC,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,85,2,'N',v_old_data.ASPB_PERFORM_QC,v_new_data.ASPB_PERFORM_QC,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,86,3,'N',v_old_data.ASSD_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,87,3,'N',v_old_data.PERFORM_RESEARCH_DT,v_new_data.PERFORM_RESEARCH_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,89,2,'N',v_old_data.ASF_PERFORM_RESEARCH,v_new_data.ASF_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,90,2,'N',v_old_data.ASPB_PERFORM_RESEARCH,v_new_data.ASPB_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,91,3,'N',v_old_data.ASSD_PERFORM_RESEARCH,v_new_data.ASSD_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,92,3,'N',v_old_data.PROCESS_APP_INFO_DT,v_new_data.PROCESS_APP_INFO_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,94,2,'N',v_old_data.ASF_PROCESS_APP_INFO,v_new_data.ASF_PROCESS_APP_INFO,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,95,2,'N',v_old_data.ASPB_PROCESS_APP_INFO,v_new_data.ASPB_PROCESS_APP_INFO,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,96,3,'N',v_old_data.ASSD_PROCESS_APP_INFO,v_new_data.ASSD_PROCESS_APP_INFO,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,97,2,'N',v_old_data.GWF_QC_OUTCOME,v_new_data.GWF_QC_OUTCOME,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,98,2,'N',v_old_data.GWF_QC_RQRD,v_new_data.GWF_QC_RQRD,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,99,1,'N',v_old_data.QC_TASK_ID,v_new_data.QC_TASK_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,100,3,'Y',v_old_data.RECEIPT_DT,v_new_data.RECEIPT_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,102,2,'N',v_old_data.ASF_RECEIVE_PROCESS_MI,v_new_data.ASF_RECEIVE_PROCESS_MI,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,106,2,'N',v_old_data.ASF_RECEIVE_APP,v_new_data.ASF_RECEIVE_APP,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,109,2,'Y',v_old_data.REFER_LDSS_FLAG,v_new_data.REFER_LDSS_FLAG,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,110,2,'N',v_old_data.GWF_RESEARCH,v_new_data.GWF_RESEARCH,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,111,2,'N',v_old_data.RESEARCH_REASON,v_new_data.RESEARCH_REASON,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,112,1,'N',v_old_data.RESEARCH_TASK_ID,v_new_data.RESEARCH_TASK_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,113,3,'N',v_old_data.RVW_ENTER_DATA_DT,v_new_data.RVW_ENTER_DATA_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,115,2,'N',v_old_data.ASF_REVIEW_ENTER_DATA,v_new_data.ASF_REVIEW_ENTER_DATA,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,116,2,'N',v_old_data.ASPB_RVW_ENTER_DATA,v_new_data.ASPB_RVW_ENTER_DATA,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,117,3,'N',v_old_data.ASSD_RVW_ENTER_DATA,v_new_data.ASSD_RVW_ENTER_DATA,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,123,3,'N',v_old_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,124,1,'N',v_old_data.STATE_REVIEW_TASK_COUNT,v_new_data.STATE_REVIEW_TASK_COUNT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,125,1,'N',v_old_data.STATE_REVIEW_TASK_ID,v_new_data.STATE_REVIEW_TASK_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,126,3,'N',v_old_data.WAIT_STATE_APPROVAL_DT,v_new_data.WAIT_STATE_APPROVAL_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,128,2,'N',v_old_data.ASPB_WAIT_STATE_APPROVAL,v_new_data.ASPB_WAIT_STATE_APPROVAL,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,129,3,'N',v_old_data.ASSD_WAIT_STATE_APPROVAL,v_new_data.ASSD_WAIT_STATE_APPROVAL,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,130,2,'N',v_old_data.ASF_WAIT_STATE_APPROVAL,v_new_data.ASF_WAIT_STATE_APPROVAL,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,133,3,'N',v_old_data.COMPLETE_DT,v_new_data.COMPLETE_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,134,3,'N',v_old_data.CREATE_DT,v_new_data.CREATE_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,136,1,'N',v_old_data.SLA_DAYS,v_new_data.SLA_DAYS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,137,2,'N',v_old_data.SLA_DAYS_TYPE,v_new_data.SLA_DAYS_TYPE,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,138,1,'N',v_old_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DAYS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,139,1,'N',v_old_data.SLA_TARGET_DAYS,v_new_data.SLA_TARGET_DAYS,v_bue_id,v_stg_last_update_date);
    
    -- r3
    BPM_EVENT.UPDATE_BIA(v_bi_id,405,2,'Y',v_old_data.CIN,v_new_data.CIN,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,406,3,'N',v_old_data.CIN_DT,v_new_data.CIN_DT,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,407,2,'N',v_old_data.PROVIDER_NAME,v_new_data.PROVIDER_NAME,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,409,2,'Y',v_old_data.FPBP_TYPE,v_new_data.FPBP_TYPE,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,410,2,'N',v_old_data.REV_CLEAR_IND,v_new_data.REV_CLEAR_IND,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,411,3,'N',v_old_data.REV_CLEAR_IND_DT,v_new_data.REV_CLEAR_IND_DT,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,412,2,'N',v_old_data.REV_CLEAR_OUTCOME,v_new_data.REV_CLEAR_OUTCOME,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,413,2,'N',v_old_data.UPSTATE_INDICATOR,v_new_data.UPSTATE_INDICATOR,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,414,3,'Y',v_old_data.INVOICE_READY_DT,v_new_data.INVOICE_READY_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,415,2,'Y',v_old_data.HEART_INCMPLT_APP_IND,v_new_data.HEART_INCMPLT_APP_IND,v_bue_id,v_stg_last_update_date);	   
    BPM_EVENT.UPDATE_BIA(v_bi_id,417,2,'Y',v_old_data.WMS_REASON,v_new_data.WMS_REASON,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,418,2,'Y',v_old_data.HEART_REPROCESS_STATUS,v_new_data.HEART_REPROCESS_STATUS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,419,3,'Y',v_old_data.HEART_REPROCESS_STATUS_DT,v_new_data.HEART_REPROCESS_STATUS_DT,v_bue_id,v_stg_last_update_date);

    -- r4
    BPM_EVENT.UPDATE_BIA(v_bi_id,425,2,'Y',v_old_data.HEART_CASE_STATUS,v_new_data.HEART_CASE_STATUS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,426,2,'N',v_old_data.STATE_CASE_IDEN,v_new_data.STATE_CASE_IDEN,v_bue_id,v_stg_last_update_date);

    -- Reactivation
    BPM_EVENT.UPDATE_BIA(v_bi_id,481,2,'N',v_old_data.STOP_APP_REASON,v_new_data.STOP_APP_REASON,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,482,2,'Y',v_old_data.REACTIVATION_REASON,v_new_data.REACTIVATION_REASON,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,483,1,'Y',v_old_data.REACTIVATION_IND,v_new_data.REACTIVATION_IND,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,484,1,'Y',v_old_data.REACTIVATION_NBR,v_new_data.REACTIVATION_NBR,v_bue_id,v_stg_last_update_date);   
    
    BPM_EVENT.UPDATE_BIA(v_bi_id,485,2,'Y',v_old_data.WORKFLOW_REACT_IND,v_new_data.WORKFLOW_REACT_IND,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,486,2,'Y',v_old_data.CURR_MODE_CD,v_new_data.CURR_MODE_CD,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,487,2,'Y',v_old_data.CURR_MODE_LABEL,v_new_data.CURR_MODE_LABEL,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,488,2,'N',v_old_data.OUTCOME_LTR_TYPE,v_new_data.OUTCOME_LTR_TYPE,v_bue_id,v_stg_last_update_date);   

    BPM_EVENT.UPDATE_BIA(v_bi_id,489,2,'y',v_old_data.OUTCOME_LTR_STATUS,v_new_data.OUTCOME_LTR_STATUS,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,490,1,'N',v_old_data.OUTCOME_LTR_ID,v_new_data.OUTCOME_LTR_ID,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,491,3,'N',v_old_data.OUTCOME_LTR_CREATE_DT,v_new_data.OUTCOME_LTR_CREATE_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,492,3,'N',v_old_data.OUTCOME_LTR_SENT_DT,v_new_data.OUTCOME_LTR_SENT_DT,v_bue_id,v_stg_last_update_date);   
    
    BPM_EVENT.UPDATE_BIA(v_bi_id,493,2,'Y',v_old_data.REACTIVATED_BY,v_new_data.REACTIVATED_BY,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,494,3,'Y',v_old_data.REACTIVATION_DT,v_new_data.REACTIVATION_DT,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,495,2,'Y',v_old_data.OUTCOME_NOTIFY_RQRD_FLAG,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_bue_id,v_stg_last_update_date);
    BPM_EVENT.UPDATE_BIA(v_bi_id,496,2,'Y',v_old_data.QC_IND,v_new_data.QC_IND,v_bue_id,v_stg_last_update_date);   

    --v4
    BPM_EVENT.UPDATE_BIA(v_bi_id,1592,2,'Y',v_old_data.REV_CLEAR_REASON,v_new_data.REV_CLEAR_REASON,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1593,2,'Y',v_old_data.MA_REASON,v_new_data.MA_REASON,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1594,1,'N',v_old_data.OFFICE_ID,v_new_data.OFFICE_ID,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1595,1,'N',v_old_data.APPLICANT_ID,v_new_data.APPLICANT_ID,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1596,1,'N',v_old_data.REG_TASK_ID,v_new_data.REG_TASK_ID,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1597,1,'N',v_old_data.QC_REG_TASK_ID,v_new_data.QC_REG_TASK_ID,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1598,3,'N',v_old_data.PERFORM_QC_REG_DT,v_new_data.PERFORM_QC_REG_DT,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1599,3,'N',v_old_data.ASSD_REG_ENTER_DATA,v_new_data.ASSD_REG_ENTER_DATA,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1600,3,'N',v_old_data.ASSD_PERFORM_QC_REG,v_new_data.ASSD_PERFORM_QC_REG,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1601,2,'N',v_old_data.ASPB_REG_ENTER_DATA,v_new_data.ASPB_REG_ENTER_DATA,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1602,2,'N',v_old_data.ASPB_PERFORM_QC_REG,v_new_data.ASPB_PERFORM_QC_REG,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1603,1,'N',v_old_data.NUMBER_OF_APPLICANTS,v_new_data.NUMBER_OF_APPLICANTS,v_bue_id,v_stg_last_update_date);   
    BPM_EVENT.UPDATE_BIA(v_bi_id,1604,3,'N',v_old_data.REG_ENTER_DATA_DT,v_new_data.REG_ENTER_DATA_DT,v_bue_id,v_stg_last_update_date);   

commit;

    
    commit;
  
    p_bue_id := v_bue_id;
  
  exception

    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
      raise;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
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
      
    v_old_data T_UPD_PA_XML := null;
    v_new_data T_UPD_PA_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dnpacou_id number := null;
    v_dnpahs_id number := null;
    v_dnpaas_id number := null;
      
    v_fnpabd_id number := null;
      
    v_dnpacin_id number := null;
    v_dnpafpbpst_id number := null;
    v_dnpahiai_id number := null;
    v_dnpahcs_id number := null;
    
    v_dnpari_id number := null;
    v_dnparr_id number := null;
    v_dnparb_id number := null;
    v_dnparn_id number := null;
    v_dnpamc_id number := null;
    v_dnpaml_id number := null;
    v_dnpaonf_id number := null;
    v_dnpaols_id number := null;
    v_dnpawri_id number := null;
    v_dnpaqi_id number := null;
    v_dnpamar_id number := null;
    v_dnparcr_id number := null;    
  begin
   
    if p_data_version != 4 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_PA_XML(p_old_data_xml,v_old_data);
    GET_UPD_PA_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.APP_ID || '_' || to_char(v_new_data.REACTIVATION_NBR);
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select NYEC_PA_BI_ID 
    into v_bi_id
    from D_NYEC_PA_CURRENT
    where 
      "Application ID" = v_new_data.APP_ID
      and "Cur Reactivation Number" = v_new_data.REACTIVATION_NBR;

    GET_DNPACOU_ID(v_identifier,v_bi_id,v_new_data.COUNTY,v_dnpacou_id);
    GET_DNPAHS_ID(v_identifier,v_bi_id,v_new_data.HEART_SYNCH_FLAG,v_dnpahs_id);
    GET_DNPAAS_ID(v_identifier,v_bi_id,v_new_data.APP_STATUS,v_new_data.APP_STATUS_GROUP,v_new_data.HEART_APP_STATUS,v_new_data.REFER_LDSS_FLAG,v_dnpaas_id);
      
    GET_DNPACIN_ID(v_identifier,v_bi_id ,v_new_data.CIN ,v_dnpacin_id );
    GET_DNPAFPBPST_ID(v_identifier, v_bi_id ,v_new_data.FPBP_TYPE,v_dnpafpbpst_id );
    GET_DNPAHIAI_ID(v_identifier ,v_bi_id ,v_new_data.HEART_INCMPLT_APP_IND ,v_dnpahiai_id);
    GET_DNPAHCS_ID(v_identifier,v_bi_id,v_new_data.HEART_CASE_STATUS,v_dnpahcs_id);
    
    GET_DNPARI_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_IND,v_dnpari_id);    
    GET_DNPARR_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_REASON,v_dnparr_id);
    GET_DNPARB_ID(v_identifier,v_bi_id,v_new_data.REACTIVATED_BY,v_dnparb_id);
    GET_DNPARN_ID(v_identifier,v_bi_id,v_new_data.REACTIVATION_NBR,v_dnparn_id);
    GET_DNPAMC_ID(v_identifier,v_bi_id,v_new_data.CURR_MODE_CD,v_dnpamc_id);
    GET_DNPAML_ID(v_identifier,v_bi_id,v_new_data.CURR_MODE_LABEL,v_dnpaml_id);
    GET_DNPAONF_ID(v_identifier,v_bi_id,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_dnpaonf_id);
    GET_DNPAOLS_ID(v_identifier,v_bi_id,v_new_data.OUTCOME_LTR_STATUS,v_dnpaols_id);
    GET_DNPAWRI_ID(v_identifier,v_bi_id,v_new_data.WORKFLOW_REACT_IND,v_dnpawri_id);
    GET_DNPAQI_ID(v_identifier,v_bi_id,v_new_data.QC_IND,v_dnpaqi_id);
    GET_DNPAMAR_ID(v_identifier,v_bi_id,v_new_data.MA_REASON,v_dnpamar_id);
    GET_DNPARCR_ID(v_identifier,v_bi_id,v_new_data.REV_CLEAR_REASON,v_dnparcr_id);

    -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
         
      SET_DNPACUR
        ('UPDATE',v_identifier,v_bi_id,
         v_new_data.APP_ID,v_new_data.APP_COMPLETE_RESULT,v_new_data.APP_TYPE,
         v_new_data.AUTO_REPROCESS_FLAG,v_new_data.ASF_CANCEL_APP,v_new_data.ASPB_CANCEL_APP,v_new_data.CANCEL_DATE,
         v_new_data.CHANNEL,v_new_data.ASF_CLOSE_APP,v_new_data.ASPB_CLOSE_APP,v_new_data.ASF_COMPLETE_APP,v_new_data.ASPB_COMPLETE_APP,
         v_new_data.COMPLETE_DT,v_new_data.CREATE_DT,v_new_data.CURRENT_TASK_ID,v_new_data.DE_TASK_ID,v_new_data.ELIGIBILITY_ACTION,
         v_new_data.APP_CYCLE_END_DT,v_new_data.APP_CYCLE_START_DT,v_new_data.LAST_MAIL_DT,
         v_new_data.MI_RECEIVED_TASK_COUNT,v_new_data.GWF_MISSING_INFO,v_new_data.GWF_NEW_MI,v_new_data.NOTIFY_CLIENT_PENDED_APP_DT,
         v_new_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_new_data.ASSD_NOTIFY_CLIENT_PENDED_APP,
         v_new_data.GWF_OUTCM_NOTIFY_RQRD,v_new_data.GWF_PEND_NOTIFY_RQRD,v_new_data.PERFORM_QC_DT,v_new_data.ASPB_PERFORM_QC,
         v_new_data.ASF_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.PERFORM_RESEARCH_DT,v_new_data.ASPB_PERFORM_RESEARCH,v_new_data.ASF_PERFORM_RESEARCH,
         v_new_data.ASSD_PERFORM_RESEARCH,v_new_data.PROCESS_APP_INFO_DT,v_new_data.ASF_PROCESS_APP_INFO,v_new_data.ASPB_PROCESS_APP_INFO,v_new_data.ASSD_PROCESS_APP_INFO,
         v_new_data.GWF_QC_OUTCOME,v_new_data.GWF_QC_RQRD,v_new_data.QC_TASK_ID,v_new_data.ASF_RECEIVE_PROCESS_MI,v_new_data.ASF_RECEIVE_APP,
         v_new_data.GWF_RESEARCH,v_new_data.RESEARCH_REASON,v_new_data.RESEARCH_TASK_ID,v_new_data.RVW_ENTER_DATA_DT,v_new_data.ASPB_RVW_ENTER_DATA,
         v_new_data.ASF_REVIEW_ENTER_DATA,v_new_data.ASSD_RVW_ENTER_DATA,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DT,
         v_new_data.SLA_TARGET_DAYS,v_new_data.STATE_REVIEW_TASK_COUNT,v_new_data.STATE_REVIEW_TASK_ID,v_new_data.WAIT_STATE_APPROVAL_DT,
         v_new_data.ASF_WAIT_STATE_APPROVAL,v_new_data.ASPB_WAIT_STATE_APPROVAL,v_new_data.ASSD_WAIT_STATE_APPROVAL,v_new_data.APP_STATUS,v_new_data.APP_STATUS_GROUP,
         v_new_data.COUNTY,v_new_data.HEART_APP_STATUS,v_new_data.HEART_SYNCH_FLAG,v_new_data.RECEIPT_DT,v_new_data.REFER_LDSS_FLAG,
         v_new_data.CIN,v_new_data.CIN_DT,v_new_data.PROVIDER_NAME,v_new_data.FPBP_TYPE,v_new_data.REV_CLEAR_IND,	
         v_new_data.REV_CLEAR_IND_DT,v_new_data.REV_CLEAR_OUTCOME,v_new_data.UPSTATE_INDICATOR,v_new_data.INVOICE_READY_DT,v_new_data.HEART_INCMPLT_APP_IND,	                    
         v_new_data.HEART_CASE_STATUS,v_new_data.STATE_CASE_IDEN,
         v_new_data.STOP_APP_REASON, v_new_data.REACTIVATION_REASON,v_new_data.REACTIVATION_IND,v_new_data.REACTIVATION_NBR,
         v_new_data.WORKFLOW_REACT_IND,v_new_data.CURR_MODE_CD,v_new_data.CURR_MODE_LABEL,v_new_data.OUTCOME_LTR_TYPE,
         v_new_data.OUTCOME_LTR_STATUS,v_new_data.OUTCOME_LTR_ID,v_new_data.OUTCOME_LTR_CREATE_DT,v_new_data.OUTCOME_LTR_SENT_DT,
         v_new_data.REACTIVATED_BY,v_new_data.REACTIVATION_DT,v_new_data.OUTCOME_NOTIFY_RQRD_FLAG,v_new_data.QC_IND,
         v_new_data.REV_CLEAR_REASON,v_new_data.MA_REASON,v_new_data.OFFICE_ID,v_new_data.APPLICANT_ID,
         v_new_data.REG_TASK_ID,v_new_data.QC_REG_TASK_ID,v_new_data.PERFORM_QC_REG_DT,v_new_data.ASSD_REG_ENTER_DATA,
         v_new_data.ASSD_PERFORM_QC_REG,v_new_data.ASPB_REG_ENTER_DATA,v_new_data.ASPB_PERFORM_QC_REG,v_new_data.NUMBER_OF_APPLICANTS,v_new_data.REG_ENTER_DATA_DT
        );
        
      UPD_FNPABD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dnpacou_id,v_dnpahs_id,v_dnpaas_id,v_new_data.RECEIPT_DT,v_new_data.STG_LAST_UPDATE_DATE,
         v_new_data.INVOICE_READY_DT,v_dnpacin_id,v_dnpafpbpst_id,v_dnpahiai_id,v_dnpahcs_id,   
         v_dnpari_id,v_dnparr_id,v_dnparb_id,v_dnparn_id,v_dnpamc_id,v_dnpaml_id,
         v_dnpaonf_id,v_dnpaols_id,v_dnpawri_id,v_dnpaqi_id,v_new_data.REACTIVATION_DT,v_dnpamar_id,v_dnparcr_id,
         v_fnpabd_id);
      
      commit;
            
    exception
          
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
        raise;
      
    end;
      
  exception
  
    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
      raise; 
        
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
      raise;
  
  end;
  
end;
/
  
alter session set plsql_code_type = interpreted;