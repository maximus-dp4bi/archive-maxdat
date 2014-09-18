alter session set plsql_code_type = native;

create or replace package MANAGE_JOBS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/createdb/MANAGE_JOBS_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 3567 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-07-01 15:26:32 -0700 (Mon, 01 Jul 2013) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

  procedure CALC_DMJCUR;


 /* FUNCTION GET_CANCEL_REASON(
    p_job_type  IN VARCHAR,
    p_file_name IN VARCHAR,
    p_job_end_dt DATE,
    p_job_status IN VARCHAR,
    p_job_id     IN NUMBER)
  RETURN VARCHAR2;*/
     
  FUNCTION FILE_RECEIVED_TIMELY(
    p_receipt_dt IN DATE,
    p_job_type   IN VARCHAR,
    p_file_name  IN VARCHAR)
  RETURN VARCHAR2;
     
  FUNCTION RECORD_THRESHOLD_CNT(
    p_record_count IN VARCHAR,
    p_job_type     IN VARCHAR,
    p_file_name    IN VARCHAR)
  RETURN VARCHAR2;
  
  FUNCTION RECORD_ERROR_PER(
    p_record_count NUMBER,
    p_error_count  NUMBER,
    p_job_type IN VARCHAR)
  RETURN NUMBER;  
  
  FUNCTION RECORD_ERR_THRESHOLD(
    p_record_count NUMBER,
    p_error_count  NUMBER,
    p_job_type  IN VARCHAR,
    p_file_name IN VARCHAR)
  RETURN VARCHAR2;
     
  FUNCTION GET_FILE_PROCESSED_TIMELY(
    p_ased_process_job IN DATE,
    p_job_type         IN VARCHAR,
    p_file_name        IN VARCHAR)
  RETURN VARCHAR2;
  
  FUNCTION GET_FILE_PROCESS_TIME(
    p_job_start_dt DATE ,
    p_job_end_dt   DATE,
    p_job_type IN VARCHAR )
  RETURN VARCHAR2;
  
     
 
  /*
   select '     '|| 'CEMFR_ID varchar2(100),' attr_element from dual  
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
    bast.BSL_ID = 11
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
  order by attr_element asc;
  */
  type T_INS_MJ_XML is record 
    (
          ASED_CREATE_OUTBOUND_FILE varchar2(19),
     ASED_CREATE_RESPONSE_FILE varchar2(19),
     ASED_IDENTIFY_JOB varchar2(19),
     ASED_PROCESS_JOB varchar2(19),
     ASF_CREATE_OUTBOUND_FILE varchar2(1),
     ASF_CREATE_RESPONSE_FILE varchar2(1),
     ASF_IDENTIFY_JOB varchar2(1),
     ASF_PROCESS_JOB varchar2(1),
     ASSD_CREATE_OUTBOUND_FILE varchar2(19),
     ASSD_CREATE_RESPONSE_FILE varchar2(19),
     ASSD_IDENTIFY_JOB varchar2(19),
     ASSD_PROCESS_JOB varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CEMFR_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATED_BY varchar2(80),
     CREATE_DT varchar2(19),
     FILE_DESTINATION varchar2(50),
     FILE_NAME varchar2(50),
     FILE_SOURCE varchar2(50),
     FILE_TYPE varchar2(50),
     GWF_JOB_TYPE varchar2(1),
     GWF_PROCESSED_OK varchar2(1),
     GWF_RESPONSE_FILE varchar2(1),
     INSTANCE_STATUS varchar2(10),
     JOB_DETAIL varchar2(500),
     JOB_END_DT varchar2(19),
     JOB_GROUP varchar2(80),
     JOB_ID varchar2(100),
     JOB_NAME varchar2(500),
     JOB_START_DT varchar2(19),
     JOB_STATUS varchar2(100),
     JOB_TYPE varchar2(32),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(50),
     PLAN_NAME varchar2(50),
     RECEIPT_DT varchar2(19),
     RECORD_COUNT varchar2(100),
     RECORD_ERROR_COUNT varchar2(100),
     RESPONSE_FILE_NAME varchar2(50),
     RESPONSE_FILE_REQ varchar2(50),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRANSMIT_DT varchar2(19)
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
    bast.BSL_ID = 11
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT')
  order by attr_element asc;
  */
  type T_UPD_MJ_XML is record
    (
          ASED_CREATE_OUTBOUND_FILE varchar2(19),
     ASED_CREATE_RESPONSE_FILE varchar2(19),
     ASED_IDENTIFY_JOB varchar2(19),
     ASED_PROCESS_JOB varchar2(19),
     ASF_CREATE_OUTBOUND_FILE varchar2(1),
     ASF_CREATE_RESPONSE_FILE varchar2(1),
     ASF_IDENTIFY_JOB varchar2(1),
     ASF_PROCESS_JOB varchar2(1),
     ASSD_CREATE_OUTBOUND_FILE varchar2(19),
     ASSD_CREATE_RESPONSE_FILE varchar2(19),
     ASSD_IDENTIFY_JOB varchar2(19),
     ASSD_PROCESS_JOB varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     COMPLETE_DT varchar2(19),
     CREATED_BY varchar2(80),
     CREATE_DT varchar2(19),
     FILE_DESTINATION varchar2(50),
     FILE_NAME varchar2(50),
     FILE_SOURCE varchar2(50),
     FILE_TYPE varchar2(50),
     GWF_JOB_TYPE varchar2(1),
     GWF_PROCESSED_OK varchar2(1),
     GWF_RESPONSE_FILE varchar2(1),
     INSTANCE_STATUS varchar2(10),
     JOB_DETAIL varchar2(500),
     JOB_END_DT varchar2(19),
     JOB_GROUP varchar2(80),
     JOB_ID varchar2(100),
     JOB_NAME varchar2(500),
     JOB_START_DT varchar2(19),
     JOB_STATUS varchar2(100),
     JOB_TYPE varchar2(32),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(50),
     PLAN_NAME varchar2(50),
     RECEIPT_DT varchar2(19),
     RECORD_COUNT varchar2(100),
     RECORD_ERROR_COUNT varchar2(100),
     RESPONSE_FILE_NAME varchar2(50),
     RESPONSE_FILE_REQ varchar2(50),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRANSMIT_DT varchar2(19)
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

create or replace 
package body MANAGE_JOBS as

  v_bem_id number := 11; -- 'Manage Jobs'
  v_bil_id number := 11; -- 'Job ID'
  v_bsl_id number := 11; -- 'CORP_ETL_MANAGE_JOBS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dmjcur_job_name varchar2(30) := 'CALC_DMJCUR';


/*FUNCTION GET_CANCEL_REASON(
    p_job_type  IN VARCHAR,
    p_file_name IN VARCHAR,
    p_job_end_dt DATE,
    p_job_status IN VARCHAR,
    p_job_id     IN NUMBER)
  RETURN VARCHAR2
IS
BEGIN
  IF p_job_status = 'File Not Found' THEN
    RETURN 'File Not Found';
  elsif p_job_type IN('Inbound File','Outbound File') AND p_file_name = 'Unknown' AND p_job_end_dt IS NOT NULL THEN
    RETURN 'Unknown File';
  elsif p_job_type IN ('Other Job Type') AND p_job_end_dt IS NOT NULL THEN
    RETURN 'Other Job Type';
  elsif p_job_id IS NULL THEN
    RETURN 'Deleted';
  ELSE
    RETURN NULL;
  END IF;
END;
*/

FUNCTION FILE_RECEIVED_TIMELY(
    p_receipt_dt IN DATE,
    p_job_type   IN VARCHAR,
    p_file_name  IN VARCHAR)
  RETURN VARCHAR2
IS
  v_sla_time DATE;
BEGIN
  SELECT DISTINCT LK.SLA_TIME
  INTO v_sla_time
  FROM corp_etl_manage_jobs jb,
    CORP_MJ_FILE_CAL_LKUP lk
  WHERE jb.file_name = lk.file_name(+)
  --AND jb.file_name   = p_file_name;
  AND NVL(jb.file_name,'XYZ') = NVL(p_file_name,'XYZ');
  
  IF p_job_type      = 'Inbound File' AND v_sla_time IS NOT NULL AND TO_CHAR(p_receipt_dt, 'HH24:MI') <= TO_CHAR(v_sla_time, 'HH24:MI') THEN
    RETURN 'Timely';
  elsif p_job_type = 'Inbound File' AND v_sla_time IS NOT NULL AND TO_CHAR(p_receipt_dt, 'HH24:MI') > TO_CHAR(v_sla_time, 'HH24:MI') THEN
    RETURN 'Untimely';
  --elsif p_job_type IN('Outbound File','Other Job Type') THEN
  --  RETURN 'NA';
  ELSE
    RETURN 'NA';
  END IF;
END; 


FUNCTION RECORD_THRESHOLD_CNT(
    p_record_count IN VARCHAR,
    p_job_type     IN VARCHAR,
    p_file_name    IN VARCHAR)
  RETURN VARCHAR2
IS
  v_min NUMBER;
  v_max NUMBER;
BEGIN
  SELECT DISTINCT LK.MINIMUM_RECORDS_EXPECTED,
    LK.MAXIMUM_RECORDS_EXPECTED
  INTO v_min,
    v_max
  FROM corp_etl_manage_jobs jb,
    CORP_MJ_FILE_CAL_LKUP lk
  WHERE jb.file_name  = lk.file_name(+)
  --AND jb.file_name = p_file_name;
  AND NVL(jb.file_name,'XYZ') = NVL(p_file_name,'XYZ');
  
  IF p_job_type IN ('Inbound File','Outbound File') AND v_min IS NOT NULL AND v_max IS NOT NULL AND (p_record_count BETWEEN v_min AND v_max) THEN
    RETURN 'Y';
  elsif p_job_type IN ('Inbound File','Outbound File') AND v_min IS NOT NULL AND v_max IS NOT NULL AND (p_record_count NOT BETWEEN v_min AND v_max) THEN
    RETURN 'N';
  ELSE
    RETURN 'NA';
  END IF;
END;


FUNCTION RECORD_ERROR_PER(
    p_record_count NUMBER,
    p_error_count  NUMBER,
    p_job_type IN VARCHAR)
  RETURN NUMBER
IS
  record_error_percentage NUMBER;
BEGIN
  record_error_percentage:= ROUND(p_error_count/p_record_count*100,2);
  IF p_job_type IN('Inbound File','Outbound File') THEN
    RETURN(record_error_percentage);
  ELSE
    RETURN NULL;
  END IF;
EXCEPTION
WHEN ZERO_DIVIDE THEN
  RETURN 0;
END;


FUNCTION RECORD_ERR_THRESHOLD(
    p_record_count NUMBER,
    p_error_count  NUMBER,
    p_job_type  IN VARCHAR,
    p_file_name IN VARCHAR)
  RETURN VARCHAR2
IS
  v_error_alert NUMBER(3,2);
BEGIN
  SELECT DISTINCT LK.PERCENTAGE_OF_ERRORS_TO_ALERT
  INTO v_error_alert
  FROM corp_etl_manage_jobs jb,
    CORP_MJ_FILE_CAL_LKUP lk
  WHERE jb.file_name  = lk.file_name(+)
  --AND jb.file_name  = p_file_name;
  AND NVL(jb.file_name,'XYZ') = NVL(p_file_name,'XYZ');
  
  IF p_job_type IN('Inbound File','Outbound File') AND v_error_alert IS NOT NULL AND RECORD_ERROR_PER (p_record_count,p_error_count,p_job_type)< v_error_alert THEN
    RETURN 'Y';
  elsif p_job_type IN ('Inbound File','Outbound File') AND v_error_alert IS NOT NULL AND RECORD_ERROR_PER (p_record_count,p_error_count,p_job_type)> v_error_alert THEN
    RETURN 'N';
  ELSE
    RETURN 'NA';
  END IF;
END;


FUNCTION GET_FILE_PROCESSED_TIMELY(
    p_ased_process_job IN DATE,
    p_job_type         IN VARCHAR,
    p_file_name        IN VARCHAR)
  RETURN VARCHAR2
IS
  v_processed_time DATE;
BEGIN
  SELECT DISTINCT LK.TIMELY_PROCESSING_ALERT_TIME
  INTO v_processed_time
  FROM corp_etl_manage_jobs jb,
    CORP_MJ_FILE_CAL_LKUP lk
  WHERE jb.file_name = lk.file_name(+)
  --AND jb.file_name = p_file_name;
  AND NVL(jb.file_name,'XYZ') = NVL(p_file_name,'XYZ');
  
  IF p_job_type IN ('Inbound File','Outbound File') AND v_processed_time IS NOT NULL AND TO_CHAR(p_ased_process_job, 'HH24:MI') <= TO_CHAR(v_processed_time, 'HH24:MI') THEN
    RETURN 'Timely';
  elsif p_job_type IN ('Inbound File','Outbound File') AND v_processed_time IS NOT NULL AND TO_CHAR(p_ased_process_job, 'HH24:MI') > TO_CHAR(v_processed_time, 'HH24:MI') THEN
    RETURN 'Untimely';
  ELSE
    RETURN 'NA';
  END IF;
END; 


FUNCTION GET_FILE_PROCESS_TIME(
    p_job_start_dt DATE ,
    p_job_end_dt   DATE,
    p_job_type IN VARCHAR )
  RETURN VARCHAR2
IS
  days         NUMBER;
  day_fraction NUMBER;
  hrs          NUMBER;
  mints        NUMBER;
  sec          NUMBER;
BEGIN
  --days  :=trunc(p_job_end_dt - add_months(p_job_start_dt,trunc(months_between(p_job_end_dt,p_job_start_dt) )));
  days        :=TRUNC(p_job_end_dt     -p_job_start_dt);
  day_fraction:= (p_job_end_dt         -p_job_start_dt)-TRUNC(p_job_end_dt-p_job_start_dt);
  hrs         :=TRUNC(day_fraction     *24);
  mints       :=TRUNC((((day_fraction) *24)-(hrs))*60);
  sec         :=TRUNC(mod((p_job_end_dt-p_job_start_dt)*24*60*60,60));
  IF p_job_type                       IN('Inbound File','Outbound File') THEN
    RETURN(days||':'||hrs||':'||mints||':'||sec);
  ELSE
    RETURN NULL;
  END IF;
END;



  
-- Calculate column values in BPM Semantic table D_MJ_CURRENT.
  procedure CALC_DMJCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMJCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
update D_MJ_CURRENT
    set
      --CANCEL_REASON = GET_CANCEL_REASON(job_type, file_name, job_end_date, job_status, job_id),
      FILE_RECEIVED_TIMELY = FILE_RECEIVED_TIMELY(receipt_date, job_type, file_name),
      RECORD_COUNT_THRESHOLD_MET = RECORD_THRESHOLD_CNT(record_count, job_type, file_name),
      RECORD_ERROR_PERCENTAGE = RECORD_ERROR_PER(record_count,RECORD_ERROR_COUNT,job_type),
      RECORD_ERROR_THRESHOLD = RECORD_ERR_THRESHOLD(record_count, RECORD_ERROR_COUNT, job_type, file_name),
      FILE_PROCESSED_TIMELY = GET_FILE_PROCESSED_TIMELY(PROCESS_JOB_END_DATE, job_type, file_name),
      FILE_PROCESS_TIME = GET_FILE_PROCESS_TIME(job_start_date, job_end_date, job_type)
     
    where 
      COMPLETE_DATE is null 
      and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
 
 commit;
 
     v_log_message := v_num_rows_updated  || ' D_MJ_CURRENT rows updated with calculated attributes by CALC_DMJCUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

  end;
 
 
 
-- Get dimension ID for BPM Semantic model - Manage Jobs - LAST_UPDATE_BY.
  procedure GET_DMJLUB_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_last_update_by_name in varchar2,
      p_dimjlub_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMJLUB_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

   SELECT DIMJLUB_ID
    INTO p_dimjlub_id
    FROM D_MJ_LAST_UPDATE_BY
    WHERE 
          last_update_by_name  = p_last_update_by_name
           OR (last_update_by_name   IS NULL AND p_last_update_by_name IS NULL);
      
   exception
     when NO_DATA_FOUND then
       p_dimjlub_id := SEQ_DIMJLUB_ID.nextval;
       begin
         insert into D_MJ_LAST_UPDATE_BY (DIMJLUB_ID, last_update_by_name)
         values (p_dimjlub_id,p_last_update_by_name);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIMJLUB_ID into p_dimjlub_id
           from D_MJ_LAST_UPDATE_BY
           where 
              last_update_by_name  = p_last_update_by_name
             OR (last_update_by_name   IS NULL AND p_last_update_by_name IS NULL);
             
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
 
-- Get record for Manage Jobs insert XML.
  procedure GET_INS_MJ_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_MJ_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MJ_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  
/*
select '      extractValue(p_data_xml,''/ROWSET/ROW/CEMFR_ID'') "' || 'CEMFR_ID'|| '",' attr_element from dual
    union 
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union 
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
      BAST.BSL_ID = 11
      and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
      order by attr_element asc;
*/ 
    select
            extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_OUTBOUND_FILE') "ASED_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_RESPONSE_FILE') "ASED_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDENTIFY_JOB') "ASED_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_JOB') "ASED_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_OUTBOUND_FILE') "ASF_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_RESPONSE_FILE') "ASF_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDENTIFY_JOB') "ASF_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_JOB') "ASF_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_OUTBOUND_FILE') "ASSD_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_RESPONSE_FILE') "ASSD_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDENTIFY_JOB') "ASSD_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_JOB') "ASSD_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CEMFR_ID') "CEMFR_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_DESTINATION') "FILE_DESTINATION",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_NAME') "FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_SOURCE') "FILE_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_TYPE') "FILE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_JOB_TYPE') "GWF_JOB_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PROCESSED_OK') "GWF_PROCESSED_OK",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESPONSE_FILE') "GWF_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_DETAIL') "JOB_DETAIL",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_END_DT') "JOB_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_GROUP') "JOB_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID') "JOB_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_NAME') "JOB_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_START_DT') "JOB_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_STATUS') "JOB_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_TYPE') "JOB_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_NAME') "PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECORD_COUNT') "RECORD_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECORD_ERROR_COUNT') "RECORD_ERROR_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FILE_NAME') "RESPONSE_FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FILE_REQ') "RESPONSE_FILE_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSMIT_DT') "TRANSMIT_DT"  
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
  
 -- Get record for Manage Jobs update XML. 
  procedure GET_UPD_MJ_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MJ_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MJ_XML';
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
      BAST.BSL_ID = 11
      and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
    order by attr_element asc; 
