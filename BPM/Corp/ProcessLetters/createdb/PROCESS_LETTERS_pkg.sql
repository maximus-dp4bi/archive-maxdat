alter session set plsql_code_type = native;

create or replace 
package PROCESS_LETTERS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DPLCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;

  function GET_SLA_CATEGORY
    (p_letter_type in varchar2,
     p_newborn_flag in varchar2)
    return varchar2 result_cache parallel_enable;
	
    FUNCTION GET_JEOPARDY_DAYS(
      p_letter_type in varchar2,
      p_newborn_flag in varchar2
       )
    RETURN number result_cache parallel_enable;

    FUNCTION GET_SLA_TARGET_DAYS(
      p_letter_type in varchar2,
      p_newborn_flag in varchar2
      )
    RETURN VARCHAR2 result_cache parallel_enable;

  FUNCTION GET_SLA_DAYS(
     p_letter_type in varchar2,
     p_newborn_flag in varchar2
      )
    RETURN VARCHAR2 result_cache parallel_enable;

  FUNCTION GET_SLA_DAYS_TYPE(
      p_letter_type in varchar2,
      p_newborn_flag in varchar2
      )
    RETURN VARCHAR2 result_cache parallel_enable;
    
   FUNCTION GET_TIMELINESS_STATUS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2,
      p_create_date   IN DATE,
      p_complete_date IN DATE )
    RETURN VARCHAR2 parallel_enable;

  FUNCTION GET_JEOPARDY_STATUS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2,
      p_create_date   IN DATE,
      p_complete_date IN DATE )
    RETURN VARCHAR2 parallel_enable;


   FUNCTION GET_JEOPARDY_DATE(
      p_letter_type in varchar2,
      p_newborn_flag in varchar2,
      p_create_date    IN DATE
      )
    RETURN date parallel_enable;


  /* 
  Include: 
    CEPN_ID    
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
  type T_INS_PL_XML is record 
    (
     AIAN_MEMBER_COUNT   number(18,0),     
	 ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_PROCESS_LETTER_REQ varchar2(19),
     ASED_RECEIVE_CONFIRMATION varchar2(19),
     ASED_TRANSMIT varchar2(19),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_PROCESS_LETTER_REQ varchar2(1),
     ASF_RECEIVE_CONFIRMATION varchar2(1),
     ASF_TRANSMIT varchar2(1),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_PROCESS_LETTER_REQ varchar2(19),
     ASSD_RECEIVE_CONFIRMATION varchar2(19),
     ASSD_TRANSMIT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CASE_ID varchar2(100),
     CEPN_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(64),
     CREATE_BY varchar2(50),
     CREATE_DT varchar2(19),
     ERROR_REASON varchar2(4000),
     FAMILY_MEMBER_COUNT number(18,0),
	 GWF_OUTCOME varchar2(1),
     GWF_VALID varchar2(1),
     GWF_WORK_REQUIRED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(32),
     LAST_UPDATE_BY_NAME varchar2(50),
     LAST_UPDATE_DT varchar2(19),
     LETTER_REQUEST_ID varchar2(100),
     LETTER_RESP_FILE_DT varchar2(19),
     LETTER_RESP_FILE_NAME varchar2(100),
     LETTER_TYPE varchar2(4000),
     MAILED_DT varchar2(19),
     MATERIAL_REQUEST_ID number(18,0),
	 NEWBORN_FLAG varchar2(1),
     PRINT_DT varchar2(19),
     PROGRAM varchar2(50),
     REJECT_REASON varchar2(100),
     REPRINT varchar2(1),
     REQUEST_DRIVER_TABLE varchar2(32),
     REQUEST_DRIVER_TYPE varchar2(10),
     REQUEST_DT varchar2(19),
     RETURN_DT varchar2(19),
     RETURN_REASON varchar2(100),
     SENT_DT varchar2(19),
     STATUS varchar2(256),
     STATUS_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TASK_ID varchar2(100),
     TRANSMIT_FILE_DT varchar2(19),
     TRANSMIT_FILE_NAME varchar2(100),
     ZIP_CODE varchar2(100)     
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
  type T_UPD_PL_XML is record
    (
     AIAN_MEMBER_COUNT   number(18,0),
	 ASED_CREATE_ROUTE_WORK varchar2(19),
     ASED_PROCESS_LETTER_REQ varchar2(19),
     ASED_RECEIVE_CONFIRMATION varchar2(19),
     ASED_TRANSMIT varchar2(19),
     ASF_CREATE_ROUTE_WORK varchar2(1),
     ASF_PROCESS_LETTER_REQ varchar2(1),
     ASF_RECEIVE_CONFIRMATION varchar2(1),
     ASF_TRANSMIT varchar2(1),
     ASSD_CREATE_ROUTE_WORK varchar2(19),
     ASSD_PROCESS_LETTER_REQ varchar2(19),
     ASSD_RECEIVE_CONFIRMATION varchar2(19),
     ASSD_TRANSMIT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CASE_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(64),
     CREATE_BY varchar2(50),
     CREATE_DT varchar2(19),
     ERROR_REASON varchar2(4000),
     FAMILY_MEMBER_COUNT number(18,0),
	 GWF_OUTCOME varchar2(1),
     GWF_VALID varchar2(1),
     GWF_WORK_REQUIRED varchar2(1),
     INSTANCE_STATUS varchar2(10),
     LANGUAGE varchar2(32),
     LAST_UPDATE_BY_NAME varchar2(50),
     LAST_UPDATE_DT varchar2(19),
     LETTER_REQUEST_ID varchar2(100),
     LETTER_RESP_FILE_DT varchar2(19),
     LETTER_RESP_FILE_NAME varchar2(100),
     LETTER_TYPE varchar2(4000),
     MAILED_DT varchar2(19),
     MATERIAL_REQUEST_ID number(18,0),
	 NEWBORN_FLAG varchar2(1),
     PRINT_DT varchar2(19),
     PROGRAM varchar2(50),
     REJECT_REASON varchar2(100),
     REPRINT varchar2(1),
     REQUEST_DRIVER_TABLE varchar2(32),
     REQUEST_DRIVER_TYPE varchar2(10),
     REQUEST_DT varchar2(19),
     RETURN_DT varchar2(19),
     RETURN_REASON varchar2(100),
     SENT_DT varchar2(19),
     STATUS varchar2(256),
     STATUS_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TASK_ID varchar2(100),
     TRANSMIT_FILE_DT varchar2(19),
     TRANSMIT_FILE_NAME varchar2(100),
     ZIP_CODE varchar2(100)     
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
package body PROCESS_LETTERS as

  v_bem_id number := 12; -- 'ILEB Process Letters'
  v_bil_id number := 12; -- 'Letter Request ID'
  v_bsl_id number := 12; -- 'CORP_ETL_PROC_LETTERS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dplcur_job_name varchar2(30) := 'CALC_DPLCUR';
  
  
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
  
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
  
function GET_SLA_CATEGORY
    (p_letter_type in varchar2,
     p_newborn_flag in varchar2)
    return varchar2 result_cache parallel_enable
  IS
    v_sla_category varchar(4000) := null;
  
  begin
 
  SELECT /*+ RESULT_CACHE +*/ out_var
  INTO v_sla_category
  FROM corp_etl_list_lkup
  WHERE 1=1
  AND list_type = 'PL_CORP_SEMANTIC_PKG'
  AND value = p_letter_type
  AND NAME = coalesce(p_newborn_flag,'N');
  
  RETURN v_sla_category;
  
  EXCEPTION
  WHEN no_data_found THEN 
  
  SELECT out_var
  INTO v_sla_category
  FROM corp_etl_list_lkup
  WHERE 1=1
  AND list_type = 'PL_CORP_SEMANTIC_PKG'
  AND value = 'N'
  AND name = 'N';
  
  RETURN v_sla_category;
  
  end GET_SLA_CATEGORY;  
  
 FUNCTION GET_JEOPARDY_DAYS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2
     )
    RETURN number result_cache parallel_enable
  IS

  v_sla_category  varchar2(4000):= null;
  v_jeopardy_days number;
  BEGIN

     v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
     BEGIN
     
       SELECT /*+ RESULT_CACHE +*/ to_number(OUT_VAR) as jeopardy_days
       into v_jeopardy_days
       FROM CORP_ETL_LIST_LKUP
        WHERE REF_TYPE = 'LETTER_TYPE'
        AND NAME = 'ProcLetters_SLA_Jeopardy_Days'
        AND VALUE = v_sla_category;
        
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_jeopardy_days := 1;
     END;
     
     RETURN v_jeopardy_days;
   END GET_JEOPARDY_DAYS;
 

  FUNCTION GET_SLA_TARGET_DAYS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2
      )
    RETURN VARCHAR2 result_cache parallel_enable
  IS

  v_sla_category  varchar2(4000):= null;
  v_sla_target_days number;
  BEGIN

     v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
    BEGIN   
    
     SELECT /*+ RESULT_CACHE +*/ TO_NUMBER(OUT_VAR) as sla_target_days
       into v_sla_target_days
       FROM CORP_ETL_LIST_LKUP
      WHERE REF_TYPE = 'LETTER_TYPE'
        AND NAME = 'ProcLetters_SLA_Target_Days'
        AND VALUE = v_sla_category;
        
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
          v_sla_target_days := 2;
     END;
     
     RETURN v_sla_target_days;
       
  END;

 FUNCTION GET_SLA_DAYS(
       p_letter_type   IN VARCHAR2,
       p_newborn_flag  IN VARCHAR2
      )
    RETURN VARCHAR2 result_cache parallel_enable
  IS
  v_sla_category varchar2(4000):= null;
  v_sla_days     number:= null;

  BEGIN

      v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
     BEGIN
     
      SELECT /*+ RESULT_CACHE +*/ TO_NUMBER(OUT_VAR) as sla_days
       into v_sla_days
       FROM CORP_ETL_LIST_LKUP
       WHERE REF_TYPE = 'LETTER_TYPE'
        AND NAME = 'ProcLetters_SLA_Days'
        AND VALUE = v_sla_category;
        
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days := 2;
       END;
    
    RETURN v_sla_days;

  END GET_SLA_DAYS;


 FUNCTION GET_SLA_DAYS_TYPE(
       p_letter_type   IN VARCHAR2,
       p_newborn_flag  IN VARCHAR2
      )
    RETURN VARCHAR2 result_cache parallel_enable
  IS

  v_sla_category  varchar2(4000):= null;
  v_sla_days_type varchar2(10):= null;
  BEGIN

      v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
     BEGIN
     
       SELECT /*+ RESULT_CACHE +*/ OUT_VAR as sla_days_type
       into v_sla_days_type
       FROM CORP_ETL_LIST_LKUP
       WHERE REF_TYPE = 'LETTER_TYPE'
       AND NAME = 'ProcLetters_SLA_Days_Type'
       AND VALUE = v_sla_category;
       
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         v_sla_days_type := 'B';
     END;
     
     RETURN v_sla_days_type;

  END GET_SLA_DAYS_TYPE;

   FUNCTION GET_JEOPARDY_STATUS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2,
      p_create_date   IN DATE,
      p_complete_date IN DATE)
    RETURN VARCHAR2 parallel_enable
  IS

  v_sla_category  varchar2(4000):= null;
  v_jeopardy_days number:= null;
  v_sla_days_type VARCHAR2(10);
  BEGIN

     v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);

     v_jeopardy_days := GET_JEOPARDY_DAYS(p_letter_type,p_newborn_flag);      
     v_sla_days_type := GET_SLA_DAYS_TYPE(p_letter_type,p_newborn_flag); 
    
    IF p_complete_date is null THEN
     IF v_sla_days_type = 'B' THEN
       IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,sysdate) > v_jeopardy_days  THEN
         RETURN 'Y';
       ELSE
         RETURN 'N';
       END IF;
     ELSE
       IF TRUNC(sysdate) - p_create_date > v_jeopardy_days THEN
         RETURN 'Y';
       ELSE
         RETURN 'N';
       END IF;
     END IF;
    ELSE
       RETURN 'N';
    END IF;

  END GET_JEOPARDY_STATUS;


 FUNCTION GET_JEOPARDY_DATE(
       p_letter_type   IN VARCHAR2,
       p_newborn_flag  IN VARCHAR2,
       p_create_date   IN DATE
      )
    RETURN date parallel_enable
  IS
  v_sla_category  varchar2(4000):= null;
  v_sla_days_type varchar2(10):= null;
  v_jeopardy_days number;
  BEGIN

     v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
     v_jeopardy_days := GET_JEOPARDY_DAYS(p_letter_type,p_newborn_flag);
     
     
     RETURN p_create_date + v_jeopardy_days;

  END GET_JEOPARDY_DATE;
  

