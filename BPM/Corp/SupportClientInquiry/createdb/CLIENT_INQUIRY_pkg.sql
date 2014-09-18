alter session set plsql_code_type = native;

create or replace package CLIENT_INQUIRY as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DSCICUR;
  
  FUNCTION get_handle_time
    (p_contact_start_dt IN DATE
    ,p_contact_end_dt   IN DATE)
  RETURN NUMBER;

  /* 
  Include: 
    CECI_ID
    PARTICIPANT_STATUS
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  type T_INS_CI_XML is record 
    (
     ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_HANDLE_CONTACT varchar2(19),
     ASF_CANCEL_CONTACT varchar2(1),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_HANDLE_CONTACT varchar2(1),
     ASPB_HANDLE_CONTACT varchar2(100),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_HANDLE_CONTACT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CECI_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CONTACT_END_DT varchar2(19),
     CONTACT_GROUP varchar2(256),
     CONTACT_RECORD_FIELD1 varchar2(80),
     CONTACT_RECORD_FIELD2 varchar2(80),
     CONTACT_RECORD_FIELD3 varchar2(80),
     CONTACT_RECORD_FIELD4 varchar2(80),
     CONTACT_RECORD_FIELD5 varchar2(80),
     CONTACT_RECORD_ID varchar2(100),
     CONTACT_START_DT varchar2(19),
     CONTACT_TYPE varchar2(256),
     CREATED_BY varchar2(100),
     CREATED_BY_ROLE varchar2(50),
     CREATED_BY_UNIT varchar2(256),
     CREATE_DT varchar2(19),
     EXT_TELEPHONY_REF varchar2(32),
     GWF_WORK_IDENTIFIED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(256),
     LAST_UPDATE_BY_NAME varchar2(100),
     LAST_UPDATE_DT varchar2(19),
     NOTE_CATEGORY varchar2(32),
     NOTE_PRESENT varchar2(1),
     NOTE_SOURCE varchar2(80),
     NOTE_TYPE varchar2(32),
     PARENT_RECORD_ID varchar2(100),
     PARTICIPANT_STATUS varchar2(15),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUPP_CONTACT_GROUP_CD varchar2(64),
     SUPP_CONTACT_TYPE_CD varchar2(64),
     SUPP_CREATED_BY varchar2(32),
     SUPP_UPDATE_BY varchar2(32),
     SUPP_LANGUAGE_CD varchar2(32),
     SUPP_LATEST_NOTE_ID varchar2(100),
     SUPP_WORKER_ID varchar2(32),
     SUPP_WORKER_NAME varchar2(100),
     TRACKING_NUMBER varchar2(32),
     TRANSLATION_REQ varchar2(1)
    );

  /* 
  Include: 
    PARTICIPANT_STATUS
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  type T_UPD_CI_XML is record
    (
     ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_HANDLE_CONTACT varchar2(19),
     ASF_CANCEL_CONTACT varchar2(1),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_HANDLE_CONTACT varchar2(1),
     ASPB_HANDLE_CONTACT varchar2(100),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_HANDLE_CONTACT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     COMPLETE_DT varchar2(19),
     CONTACT_END_DT varchar2(19),
     CONTACT_GROUP varchar2(256),
     CONTACT_RECORD_FIELD1 varchar2(80),
     CONTACT_RECORD_FIELD2 varchar2(80),
     CONTACT_RECORD_FIELD3 varchar2(80),
     CONTACT_RECORD_FIELD4 varchar2(80),
     CONTACT_RECORD_FIELD5 varchar2(80),
     CONTACT_RECORD_ID varchar2(100),
     CONTACT_START_DT varchar2(19),
     CONTACT_TYPE varchar2(256),
     CREATED_BY varchar2(100),
     CREATED_BY_ROLE varchar2(50),
     CREATED_BY_UNIT varchar2(256),
     CREATE_DT varchar2(19),
     EXT_TELEPHONY_REF varchar2(32),
     GWF_WORK_IDENTIFIED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(256),
     LAST_UPDATE_BY_NAME varchar2(100),
     LAST_UPDATE_DT varchar2(19),
     NOTE_CATEGORY varchar2(32),
     NOTE_PRESENT varchar2(1),
     NOTE_SOURCE varchar2(80),
     NOTE_TYPE varchar2(32),
     PARENT_RECORD_ID varchar2(100),
     PARTICIPANT_STATUS varchar2(15),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUPP_CONTACT_GROUP_CD varchar2(64),
     SUPP_CONTACT_TYPE_CD varchar2(64),
     SUPP_CREATED_BY varchar2(32),
     SUPP_UPDATE_BY varchar2(32),
     SUPP_LANGUAGE_CD varchar2(32),
     SUPP_LATEST_NOTE_ID varchar2(100),
     SUPP_WORKER_ID varchar2(32),
     SUPP_WORKER_NAME varchar2(100),
     TRACKING_NUMBER varchar2(32),
     TRANSLATION_REQ varchar2(1)
    );

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
     
END CLIENT_INQUIRY;
/
create or replace package body CLIENT_INQUIRY as

  v_bem_id number := 13; -- 'Corp Client Inquiry'
  v_bil_id number := 13; -- 'Call Record ID'
  v_bsl_id number := 13; -- 'CORP_ETL_CLIENT_INQUIRY'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dscicur_job_name varchar2(30) := 'CALC_DSCICUR';
  
  -- Calculate column values in BPM Semantic table D_SCI_CURRENT.
  procedure CALC_DSCICUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DSCICUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
update D_SCI_CURRENT
    set
     handle_time = get_handle_time(contact_start_time, contact_end_time)
    --,participant_status = get_participant_status (contact_record_id)
    where 
      COMPLETE_DATE is null 
      and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
 
 commit;
 
     v_log_message := v_num_rows_updated  || ' D_SCI_CURRENT rows updated with calculated attributes by CALC_DMJCUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  END CALC_DSCICUR;

  
-- Get record for Manage Jobs insert XML.
  procedure GET_INS_CI_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_CI_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_CI_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_HANDLE_CONTACT') "ASED_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_CONTACT') "ASF_CANCEL_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_HANDLE_CONTACT') "ASF_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_HANDLE_CONTACT') "ASPB_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_HANDLE_CONTACT') "ASSD_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CECI_ID') "CECI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_END_DT') "CONTACT_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_GROUP') "CONTACT_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD1') "CONTACT_RECORD_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD2') "CONTACT_RECORD_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD3') "CONTACT_RECORD_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD4') "CONTACT_RECORD_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD5') "CONTACT_RECORD_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_ID') "CONTACT_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_START_DT') "CONTACT_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_TYPE') "CONTACT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_ROLE') "CREATED_BY_ROLE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_UNIT') "CREATED_BY_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/EXT_TELEPHONY_REF') "EXT_TELEPHONY_REF",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_CATEGORY') "NOTE_CATEGORY",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_PRESENT') "NOTE_PRESENT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_SOURCE') "NOTE_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_TYPE') "NOTE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PARENT_RECORD_ID') "PARENT_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PARTICIPANT_STATUS') "PARTICIPANT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CONTACT_GROUP_CD') "SUPP_CONTACT_GROUP_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CONTACT_TYPE_CD') "SUPP_CONTACT_TYPE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CREATED_BY') "SUPP_CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_UPDATE_BY') "SUPP_UPDATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_LANGUAGE_CD') "SUPP_LANGUAGE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_LATEST_NOTE_ID') "SUPP_LATEST_NOTE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_WORKER_ID') "SUPP_WORKER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_WORKER_NAME') "SUPP_WORKER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSLATION_REQ') "TRANSLATION_REQ"
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  END GET_INS_CI_XML;
  
  
 -- Get record for Manage Jobs update XML. 
  procedure GET_UPD_CI_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_CI_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_CI_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 

     select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_HANDLE_CONTACT') "ASED_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_CONTACT') "ASF_CANCEL_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_HANDLE_CONTACT') "ASF_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_HANDLE_CONTACT') "ASPB_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_HANDLE_CONTACT') "ASSD_HANDLE_CONTACT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_END_DT') "CONTACT_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_GROUP') "CONTACT_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD1') "CONTACT_RECORD_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD2') "CONTACT_RECORD_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD3') "CONTACT_RECORD_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD4') "CONTACT_RECORD_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_FIELD5') "CONTACT_RECORD_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_RECORD_ID') "CONTACT_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_START_DT') "CONTACT_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_TYPE') "CONTACT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_ROLE') "CREATED_BY_ROLE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_UNIT') "CREATED_BY_UNIT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/EXT_TELEPHONY_REF') "EXT_TELEPHONY_REF",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_CATEGORY') "NOTE_CATEGORY",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_PRESENT') "NOTE_PRESENT",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_SOURCE') "NOTE_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_TYPE') "NOTE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PARENT_RECORD_ID') "PARENT_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PARTICIPANT_STATUS') "PARTICIPANT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CONTACT_GROUP_CD') "SUPP_CONTACT_GROUP_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CONTACT_TYPE_CD') "SUPP_CONTACT_TYPE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_CREATED_BY') "SUPP_CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_UPDATE_BY') "SUPP_UPDATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_LANGUAGE_CD') "SUPP_LANGUAGE_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_LATEST_NOTE_ID') "SUPP_LATEST_NOTE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_WORKER_ID') "SUPP_WORKER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SUPP_WORKER_NAME') "SUPP_WORKER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSLATION_REQ') "TRANSLATION_REQ"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  END GET_UPD_CI_XML;  

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
     p_sla_days_type in varchar,
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

  FUNCTION get_handle_time
    (p_contact_start_dt IN DATE
    ,p_contact_end_dt   IN DATE)
  RETURN NUMBER
  AS
    /* Purpose: Total time for the contact/web chat calculated as,
                contact_end_dt - contact_start_dt  (expressed in seconds).
    */
  BEGIN
    IF (p_contact_start_dt IS NULL) OR (p_contact_end_dt IS NULL)
    THEN RETURN('0');
    ELSE RETURN((p_contact_end_dt - p_contact_start_dt) * 24 * 60 * 60);
    END IF;

  EXCEPTION
    when OTHERS then
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL
                       ,$$PLSQL_UNIT || '.' || 'get_handle_time'
                       ,v_bsl_id,v_bil_id,null,null,SQLERRM,SQLCODE);
      raise; 
  END get_handle_time;
  
  
  
  -- Insert fact for BPM Semantic model - F_SCI_BY_DATE. 
    procedure INS_FSCIBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_stg_last_update_date in varchar2,
       p_fscibd_id out number) 
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FSCIBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
    begin
    
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      p_fscibd_id := SEQ_FSCIBD_ID.nextval;
      
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
      
      insert into F_SCI_BY_DATE
        (fscibd_id,
        d_date,
        bucket_start_date,
        bucket_end_date,
        sci_bi_id,
        inventory_count,
        creation_count,
        completion_count
        )
      values
        (p_fscibd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         1,
         case 
         when p_end_date is null then 1
         else 0
         end,
         case 
           when p_end_date is null then 0
           else 1
           END
        );
        
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  END INS_FSCIBD; 
  

  -- Insert or update dimension for BPM Semantic model - Corp Client Inquiry - Current.
  procedure SET_DICICUR
    (p_set_type in varchar2,
     p_identifier in varchar2,
     p_bi_id in number,
     p_contact_record_id	IN VARCHAR2,
     p_contact_type	IN VARCHAR2,
     p_parent_record_id	IN VARCHAR2,
     p_tracking_number	IN VARCHAR2,
     p_created_by_name	IN VARCHAR2,
     p_create_date	IN VARCHAR2,
     p_complete_date	IN VARCHAR2,
     p_contact_start_time	IN VARCHAR2,
     p_contact_end_time	IN VARCHAR2,
     --p_handle_time	IN VARCHAR2,
     p_contact_group	IN VARCHAR2,
     p_language	IN VARCHAR2,
     p_translation_required	IN VARCHAR2,
     p_ext_telephony_ref	IN VARCHAR2,
     p_note_category	IN VARCHAR2,
     p_note_type	IN VARCHAR2,
     p_note_source	IN VARCHAR2,
     p_note_present	IN VARCHAR2,
     p_contact_record_field_1	IN VARCHAR2,
     p_contact_record_field_2	IN VARCHAR2,
     p_contact_record_field_3	IN VARCHAR2,
     p_contact_record_field_4	IN VARCHAR2,
     p_contact_record_field_5	IN VARCHAR2,
     p_handle_call_webchat_start_dt	IN VARCHAR2,
     p_handle_call_webchat_end_dt	IN VARCHAR2,
     p_handle_call_webchat_perf_by	IN VARCHAR2,
     p_create_route_work_start_date	IN VARCHAR2,
     p_create_route_work_end_date	IN VARCHAR2,
     p_instance_status	IN VARCHAR2,
     p_cancel_date	IN VARCHAR2,
     p_last_update_by_name	IN VARCHAR2,
     p_last_update_date	IN VARCHAR2,
     p_handle_contact_flag	IN VARCHAR2,
     p_create_route_work_flag	IN VARCHAR2,
     p_cancel_contact_flag	IN VARCHAR2,
     p_work_identified_flag	IN VARCHAR2,
     p_participant_status	IN VARCHAR2,
     p_cancel_method	IN VARCHAR2,
     p_cancel_reason	IN VARCHAR2,
     p_cancel_by	IN VARCHAR2,
     p_created_by_role	IN VARCHAR2,
     p_created_by_unit	IN VARCHAR2
    )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DICICUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dicicur D_SCI_CURRENT%rowtype := null;
  begin
          
     r_dicicur.sci_bi_id := p_bi_id;
     r_dicicur.contact_record_id := p_contact_record_id;
     r_dicicur.contact_type  := p_contact_type ;
     r_dicicur.parent_record_id := p_parent_record_id;
     r_dicicur.tracking_number := p_tracking_number;
     r_dicicur.created_by_name := p_created_by_name;
     r_dicicur.create_date := TO_DATE(p_create_date, bpm_common.date_fmt);
     r_dicicur.complete_date := TO_DATE(p_complete_date, bpm_common.date_fmt);
     r_dicicur.contact_start_time := TO_DATE(p_contact_start_time, bpm_common.date_fmt);
     r_dicicur.contact_end_time := TO_DATE(p_contact_end_time, bpm_common.date_fmt);
     r_dicicur.contact_group := p_contact_group;
     r_dicicur.language := p_language;
     r_dicicur.translation_required := p_translation_required;
     r_dicicur.ext_telephony_ref := p_ext_telephony_ref;
     r_dicicur.note_category := p_note_category;
     r_dicicur.note_type := p_note_type;
     r_dicicur.note_source := p_note_source;
     r_dicicur.note_present := p_note_present;
     r_dicicur.contact_record_field_1 := p_contact_record_field_1;
     r_dicicur.contact_record_field_2 := p_contact_record_field_2;
     r_dicicur.contact_record_field_3 := p_contact_record_field_3;
     r_dicicur.contact_record_field_4 := p_contact_record_field_4;
     r_dicicur.handle_call_webchat_start_date := TO_DATE(p_handle_call_webchat_start_dt, bpm_common.date_fmt);
     r_dicicur.handle_call_webchat_end_date := TO_DATE(p_handle_call_webchat_end_dt, bpm_common.date_fmt);
     r_dicicur.handle_call_webchat_perf_by := p_handle_call_webchat_perf_by;
     r_dicicur.create_route_work_start_date := TO_DATE(p_create_route_work_start_date, bpm_common.date_fmt);
     r_dicicur.create_route_work_end_date := TO_DATE(p_create_route_work_end_date, bpm_common.date_fmt);
     r_dicicur.instance_status := p_instance_status;
     r_dicicur.last_update_by_name := p_last_update_by_name;
     r_dicicur.last_update_date := TO_DATE(p_last_update_date, bpm_common.date_fmt);
     r_dicicur.handle_contact_flag := p_handle_contact_flag;
     r_dicicur.create_route_work_flag := p_create_route_work_flag;
     r_dicicur.cancel_contact_flag := p_cancel_contact_flag;
     r_dicicur.cancel_date := TO_DATE(p_cancel_date, bpm_common.date_fmt);
     r_dicicur.work_identified_flag := p_work_identified_flag;

     r_dicicur.handle_time := get_handle_time(r_dicicur.contact_start_time, r_dicicur.contact_end_time);
     --r_dicicur.participant_status := get_participant_status (p_contact_record_id);
     r_dicicur.participant_status := p_participant_status;
     r_dicicur.cancel_method := p_cancel_method;
     r_dicicur.cancel_reason := p_cancel_reason;
     r_dicicur.cancel_by := p_cancel_by;

     -- TXEB
     r_dicicur.created_by_role := p_created_by_role;
     r_dicicur.created_by_unit := p_created_by_unit;

    if p_set_type = 'INSERT' then
      insert into D_SCI_CURRENT
      values r_dicicur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_SCI_CURRENT
        set row = r_dicicur
        where SCI_BI_ID = p_bi_id;
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
      
  END SET_DICICUR;
  
  
  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_new_data T_INS_CI_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_ficibd_id number := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
  begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_CI_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.contact_record_id;
    v_start_date := to_date(v_new_data.contact_start_dt,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.complete_dt,v_new_data.cancel_dt),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;
  
    -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
         
      SET_DICICUR
        ('INSERT',v_identifier,v_bi_id,
        v_new_data.contact_record_id,v_new_data.contact_type,v_new_data.parent_record_id,
        v_new_data.tracking_number,v_new_data.created_by,v_new_data.create_dt,
        v_new_data.complete_dt,v_new_data.contact_start_dt,v_new_data.contact_end_dt,
        --v_new_data.handle_time
        v_new_data.contact_group,v_new_data.language,v_new_data.translation_req,v_new_data.ext_telephony_ref,
        v_new_data.note_category,v_new_data.note_type,v_new_data.note_source,
        v_new_data.note_present,v_new_data.contact_record_field1,v_new_data.contact_record_field2,
        v_new_data.contact_record_field3,v_new_data.contact_record_field4,v_new_data.contact_record_field5,
        v_new_data.assd_handle_contact,v_new_data.ased_handle_contact,v_new_data.aspb_handle_contact,
        v_new_data.assd_create_route_work,v_new_data.ased_create_route_work,v_new_data.instance_status,
        v_new_data.cancel_dt,v_new_data.last_update_by_name,v_new_data.last_update_dt,
        v_new_data.asf_handle_contact,v_new_data.asf_create_route_work,v_new_data.asf_cancel_contact,
        v_new_data.gwf_work_identified,v_new_data.participant_status,
        v_new_data.cancel_method,v_new_data.cancel_reason,v_new_data.cancel_by,
        v_new_data.created_by_role,v_new_data.created_by_unit); 
        
      INS_FSCIBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_new_data.STG_LAST_UPDATE_DATE,
         v_ficibd_id);
      
      
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
  
   
  -- Update fact for BPM Semantic model - NYEC Process App process. 
  procedure UPD_FICIBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_stg_last_update_date in varchar2,
     p_fscibd_id out number) 
     
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FICIBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fscibd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_event_date date := null;

    r_ficibd F_SCI_BY_DATE%rowtype := null;
  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;

    with most_recent_fact_bi_id as
      (select 
         max(fscibd_id) max_fscibd_id,
         max(D_DATE) max_d_date
       from F_SCI_BY_DATE
       where sci_bi_id = p_bi_id) 
    select 
      ficibd.fscibd_id,
      ficibd.D_DATE,
      ficibd.CREATION_COUNT,
      ficibd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fscibd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_SCI_BY_DATE ficibd,
      most_recent_fact_bi_id 
    where
      ficibd.fscibd_id = max_fscibd_id
      and ficibd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
      
    if p_end_date is null then
      r_ficibd.D_DATE := v_event_date;
      r_ficibd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_ficibd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_ficibd.INVENTORY_COUNT := 1;
      r_ficibd.COMPLETION_COUNT := 0;
    else
      
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_SCI_BY_DATE
        where 
          sci_bi_id = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        with most_recent_fact_bi_id as
          (select 
             max(fscibd_id) max_fscibd_id,
             max(D_DATE) max_d_date
           from F_SCI_BY_DATE
           where sci_bi_id = p_bi_id) 
        select 
          ficibd.fscibd_id,
          ficibd.D_DATE,
          ficibd.CREATION_COUNT,
          ficibd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date
        into 
          v_fscibd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date
        from 
          F_SCI_BY_DATE ficibd,
          most_recent_fact_bi_id 
        where
          ficibd.fscibd_id = max_fscibd_id
          and ficibd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
      r_ficibd.D_DATE := p_end_date;
      r_ficibd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_ficibd.BUCKET_END_DATE := r_ficibd.BUCKET_START_DATE;
      r_ficibd.INVENTORY_COUNT := 0;
      r_ficibd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fscibd_id := seq_fscibd_id.NEXTVAL;
    r_ficibd.fscibd_id := p_fscibd_id;
    r_ficibd.sci_bi_id := p_bi_id;
    r_ficibd.CREATION_COUNT := 0;
    
    -- Validate fact date ranges.
    if r_ficibd.D_DATE < r_ficibd.BUCKET_START_DATE
      or to_date(to_char(r_ficibd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_ficibd.BUCKET_END_DATE
      or r_ficibd.BUCKET_START_DATE > r_ficibd.BUCKET_END_DATE
      or r_ficibd.BUCKET_END_DATE < r_ficibd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_ficibd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_ficibd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_ficibd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_ficibd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_ficibd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_SCI_BY_DATE
      set row = r_ficibd
      where fscibd_id = v_fscibd_id_old;
        
    else
    
      -- Different bucket time.
    
      update F_SCI_BY_DATE
      set BUCKET_END_DATE = r_ficibd.BUCKET_START_DATE
      where fscibd_id = v_fscibd_id_old;
        
      insert into F_SCI_BY_DATE
      values r_ficibd;
      
    end if;
    
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);  
      raise; 
      
  END UPD_FICIBD; 


  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_old_data T_UPD_CI_XML := null;
    v_new_data T_UPD_CI_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_ficibd_id number := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Client Outreach in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_CI_XML(p_old_data_xml,v_old_data);
    GET_UPD_CI_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.contact_record_id;
    v_start_date := to_date(v_new_data.CONTACT_START_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT); 
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select SCI_BI_ID 
    into v_bi_id
    from D_SCI_CURRENT
    where CONTACT_RECORD_ID = v_identifier;

    -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
         
      SET_DICICUR
        ('UPDATE',v_identifier,v_bi_id,
        v_new_data.contact_record_id,v_new_data.contact_type,v_new_data.parent_record_id,
        v_new_data.tracking_number,v_new_data.created_by,v_new_data.create_dt,
        v_new_data.complete_dt,v_new_data.contact_start_dt,v_new_data.contact_end_dt,
        --v_new_data.handle_time
        v_new_data.contact_group,v_new_data.language,v_new_data.translation_req,v_new_data.ext_telephony_ref,
        v_new_data.note_category,v_new_data.note_type,v_new_data.note_source,
        v_new_data.note_present,v_new_data.contact_record_field1,v_new_data.contact_record_field2,
        v_new_data.contact_record_field3,v_new_data.contact_record_field4,v_new_data.contact_record_field5,
        v_new_data.assd_handle_contact,v_new_data.ased_handle_contact,v_new_data.aspb_handle_contact,
        v_new_data.assd_create_route_work,v_new_data.ased_create_route_work,v_new_data.instance_status,
        v_new_data.cancel_dt,v_new_data.last_update_by_name,v_new_data.last_update_dt,
        v_new_data.asf_handle_contact,v_new_data.asf_create_route_work,v_new_data.asf_cancel_contact,
        v_new_data.gwf_work_identified,v_new_data.participant_status,
        v_new_data.cancel_method,v_new_data.cancel_reason,v_new_data.cancel_by,
        v_new_data.created_by_role,v_new_data.created_by_unit); 
        
      UPD_FICIBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_new_data.STG_LAST_UPDATE_DATE,
         v_ficibd_id);
      
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
  
END CLIENT_INQUIRY;
/

alter session set plsql_code_type = interpreted;