*/ 
     select
            extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_OUTBOUND_FILE') "ASED_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_RESPONSE_FILE') "ASED_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDENTIFY_JOB') "ASED_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_JOB') "ASED_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_OUTBOUND_FILE') "ASF_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_RESPONSE_FILE') "ASF_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDENTIFY_JOB') "ASF_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_JOB') "ASF_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_OUTBOUND_FILE') "ASSD_CREATE_OUTBOUND_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_RESPONSE_FILE') "ASSD_CREATE_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDENTIFY_JOB') "ASSD_IDENTIFY_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_JOB') "ASSD_PROCESS_JOB",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY') "CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_DESTINATION') "FILE_DESTINATION",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_NAME') "FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_SOURCE') "FILE_SOURCE",
      extractValue(p_data_xml,'/ROWSET/ROW/FILE_TYPE') "FILE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_JOB_TYPE') "GWF_JOB_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PROCESSED_OK') "GWF_PROCESSED_OK",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESPONSE_FILE') "GWF_RESPONSE_FILE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_DETAIL') "JOB_DETAIL",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_END_DT') "JOB_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_GROUP') "JOB_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID') "JOB_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_NAME') "JOB_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_START_DT') "JOB_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_STATUS') "JOB_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_TYPE') "JOB_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_NAME') "PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECORD_COUNT') "RECORD_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECORD_ERROR_COUNT') "RECORD_ERROR_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FILE_NAME') "RESPONSE_FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FILE_REQ') "RESPONSE_FILE_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSMIT_DT') "TRANSMIT_DT"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  