FUNCTION GET_TIMELINESS_STATUS(
      p_letter_type   IN VARCHAR2,
      p_newborn_flag  IN VARCHAR2,
      p_create_date   IN DATE,
      p_complete_date IN DATE )
    RETURN VARCHAR2 parallel_enable
  IS
  v_sla_category varchar2(4000):= null;
  v_sla_days     number:= null;
  v_sla_days_type VARCHAR2(10);
  BEGIN
     
     v_sla_category := GET_SLA_CATEGORY(p_letter_type,p_newborn_flag);
     
     v_sla_days := GET_SLA_DAYS(p_letter_type,p_newborn_flag);
     v_sla_days_type := GET_SLA_DAYS_TYPE(p_letter_type,p_newborn_flag);

    IF v_sla_category = 'Other' THEN
      RETURN 'NA';
    ELSE
      IF p_complete_date is null then
        return 'In Process';    
      ELSE 
        IF v_sla_days_type = 'B' THEN
          IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,COALESCE(p_complete_date,sysdate)) <= v_sla_days THEN
            RETURN 'Timely';
          ELSE
            RETURN 'Untimely';
          END IF;
        ELSE
          IF COALESCE(p_complete_date,sysdate) - p_create_date <= v_sla_days THEN
            RETURN 'Timely';
          ELSE
            RETURN 'Untimely';
          END IF;
        END IF;      
      END IF;
   END IF;
    
  END GET_TIMELINESS_STATUS;


  -- Calculate column values in BPM Semantic table D_PL_CURRENT.
  procedure CALC_DPLCUR
  as
    v_procedure_name   varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DPLCUR';
    v_log_message      clob := null;
    v_sql_code         number := null;
    v_num_rows_updated number := null;
  begin

    update D_PL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE),
      JEOPARDY_STATUS = GET_JEOPARDY_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE),
      SLA_CATEGORY = GET_SLA_CATEGORY(LETTER_TYPE,NEWBORN_FLAG),
      SLA_DAYS = GET_SLA_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_DAYS_TYPE = GET_SLA_DAYS_TYPE(LETTER_TYPE,NEWBORN_FLAG),
      SLA_JEOPARDY_DATE = GET_JEOPARDY_DATE(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE),
      SLA_JEOPARDY_DAYS = GET_JEOPARDY_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_TARGET_DAYS =GET_SLA_TARGET_DAYS(LETTER_TYPE,NEWBORN_FLAG)
    where
      COMPLETE_DATE is null
      and CANCEL_DATE is null;

    v_num_rows_updated := sql%rowcount;

    commit;

    v_log_message := v_num_rows_updated  || ' D_PL_CURRENT rows updated with calculated attributes by CALC_DPLCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;

  -- Get dimension ID for BPM Semantic model - Process Letters process - Letter_status.
  procedure GET_DPLLS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_letter_status in varchar2,
      p_dplls_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPLLS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPLLS_ID
     into p_dplls_id
     from D_PL_LETTER_STATUS
     where 
       LETTER_STATUS = p_letter_status 
       or (LETTER_STATUS is null and p_letter_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dplls_id := SEQ_DPLLS_ID.nextval;
       begin
         insert into D_PL_LETTER_STATUS (DPLLS_ID,LETTER_STATUS)
         values (p_dplls_id,p_letter_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPLLS_ID into p_dplls_id
           from D_PL_LETTER_STATUS
           where 
             LETTER_STATUS = p_letter_status 
       or (LETTER_STATUS is null and p_letter_status is null);
             
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
    
  
  -- Get record for Process Letters insert XML.
  procedure GET_INS_PL_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select
	  extractvalue(p_data_xml,'/ROWSET/ROW/AIAN_MEMBER_COUNT') "AIAN_MEMBER_COUNT", 
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_LETTER_REQ') "ASED_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_CONFIRMATION') "ASED_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT') "ASED_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_LETTER_REQ') "ASF_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_CONFIRMATION') "ASF_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT') "ASF_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_LETTER_REQ') "ASSD_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_CONFIRMATION') "ASSD_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT') "ASSD_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPN_ID') "CEPA_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY') "CREATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_REASON') "ERROR_REASON",
	  EXTRACTVALUE(P_DATA_XML,'/ROWSET/ROW/FAMILY_MEMBER_COUNT') "FAMILY_MEMBER_COUNT" ,
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTCOME') "GWF_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_VALID') "GWF_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_REQUIRED') "GWF_WORK_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQUEST_ID') "LETTER_REQUEST_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_RESP_FILE_DT') "LETTER_RESP_FILE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_RESP_FILE_NAME') "LETTER_RESP_FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_TYPE') "LETTER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/MAILED_DT') "MAILED_DT",
	  extractvalue(p_data_xml,'/ROWSET/ROW/MATERIAL_REQUEST_ID') "MATERIAL_REQUEST_ID" ,
      extractValue(p_data_xml,'/ROWSET/ROW/NEWBORN_FLAG') "NEWBORN_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PRINT_DT') "PRINT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM') "PROGRAM",
      extractValue(p_data_xml,'/ROWSET/ROW/REJECT_REASON') "REJECT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/REPRINT') "REPRINT",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DRIVER_TABLE') "REQUEST_DRIVER_TABLE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DRIVER_TYPE') "REQUEST_DRIVER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DT') "REQUEST_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURN_DT') "RETURN_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURN_REASON') "RETURN_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/SENT_DT') "SENT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS') "STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DT') "STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSMIT_FILE_DT') "TRANSMIT_FILE_DT",
      EXTRACTVALUE(P_DATA_XML,'/ROWSET/ROW/TRANSMIT_FILE_NAME') "TRANSMIT_FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ZIP_CODE') "ZIP_CODE"
    into p_data_record
    from dual;
  
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise; 
      
  end;
    
    
  -- Get record for Process Letters update XML. 
  procedure GET_UPD_PL_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_PL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
  
    select
	  extractvalue(p_data_xml,'/ROWSET/ROW/AIAN_MEMBER_COUNT') "AIAN_MEMBER_COUNT",   
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_ROUTE_WORK') "ASED_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_LETTER_REQ') "ASED_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_CONFIRMATION') "ASED_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT') "ASED_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_ROUTE_WORK') "ASF_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_LETTER_REQ') "ASF_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_CONFIRMATION') "ASF_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT') "ASF_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_ROUTE_WORK') "ASSD_CREATE_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_LETTER_REQ') "ASSD_PROCESS_LETTER_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_CONFIRMATION') "ASSD_RECEIVE_CONFIRMATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT') "ASSD_TRANSMIT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY') "CREATE_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_REASON') "ERROR_REASON",
	  extractvalue(p_data_xml,'/ROWSET/ROW/FAMILY_MEMBER_COUNT') "FAMILY_MEMBER_COUNT" ,
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTCOME') "GWF_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_VALID') "GWF_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_REQUIRED') "GWF_WORK_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DT') "LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQUEST_ID') "LETTER_REQUEST_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_RESP_FILE_DT') "LETTER_RESP_FILE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_RESP_FILE_NAME') "LETTER_RESP_FILE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_TYPE') "LETTER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/MAILED_DT') "MAILED_DT",
	  extractvalue(p_data_xml,'/ROWSET/ROW/MATERIAL_REQUEST_ID') "MATERIAL_REQUEST_ID" ,
      extractValue(p_data_xml,'/ROWSET/ROW/NEWBORN_FLAG') "NEWBORN_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PRINT_DT') "PRINT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM') "PROGRAM",
      extractValue(p_data_xml,'/ROWSET/ROW/REJECT_REASON') "REJECT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/REPRINT') "REPRINT",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DRIVER_TABLE') "REQUEST_DRIVER_TABLE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DRIVER_TYPE') "REQUEST_DRIVER_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DT') "REQUEST_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURN_DT') "RETURN_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURN_REASON') "RETURN_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/SENT_DT') "SENT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS') "STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DT') "STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSMIT_FILE_DT') "TRANSMIT_FILE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/TRANSMIT_FILE_NAME') "TRANSMIT_FILE_NAME",
      EXTRACTVALUE(P_DATA_XML,'/ROWSET/ROW/ZIP_CODE') "ZIP_CODE"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;
  
  
  -- Insert fact for BPM Semantic model - Process Letter process. 
    procedure INS_FPLBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dplls_id in number,
       p_letter_status_date varchar2,
       --p_stg_last_update_date in varchar2,
       p_fplbd_id out number) 
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPLBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      --v_stg_last_update_date date := null;
      v_letter_status_date date := null;
    begin
    
      --v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_letter_status_date := to_date(p_letter_status_date,BPM_COMMON.DATE_FMT);
      p_fplbd_id := SEQ_FPLBD_ID.nextval;
      
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
      
      insert into F_PL_BY_DATE
        (FPLBD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         PL_BI_ID,
         DPLLS_ID,
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT,
         LETTER_STATUS_DATE)
      values
        (p_fplbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dplls_id,
         1,
         case 
         when p_end_date is null then 1
         else 0
         end,
         case 
           when p_end_date is null then 0
           else 1
           end,
         v_letter_status_date
        );
        
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
   -- Insert or update dimension for BPM Semantic model - Process Letters process - Current.
  procedure SET_DPLCUR
    (p_set_type in varchar2,
     p_identifier  in varchar2,
     p_bi_id in number,
     p_letter_request_id	in number,
     p_create_date in varchar2,
     p_created_by	in varchar2,
     p_request_date in varchar2,
     p_instance_status	in varchar2,
     p_letter_type	in varchar2,
     p_program	in varchar2,
     p_case_id	   in number,
     p_county_code	in varchar2,
     p_zip_code	in number,
     p_language	in varchar2,
     p_reprint	in varchar2,
     p_request_driver_type	in varchar2,
     p_request_driver_table	in varchar2,
     p_letter_status	in varchar2,
     p_letter_status_date	in varchar2,
     p_sent_date in varchar2,
     p_print_date in varchar2,
     p_mailed_date in varchar2,
     p_return_date in varchar2,
     p_return_reason	in varchar2,
     p_rejection_reason	in varchar2,
     p_request_error_reason	in varchar2,
     p_transmitted_file_name	in varchar2,
     p_transmitted_file_date	in varchar2,
     p_letter_response_file_name	in varchar2,
     p_letter_response_file_date	in varchar2,
     p_last_update_date	in varchar2,
     p_last_updated_by_name	in varchar2,
     p_newborn_flag	in varchar2,
     p_task_id	in number,
     p_cancel_date	in varchar2,
     p_cancel_by	in varchar2,
     p_complete_date	in varchar2,
     p_proc_ltr_request_start_date	in varchar2,
     p_process_ltr_request_end_date	in varchar2,
     p_send_mail_house_start_date	in varchar2,
     p_send_to_mail_house_end_date	in varchar2,
     p_receive_confirm_start_date	in varchar2,
     p_receive_confirm_end_date	in varchar2,
     p_create_route_work_start_date	in varchar2,
     p_create_route_work_end_date	in varchar2,
     p_validation_flag	in varchar2,
     p_outcome_flag	in varchar2,
     p_work_required_flag	in varchar2,
     p_process_letters_flag	in varchar2,
     p_transmit_flag	in varchar2,
     P_CONFIRMATION_FLAG	in varchar2,
     p_create_route_work_flag	in varchar2,
     p_material_request_id in number ,
     P_FAMILY_MEMBER_COUNT in number ,
     p_aian_member_count  in number
    )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPLCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dplcur D_PL_CURRENT%rowtype := null;
    --v_jeopardy_flag varchar2(1) := null; 
  begin
    
    r_dplcur.PL_BI_ID := p_bi_id;
    r_dplcur.LETTER_REQUEST_ID := p_letter_request_id;
