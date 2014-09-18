alter session set plsql_code_type = native;

create or replace package PROCESS_ONLINE_INFO as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

procedure CALC_DONLCUR;

gv_sla_days number:=null;
gv_sla_days_type varchar2(10):=null;
gv_sla_target_days number:=null;
gv_jeopardy_days number:=null;
gv_jeopardy_days_type varchar2(10):=null;
gv_jeopardy_target_days number:=null;

  
FUNCTION GET_AGE_IN_BUSINESS_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER;
  
FUNCTION GET_AGE_IN_CALENDAR_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER; 

FUNCTION GET_POI_TIMELINESS_STAT(
    p_transaction_type in varchar2,
    p_instance_status in varchar2,
    p_create_date   IN DATE,
    p_complete_date IN DATE 
 )
  RETURN VARCHAR2;  
  
FUNCTION GET_POI_SLA_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN number; 

FUNCTION GET_POI_SLA_DAYS_TYPE(
    p_transaction_type IN VARCHAR2)
  RETURN VARCHAR2; 
  
FUNCTION GET_POI_SLA_TARGET_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER;  
  
FUNCTION GET_POI_JEOPARDY_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER;
  
FUNCTION GET_POI_JEOPARDY_DAYS_TYPE(
    p_transaction_type IN VARCHAR2)
  RETURN VARCHAR2;
  