-- Insert fact for BPM Semantic model - Manage Jobs process. 
    procedure INS_FIMBD 
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dimjlub_id in number,  
     p_last_update_date in varchar2,
    -- p_stg_last_update_date in varchar2,   
     p_fimjbd_id out number)
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FIMBD';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
       --  v_stg_last_update_date date := null;
         v_last_update_date date:=null;
    begin
     -- v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_last_update_date:=to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      p_fimjbd_id := SEQ_FIMJBD_ID.nextval;
      
      v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
      if p_end_date is null then
        v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      else 
        v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      end if;  
      
       -- Validate fact date ranges.
            if p_start_date < v_bucket_start_date
              --or p_start_date > v_bucket_end_date
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
      
  insert into F_MJ_BY_DATE
    (FIMJBD_ID, 
     D_DATE, 
     BUCKET_START_DATE, 
     BUCKET_END_DATE, 
     MJ_BI_ID, 
     DIMJLUB_ID, 
     LAST_UPDATE_BY_DATE, 
     INVENTORY_COUNT, 
     CREATION_COUNT, 
     COMPLETION_COUNT )
	values
	(p_fimjbd_id,
	  p_start_date,
	  to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt),
	  v_bucket_end_date,
	  p_bi_id,
	  p_dimjlub_id,
    v_last_update_date,
	  case 
	  when p_end_date is null then 1
	  else 0
	  end,
	  1,
	  case 
	    when p_end_date is null then 0
	    else 1
	    end
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
      
    v_new_data T_INS_MJ_XML := null;
      
  begin  
	 
  if p_data_version >1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Jobs in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_MJ_XML(p_new_data_xml,v_new_data);
    
    v_bi_id := SEQ_BI_ID.nextval;
    v_identifier := v_new_data.JOB_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);  
    
  insert into BPM_INSTANCE 
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.CEMFR_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
  
    commit;  
  v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
  /*
  select 'BPM_EVENT.INSERT_BIA(v_bi_id, '||b.ba_id || ','||bl.bdl_id || ',v_new_data.'|| stg.staging_table_column || ',v_start_date,v_bue_id);'
      from bpm_attribute b, bpm_attribute_lkup bl,bpm_attribute_staging_table stg
      where b.bal_id = bl.bal_id
      and stg.ba_id = b.ba_id
      and b.when_populated in ('CREATE','BOTH')
      and b.bem_id = 11
      and bsl_id = 11
      order by b.ba_id
  */    
    BPM_EVENT.INSERT_BIA(v_bi_id, 1482,1,v_new_data.JOB_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1483,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1484,2,v_new_data.CREATED_BY,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1485,2,v_new_data.JOB_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1486,2,v_new_data.JOB_DETAIL,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1487,2,v_new_data.JOB_GROUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1488,2,v_new_data.JOB_TYPE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1489,3,v_new_data.JOB_START_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1490,3,v_new_data.JOB_END_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1491,2,v_new_data.JOB_STATUS,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1492,2,v_new_data.FILE_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1493,3,v_new_data.RECEIPT_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1494,3,v_new_data.TRANSMIT_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1495,2,v_new_data.FILE_TYPE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1496,2,v_new_data.FILE_SOURCE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1497,2,v_new_data.FILE_DESTINATION,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1498,2,v_new_data.PLAN_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1499,2,v_new_data.RESPONSE_FILE_REQ,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1500,1,v_new_data.RECORD_COUNT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1501,1,v_new_data.RECORD_ERROR_COUNT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1502,2,v_new_data.RESPONSE_FILE_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1503,2,v_new_data.LAST_UPDATE_BY_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1504,3,v_new_data.LAST_UPDATE_BY_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1505,3,v_new_data.ASSD_IDENTIFY_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1506,3,v_new_data.ASED_IDENTIFY_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1507,3,v_new_data.ASSD_PROCESS_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1508,3,v_new_data.ASED_PROCESS_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1509,3,v_new_data.ASSD_CREATE_RESPONSE_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1510,3,v_new_data.ASED_CREATE_RESPONSE_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1511,3,v_new_data.ASSD_CREATE_OUTBOUND_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1512,3,v_new_data.ASED_CREATE_OUTBOUND_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1513,3,v_new_data.COMPLETE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1514,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1515,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1516,2,v_new_data.ASF_IDENTIFY_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1517,2,v_new_data.ASF_PROCESS_JOB,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1518,2,v_new_data.ASF_CREATE_RESPONSE_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1519,2,v_new_data.ASF_CREATE_OUTBOUND_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1520,2,v_new_data.GWF_PROCESSED_OK,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1521,2,v_new_data.GWF_JOB_TYPE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1522,2,v_new_data.GWF_RESPONSE_FILE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1523,2,v_new_data.CANCEL_REASON,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1693,2,v_new_data.CANCEL_BY,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id, 1694,2,v_new_data.CANCEL_METHOD,v_start_date,v_bue_id);