r_dplcur.CREATE_DATE  :=  to_date(p_create_date,BPM_COMMON.DATE_FMT);
r_dplcur.CREATED_BY :=  p_created_by;
r_dplcur.REQUEST_DATE  :=  to_date(p_request_date,BPM_COMMON.DATE_FMT);
r_dplcur.INSTANCE_STATUS := p_instance_status;
r_dplcur.LETTER_TYPE := p_letter_type;
r_dplcur.PROGRAM := p_program;
r_dplcur.CASE_ID  := p_case_id;
r_dplcur.COUNTY_CODE := p_county_code;
r_dplcur.ZIP_CODE := p_zip_code;
r_dplcur.LANGUAGE := p_language;
r_dplcur.REPRINT := p_reprint;
r_dplcur.REQUEST_DRIVER_TYPE := p_request_driver_type;
r_dplcur.REQUEST_DRIVER_TABLE := p_request_driver_table;
r_dplcur.LETTER_STATUS := p_letter_status;
r_dplcur.LETTER_STATUS_DATE  :=  to_date(p_letter_status_date,BPM_COMMON.DATE_FMT);
r_dplcur.SENT_DATE  :=  to_date(p_sent_date,BPM_COMMON.DATE_FMT);
r_dplcur.PRINT_DATE  :=  to_date(p_print_date,BPM_COMMON.DATE_FMT);
r_dplcur.MAILED_DATE  :=  to_date(p_mailed_date,BPM_COMMON.DATE_FMT);
r_dplcur.RETURN_DATE  :=  to_date(p_return_date,BPM_COMMON.DATE_FMT);
r_dplcur.RETURN_REASON := p_return_reason;
r_dplcur.REJECTION_REASON := p_rejection_reason;
r_dplcur.REQUEST_ERROR_REASON := p_request_error_reason;
r_dplcur.TRANSMITTED_FILE_NAME := p_transmitted_file_name;
r_dplcur.TRANSMITTED_FILE_DATE  :=  to_date(p_transmitted_file_date,BPM_COMMON.DATE_FMT);
r_dplcur.LETTER_RESPONSE_FILE_NAME := p_letter_response_file_name;
r_dplcur.LETTER_RESPONSE_FILE_DATE  :=  to_date(p_letter_response_file_date,BPM_COMMON.DATE_FMT);
r_dplcur.LAST_UPDATE_DATE  :=  to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
r_dplcur.LAST_UPDATED_BY_NAME := p_last_updated_by_name;
r_dplcur.NEWBORN_FLAG := p_newborn_flag;
r_dplcur.TASK_ID := p_task_id;
r_dplcur.CANCEL_DATE  :=  to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
r_dplcur.CANCEL_BY := p_cancel_by;
r_dplcur.COMPLETE_DATE  :=  to_date(p_complete_date,BPM_COMMON.DATE_FMT);
r_dplcur.PROCESS_LTR_REQUEST_START_DATE  :=  to_date(p_proc_ltr_request_start_date,BPM_COMMON.DATE_FMT);
r_dplcur.PROCESS_LTR_REQUEST_END_DATE  :=  to_date(p_process_ltr_request_end_date,BPM_COMMON.DATE_FMT);
r_dplcur.SEND_TO_MAIL_HOUSE_START_DATE  :=  to_date(p_send_mail_house_start_date,BPM_COMMON.DATE_FMT);
r_dplcur.SEND_TO_MAIL_HOUSE_END_DATE  :=  to_date(p_send_to_mail_house_end_date,BPM_COMMON.DATE_FMT);
r_dplcur.RECEIVE_CONFIRM_START_DATE  :=  to_date(p_receive_confirm_start_date,BPM_COMMON.DATE_FMT);
r_dplcur.RECEIVE_CONFIRM_END_DATE  :=  to_date(p_receive_confirm_end_date,BPM_COMMON.DATE_FMT);
r_dplcur.CREATE_ROUTE_WORK_START_DATE  :=  to_date(p_create_route_work_start_date,BPM_COMMON.DATE_FMT);
r_dplcur.CREATE_ROUTE_WORK_END_DATE  :=  to_date(p_create_route_work_end_date,BPM_COMMON.DATE_FMT);
r_dplcur.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_dplcur.CREATE_DATE,r_dplcur.COMPLETE_DATE);
r_dplcur.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_dplcur.CREATE_DATE,r_dplcur.COMPLETE_DATE);
r_dplcur.TIMELINESS_STATUS := GET_TIMELINESS_STATUS(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG,r_dplcur.CREATE_DATE,r_dplcur.COMPLETE_DATE);
r_dplcur.JEOPARDY_STATUS := GET_JEOPARDY_STATUS(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG,r_dplcur.CREATE_DATE,r_dplcur.COMPLETE_DATE);
r_dplcur.SLA_CATEGORY :=GET_SLA_CATEGORY(r_dplcur.LETTER_TYPE, r_dplcur.NEWBORN_FLAG);
r_dplcur.SLA_DAYS := GET_SLA_DAYS(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG);
r_dplcur.SLA_DAYS_TYPE := GET_SLA_DAYS_TYPE(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG);
r_dplcur.SLA_JEOPARDY_DATE  :=  GET_JEOPARDY_DATE(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG,r_dplcur.CREATE_DATE);
r_dplcur.SLA_JEOPARDY_DAYS := GET_JEOPARDY_DAYS(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG);
r_dplcur.SLA_TARGET_DAYS := GET_SLA_TARGET_DAYS(r_dplcur.LETTER_TYPE,r_dplcur.NEWBORN_FLAG);
r_dplcur.VALIDATION_FLAG := p_validation_flag;
r_dplcur.OUTCOME_FLAG := p_outcome_flag;
r_dplcur.WORK_REQUIRED_FLAG := p_work_required_flag;
r_dplcur.PROCESS_LETTERS_FLAG := p_process_letters_flag;
r_dplcur.TRANSMIT_FLAG := p_transmit_flag;
r_dplcur.CONFIRMATION_FLAG := p_confirmation_flag;
r_dplcur.CREATE_ROUTE_WORK_FLAG := p_create_route_work_flag;
r_dplcur.MATERIAL_REQUEST_ID := p_material_request_id;
R_DPLCUR.FAMILY_MEMBER_COUNT := P_FAMILY_MEMBER_COUNT;
r_dplcur.AIAN_MEMBER_COUNT := p_aian_member_count ;
      
    if p_set_type = 'INSERT' then
      insert into D_PL_CURRENT
      values r_dplcur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_PL_CURRENT
        set row = r_dplcur
        where PL_BI_ID = p_bi_id;
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
      
    v_new_data T_INS_PL_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dplls_id number := null;  
    v_fplbd_id number := null;   
  begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for  Process Letters in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_PL_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.LETTER_REQUEST_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;

    GET_DPLLS_ID(v_identifier,v_bi_id,v_new_data.STATUS,v_dplls_id);
       
    -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
         
      SET_DPLCUR
        ('INSERT',v_identifier,v_bi_id,
         v_new_data.LETTER_REQUEST_ID,
         v_new_data.CREATE_DT,
         v_new_data.CREATE_BY,
         v_new_data.REQUEST_DT,
         v_new_data.INSTANCE_STATUS,
         v_new_data.LETTER_TYPE,
         v_new_data.PROGRAM,
         v_new_data.CASE_ID,
         v_new_data.COUNTY_CODE,
         v_new_data.ZIP_CODE,
         v_new_data.LANGUAGE,
         v_new_data.REPRINT,
         v_new_data.REQUEST_DRIVER_TYPE,
         v_new_data.REQUEST_DRIVER_TABLE,
         v_new_data.STATUS,
         v_new_data.STATUS_DT,
         v_new_data.SENT_DT,
         v_new_data.PRINT_DT,
         v_new_data.MAILED_DT,
         v_new_data.RETURN_DT,
         v_new_data.RETURN_REASON,
         v_new_data.REJECT_REASON,
         v_new_data.ERROR_REASON,
         v_new_data.TRANSMIT_FILE_NAME,
         v_new_data.TRANSMIT_FILE_DT,
         v_new_data.LETTER_RESP_FILE_NAME,
         v_new_data.LETTER_RESP_FILE_DT,
         v_new_data.LAST_UPDATE_DT,
         v_new_data.LAST_UPDATE_BY_NAME,
         v_new_data.NEWBORN_FLAG,
         v_new_data.TASK_ID,
         v_new_data.CANCEL_DT,
         v_new_data.CANCEL_BY,
         v_new_data.COMPLETE_DT,
         v_new_data.ASSD_PROCESS_LETTER_REQ,
         v_new_data.ASED_PROCESS_LETTER_REQ,
         v_new_data.ASSD_TRANSMIT,
         v_new_data.ASED_TRANSMIT,
         v_new_data.ASSD_RECEIVE_CONFIRMATION,
         v_new_data.ASED_RECEIVE_CONFIRMATION,
         v_new_data.ASSD_CREATE_ROUTE_WORK,
         v_new_data.ASED_CREATE_ROUTE_WORK,
         v_new_data.GWF_VALID,
         v_new_data.GWF_OUTCOME,
         v_new_data.GWF_WORK_REQUIRED,
         v_new_data.ASF_PROCESS_LETTER_REQ,
         v_new_data.ASF_TRANSMIT,
         v_new_data.ASF_RECEIVE_CONFIRMATION,
         V_NEW_DATA.ASF_CREATE_ROUTE_WORK,
         V_NEW_DATA.MATERIAL_REQUEST_ID, 
         v_new_data.FAMILY_MEMBER_COUNT ,
         v_new_data.AIAN_MEMBER_COUNT    
         
        ); 
        
      INS_FPLBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dplls_id,v_new_data.STATUS_DT,v_fplbd_id);
      
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
  
   
  -- Update fact for BPM Semantic model -  Process Letters process. 
  procedure UPD_FPLBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dplls_id in number,
     p_letter_status_date varchar2,
     p_stg_last_update_date in varchar2,
     p_fplbd_id out number) 
     
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPLBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fplbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_letter_status_date date := null;
    v_event_date date := null;
    
    v_dplls_id number := null;
    v_fplbd_id number := null;

    r_fplbd F_PL_BY_DATE%rowtype := null;
  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_letter_status_date := to_date(p_letter_status_date,BPM_COMMON.DATE_FMT);
    
    v_dplls_id := p_dplls_id;
    v_fplbd_id := p_fplbd_id;
    with most_recent_fact_bi_id as
      (select 
         max(FPLBD_ID) max_fplbd_id,
         max(D_DATE) max_d_date
       from F_PL_BY_DATE
       where PL_BI_ID = p_bi_id) 
    select 
      fplbd.FPLBD_ID,
      fplbd.D_DATE,
      fplbd.CREATION_COUNT,
      fplbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fplbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_PL_BY_DATE fplbd,
      most_recent_fact_bi_id 
    where
      fplbd.FPLBD_ID = max_fplbd_id
      and fplbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
      
    if p_end_date is null then
      r_fplbd.D_DATE := v_event_date;
      r_fplbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fplbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fplbd.INVENTORY_COUNT := 1;
      r_fplbd.COMPLETION_COUNT := 0;
    else
      
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_PL_BY_DATE
        where 
          PL_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        with most_recent_fact_bi_id as
          (select 
             max(FPLBD_ID) max_fplbd_id,
             max(D_DATE) max_d_date
           from F_PL_BY_DATE
           where PL_BI_ID = p_bi_id) 
        select 
          fplbd.FPLBD_ID,
          fplbd.D_DATE,
          fplbd.CREATION_COUNT,
          fplbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fplbd.DPLLS_ID,
          fplbd.LETTER_STATUS_DATE
        into 
          v_fplbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dplls_id,
          v_letter_status_date 
        from 
          F_PL_BY_DATE fplbd,
          most_recent_fact_bi_id 
        where
          fplbd.FPLBD_ID = max_fplbd_id
          and fplbd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
      r_fplbd.D_DATE := p_end_date;
      r_fplbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fplbd.BUCKET_END_DATE := r_fplbd.BUCKET_START_DATE;
      r_fplbd.INVENTORY_COUNT := 0;
      r_fplbd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fplbd_id := SEQ_FPLBD_ID.nextval;
    r_fplbd.FPLBD_ID := p_fplbd_id;
    r_fplbd.PL_BI_ID := p_bi_id;
    r_fplbd.DPLLS_ID := v_dplls_id;
    r_fplbd.CREATION_COUNT := 0;
    r_fplbd.LETTER_STATUS_DATE := v_letter_status_date;
    
    -- Validate fact date ranges.
    if r_fplbd.D_DATE < r_fplbd.BUCKET_START_DATE
      or to_date(to_char(r_fplbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fplbd.BUCKET_END_DATE
      or r_fplbd.BUCKET_START_DATE > r_fplbd.BUCKET_END_DATE
      or r_fplbd.BUCKET_END_DATE < r_fplbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fplbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fplbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fplbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fplbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fplbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_PL_BY_DATE
      set row = r_fplbd
      where FPLBD_ID = v_fplbd_id_old;
        
    else
    
      -- Different bucket time.
    
      update F_PL_BY_DATE
      set BUCKET_END_DATE = r_fplbd.BUCKET_START_DATE
      where FPLBD_ID = v_fplbd_id_old;
        
      insert into F_PL_BY_DATE
      values r_fplbd;
      
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
      
    v_old_data T_UPD_PL_XML := null;
    v_new_data T_UPD_PL_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_dplls_id number := null;
    
    v_fplbd_id number := null;
      
   
      
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Letters in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_PL_XML(p_old_data_xml,v_old_data);
    GET_UPD_PL_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.LETTER_REQUEST_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select PL_BI_ID 
    into v_bi_id
    from D_PL_CURRENT
    where LETTER_REQUEST_ID = v_identifier;

    GET_DPLLS_ID(v_identifier,v_bi_id,v_new_data.STATUS,v_dplls_id);
      
    -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
         
      SET_DPLCUR
        ('UPDATE',v_identifier,v_bi_id,
        v_new_data.LETTER_REQUEST_ID,
         v_new_data.CREATE_DT,
         v_new_data.CREATE_BY,
         v_new_data.REQUEST_DT,
         v_new_data.INSTANCE_STATUS,
         v_new_data.LETTER_TYPE,
         v_new_data.PROGRAM,
         v_new_data.CASE_ID,
         v_new_data.COUNTY_CODE,
         v_new_data.ZIP_CODE,
         v_new_data.LANGUAGE,
         v_new_data.REPRINT,
         v_new_data.REQUEST_DRIVER_TYPE,
         v_new_data.REQUEST_DRIVER_TABLE,
         v_new_data.STATUS,
         v_new_data.STATUS_DT,
         v_new_data.SENT_DT,
         v_new_data.PRINT_DT,
         v_new_data.MAILED_DT,
         v_new_data.RETURN_DT,
         v_new_data.RETURN_REASON,
         v_new_data.REJECT_REASON,
         v_new_data.ERROR_REASON,
         v_new_data.TRANSMIT_FILE_NAME,
         v_new_data.TRANSMIT_FILE_DT,
         v_new_data.LETTER_RESP_FILE_NAME,
         v_new_data.LETTER_RESP_FILE_DT,
         v_new_data.LAST_UPDATE_DT,
         v_new_data.LAST_UPDATE_BY_NAME,
         v_new_data.NEWBORN_FLAG,
         v_new_data.TASK_ID,
         v_new_data.CANCEL_DT,
         v_new_data.CANCEL_BY,
         v_new_data.COMPLETE_DT,
         v_new_data.ASSD_PROCESS_LETTER_REQ,
         v_new_data.ASED_PROCESS_LETTER_REQ,
         v_new_data.ASSD_TRANSMIT,
         v_new_data.ASED_TRANSMIT,
         v_new_data.ASSD_RECEIVE_CONFIRMATION,
         v_new_data.ASED_RECEIVE_CONFIRMATION,
         v_new_data.ASSD_CREATE_ROUTE_WORK,
         v_new_data.ASED_CREATE_ROUTE_WORK,
         v_new_data.GWF_VALID,
         v_new_data.GWF_OUTCOME,
         v_new_data.GWF_WORK_REQUIRED,
         v_new_data.ASF_PROCESS_LETTER_REQ,
         v_new_data.ASF_TRANSMIT,
         v_new_data.ASF_RECEIVE_CONFIRMATION,
         v_new_data.ASF_CREATE_ROUTE_WORK,
         V_NEW_DATA.MATERIAL_REQUEST_ID, 
         V_NEW_DATA.FAMILY_MEMBER_COUNT ,
         v_new_data.AIAN_MEMBER_COUNT 
        );
        
      UPD_FPLBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_dplls_id,v_new_data.STATUS_DT,v_new_data.stg_last_update_date, v_fplbd_id);
      
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