FUNCTION GET_POI_JEOPARDY_TARGET_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER;

 /* 
  Include: 
    CEPOI_ID    
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
  type T_INS_ONL_XML is record 
    (
     ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_PROCESS_NEW_INFO varchar2(19),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_PROCESS_NEW_INFO varchar2(1),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_PROCESS_NEW_INFO varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(50),
     CASE_ID varchar2(100),
     CEPOI_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_BY varchar2(80),
     CREATE_DT varchar2(19),
     GWF_WORK_IDENTIFIED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(2),
     LAST_UPDATED_BY varchar2(80),
     LAST_UPDATED_DT varchar2(19),
     SOURCE_RECORD_ID varchar2(100),
     SOURCE_RECORD_TYPE varchar2(50),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRANSACTION_ID varchar2(100),
     TRANSACTION_TYPE varchar2(50),
     WORK_REQUIRED_FLAG varchar2(1)
    );
      
 /* 
  Include:     
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
  type T_UPD_ONL_XML is record
    (
    ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_PROCESS_NEW_INFO varchar2(19),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_PROCESS_NEW_INFO varchar2(1),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_PROCESS_NEW_INFO varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(50),
     CASE_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_BY varchar2(80),
     CREATE_DT varchar2(19),
     GWF_WORK_IDENTIFIED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(2),
     LAST_UPDATED_BY varchar2(80),
     LAST_UPDATED_DT varchar2(19),
     SOURCE_RECORD_ID varchar2(100),
     SOURCE_RECORD_TYPE varchar2(50),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRANSACTION_ID varchar2(100),
     TRANSACTION_TYPE varchar2(50),
     WORK_REQUIRED_FLAG varchar2(1)
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

create or replace package body PROCESS_ONLINE_INFO as

  v_bem_id number := 19; -- 'PROCESS ONLINE INFO'
  v_bil_id number := 19; -- 'TRANSACTION_ID'
  v_bsl_id number := 19; -- 'CORP_ETL_PROCESS_ONLINE_INFO'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_donlcur_job_name varchar2(30) := 'CALC_DONLCUR';


FUNCTION GET_AGE_IN_BUSINESS_DAYS(
    p_create_date   IN DATE, 
    p_complete_date IN DATE)
  RETURN NUMBER
AS
BEGIN
  RETURN BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,NVL(p_complete_date,sysdate));
END GET_AGE_IN_BUSINESS_DAYS;


FUNCTION GET_AGE_IN_CALENDAR_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER
AS
BEGIN
  RETURN TRUNC(NVL(p_complete_date,sysdate)) - TRUNC(p_create_date);
END GET_AGE_IN_CALENDAR_DAYS;


FUNCTION GET_POI_TIMELINESS_STAT(
    p_transaction_type in varchar2,
    p_instance_status in varchar2,
    p_create_date   IN DATE,
    p_complete_date IN DATE 
 )
  RETURN VARCHAR2
IS
BEGIN
IF p_transaction_type <> 'Demographic Change' AND  p_instance_status = 'Active' THEN
  RETURN 'In Process';
elsif p_transaction_type <> 'Demographic Change' AND p_instance_status = 'Complete' AND BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,NVL(p_complete_date,sysdate)) > 1 THEN
  RETURN 'Untimely';
elsif p_transaction_type <> 'Demographic Change' AND p_instance_status = 'Complete' AND BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,NVL(p_complete_date,sysdate)) <= 1 THEN
  RETURN 'Timely';
elsif p_transaction_type = 'Demographic Change' THEN
  RETURN 'NA';
END IF;
END GET_POI_TIMELINESS_STAT;


FUNCTION GET_POI_SLA_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER
IS
BEGIN
  SELECT out_var
  INTO gv_sla_days
  FROM corp_etl_list_lkup
  WHERE name ='POI_SLA_Days'
  AND value  = p_transaction_type;
  RETURN gv_sla_days;
END GET_POI_SLA_DAYS;
  

FUNCTION GET_POI_SLA_DAYS_TYPE(
    p_transaction_type IN VARCHAR2)
  RETURN VARCHAR2
IS
BEGIN
  SELECT out_var
  INTO gv_sla_days_type
  FROM corp_etl_list_lkup 
  WHERE value = p_transaction_type
  AND name    ='POI_SLA_Days_Type';
  RETURN gv_sla_days_type;
END GET_POI_SLA_DAYS_TYPE;


FUNCTION GET_POI_SLA_TARGET_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER
IS
BEGIN
  SELECT out_var
  INTO gv_sla_target_days
  FROM corp_etl_list_lkup 
  WHERE value = p_transaction_type
  AND name ='POI_SLA_Target_Days';
  RETURN gv_sla_target_days;
END GET_POI_SLA_TARGET_DAYS;


FUNCTION GET_POI_JEOPARDY_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER
IS
BEGIN
  SELECT out_var
  INTO gv_jeopardy_days
  FROM corp_etl_list_lkup 
  WHERE value = p_transaction_type
  AND name ='POI_Jeopardy_Days';
  RETURN gv_jeopardy_days;
END GET_POI_JEOPARDY_DAYS;
  
  
FUNCTION GET_POI_JEOPARDY_DAYS_TYPE(
    p_transaction_type IN VARCHAR2)
  RETURN VARCHAR2
IS
BEGIN
  SELECT out_var
  INTO gv_jeopardy_days_type
  FROM corp_etl_list_lkup 
  WHERE value = p_transaction_type
  AND name ='POI_Jeopardy_Days_Type';
  RETURN gv_jeopardy_days_type;
END GET_POI_JEOPARDY_DAYS_TYPE;
  
  
FUNCTION GET_POI_JEOPARDY_TARGET_DAYS(
    p_transaction_type IN VARCHAR2)
  RETURN NUMBER
IS
BEGIN
  SELECT out_var
  INTO gv_jeopardy_target_days
  FROM corp_etl_list_lkup
  WHERE value = p_transaction_type
  AND name ='POI_Jeopardy_Target_Days';
  RETURN gv_jeopardy_target_days;
END GET_POI_JEOPARDY_TARGET_DAYS; 



-- Calculate column values in BPM Semantic table D_ONL_CURRENT.
  procedure CALC_DONLCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DONLCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
update D_ONL_CURRENT
    set  
      AGE_IN_BUSINESS_DAYS= GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_STATUS = GET_POI_TIMELINESS_STAT(TRANSACTION_TYPE,CUR_INSTANCE_STATUS,CREATE_DATE,COMPLETE_DATE),
      SLA_DAYS = GET_POI_SLA_DAYS(TRANSACTION_TYPE),
      SLA_DAYS_TYPE = GET_POI_SLA_DAYS_TYPE(TRANSACTION_TYPE),
      SLA_TARGET_DAYS = GET_POI_SLA_TARGET_DAYS(TRANSACTION_TYPE),
      JEOPARDY_DAYS  = GET_POI_JEOPARDY_DAYS(TRANSACTION_TYPE),
      JEOPARDY_DAYS_TYPE  = GET_POI_JEOPARDY_DAYS_TYPE(TRANSACTION_TYPE),
      JEOPARDY_TARGET_DAYS  = GET_POI_JEOPARDY_TARGET_DAYS(TRANSACTION_TYPE)
    
    where 
      COMPLETE_DATE is null 
      and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
 
 commit;

     v_log_message := v_num_rows_updated  || ' D_ONL_CURRENT rows updated with calculated attributes by D_ONL_CURRENT.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;
 

 
-- Get dimension ID for BPM Semantic model - Process Online Info - Instance_Status.
  procedure GET_DONLIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_instance_status  in varchar2,
      p_donlis_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DONLIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

   SELECT DONLIS_ID
    INTO p_donlis_id
    FROM D_ONL_INSTANCE_STATUS
    WHERE 
          instance_status  = p_instance_status
           OR (instance_status   IS NULL AND p_instance_status IS NULL);
      
   exception
     when NO_DATA_FOUND then
       p_donlis_id := SEQ_DONLIS_ID.nextval;
       begin
         insert into D_ONL_INSTANCE_STATUS (DONLIS_ID,instance_status)
         values (p_donlis_id,p_instance_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DONLIS_ID into p_donlis_id
           from D_ONL_INSTANCE_STATUS
           where 
              instance_status  = p_instance_status
             OR (instance_status   IS NULL AND p_instance_status IS NULL);
             
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
 
-- Get record for Process Online Info insert XML.
  procedure GET_INS_ONL_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_ONL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_ONL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_NEW_INFO') "ASED_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_NEW_INFO') "ASF_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_NEW_INFO') "ASSD_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPOI_ID') "CEPOI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY') "CREATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATED_BY') "LAST_UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATED_DT') "LAST_UPDATED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_RECORD_ID') "SOURCE_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_RECORD_TYPE') "SOURCE_RECORD_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSACTION_ID') "TRANSACTION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSACTION_TYPE') "TRANSACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_REQUIRED_FLAG') "WORK_REQUIRED_FLAG"
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
  
 -- Get record for Process Online Info update XML. 
  procedure GET_UPD_ONL_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_ONL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_ONL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
 
     select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_NEW_INFO') "ASED_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_NEW_INFO') "ASF_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_NEW_INFO') "ASSD_PROCESS_NEW_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY') "CREATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATED_BY') "LAST_UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATED_DT') "LAST_UPDATED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_RECORD_ID') "SOURCE_RECORD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_RECORD_TYPE') "SOURCE_RECORD_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSACTION_ID') "TRANSACTION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSACTION_TYPE') "TRANSACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_REQUIRED_FLAG') "WORK_REQUIRED_FLAG"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  

-- Insert fact for BPM Semantic model - Process Onlin Info. 
    procedure INS_FONLBD 
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_donlis_id in number,  
     p_last_update_date in varchar2,
    -- p_stg_last_update_date in varchar2,   
     p_fonlbd_id out number) 
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FONLBD';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
       --  v_stg_last_update_date date := null;
         v_last_update_date date:=null;
    begin
     -- v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_last_update_date:=to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      p_fonlbd_id := SEQ_FONLBD_ID.nextval;
      
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
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
              RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
  insert into F_ONL_BY_DATE
    (FONLBD_ID, 
     D_DATE, 
     BUCKET_START_DATE, 
     BUCKET_END_DATE, 
     ONL_BI_ID, 
     DONLIS_ID, 
     LAST_UPDATE_BY_DATE, 
     INVENTORY_COUNT, 
     CREATION_COUNT, 
     COMPLETION_COUNT )
	values
	(p_fonlbd_id,
	  p_start_date,
	  to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt),
	  v_bucket_end_date,
	  p_bi_id,
	  p_donlis_id,
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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
 
 -- Insert or update dimension for BPM Semantic model - Process Online Info - Current.
  procedure SET_DONLCUR  
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
  p_transaction_id	in number,
  p_transaction_type	in varchar ,
  p_create_date	in varchar ,
  p_create_by_name	in varchar ,
  p_case_id	in number,
  p_client_id	in number,
  p_work_required_flag	in varchar ,
  p_cur_instance_status	in varchar ,
  p_source_record_type	in varchar ,
  p_source_record_id	in number,
  p_last_update_date	in varchar ,
  p_last_updated_by_name	in varchar ,
  p_language	in varchar ,
  p_process_new_info_start_date	in varchar ,
  p_process_new_info_end_date	in varchar ,
  p_process_new_info_flag	in varchar ,
  p_create_route_work_start_date	in varchar ,
  p_create_route_work_end_date	in varchar ,
  p_create_route_work_flag	in varchar ,
  p_work_identified_flag	in varchar ,
  p_cancel_reason	in varchar ,
  p_cancel_method	in varchar ,
  p_cancel_by	in varchar ,
  p_cancel_date	in varchar ,
  p_complete_date	in varchar 
--p_age_in_business_days	in number,
--p_age_in_calendar_days	in number,
--p_timeliness_status	in varchar ,
--p_jeopardy_status	in varchar ,
--p_sla_days	in number,
--p_sla_days_type	in varchar ,
--p_sla_target_days	in number,
--p_jeopardy_days	in number,
--p_jeopardy_days_type	in varchar ,
--p_jeopardy_target_days	in number,
--p_jeopardy_date	in varchar 

   ) 
   
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DONLCUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_donlcur D_ONL_CURRENT%rowtype := null;
    --   v_jeopardy_flag varchar2(1) := null; 
  begin
  
r_donlcur.ONL_BI_ID := p_bi_id;  
r_donlcur.transaction_id := p_transaction_id;
r_donlcur.transaction_type := p_transaction_type;
r_donlcur.create_date	:= to_date(p_create_date,BPM_COMMON.DATE_FMT);
r_donlcur.create_by_name	:= p_create_by_name;
r_donlcur.case_id	:= p_case_id;
r_donlcur.client_id	:= p_client_id;
r_donlcur.work_required_flag	:= p_work_required_flag;
r_donlcur.cur_instance_status	:= p_cur_instance_status;
r_donlcur.source_record_type	:= p_source_record_type;
r_donlcur.source_record_id	:= p_source_record_id;
r_donlcur.last_update_date	:= to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
r_donlcur.last_updated_by_name	:= p_last_updated_by_name;
r_donlcur.language	:= p_language;
r_donlcur.process_new_info_start_date	:= to_date(p_process_new_info_start_date,BPM_COMMON.DATE_FMT);
r_donlcur.process_new_info_end_date	:= to_date(p_process_new_info_end_date,BPM_COMMON.DATE_FMT);
r_donlcur.process_new_info_flag	:= p_process_new_info_flag;
r_donlcur.create_route_work_start_date	:= to_date(p_create_route_work_start_date,BPM_COMMON.DATE_FMT);
r_donlcur.create_route_work_end_date	:= to_date(p_create_route_work_end_date,BPM_COMMON.DATE_FMT);
r_donlcur.create_route_work_flag	:= p_create_route_work_flag;
r_donlcur.work_identified_flag	:= p_work_identified_flag;
r_donlcur.cancel_reason	:= p_cancel_reason;
r_donlcur.cancel_method	:= p_cancel_method;
r_donlcur.cancel_by	:= p_cancel_by;
r_donlcur.cancel_date	:= to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
r_donlcur.complete_date	:= to_date(p_complete_date,BPM_COMMON.DATE_FMT);
r_donlcur.age_in_business_days	:= GET_AGE_IN_BUSINESS_DAYS(r_donlcur.CREATE_DATE,r_donlcur.COMPLETE_DATE);
r_donlcur.age_in_calendar_days	:= GET_AGE_IN_CALENDAR_DAYS(r_donlcur.CREATE_DATE,r_donlcur.COMPLETE_DATE);
r_donlcur.timeliness_status    	:= GET_POI_TIMELINESS_STAT(r_donlcur.TRANSACTION_TYPE,r_donlcur.CUR_INSTANCE_STATUS,r_donlcur.CREATE_DATE,r_donlcur.COMPLETE_DATE);
r_donlcur.SLA_Days              := GET_POI_SLA_DAYS (r_donlcur.TRANSACTION_TYPE);
r_donlcur.SLA_Days_Type         := GET_POI_SLA_DAYS_TYPE (r_donlcur.TRANSACTION_TYPE);
r_donlcur.SLA_Target_Days       := GET_POI_SLA_TARGET_DAYS (r_donlcur.TRANSACTION_TYPE);
r_donlcur.Jeopardy_Days         := GET_POI_JEOPARDY_DAYS (r_donlcur.TRANSACTION_TYPE);
r_donlcur.Jeopardy_Days_Type    := GET_POI_JEOPARDY_DAYS_TYPE (r_donlcur.TRANSACTION_TYPE);
r_donlcur.Jeopardy_Target_Days  := GET_POI_JEOPARDY_TARGET_DAYS (r_donlcur.TRANSACTION_TYPE);

 
  if p_set_type = 'INSERT' then
       insert into D_ONL_CURRENT
       values r_donlcur;
     elsif p_set_type = 'UPDATE' then
       begin
         update D_ONL_CURRENT
         set row = r_donlcur
         where ONL_BI_ID = p_bi_id;
       end;
     else
       v_log_message := 'Unexpected p_set_type value ' || p_set_type || ' in procedure ' || v_procedure_name || '.';
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
      
    v_new_data T_INS_ONL_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null; 
    
    v_donlis_id  number    := null;
    v_fonlbd_id number := null;
    
       
    begin
      
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Online Info in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_INS_ONL_XML(p_new_data_xml,v_new_data);
    
        v_identifier := v_new_data.TRANSACTION_ID;
        v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_bi_id := SEQ_BI_ID.nextval;
        
   --  v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);   
   --  v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS) ;  
        
     GET_DONLIS_ID (v_identifier,v_bi_id ,v_new_data.instance_status ,v_donlis_id );    
  
 -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
 
 
SET_DONLCUR
  ('INSERT',v_identifier,v_bi_id
,v_new_data.TRANSACTION_ID
,v_new_data.TRANSACTION_TYPE
,v_new_data.CREATE_DT
,v_new_data.CREATE_BY
,v_new_data.CLIENT_ID
,v_new_data.CASE_ID
,v_new_data.WORK_REQUIRED_FLAG
,v_new_data.INSTANCE_STATUS
,v_new_data.SOURCE_RECORD_TYPE
,v_new_data.SOURCE_RECORD_ID
,v_new_data.LAST_UPDATED_DT
,v_new_data.LAST_UPDATED_BY
,v_new_data.LANGUAGE
,v_new_data.ASSD_PROCESS_NEW_INFO
,v_new_data.ASED_PROCESS_NEW_INFO
,v_new_data.ASF_PROCESS_NEW_INFO
,v_new_data.ASSD_CREATE_ROUTE_WORK
,v_new_data.ASED_CREATE_ROUTE_WORK
,v_new_data.ASF_CREATE_ROUTE_WORK
,v_new_data.GWF_WORK_IDENTIFIED
,v_new_data.CANCEL_REASON
,v_new_data.CANCEL_METHOD
,v_new_data.CANCEL_BY
,v_new_data.CANCEL_DT
,v_new_data.COMPLETE_DT
);
  
  
  
   INS_FONLBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_donlis_id, v_new_data.LAST_UPDATED_DT, v_fonlbd_id);
        
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





-- Update fact for BPM Semantic model - Process Online Info. 
    procedure UPD_FONLBD
      (p_identifier in varchar2,  
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_donlis_id in number,
       p_last_update_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fonlbd_id out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FONLBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fonlbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
   -- v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
   -- v_incident_status_dt date := null;
    v_last_update_date date := null;
    v_event_date date := null;  
    
    v_donlis_id   number    := null;
    v_fonlbd_id	 number    := null;
     
    
    r_fonlbd F_ONL_BY_DATE%rowtype := null;
  begin 
  
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
    --  v_incident_status_dt := to_date(p_incident_status_dt,BPM_COMMON.DATE_FMT);
      v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      
     v_donlis_id :=  p_donlis_id;   
     v_fonlbd_id  :=  p_fonlbd_id;
     
     with most_recent_fact_bi_id as
           (select 
              max(FONLBD_ID) max_fonlbd_id,
              max(D_DATE) max_d_date
            from F_ONL_BY_DATE
            where ONL_BI_ID = p_bi_id) 
         select 
           fonlbd.FONLBD_ID,
           fonlbd.D_DATE,
           fonlbd.CREATION_COUNT,
           fonlbd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into 
           v_fonlbd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from 
           F_ONL_BY_DATE fonlbd,
           most_recent_fact_bi_id 
         where
           fonlbd.FONLBD_ID = max_fonlbd_id
      and fonlbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    
   if p_end_date is null then
      r_fonlbd.D_DATE := v_event_date;
      r_fonlbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fonlbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fonlbd.INVENTORY_COUNT := 1;
      r_fonlbd.COMPLETION_COUNT := 0;
    else 
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
          
            delete from F_ONL_BY_DATE
            where 
              ONL_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
              
            with most_recent_fact_bi_id as
              (select 
                max(FONLBD_ID) max_fonlbd_id,
                max(D_DATE) max_d_date
               from F_ONL_BY_DATE
               where ONL_BI_ID = p_bi_id) 
           select 
	             fonlbd.FONLBD_ID,
	             fonlbd.D_DATE,
	             fonlbd.CREATION_COUNT,
	             fonlbd.COMPLETION_COUNT,
	             most_recent_fact_bi_id.max_d_date,
	             fonlbd.DONLIS_ID, 
	             fonlbd.LAST_UPDATE_BY_DATE
	           into 
	             v_fonlbd_id_old,
	             v_d_date_old,
	             v_creation_count_old,
	             v_completion_count_old,
	             v_max_d_date,
	             v_donlis_id,
	             v_last_update_date 
	           from 
	             F_ONL_BY_DATE fonlbd,
	             most_recent_fact_bi_id 
	           where
	             fonlbd.FONLBD_ID = max_fonlbd_id
          and fonlbd.D_DATE = most_recent_fact_bi_id.max_d_date;
          
      end if;
      
      r_fonlbd.D_DATE := p_end_date;
      r_fonlbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fonlbd.BUCKET_END_DATE := r_fonlbd.BUCKET_START_DATE;
      r_fonlbd.INVENTORY_COUNT := 0;
      r_fonlbd.COMPLETION_COUNT := 1;
      
    end if;    
    
    p_fonlbd_id := SEQ_FONLBD_ID.nextval;
    r_fonlbd.FONLBD_ID := p_fonlbd_id;
    r_fonlbd.ONL_BI_ID := p_bi_id;
    r_fonlbd.DONLIS_ID := v_donlis_id ;
    r_fonlbd.CREATION_COUNT := 0;
    r_fonlbd.LAST_UPDATE_BY_DATE := v_last_update_date;
 
 -- Validate fact date ranges.
     if r_fonlbd.D_DATE < r_fonlbd.BUCKET_START_DATE
     --  or r_fmjbd.D_DATE > r_fmjbd.BUCKET_END_DATE
       or to_date(to_char(r_fonlbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fonlbd.BUCKET_END_DATE
       or r_fonlbd.BUCKET_START_DATE > r_fonlbd.BUCKET_END_DATE
       or r_fonlbd.BUCKET_END_DATE < r_fonlbd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' || 
         'D_DATE = ' || r_fonlbd.D_DATE || 
         ' BUCKET_START_DATE = ' || to_char(r_fonlbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fonlbd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
     
   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fonlbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fonlbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_ONL_BY_DATE
      set row = r_fonlbd
      where FONLBD_ID = v_fonlbd_id_old;
        
    else  
    
     -- Different bucket time.
        
          update F_ONL_BY_DATE
          set BUCKET_END_DATE = r_fonlbd.BUCKET_START_DATE
          where FONLBD_ID = v_fonlbd_id_old;
            
          insert into F_ONL_BY_DATE
          values r_fonlbd;
          
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
        
      v_old_data T_UPD_ONL_XML := null;
      v_new_data T_UPD_ONL_XML := null;
      
      v_bi_id number := null;
      v_identifier varchar2(100) := null;
        
      v_start_date date := null;
      v_end_date date := null;
      
      v_donlis_id    number    := null;
      v_fonlbd_id	 number    := null;
   
    
    begin
       
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Online Info in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_UPD_ONL_XML(p_old_data_xml,v_old_data);
        GET_UPD_ONL_XML(p_new_data_xml,v_new_data);
        
    v_identifier := v_new_data.TRANSACTION_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select ONL_BI_ID 
    into v_bi_id
    from D_ONL_CURRENT
    where TRANSACTION_ID = v_identifier;
    
    GET_DONLIS_ID (v_identifier,v_bi_id ,v_new_data.instance_status,v_donlis_id );
            
   -- Update current dimension and fact as a single transaction.
    begin
             
      commit;   
 
  SET_DONLCUR
        ('UPDATE',v_identifier,v_bi_id,
           v_new_data.TRANSACTION_ID ,v_new_data.TRANSACTION_TYPE ,v_new_data.CREATE_DT ,v_new_data.CREATE_BY ,v_new_data.CLIENT_ID ,v_new_data.CASE_ID ,v_new_data.WORK_REQUIRED_FLAG ,v_new_data.INSTANCE_STATUS ,v_new_data.SOURCE_RECORD_TYPE ,v_new_data.SOURCE_RECORD_ID ,v_new_data.LAST_UPDATED_DT ,v_new_data.LAST_UPDATED_BY ,v_new_data.LANGUAGE ,v_new_data.ASSD_PROCESS_NEW_INFO ,v_new_data.ASED_PROCESS_NEW_INFO ,v_new_data.ASF_PROCESS_NEW_INFO ,v_new_data.ASSD_CREATE_ROUTE_WORK ,v_new_data.ASED_CREATE_ROUTE_WORK ,v_new_data.ASF_CREATE_ROUTE_WORK ,v_new_data.GWF_WORK_IDENTIFIED ,v_new_data.CANCEL_REASON ,v_new_data.CANCEL_METHOD ,v_new_data.CANCEL_BY ,v_new_data.CANCEL_DT ,v_new_data.COMPLETE_DT
        );   
 
 
  UPD_FONLBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_donlis_id, v_new_data.COMPLETE_DT, v_new_data.stg_last_update_date, v_fonlbd_id);
    	
 
      
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