commit;
        
        p_bue_id := v_bue_id;
        
      exception
         
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
end;


 -- Insert or update dimension for BPM Semantic model - Manage Jobs process - Current.
  procedure SET_DMJCUR  
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,   
   p_job_id in number, 
   p_create_date in	varchar2,
   p_created_by in varchar2,
   p_job_name in varchar2,
   p_job_detail in varchar2,
   p_job_group in varchar2,
   p_job_type in varchar2,
   p_job_start_date in varchar2,
   p_job_end_date in varchar2,
   p_job_status in varchar2,
   p_file_name in varchar2,
   p_receipt_date in varchar2,
   p_transmit_date in varchar2,
   p_file_type in varchar2,
   p_file_source in varchar2,
   p_file_destination in varchar2,
   p_health_plan_name in varchar2,
   p_response_file_required in varchar2,
   p_record_count in number,
   p_record_error_count in number,
   p_response_file_name in varchar2,
   p_last_update_by_name in varchar2,
   p_last_update_by_date in varchar2,
   p_identify_job_start_date in varchar2,
   p_identify_job_end_date in varchar2,
   p_process_job_start_date in varchar2,
   p_process_job_end_date in varchar2,
   p_create_resp_file_start_dt in varchar2, --
   p_create_resp_file_end_dt in varchar2, --
   p_create_outbound_start_date in varchar2,
   p_create_outbound_end_date in varchar2,
   p_identify_job_type_flag in varchar2,
   p_process_job_flag in varchar2,
   p_response_file_flag in varchar2,
   p_outbound_file_flag in varchar2,
   p_processed_ok_flag in varchar2,
   p_job_type_flag in varchar2,
   p_response_file_gtw_flag in varchar2,
   p_complete_date in varchar2,
   p_instance_Status in varchar2,
   p_cancel_date in varchar2,
   p_cancel_by in varchar2,
   p_cancel_reason in varchar2,
   p_cancel_method in varchar2
   --p_cur_file_received_timely in varchar2,
   --p_cur_record_cnt_threshold in varchar2,  --
   --p_cur_record_error_percentage in varchar2,
   --p_cur_record_error_threshold in varchar2,
   --p_cur_file_processed_timely in varchar2,
   --p_cur_file_process_time in varchar2 
   ) 
   
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMJCUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_dmjcur D_MJ_CURRENT%rowtype := null;
    --   v_jeopardy_flag varchar2(1) := null; 
  begin
  
  r_dmjcur.MJ_BI_ID := p_bi_id;  
  r_dmjcur.job_id := p_job_id;
  r_dmjcur.create_date := to_date(p_create_date,BPM_COMMON.DATE_FMT);  --
  r_dmjcur.created_by := p_created_by;
  r_dmjcur.job_name := p_job_name;
  r_dmjcur.job_detail := p_job_detail;
  r_dmjcur.job_group := p_job_group;
  r_dmjcur.job_type := p_job_type;
  r_dmjcur.job_start_date := to_date(p_job_start_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.job_end_date := to_date(p_job_end_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.job_status := p_job_status;
  r_dmjcur.file_name := p_file_name;
  r_dmjcur.receipt_date := to_date(p_receipt_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.transmit_date := to_date(p_transmit_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.file_type := p_file_type;
  r_dmjcur.file_source := p_file_source;
  r_dmjcur.file_destination := p_file_destination;
  r_dmjcur.health_plan_name := p_health_plan_name;
  r_dmjcur.response_file_required := p_response_file_required;
  r_dmjcur.record_count := p_record_count;
  r_dmjcur.record_error_count := p_record_error_count;
  r_dmjcur.response_file_name := p_response_file_name;
  r_dmjcur.last_update_by_name := p_last_update_by_name;
  r_dmjcur.last_update_by_date := to_date(p_last_update_by_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.identify_job_start_date := to_date(p_identify_job_start_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.identify_job_end_date := to_date(p_identify_job_end_date,BPM_COMMON.DATE_FMT);  
  r_dmjcur.process_job_start_date := to_date(p_process_job_start_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.process_job_end_date := to_date(p_process_job_end_date,BPM_COMMON.DATE_FMT);  
  r_dmjcur.create_reponse_file_start_date := to_date(p_create_resp_file_start_dt,BPM_COMMON.DATE_FMT); --
  r_dmjcur.create_response_file_end_date := to_date(p_create_resp_file_end_dt,BPM_COMMON.DATE_FMT); --
  r_dmjcur.create_outbound_start_date := to_date(p_create_outbound_start_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.create_outbound_end_date := to_date(p_create_outbound_end_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.identify_job_type_flag := p_identify_job_type_flag;
  r_dmjcur.process_job_flag := p_process_job_flag;
  r_dmjcur.response_file_flag := p_response_file_flag;
  r_dmjcur.outbound_file_flag := p_outbound_file_flag;
  r_dmjcur.response_file_flag := p_response_file_flag;  
  r_dmjcur.processed_ok_flag := p_processed_ok_flag;
  r_dmjcur.job_type_flag := p_job_type_flag;
  r_dmjcur.response_file_gtw_flag := p_response_file_gtw_flag;  
  r_dmjcur.complete_date := to_date(p_complete_date,BPM_COMMON.DATE_FMT);
  r_dmjcur.instance_Status := p_instance_Status;
  r_dmjcur.cancel_date := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);   
  r_dmjcur.cancel_by := p_cancel_by;
  r_dmjcur.cancel_reason := p_cancel_reason;
  r_dmjcur.cancel_method := p_cancel_method;
  --r_dmjcur.CANCEL_REASON := GET_CANCEL_REASON(r_dmjcur.job_type, r_dmjcur.file_name, r_dmjcur.job_end_date, r_dmjcur.job_status, r_dmjcur.job_id);
  r_dmjcur.FILE_RECEIVED_TIMELY := FILE_RECEIVED_TIMELY(r_dmjcur.receipt_date, r_dmjcur.job_type, r_dmjcur.file_name);
  r_dmjcur.RECORD_COUNT_THRESHOLD_MET := RECORD_THRESHOLD_CNT(r_dmjcur.record_count, r_dmjcur.job_type, r_dmjcur.file_name);
  r_dmjcur.RECORD_ERROR_PERCENTAGE := RECORD_ERROR_PER(r_dmjcur.record_count,r_dmjcur.RECORD_ERROR_COUNT,r_dmjcur.job_type);
  r_dmjcur.RECORD_ERROR_THRESHOLD := RECORD_ERR_THRESHOLD(r_dmjcur.record_count, r_dmjcur.RECORD_ERROR_COUNT, r_dmjcur.job_type, r_dmjcur.file_name);
  r_dmjcur.FILE_PROCESSED_TIMELY := GET_FILE_PROCESSED_TIMELY(r_dmjcur.PROCESS_JOB_END_DATE, r_dmjcur.job_type, r_dmjcur.file_name);
  r_dmjcur.FILE_PROCESS_TIME := GET_FILE_PROCESS_TIME(r_dmjcur.job_start_date, r_dmjcur.job_end_date, r_dmjcur.job_type);
 
  if p_set_type = 'INSERT' then
       insert into D_MJ_CURRENT
       values r_dmjcur;
     elsif p_set_type = 'UPDATE' then
       begin
         update D_MJ_CURRENT
         set row = r_dmjcur
         where MJ_BI_ID = p_bi_id;
       end;
     else
       v_log_message := 'Unexpected p_set_type value ' || p_set_type || ' in procedure ' || v_procedure_name || '.';
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
      
    v_new_data T_INS_MJ_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null; 
    
    v_dimjlub_id  number    := null;
    v_fimjbd_id number := null;
    
       
    begin
      
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Jobs in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_INS_MJ_XML(p_new_data_xml,v_new_data);
    
        v_identifier := v_new_data.JOB_ID ;
        v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        
      select BI_ID 
	     into v_bi_id
	    from BPM_INSTANCE
	    where 
	      IDENTIFIER = to_char(v_identifier)
	      and BEM_ID = v_bem_id
        and BSL_ID = v_bsl_id;
        
   --  v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);   
   --  v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS) ;  
        
     GET_DMJLUB_ID (v_identifier,v_bi_id ,v_new_data.last_update_by_name ,v_dimjlub_id );    
   

 -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
 
 
SET_DMJCUR
  ('INSERT',v_identifier,v_bi_id
      ,v_new_data.JOB_ID
      ,v_new_data.CREATE_DT
      ,v_new_data.CREATED_BY
      ,v_new_data.JOB_NAME
      ,v_new_data.JOB_DETAIL
      ,v_new_data.JOB_GROUP
      ,v_new_data.JOB_TYPE
      ,v_new_data.JOB_START_DT
      ,v_new_data.JOB_END_DT
      ,v_new_data.JOB_STATUS
      ,v_new_data.FILE_NAME
      ,v_new_data.RECEIPT_DT
      ,v_new_data.TRANSMIT_DT
      ,v_new_data.FILE_TYPE
      ,v_new_data.FILE_SOURCE
      ,v_new_data.FILE_DESTINATION
      ,v_new_data.PLAN_NAME
      ,v_new_data.RESPONSE_FILE_REQ
      ,v_new_data.RECORD_COUNT
      ,v_new_data.RECORD_ERROR_COUNT
      ,v_new_data.RESPONSE_FILE_NAME
      ,v_new_data.LAST_UPDATE_BY_NAME
      ,v_new_data.LAST_UPDATE_BY_DT
      ,v_new_data.ASSD_IDENTIFY_JOB
      ,v_new_data.ASED_IDENTIFY_JOB
      ,v_new_data.ASSD_PROCESS_JOB
      ,v_new_data.ASED_PROCESS_JOB
      ,v_new_data.ASSD_CREATE_RESPONSE_FILE
      ,v_new_data.ASED_CREATE_RESPONSE_FILE
      ,v_new_data.ASSD_CREATE_OUTBOUND_FILE
      ,v_new_data.ASED_CREATE_OUTBOUND_FILE
      ,v_new_data.ASF_IDENTIFY_JOB
      ,v_new_data.ASF_PROCESS_JOB
      ,v_new_data.ASF_CREATE_RESPONSE_FILE
      ,v_new_data.ASF_CREATE_OUTBOUND_FILE
      ,v_new_data.GWF_PROCESSED_OK
      ,v_new_data.GWF_JOB_TYPE
      ,v_new_data.GWF_RESPONSE_FILE
      ,v_new_data.COMPLETE_DT
      ,v_new_data.INSTANCE_STATUS
      ,v_new_data.CANCEL_DT
      ,v_new_data.CANCEL_BY
      ,v_new_data.CANCEL_REASON
      ,v_new_data.CANCEL_METHOD

      
      
);
  
  
  
   INS_FIMBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_dimjlub_id, v_new_data.LAST_UPDATE_BY_DT, v_fimjbd_id);
        
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





-- Update fact for BPM Semantic model - Manage Jobs process. 
    procedure UPD_FMJBD
      (p_identifier in varchar2,  
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dimjlub_id in number,
       p_last_update_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fimjbd_id out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FMJBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fimjbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
   -- v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
   -- v_incident_status_dt date := null;
    v_last_update_date date := null;
    v_event_date date := null;  
    
    v_dimjlub_id   number    := null;
    v_fimjbd_id	 number    := null;
     
    
    r_fmjbd F_MJ_BY_DATE%rowtype := null;
  begin 
  
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
    --  v_incident_status_dt := to_date(p_incident_status_dt,BPM_COMMON.DATE_FMT);
      v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      
     v_dimjlub_id :=  p_dimjlub_id ;   
     v_fimjbd_id  :=  p_fimjbd_id;
     
     with most_recent_fact_bi_id as
           (select 
              max(FIMJBD_ID) max_fimjbd_id,
              max(D_DATE) max_d_date
            from F_MJ_BY_DATE
            where MJ_BI_ID = p_bi_id) 
         select 
           fimjbd.FIMJBD_ID,
           fimjbd.D_DATE,
           fimjbd.CREATION_COUNT,
           fimjbd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into 
           v_fimjbd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from 
           F_MJ_BY_DATE fimjbd,
           most_recent_fact_bi_id 
         where
           fimjbd.FIMJBD_ID = max_fimjbd_id
      and fimjbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case were update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    
   if p_end_date is null then
      r_fmjbd.D_DATE := v_event_date;
      r_fmjbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmjbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmjbd.INVENTORY_COUNT := 1;
      r_fmjbd.COMPLETION_COUNT := 0;
    else 
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
          
            delete from F_MJ_BY_DATE
            where 
              MJ_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
              
            with most_recent_fact_bi_id as
              (select 
                max(FIMJBD_ID) max_fimjbd_id,
                max(D_DATE) max_d_date
               from F_MJ_BY_DATE
               where MJ_BI_ID = p_bi_id) 
           select 
	             fimjbd.FIMJBD_ID,
	             fimjbd.D_DATE,
	             fimjbd.CREATION_COUNT,
	             fimjbd.COMPLETION_COUNT,
	             most_recent_fact_bi_id.max_d_date,
	             fimjbd.DIMJLUB_ID, 
	             fimjbd.LAST_UPDATE_BY_DATE
	           into 
	             v_fimjbd_id_old,
	             v_d_date_old,
	             v_creation_count_old,
	             v_completion_count_old,
	             v_max_d_date,
	             v_dimjlub_id,
	             v_last_update_date 
	           from 
	             F_MJ_BY_DATE fimjbd,
	             most_recent_fact_bi_id 
	           where
	             fimjbd.FIMJBD_ID = max_fimjbd_id
          and fimjbd.D_DATE = most_recent_fact_bi_id.max_d_date;
          
      end if;
      
      r_fmjbd.D_DATE := p_end_date;
      r_fmjbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmjbd.BUCKET_END_DATE := r_fmjbd.BUCKET_START_DATE;
      r_fmjbd.INVENTORY_COUNT := 0;
      r_fmjbd.COMPLETION_COUNT := 1;
      
    end if;    
    
    p_fimjbd_id := SEQ_FIMJBD_ID.nextval;
    r_fmjbd.FIMJBD_ID := p_fimjbd_id;
    r_fmjbd.MJ_BI_ID := p_bi_id;
    r_fmjbd.DIMJLUB_ID := v_dimjlub_id ;
    r_fmjbd.CREATION_COUNT := 0;
    r_fmjbd.LAST_UPDATE_BY_DATE := v_last_update_date;
 
 -- Validate fact date ranges.
     if r_fmjbd.D_DATE < r_fmjbd.BUCKET_START_DATE
     --  or r_fmjbd.D_DATE > r_fmjbd.BUCKET_END_DATE
       or to_date(to_char(r_fmjbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fmjbd.BUCKET_END_DATE
       or r_fmjbd.BUCKET_START_DATE > r_fmjbd.BUCKET_END_DATE
       or r_fmjbd.BUCKET_END_DATE < r_fmjbd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' || 
         'D_DATE = ' || r_fmjbd.D_DATE || 
         ' BUCKET_START_DATE = ' || to_char(r_fmjbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fmjbd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
     
   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fmjbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fmjbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_MJ_BY_DATE
      set row = r_fmjbd
      where FIMJBD_ID = v_fimjbd_id_old;
        
    else  
    
     -- Different bucket time.
        
          update F_MJ_BY_DATE
          set BUCKET_END_DATE = r_fmjbd.BUCKET_START_DATE
          where FIMJBD_ID = v_fimjbd_id_old;
            
          insert into F_MJ_BY_DATE
          values r_fmjbd;
          
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

    v_old_data T_UPD_MJ_XML := null;
    v_new_data T_UPD_MJ_XML := null;
  begin
   
 if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with Manage Jobs in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if; 

    GET_UPD_MJ_XML(p_old_data_xml,v_old_data);
    GET_UPD_MJ_XML(p_new_data_xml,v_new_data);
    
   v_identifier := v_new_data.JOB_ID ;
   v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT); 
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
 /*
 select 'BPM_EVENT.UPDATE_BIA(v_bi_id,' ||b.ba_id || ','||bl.bdl_id || ','||''''||b.retain_history_flag||''''||',v_old_data.'|| stg.staging_table_column ||
        ',v_new_data.'|| stg.staging_table_column ||
      ','||'v_bue_id,v_stg_last_update_date);'
    from bpm_attribute b, bpm_attribute_lkup bl,bpm_attribute_staging_table stg
    where b.bal_id = bl.bal_id
    and stg.ba_id = b.ba_id
    and b.when_populated in ('UPDATE','BOTH')
    and b.bem_id = 11
    and bsl_id = 11
    order by b.ba_id;  
 */   
  BPM_EVENT.UPDATE_BIA(v_bi_id,1485,2,'N',v_old_data.JOB_NAME,v_new_data.JOB_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1486,2,'N',v_old_data.JOB_DETAIL,v_new_data.JOB_DETAIL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1487,2,'N',v_old_data.JOB_GROUP,v_new_data.JOB_GROUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1488,2,'N',v_old_data.JOB_TYPE,v_new_data.JOB_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1489,3,'N',v_old_data.JOB_START_DT,v_new_data.JOB_START_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1490,3,'N',v_old_data.JOB_END_DT,v_new_data.JOB_END_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1491,2,'N',v_old_data.JOB_STATUS,v_new_data.JOB_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1492,2,'N',v_old_data.FILE_NAME,v_new_data.FILE_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1493,3,'N',v_old_data.RECEIPT_DT,v_new_data.RECEIPT_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1494,3,'N',v_old_data.TRANSMIT_DT,v_new_data.TRANSMIT_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1495,2,'N',v_old_data.FILE_TYPE,v_new_data.FILE_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1496,2,'N',v_old_data.FILE_SOURCE,v_new_data.FILE_SOURCE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1497,2,'N',v_old_data.FILE_DESTINATION,v_new_data.FILE_DESTINATION,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1498,2,'N',v_old_data.PLAN_NAME,v_new_data.PLAN_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1499,2,'N',v_old_data.RESPONSE_FILE_REQ,v_new_data.RESPONSE_FILE_REQ,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1500,1,'N',v_old_data.RECORD_COUNT,v_new_data.RECORD_COUNT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1501,1,'N',v_old_data.RECORD_ERROR_COUNT,v_new_data.RECORD_ERROR_COUNT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1502,2,'N',v_old_data.RESPONSE_FILE_NAME,v_new_data.RESPONSE_FILE_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1503,2,'Y',v_old_data.LAST_UPDATE_BY_NAME,v_new_data.LAST_UPDATE_BY_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1504,3,'Y',v_old_data.LAST_UPDATE_BY_DT,v_new_data.LAST_UPDATE_BY_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1506,3,'N',v_old_data.ASED_IDENTIFY_JOB,v_new_data.ASED_IDENTIFY_JOB,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1507,3,'N',v_old_data.ASSD_PROCESS_JOB,v_new_data.ASSD_PROCESS_JOB,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1508,3,'N',v_old_data.ASED_PROCESS_JOB,v_new_data.ASED_PROCESS_JOB,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1509,3,'N',v_old_data.ASSD_CREATE_RESPONSE_FILE,v_new_data.ASSD_CREATE_RESPONSE_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1510,3,'N',v_old_data.ASED_CREATE_RESPONSE_FILE,v_new_data.ASED_CREATE_RESPONSE_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1511,3,'N',v_old_data.ASSD_CREATE_OUTBOUND_FILE,v_new_data.ASSD_CREATE_OUTBOUND_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1512,3,'N',v_old_data.ASED_CREATE_OUTBOUND_FILE,v_new_data.ASED_CREATE_OUTBOUND_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1513,3,'N',v_old_data.COMPLETE_DT,v_new_data.COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1514,2,'N',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1515,3,'N',v_old_data.CANCEL_DT,v_new_data.CANCEL_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1516,2,'N',v_old_data.ASF_IDENTIFY_JOB,v_new_data.ASF_IDENTIFY_JOB,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1517,2,'N',v_old_data.ASF_PROCESS_JOB,v_new_data.ASF_PROCESS_JOB,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1518,2,'N',v_old_data.ASF_CREATE_RESPONSE_FILE,v_new_data.ASF_CREATE_RESPONSE_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1519,2,'N',v_old_data.ASF_CREATE_OUTBOUND_FILE,v_new_data.ASF_CREATE_OUTBOUND_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1520,2,'N',v_old_data.GWF_PROCESSED_OK,v_new_data.GWF_PROCESSED_OK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1521,2,'N',v_old_data.GWF_JOB_TYPE,v_new_data.GWF_JOB_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1522,2,'N',v_old_data.GWF_RESPONSE_FILE,v_new_data.GWF_RESPONSE_FILE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1523,2,'N',v_old_data.CANCEL_REASON,v_new_data.CANCEL_REASON,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1693,2,'N',v_old_data.CANCEL_BY,v_new_data.CANCEL_BY,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1694,2,'N',v_old_data.CANCEL_METHOD,v_new_data.CANCEL_METHOD,v_bue_id,v_stg_last_update_date);
  
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
        
      v_old_data T_UPD_MJ_XML := null;
      v_new_data T_UPD_MJ_XML := null;
      
      v_bi_id number := null;
      v_identifier varchar2(35) := null;
        
      v_start_date date := null;
      v_end_date date := null;
      
      v_dimjlub_id    number    := null;
      v_fimjbd_id	 number    := null;
   
    
    begin
       
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Jobs in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_UPD_MJ_XML(p_old_data_xml,v_old_data);
        GET_UPD_MJ_XML(p_new_data_xml,v_new_data);
        
    v_identifier := v_new_data.JOB_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);    
    
    select BI_ID into v_bi_id
        from BPM_INSTANCE
        where
          IDENTIFIER = v_identifier
          and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
      
    
    GET_DMJLUB_ID (v_identifier,v_bi_id ,v_new_data.last_update_by_name ,v_dimjlub_id );
        
         
   -- Update current dimension and fact as a single transaction.
    begin
             
      commit;   
 
  SET_DMJCUR
        ('UPDATE',v_identifier,v_bi_id,
        v_new_data.JOB_ID ,v_new_data.CREATE_DT ,v_new_data.CREATED_BY ,v_new_data.JOB_NAME ,v_new_data.JOB_DETAIL ,v_new_data.JOB_GROUP ,v_new_data.JOB_TYPE ,v_new_data.JOB_START_DT ,v_new_data.JOB_END_DT ,v_new_data.JOB_STATUS ,v_new_data.FILE_NAME ,v_new_data.RECEIPT_DT ,v_new_data.TRANSMIT_DT ,v_new_data.FILE_TYPE ,v_new_data.FILE_SOURCE ,v_new_data.FILE_DESTINATION ,v_new_data.PLAN_NAME ,v_new_data.RESPONSE_FILE_REQ ,v_new_data.RECORD_COUNT ,v_new_data.RECORD_ERROR_COUNT ,v_new_data.RESPONSE_FILE_NAME ,v_new_data.LAST_UPDATE_BY_NAME ,v_new_data.LAST_UPDATE_BY_DT ,v_new_data.ASSD_IDENTIFY_JOB ,v_new_data.ASED_IDENTIFY_JOB ,v_new_data.ASSD_PROCESS_JOB ,v_new_data.ASED_PROCESS_JOB ,v_new_data.ASSD_CREATE_RESPONSE_FILE ,v_new_data.ASED_CREATE_RESPONSE_FILE ,v_new_data.ASSD_CREATE_OUTBOUND_FILE ,v_new_data.ASED_CREATE_OUTBOUND_FILE ,v_new_data.ASF_IDENTIFY_JOB ,v_new_data.ASF_PROCESS_JOB ,v_new_data.ASF_CREATE_RESPONSE_FILE ,v_new_data.ASF_CREATE_OUTBOUND_FILE ,v_new_data.GWF_PROCESSED_OK ,
        v_new_data.GWF_JOB_TYPE ,v_new_data.GWF_RESPONSE_FILE ,v_new_data.COMPLETE_DT ,v_new_data.INSTANCE_STATUS ,v_new_data.CANCEL_DT,v_new_data.CANCEL_BY,v_new_data.CANCEL_REASON,v_new_data.CANCEL_METHOD   
        );   
 
 
  UPD_FMJBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_dimjlub_id, v_new_data.LAST_UPDATE_BY_DT, v_new_data.stg_last_update_date, v_fimjbd_id);
    	
 
      
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