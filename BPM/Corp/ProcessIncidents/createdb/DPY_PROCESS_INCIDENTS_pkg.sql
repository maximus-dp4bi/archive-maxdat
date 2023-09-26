alter session set plsql_code_type = native;

create or replace package DPY_PROCESS_INCIDENTS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DPICUR;
  
  
  function GET_AGE_IN_BUSINESS_DAYS
      ( p_receipt_date in date,
        p_complete_date in date
       )
  return number parallel_enable;
  
  function GET_AGE_IN_CALENDAR_DAYS
    (p_receipt_date in date,
     p_complete_date in date
     )
    return number parallel_enable;
    
function GET_STATUS_AGE_IN_BUS_DAYS
      (p_incident_status_dt in date,
       p_instance_status in varchar2
       )
  return number parallel_enable;

function GET_STATUS_AGE_IN_CAL_DAYS
      (p_incident_status_dt in date,
       p_instance_status in varchar2
       )
  return number parallel_enable;

function GET_JEOPARDY_STATUS
    (p_receipt_date in date,  
     p_instance_status in varchar,
     p_priority in varchar2
    )
    return varchar2 parallel_enable;

function GET_JEOPARDY_STATUS_DATE
    (p_receipt_date in date,  
     p_instance_status in varchar,
     p_priority in varchar
    )
    return date parallel_enable;

function GET_TIMELINESS_STATUS
    (p_receipt_date in date, 
     p_instance_status_dt in date,
     p_instance_status in varchar,
     p_cancel_date in date,
     p_priority in varchar
     )
return varchar2 parallel_enable;

  /* 
  Include: 
    CEPI_ID    
    STG_LAST_UPDATE_DATE
  */
type T_INS_PI_XML is record 
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     ASED_IDENTIFY_RSRCH_INCIDENT varchar2(19),
     ASED_NOTIFY_CLIENT varchar2(19),
     ASED_PROCESS_INCIDENT varchar2(19),
     ASED_RESOLVE_CMPLT_INCIDENT varchar2(19),
     ASF_IDENTIFY_RSRCH_INCIDENT varchar2(1),
     ASF_NOTIFY_CLIENT varchar2(1),
     ASF_PROCESS_INCIDENT varchar2(1),
     ASF_RESOLVE_CMPLT_INCIDENT varchar2(1),
     ASSD_IDENTIFY_RSRCH_INCIDENT varchar2(19),
     ASSD_NOTIFY_CLIENT varchar2(19),
     ASSD_PROCESS_INCIDENT varchar2(19),
     ASSD_RESOLVE_CMPLT_INCIDENT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CASE_ID varchar2(100),
     CEPI_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID	NUMBER(18,0),
     CLIENT_NOTICE_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(32),
     COUNTY_NAME varchar2(64),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     EB_FOLLOWUP_NEEDED_IND varchar2(1),
     ENROLLEE_RIN varchar2(30),
     ENROLLMENT_STATUS varchar2(32),
     ESCALATE_DT varchar2(19),
     GENERIC_FIELD1 varchar2(50),
     GENERIC_FIELD2 varchar2(50),
     GENERIC_FIELD3 varchar2(50),
     GENERIC_FIELD4 varchar2(50),
     GENERIC_FIELD5 varchar2(50),
     GWF_ESCALATE_INCIDENT varchar2(1),
     GWF_NOTIFY_CLIENT varchar2(1),
     GWF_RETURN_INCIDENT varchar2(1),
     HEARING_DT varchar2(19),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     ORIGIN_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(80),
     PLAN_CODE varchar2(32),
     PRIORITY varchar2(256),
     PROGRAM_SUBTYPE varchar2(32),
     PROGRAM_TYPE varchar2(32),
     PROVIDER_ID varchar2(100),
     RECEIPT_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(160),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     RETURNED_DT varchar2(19),
     SELECTION_ID varchar2(100),
     STATE_RECD_APPEAL_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32)
     );
    
  /* 
  Include:     
    STG_LAST_UPDATE_DATE
  */

type T_UPD_PI_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     ASED_IDENTIFY_RSRCH_INCIDENT varchar2(19),
     ASED_NOTIFY_CLIENT varchar2(19),
     ASED_PROCESS_INCIDENT varchar2(19),
     ASED_RESOLVE_CMPLT_INCIDENT varchar2(19),
     ASF_IDENTIFY_RSRCH_INCIDENT varchar2(1),
     ASF_NOTIFY_CLIENT varchar2(1),
     ASF_PROCESS_INCIDENT varchar2(1),
     ASF_RESOLVE_CMPLT_INCIDENT varchar2(1),
     ASSD_IDENTIFY_RSRCH_INCIDENT varchar2(19),
     ASSD_NOTIFY_CLIENT varchar2(19),
     ASSD_PROCESS_INCIDENT varchar2(19),
     ASSD_RESOLVE_CMPLT_INCIDENT varchar2(19),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID	NUMBER(18,0),
     CLIENT_NOTICE_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(32),
     COUNTY_NAME varchar2(64),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     EB_FOLLOWUP_NEEDED_IND varchar2(1),
     ENROLLEE_RIN varchar2(30),
     ENROLLMENT_STATUS varchar2(32),
     ESCALATE_DT varchar2(19),
     GENERIC_FIELD1 varchar2(50),
     GENERIC_FIELD2 varchar2(50),
     GENERIC_FIELD3 varchar2(50),
     GENERIC_FIELD4 varchar2(50),
     GENERIC_FIELD5 varchar2(50),
     GWF_ESCALATE_INCIDENT varchar2(1),
     GWF_NOTIFY_CLIENT varchar2(1),
     GWF_RETURN_INCIDENT varchar2(1),
     HEARING_DT varchar2(19),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     ORIGIN_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(80),
     PLAN_CODE varchar2(32),
     PRIORITY varchar2(256),
     PROGRAM_SUBTYPE varchar2(32),
     PROGRAM_TYPE varchar2(32),
     PROVIDER_ID varchar2(100),
     RECEIPT_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(160),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     RETURNED_DT varchar2(19),
     SELECTION_ID varchar2(100),
     STATE_RECD_APPEAL_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32)
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

create or replace package body DPY_PROCESS_INCIDENTS as

  v_bem_id number := 10; -- 'Process Incidents'
  v_bil_id number := 10; -- 'Incident ID'
  v_bsl_id number := 10; -- 'CORP_ETL_PROCESS_INCIDENTS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dpicur_job_name varchar2(30) := 'CALC_DPICUR';
  
function GET_AGE_IN_BUSINESS_DAYS
    (p_receipt_date in date,
     p_complete_date in date
     )
    return number parallel_enable
  as
  begin
  return BPM_COMMON.BUS_DAYS_BETWEEN(p_receipt_date,nvl(p_complete_date,sysdate));
  end;
  
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_receipt_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_receipt_date);
  end;
  
function GET_STATUS_AGE_IN_BUS_DAYS
      (p_incident_status_dt in date,
       p_instance_status in varchar2
       )
  return number parallel_enable
  as
  begin
  if (p_instance_status='Active') then
    return BPM_COMMON.BUS_DAYS_BETWEEN(p_incident_status_dt,sysdate);
  else 
    return 0;
  end if;
 end;

-- 
function GET_STATUS_AGE_IN_CAL_DAYS
      (p_incident_status_dt in date,
       p_instance_status in varchar2
       )
  return number parallel_enable
as
begin
   if (p_instance_status='Active') then
    return trunc(sysdate) - trunc(p_incident_status_dt);
  else
    return 0;
  end if;
  end;
  

FUNCTION GET_JEOPARDY_STATUS(
    p_receipt_date    IN DATE,
    p_instance_status IN VARCHAR,
    p_priority        IN VARCHAR2 )
  RETURN VARCHAR2 parallel_enable
AS

driver varchar2(20) := null;
v_timeliness_calc varchar2(20) := null;
v_jeopardy_days NUMBER;
v_trunc_jeopardy_days NUMBER;
v_jeopardy_threshold NUMBER;
v_jeopardy_status varchar2(20) := null;
BEGIN

  select /*+ RESULT_CACHE +*/ out_var 
  into driver
  from corp_etl_list_lkup
  where name='PI_INCIDENT_SLA_BASIS';

  --added 3/17 for TXEB-2309
  select /*+ RESULT_CACHE +*/ out_var 
  into v_timeliness_calc
  from corp_etl_list_lkup
  where name='PI_TIMELINESS_CALC';

  select /*+ RESULT_CACHE +*/ out_var 
  into v_jeopardy_threshold
  from corp_etl_list_lkup
  where name='PI_JEOPARDY_DAYS';

  if v_timeliness_calc = 'B' then
     v_jeopardy_days := BPM_COMMON.BUS_DAYS_BETWEEN(p_receipt_date,sysdate);
     v_trunc_jeopardy_days := BPM_COMMON.BUS_DAYS_BETWEEN(TRUNC(p_receipt_date),TRUNC(sysdate));
  else
     v_jeopardy_days := sysdate - p_receipt_date;
     v_trunc_jeopardy_days := TRUNC(sysdate) - TRUNC(p_receipt_date);
  end if;

  if (driver='Priority') then

    if (p_instance_status           ='Active') then   
    --added 3/17 for TXEB_2309
      BEGIN   
      
        SELECT /*+ RESULT_CACHE +*/ 'Y'
        INTO v_jeopardy_status
        FROM corp_etl_list_lkup
        WHERE list_type = 'JEOPARDY_PRIORITY_CALC'
        AND v_jeopardy_days >= to_number(value)
        AND out_var = p_priority;
        
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_jeopardy_status := 'N';
      END;

      return v_jeopardy_status;
    else
      return 'NA';
    end if;
  elsif (driver='Incident Type') then
    if (p_instance_status='Active') then
       --added 3/17 for TXEB_2309
       -- if ((trunc(sysdate)-trunc(p_receipt_date))>=20) then
       if v_trunc_jeopardy_days >= v_jeopardy_threshold then
         return 'Y';
        else 
         return 'N';
        end if; 
    else
      return 'NA';
    end if;
  end if;
end;

function GET_JEOPARDY_STATUS_DATE
    (p_receipt_date in date,  
     p_instance_status in varchar,
     p_priority in varchar
    )
    return date parallel_enable
   as
   begin
   if (GET_JEOPARDY_STATUS(p_receipt_date,p_instance_status,p_priority) is not null) then
   return sysdate;
   else
   return null; -- do nothing
   end if;
  end; 

function GET_TIMELINESS_STATUS
    (p_receipt_date in date, 
     p_instance_status_dt in date,
     p_instance_status in varchar,
     p_cancel_date in date,
     p_priority in varchar
     )
return varchar2 parallel_enable
  as
   driver varchar2(20) := null;
   v_timeliness_threshold NUMBER;
   v_timeliness_calc varchar2(20) := null;
   v_timeliness_days NUMBER;
   v_timeliness_status varchar2(30) := null;
  begin
 
  select /*+ RESULT_CACHE +*/ out_var 
  into driver
  from corp_etl_list_lkup
  where name='PI_INCIDENT_SLA_BASIS';
  
  --added 3/17 for TXEB_2309
  select /*+ RESULT_CACHE +*/ out_var 
  into v_timeliness_calc
  from corp_etl_list_lkup
  where name='PI_TIMELINESS_CALC';

  select /*+ RESULT_CACHE +*/ out_var 
  into v_timeliness_threshold
  from corp_etl_list_lkup
  where name='PI_TIMELINESS_DAYS';
  
  if v_timeliness_calc = 'B' then
     v_timeliness_days := BPM_COMMON.BUS_DAYS_BETWEEN(trunc(p_receipt_date),trunc(p_instance_status_dt));    
  else
     v_timeliness_days := trunc(p_instance_status_dt) - trunc(p_receipt_date);   
  end if;
  
  if (driver='Priority')
  then
  
  if (p_instance_status='Complete') then
    --added 3/17 for TXEB_2309
    BEGIN   
    
      SELECT /*+ RESULT_CACHE +*/ 'Processed Timely'
      INTO v_timeliness_status
      FROM corp_etl_list_lkup
      WHERE list_type = 'TIMELINESS_PRIORITY_CALC'
      AND v_timeliness_days <= to_number(value)
      AND out_var = p_priority;
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_timeliness_status := 'Processed Untimely';
    END;
    
    RETURN v_timeliness_status;
    
  elsif (p_instance_status='Active' or p_cancel_date is not null)
   then
   return 'Not Processed';
   else
   return null;
  end if; 
  elsif (driver='Incident Type') then
  if (p_instance_status='Complete') then
      --if (trunc(p_instance_status_dt)-trunc(p_receipt_date)<=30) then
      --added 3/17 for TXEB_2309
      if v_timeliness_days <= v_timeliness_threshold then
       return 'Processed Timely';
      else
       return 'Processed Untimely';
      end if;
    elsif (p_instance_status='Active' or p_cancel_date is not null)
     then
     return 'Not Processed';
     else
     return null;
  end if; 
  end if;
 end;
  
-- Calculate column values in BPM Semantic table D_PI_CURRENT.
  procedure CALC_DPICUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DPICUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
update D_PI_CURRENT
    set
      "Age in Business Days" = GET_AGE_IN_BUSINESS_DAYS("Receipt Date","Complete Date"),
      "Age in Calendar Days" = GET_AGE_IN_CALENDAR_DAYS("Receipt Date","Complete Date"),
      "Status Age in Business Days" = GET_STATUS_AGE_IN_BUS_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Status Age in Calendar Days" = GET_STATUS_AGE_IN_CAL_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Cur Jeopardy Status" = GET_JEOPARDY_STATUS("Receipt Date","Cur Instance Status",PRIORITY),
      "Jeopardy Status Date" = GET_JEOPARDY_STATUS_DATE("Receipt Date","Cur Instance Status",PRIORITY),
      "Timeliness Status" = GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
    where 
      "Complete Date" is null 
      and "Cancel Date" is null;
    
    v_num_rows_updated := sql%rowcount;
 
 commit;
 
     v_log_message := v_num_rows_updated  || ' D_PI_CURRENT rows updated with calculated attributes by CALC_DPICUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
 
  end;
  
  
-- Get dimension ID for BPM Semantic model - Process Incidents process - Enrollment Status.
  procedure GET_DPIES_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_enrollment_status in varchar2,
      p_dpies_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIES_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIES_ID
     into p_dpies_id
     from D_PI_ENROLLMENT_STATUS
     where 
       "Enrollment Status" = p_enrollment_status 
       or ("Enrollment Status" is null and p_enrollment_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpies_id := SEQ_DPIES_ID.nextval;
       begin
         insert into D_PI_ENROLLMENT_STATUS (DPIES_ID,"Enrollment Status")
         values (p_dpies_id,p_enrollment_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIES_ID into p_dpies_id
           from D_PI_ENROLLMENT_STATUS
           where 
             "Enrollment Status" = p_enrollment_status 
             or ("Enrollment Status" is null and p_enrollment_status is null);
             
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

  -- Get dimension ID for BPM Semantic model - Process Incidents process - Incident About.
  procedure GET_DPIIA_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_incident_about in varchar2,
      p_dpiia_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIIA_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIIA_ID
     into p_dpiia_id
     from D_PI_INCIDENT_ABOUT
     where 
       "Incident About" = p_incident_about 
       or ("Incident About" is null and p_incident_about is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiia_id := SEQ_DPIIA_ID.nextval;
       begin
         insert into D_PI_INCIDENT_ABOUT (DPIIA_ID,"Incident About")
         values (p_dpiia_id,p_incident_about);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIIA_ID into p_dpiia_id
           from D_PI_INCIDENT_ABOUT
           where 
             "Incident About" = p_incident_about 
             or ("Incident About" is null and p_incident_about is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Instance Status.
  procedure GET_DPIIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_instance_status in varchar2,
      p_dpiis_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIIS_ID
     into p_dpiis_id
     from D_PI_INSTANCE_STATUS
     where 
       "Instance Status" = p_instance_status 
       or ("Instance Status" is null and p_instance_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiis_id := SEQ_DPIIS_ID.nextval;
       begin
         insert into D_PI_INSTANCE_STATUS (DPIIS_ID,"Instance Status")
         values (p_dpiis_id,p_instance_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIIS_ID into p_dpiis_id
           from D_PI_INSTANCE_STATUS
           where 
             "Instance Status" = p_instance_status 
             or ("Instance Status" is null and p_instance_status is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Jeopardy Status.
  procedure GET_DPIJS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_jeopardy_status in varchar2,
      p_dpijs_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIJS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIJS_ID
     into p_dpijs_id
     from D_PI_JEOPARDY_STATUS
     where 
       "Jeopardy Status" = p_jeopardy_status 
       or ("Jeopardy Status" is null and p_jeopardy_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpijs_id := SEQ_DPIJS_ID.nextval;
       begin
         insert into D_PI_JEOPARDY_STATUS (DPIJS_ID,"Jeopardy Status")
         values (p_dpijs_id,p_jeopardy_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIJS_ID into p_dpijs_id
           from D_PI_JEOPARDY_STATUS
           where 
             "Jeopardy Status" = p_jeopardy_status 
             or ("Jeopardy Status" is null and p_jeopardy_status is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Lat Update By Name.
  procedure GET_DPIUB_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_last_update_by_name in varchar2,
      p_dpiub_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIUB_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIUB_ID
     into p_dpiub_id
     from D_PI_LAST_UPDATE_BY
     where 
       "Last Update By Name" = p_last_update_by_name 
       or ("Last Update By Name" is null and p_last_update_by_name is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiub_id := SEQ_DPIUB_ID.nextval;
       begin
         insert into D_PI_LAST_UPDATE_BY (DPIUB_ID,"Last Update By Name")
         values (p_dpiub_id,p_last_update_by_name);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIUB_ID into p_dpiub_id
           from D_PI_LAST_UPDATE_BY
           where 
             "Last Update By Name" = p_last_update_by_name 
             or ("Last Update By Name" is null and p_last_update_by_name is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Incident Reason.
  procedure GET_DPIIR_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_incident_reason in varchar2,
      p_dpiir_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIIR_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIIR_ID
     into p_dpiir_id
     from D_PI_INCIDENT_REASON
     where 
       "Incident Reason" = p_incident_reason 
       or ("Incident Reason" is null and p_incident_reason is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiir_id := SEQ_DPIIR_ID.nextval;
       begin
         insert into D_PI_INCIDENT_REASON (DPIIR_ID,"Incident Reason")
         values (p_dpiir_id,p_incident_reason);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIIR_ID into p_dpiir_id
           from D_PI_INCIDENT_REASON
           where 
             "Incident Reason" = p_incident_reason 
             or ("Incident Reason" is null and p_incident_reason is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Task ID.
  procedure GET_DPITI_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_task_id in varchar2,
      p_dpiti_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPITI_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPITI_ID
     into p_dpiti_id
     from D_PI_TASK_ID
     where 
       "Task ID" = p_task_id 
       or ("Task ID" is null and p_task_id is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiti_id := SEQ_DPITI_ID.nextval;
       begin
         insert into D_PI_TASK_ID (DPITI_ID,"Task ID")
         values (p_dpiti_id,p_task_id);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPITI_ID into p_dpiti_id
           from D_PI_TASK_ID
           where 
             "Task ID" = p_task_id 
             or ("Task ID" is null and p_task_id is null);
             
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
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Incident Description.
 /* procedure GET_DPIID_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_incident_desc in varchar2,
      p_dpiid_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIID_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIID_ID
     into p_dpiid_id
     from D_PI_INCIDENT_DESC
     where 
       "Incident Description" = p_incident_desc 
       or ("Incident Description" is null and p_incident_desc is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiid_id := SEQ_DPIID_ID.nextval;
       begin
         insert into D_PI_INCIDENT_DESC (DPIID_ID,"Incident Description")
         values (p_dpiid_id,p_incident_desc);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIID_ID into p_dpiid_id
           from D_PI_INCIDENT_DESC
           where 
             "Incident Description" = p_incident_desc 
             or ("Incident Description" is null and p_incident_desc is null);
             
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
       
  end;  */
  
  -- Get dimension ID for BPM Semantic model - Process Incidents process - Incident Status.
  procedure GET_DPIISS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_incident_status in varchar2,
      p_dpiiss_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DPIISS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DPIISS_ID
     into p_dpiiss_id
     from D_PI_INCIDENT_STATUS
     where 
       "Incident Status" = p_incident_status 
       or ("Incident Status" is null and p_incident_status is null);
      
   exception

     when NO_DATA_FOUND then

       p_dpiiss_id := SEQ_DPIISS_ID.nextval;
       begin
         insert into D_PI_INCIDENT_STATUS (DPIISS_ID,"Incident Status")
         values (p_dpiiss_id,p_incident_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DPIISS_ID into p_dpiiss_id
           from D_PI_INCIDENT_STATUS
           where 
             "Incident Status" = p_incident_status 
             or ("Incident Status" is null and p_incident_status is null);
             
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
  
-- Get record for Process Incidents insert XML.
  procedure GET_INS_PI_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PI_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PI_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDENTIFY_RSRCH_INCIDENT') "ASED_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_CLIENT') "ASED_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_INCIDENT') "ASED_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_CMPLT_INCIDENT') "ASED_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDENTIFY_RSRCH_INCIDENT') "ASF_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT') "ASF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_INCIDENT') "ASF_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_CMPLT_INCIDENT') "ASF_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDENTIFY_RSRCH_INCIDENT') "ASSD_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT') "ASSD_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_INCIDENT') "ASSD_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_CMPLT_INCIDENT') "ASSD_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPI_ID') "CEPI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_NOTICE_ID') "CLIENT_NOTICE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_NAME') "COUNTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/EB_FOLLOWUP_NEEDED_IND') "EB_FOLLOWUP_NEEDED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLEE_RIN') "ENROLLEE_RIN",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/ESCALATE_DT') "ESCALATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD1') "GENERIC_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD2') "GENERIC_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD3') "GENERIC_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD4') "GENERIC_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD5') "GENERIC_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ESCALATE_INCIDENT') "GWF_ESCALATE_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_CLIENT') "GWF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_INCIDENT') "GWF_RETURN_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/HEARING_DT') "HEARING_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN_ID') "ORIGIN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_CODE') "PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_SUBTYPE') "PROGRAM_SUBTYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_ID') "PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_DT') "RETURNED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SELECTION_ID') "SELECTION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_RECD_APPEAL_DT') "STATE_RECD_APPEAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER"
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
 -- Get record for Process Incidents update XML. 
  procedure GET_UPD_PI_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_PI_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PI_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
 
     select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDENTIFY_RSRCH_INCIDENT') "ASED_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_NOTIFY_CLIENT') "ASED_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_INCIDENT') "ASED_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_CMPLT_INCIDENT') "ASED_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDENTIFY_RSRCH_INCIDENT') "ASF_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_NOTIFY_CLIENT') "ASF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_INCIDENT') "ASF_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_CMPLT_INCIDENT') "ASF_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDENTIFY_RSRCH_INCIDENT') "ASSD_IDENTIFY_RSRCH_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_NOTIFY_CLIENT') "ASSD_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_INCIDENT') "ASSD_PROCESS_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_CMPLT_INCIDENT') "ASSD_RESOLVE_CMPLT_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_NOTICE_ID') "CLIENT_NOTICE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_NAME') "COUNTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/EB_FOLLOWUP_NEEDED_IND') "EB_FOLLOWUP_NEEDED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLEE_RIN') "ENROLLEE_RIN",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/ESCALATE_DT') "ESCALATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD1') "GENERIC_FIELD1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD2') "GENERIC_FIELD2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD3') "GENERIC_FIELD3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD4') "GENERIC_FIELD4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD5') "GENERIC_FIELD5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ESCALATE_INCIDENT') "GWF_ESCALATE_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NOTIFY_CLIENT') "GWF_NOTIFY_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_INCIDENT') "GWF_RETURN_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/HEARING_DT') "HEARING_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGIN_ID') "ORIGIN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_CODE') "PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_SUBTYPE') "PROGRAM_SUBTYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_ID') "PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_DT') "RETURNED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SELECTION_ID') "SELECTION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_RECD_APPEAL_DT') "STATE_RECD_APPEAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  
 -- Insert fact for BPM Semantic model - Process Incidents process. 
    procedure INS_FPIBD 
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dpiis_id  in number,
     p_dpiia_id  in number,
     p_dpiir_id  in number,
    -- p_dpiid_id  in number,
     p_dpiiss_id in number,
     p_dpijs_id  in number,
     p_dpies_id  in number,
     p_dpiub_id  in number,
     p_dpiti_id  in number,
     p_incident_status_dt in varchar2,
     p_last_update_date in varchar2,
     p_stg_last_update_date in varchar2,
     p_fpibd_id out number)
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPIBD';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
         v_stg_last_update_date date := null;
         v_incident_status_dt date :=null;
         v_last_update_date date:=null;
    begin
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_incident_status_dt:=to_date(p_incident_status_dt,BPM_COMMON.DATE_FMT);
      v_last_update_date:=to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      p_fpibd_id := SEQ_FPIBD_ID.nextval;
      
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
      
       insert into F_PI_BY_DATE
        ( FPIBD_ID,  
	  D_DATE,
	  BUCKET_START_DATE,
	  BUCKET_END_DATE,
	  PI_BI_ID, 
	  DPIIS_ID, 
	  DPIIA_ID, 
	  DPIIR_ID, 
	 -- DPIID_ID, 
	  DPIISS_ID, 
	  DPIJS_ID, 
	  DPIES_ID, 
	  DPIUB_ID, 
	  DPITI_ID, 
	  INVENTORY_COUNT, 
	  CREATION_COUNT, 
	  COMPLETION_COUNT, 
	  "Incident Status Date",
	  "Last Update Date"  )
	values
	(p_fpibd_id,
	  p_start_date,
	  v_bucket_start_date,
	  v_bucket_end_date,
	  p_bi_id,
	  p_dpiis_id, 
	  p_dpiia_id, 
	  p_dpiir_id, 
	 -- p_dpiid_id, 
	  p_dpiiss_id,
	  p_dpijs_id, 
	  p_dpies_id, 
	  p_dpiub_id, 
	  p_dpiti_id,
	  case 
	  when p_end_date is null then 1
	  else 0
	  end,
	  1,
	  case 
	    when p_end_date is null then 0
	    else 1
	    end,
	 v_incident_status_dt,
	 v_last_update_date
	 );
      exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
 -- Insert or update dimension for BPM Semantic model - Process App process - Current.
  procedure SET_DPICUR  
  (p_set_type 			             in     varchar2,
   p_identifier                  in     varchar2,
   p_bi_id                       in     number,
   p_incident_id		             in     number,
   p_incident_tracking_number	   in	    varchar2,
   p_receipt_date		             in	    varchar2,
   p_create_date		             in	    varchar2,
   p_created_by_group		         in	    varchar2, 
   p_origin_id			             in	    number,
   p_channel			               in	    varchar2,
   p_prcss_clnt_notifcatn_id     in	    number,
   p_cur_instance_status	       in	    varchar2, 
   p_cancel_date		             in	    varchar2,
   p_incident_type		           in	    varchar2, 
   p_cur_incident_about		       in	    varchar2, 
   p_cur_incident_reason	       in	    varchar2, 
   p_about_provider_id		       in	    number,
   p_about_plan_code		         in	    varchar2,
   p_cur_incident_status	       in	    varchar2, 
   p_cur_incident_status_date	   in	    varchar2,
   p_complete_date		           in	    varchar2,
   p_reported_by		             in	    varchar2, 
   p_reporter_relationship	     in	    varchar2, 
   p_case_id			               in	    number,
   p_cur_enrollment_status	     in	    varchar2,
   p_priority			               in	    varchar2, 
   p_program			               in	    varchar2,
   p_sub_program		             in	    varchar2,
   p_cur_last_update_date	       in	    varchar2,
   p_cur_last_update_by_name	   in	    varchar2, 
   p_plan_code			             in	    varchar2,
   p_provider_id		             in	    number,
   p_action_type		             in	    varchar2, 
   p_resolution_type		         in	    varchar2, 
   p_notify_client_flag		       in	    varchar2, 
   p_proces_clnt_notify_start_dt in	    varchar2,
   p_proces_clnt_notify_end_dt	 in	    varchar2,
   p_proces_clnt_notify_flag	   in	    varchar2, 
   p_escalate_incident_flag	     in	    varchar2, 
   p_escalate_to_state_dt	       in	    varchar2,
   p_cur_task_id		             in	    number,
   p_state_received_appeal_date	 in	    varchar2,
   p_hearing_date		             in	    varchar2,
   p_selection_id		             in	    number,
   p_eb_follow_up_needed_flag	   in	    varchar2, 
   p_other_party_name		         in	    varchar2, 
   p_research_incident_st_dt	   in	    varchar2,
   p_research_incident_end_dt	   in	    varchar2,
   p_process_incident_st_dt	     in	    varchar2,
   p_process_incident_end_dt	   in	    varchar2,
   p_process_incident_flag	     in	    varchar2, 
   p_return_incident_flag	       in	    varchar2, 
   p_complete_incident_st_dt	   in	    varchar2,
   p_complete_incident_end_dt	   in	    varchar2,
   p_complete_incident_flag	     in	    varchar2, 
   p_return_to_mms_dt		         in	    varchar2,
   p_created_by_name		         in	    varchar2, 
   p_generic_field_1		         in	    varchar2, 
   p_generic_field_2		         in	    varchar2, 
   p_generic_field_3		         in	    varchar2, 
   p_generic_field_4		         in	    varchar2, 
   p_generic_field_5		         in	    varchar2, 
   p_research_incident_flag	     in	    varchar2,
   p_cancel_by                   in     varchar2,
   p_cancel_method               in     varchar2,
   p_cancel_reason               in     varchar2,
   p_enrollee_rin	  	           in	    varchar2, 
   p_reporter_name		           in	    varchar2, 
   p_county_code                 in     varchar2,
   p_county_name                 in     varchar2,
   p_action_comments             in     varchar2,
   p_incident_description        in     varchar2,
   p_resolution_description      in     varchar2,
   p_client_id		               in	    number
   )
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPICUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_dpicur D_PI_CURRENT%rowtype := null;
       v_jeopardy_flag varchar2(1) := null; 
  begin
  
  r_dpicur."PI_BI_ID" 			             :=  p_bi_id;
  r_dpicur."Receipt Date" 		           :=  to_date(p_receipt_date,BPM_COMMON.DATE_FMT);
  r_dpicur."Cancel Date" 		             :=  to_date(p_cancel_date,BPM_COMMON.DATE_FMT)	;
  r_dpicur."Cur Incident Status" 	       :=  p_cur_incident_status;
  r_dpicur."Cur Instance Status"         :=  p_cur_instance_status	;
  r_dpicur."Cur Incident Status Date" 	 :=  to_date(p_cur_incident_status_date,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Complete Date" 		           :=  to_date(p_complete_date,BPM_COMMON.DATE_FMT);
  r_dpicur.PRIORITY 			               :=  p_priority;	
  
  
  r_dpicur."Age in Business Days" 	      :=  GET_AGE_IN_BUSINESS_DAYS(r_dpicur."Receipt Date",r_dpicur."Complete Date");
  r_dpicur."Age in Calendar Days" 	      :=  GET_AGE_IN_CALENDAR_DAYS(r_dpicur."Receipt Date",r_dpicur."Complete Date");
  r_dpicur."Status Age in Business Days"  :=  GET_STATUS_AGE_IN_BUS_DAYS(r_dpicur."Cur Incident Status Date",r_dpicur."Cur Instance Status");	
  r_dpicur."Status Age in Calendar Days"  :=  GET_STATUS_AGE_IN_CAL_DAYS(r_dpicur."Cur Incident Status Date",r_dpicur."Cur Instance Status");
  r_dpicur."Cur Jeopardy Status"          :=  GET_JEOPARDY_STATUS(r_dpicur."Receipt Date",r_dpicur."Cur Instance Status",r_dpicur.PRIORITY );
  r_dpicur."Jeopardy Status Date" 	      :=  GET_JEOPARDY_STATUS_DATE(r_dpicur."Receipt Date",r_dpicur."Cur Instance Status",r_dpicur.PRIORITY);
  r_dpicur."Timeliness Status" 		        :=  GET_TIMELINESS_STATUS(r_dpicur."Receipt Date",r_dpicur."Cur Incident Status Date",r_dpicur."Cur Instance Status",r_dpicur."Cancel Date",r_dpicur.PRIORITY);
  
  
  
  r_dpicur."Incident ID"                      :=  p_incident_id	;		 
  r_dpicur."Incident Tracking Number" 	      :=  p_incident_tracking_number;
  r_dpicur."Create Date" 		                  :=  to_date(p_create_date,BPM_COMMON.DATE_FMT);		 
  r_dpicur."Created By Group" 		            :=  p_created_by_group;		 
  r_dpicur."Origin ID" 			                  :=  p_origin_id;			 
  r_dpicur.CHANNEL			                      :=  p_channel;			 
  r_dpicur."Process Client Notification ID"   :=  p_prcss_clnt_notifcatn_id ;
  	 
  r_dpicur."Incident Type" 		                :=  p_incident_type;			 
  r_dpicur."Cur Incident About" 	            :=  p_cur_incident_about	;	 
  r_dpicur."Cur Incident Reason" 	            :=  p_cur_incident_reason	;	 
  r_dpicur."About Provider ID" 		            :=  p_about_provider_id;		 
  r_dpicur."About Plan Code" 		              :=  p_about_plan_code;		 
  r_dpicur."Reported By" 		                  :=  p_reported_by;			 
  r_dpicur."Reporter Relationship" 	          :=  p_reporter_relationship;		 
  r_dpicur."Case ID" 			                    :=  p_case_id;	
  r_dpicur."Cur Enrollment Status" 	          :=  p_cur_enrollment_status;
  r_dpicur.PROGRAM 			                      :=  p_program;			 
  r_dpicur."Sub-Program" 		                  :=  p_sub_program;			 
  r_dpicur."Cur Last Update Date" 	          :=  to_date(p_cur_last_update_date,BPM_COMMON.DATE_FMT);
  r_dpicur."Cur Last Update By Name" 	        :=  p_cur_last_update_by_name;	 
  r_dpicur."Plan Code" 			                  :=  p_plan_code;			 
  r_dpicur."Provider ID" 		                  :=  p_provider_id;			 
  r_dpicur."Action Type" 		                  :=  p_action_type;			 
  r_dpicur."Resolution Type" 		              :=  p_resolution_type;		 
  r_dpicur."Notify Client Flag" 	            :=  p_notify_client_flag;		 
  r_dpicur."Process Clnt Notify Start Dt"     :=  to_date(p_proces_clnt_notify_start_dt,BPM_COMMON.DATE_FMT); 
  r_dpicur."Process Clnt Notify End Dt"       :=  to_date(p_proces_clnt_notify_end_dt,BPM_COMMON.DATE_FMT);	
  r_dpicur."Process Clnt Notify Flag" 	      :=  p_proces_clnt_notify_flag;	
  r_dpicur."Escalate Incident Flag" 	        :=  p_escalate_incident_flag;	 
  r_dpicur."Escalate to State Dt" 	          :=  to_date(p_escalate_to_state_dt,BPM_COMMON.DATE_FMT);		 
  r_dpicur."Cur Task ID" 		                  :=  p_cur_task_id;			 
  r_dpicur."State Received Appeal Date"       :=  to_date(p_state_received_appeal_date,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Hearing Date" 		                :=  to_date(p_hearing_date,BPM_COMMON.DATE_FMT);			 
  r_dpicur."Selection ID" 		                :=  p_selection_id;			 
  r_dpicur."EB Follow-Up Needed Flag" 	      :=  p_eb_follow_up_needed_flag;	 
  r_dpicur."Other Party Name" 		            :=  p_other_party_name;		 
  r_dpicur."Research Incident St Dt" 	        :=  to_date(p_research_incident_st_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Research Incident End Dt" 	      :=  to_date(p_research_incident_end_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Process Incident St Dt" 	        :=  to_date(p_process_incident_st_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Process Incident End Dt" 	        :=  to_date(p_process_incident_end_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Process Incident Flag" 	          :=  p_process_incident_flag;		 
  r_dpicur."Return Incident Flag" 	          :=  p_return_incident_flag;		 
  r_dpicur."Complete Incident St Dt" 	        :=  to_date(p_complete_incident_st_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Complete Incident End Dt" 	      :=  to_date(p_complete_incident_end_dt,BPM_COMMON.DATE_FMT);	 
  r_dpicur."Complete Incident Flag" 	        :=  p_complete_incident_flag;	 
  r_dpicur."Return to MMS Dt" 		            :=  to_date(p_return_to_mms_dt,BPM_COMMON.DATE_FMT);		 
  r_dpicur."Created By Name" 		              :=  p_created_by_name;		 
  r_dpicur."Generic Field 1" 		              :=  p_generic_field_1;		 
  r_dpicur."Generic Field 2" 		              :=  p_generic_field_2;		 
  r_dpicur."Generic Field 3" 		              :=  p_generic_field_3;		 
  r_dpicur."Generic Field 4" 		              :=  p_generic_field_4;		 
  r_dpicur."Generic Field 5" 		              :=  p_generic_field_5;		 
  r_dpicur."Research Incident Flag" 	        :=  p_research_incident_flag;	
  r_dpicur.CANCEL_BY 	                        :=  p_cancel_by;
  r_dpicur.CANCEL_METHOD	                    :=  p_cancel_method;
  r_dpicur.CANCEL_REASON 	                    :=  p_cancel_reason;
  
  r_dpicur.ENROLLEE_RIN 		                  :=  p_enrollee_rin;			 
  r_dpicur.REPORTER_NAME 		                  :=  p_reporter_name;		
  r_dpicur.COUNTY_CODE 		                    :=  p_county_code;			 
  r_dpicur.COUNTY_NAME 		                    :=  p_county_name;
  r_dpicur.INCIDENT_DESCRIPTION        	      :=  p_incident_description;	 
  r_dpicur.ACTION_COMMENTS                    :=  p_action_comments;    
  r_dpicur.RESOLUTION_DESCRIPTION             :=  p_resolution_description;
  r_dpicur."CLIENT_ID" 			                  :=  p_client_id;
 
  if p_set_type = 'INSERT' then
       insert into D_PI_CURRENT
       values r_dpicur;
     elsif p_set_type = 'UPDATE' then
       begin
         update D_PI_CURRENT
         set row = r_dpicur
         where PI_BI_ID = p_bi_id;
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
      
    v_new_data T_INS_PI_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null; 
    
    v_dpiis_id   number    := null;
    v_dpiia_id   number    := null;
    v_dpiir_id   number    := null;
   -- v_dpiid_id   number    := null;
    v_dpiiss_id  number    := null;
    v_dpijs_id   number    := null;
    v_dpies_id   number    := null;
    v_dpiub_id   number    := null;
    v_dpiti_id   number    := null;
    v_fpibd_id number := null;
    v_jeopardy_status varchar2(2):=null;
    v_receipt_date date := null;
    
    begin
      
        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Incidents in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_INS_PI_XML(p_new_data_xml,v_new_data);
    
        v_identifier := v_new_data.INCIDENT_ID ;
        v_start_date := to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_bi_id := SEQ_BI_ID.nextval;
        
     v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);   
     v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS,v_new_data.PRIORITY) ;  
        
     GET_DPIES_ID     (v_identifier,v_bi_id ,v_new_data.ENROLLMENT_STATUS ,v_dpies_id )  ;    
     GET_DPIIA_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_ABOUT ,v_dpiia_id )  ;       
     GET_DPIIS_ID     (v_identifier,v_bi_id ,v_new_data.INSTANCE_STATUS ,v_dpiis_id );     
     GET_DPIJS_ID     (v_identifier ,v_bi_id ,v_jeopardy_status ,v_dpijs_id ) ;     
     GET_DPIUB_ID     (v_identifier ,v_bi_id ,v_new_data.LAST_UPDATE_BY_NAME ,v_dpiub_id ) ;     
     GET_DPIIR_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_REASON ,v_dpiir_id );      
     GET_DPITI_ID     (v_identifier ,v_bi_id ,v_new_data.CURRENT_TASK_ID ,v_dpiti_id )   ;   
   --  GET_DPIID_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_DESCRIPTION ,v_dpiid_id );   
     GET_DPIISS_ID    (v_identifier ,v_bi_id ,v_new_data.INCIDENT_STATUS ,v_dpiiss_id )  ;     


 -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
   SET_DPICUR
        ('INSERT',v_identifier,v_bi_id, 
         v_new_data.INCIDENT_ID,v_new_data.TRACKING_NUMBER,v_new_data.RECEIPT_DT,v_new_data.CREATE_DT,v_new_data.CREATED_BY_GROUP,v_new_data.ORIGIN_ID,v_new_data.CHANNEL, 
	 v_new_data.CLIENT_NOTICE_ID ,v_new_data.INSTANCE_STATUS,v_new_data.CANCEL_DT,v_new_data.INCIDENT_TYPE,v_new_data.INCIDENT_ABOUT,
	 v_new_data.INCIDENT_REASON,v_new_data.ABOUT_PROVIDER_ID,v_new_data.ABOUT_PLAN_CODE,v_new_data.INCIDENT_STATUS,
	 v_new_data.INCIDENT_STATUS_DT,v_new_data.COMPLETE_DT,v_new_data.REPORTED_BY,v_new_data.REPORTER_RELATIONSHIP,v_new_data.CASE_ID,v_new_data.ENROLLMENT_STATUS,v_new_data.PRIORITY,
	 v_new_data.PROGRAM_TYPE,v_new_data.PROGRAM_SUBTYPE,v_new_data.LAST_UPDATE_BY_DT,v_new_data.LAST_UPDATE_BY_NAME,v_new_data.PLAN_CODE,v_new_data.PROVIDER_ID,
	 v_new_data.ACTION_TYPE,v_new_data.RESOLUTION_TYPE,v_new_data.GWF_NOTIFY_CLIENT,v_new_data.ASSD_NOTIFY_CLIENT ,
	 v_new_data.ASED_NOTIFY_CLIENT,v_new_data.ASF_NOTIFY_CLIENT,v_new_data.GWF_ESCALATE_INCIDENT,
	 v_new_data.ESCALATE_DT,v_new_data.CURRENT_TASK_ID,v_new_data.STATE_RECD_APPEAL_DT,v_new_data.HEARING_DT,v_new_data.SELECTION_ID,  
	 v_new_data.EB_FOLLOWUP_NEEDED_IND,v_new_data.OTHER_PARTY_NAME,v_new_data.ASSD_IDENTIFY_RSRCH_INCIDENT,
	 v_new_data.ASED_IDENTIFY_RSRCH_INCIDENT,v_new_data.ASSD_PROCESS_INCIDENT,v_new_data.ASED_PROCESS_INCIDENT,v_new_data.ASF_PROCESS_INCIDENT,
	 v_new_data.GWF_RETURN_INCIDENT,v_new_data.ASSD_RESOLVE_CMPLT_INCIDENT,v_new_data.ASED_RESOLVE_CMPLT_INCIDENT,v_new_data.ASF_RESOLVE_CMPLT_INCIDENT,
	 v_new_data.RETURNED_DT,v_new_data.CREATED_BY_NAME,v_new_data.GENERIC_FIELD1,v_new_data.GENERIC_FIELD2,v_new_data.GENERIC_FIELD3,v_new_data.GENERIC_FIELD4,
	 v_new_data.GENERIC_FIELD5,v_new_data.ASF_IDENTIFY_RSRCH_INCIDENT, v_new_data.cancel_by, v_new_data.cancel_method,v_new_data.cancel_reason,
   v_new_data.ENROLLEE_RIN,	  	        
   v_new_data.REPORTER_NAME,		        
   v_new_data.COUNTY_CODE ,               
   v_new_data.COUNTY_NAME,                
   v_new_data.ACTION_COMMENTS ,            
   v_new_data.INCIDENT_DESCRIPTION ,       
   v_new_data.RESOLUTION_DESCRIPTION,
   v_new_data.CLIENT_ID
	); 
	
   INS_FPIBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dpiis_id  ,v_dpiia_id  ,v_dpiir_id  ,/*v_dpiid_id  ,*/
         v_dpiiss_id ,v_dpijs_id  ,v_dpies_id  ,v_dpiub_id  ,v_dpiti_id  ,v_new_data.INCIDENT_STATUS_DT ,v_new_data.LAST_UPDATE_BY_DT ,v_new_data.stg_last_update_date,v_fpibd_id 
         );
         
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
  
  -- Update fact for BPM Semantic model - Process Incidents process. 
    procedure UPD_FPIBD
      (p_identifier in varchar2,  
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dpiis_id  in number,
       p_dpiia_id  in number,
       p_dpiir_id  in number,
     --  p_dpiid_id  in number,
       p_dpiiss_id in number,
       p_dpijs_id  in number,
       p_dpies_id  in number,
       p_dpiub_id  in number,
       p_dpiti_id  in number,
       p_incident_status_dt in varchar2,
       p_last_update_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fpibd_id out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPIBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fpibd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_incident_status_dt date := null;
    v_last_update_date date := null;
    v_event_date date := null;  
    
    v_dpiis_id   number    := null;
    v_dpiia_id   number    := null;
    v_dpiir_id   number    := null;
   -- v_dpiid_id   number    := null;
    v_dpiiss_id  number    := null;
    v_dpijs_id   number    := null;
    v_dpies_id   number    := null;
    v_dpiub_id   number    := null;
    v_dpiti_id   number    := null;
    v_fpibd_id	 number    := null;
    v_jeopardy_status varchar2(2):=null;
  
    
       r_fpibd F_PI_BY_DATE%rowtype := null;
  begin 
  
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
      v_incident_status_dt := to_date(p_incident_status_dt,BPM_COMMON.DATE_FMT);
      v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      
     v_dpiis_id :=  p_dpiis_id ;   
     v_dpiia_id :=  p_dpiia_id ; 
     v_dpiir_id :=  p_dpiir_id ; 
   --  v_dpiid_id :=  p_dpiid_id ; 
     v_dpiiss_id := p_dpiiss_id ;
     v_dpijs_id  := p_dpijs_id ; 
     v_dpies_id  := p_dpies_id ; 
     v_dpiub_id  := p_dpiub_id ; 
     v_dpiti_id  := p_dpiti_id ; 
     v_fpibd_id  := p_fpibd_id;
     
     with most_recent_fact_bi_id as
           (select 
              max(FPIBD_ID) max_fpibd_id,
              max(D_DATE) max_d_date
            from F_PI_BY_DATE
            where PI_BI_ID = p_bi_id) 
         select 
           fpibd.FPIBD_ID,
           fpibd.D_DATE,
           fpibd.CREATION_COUNT,
           fpibd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into 
           v_fpibd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from 
           F_PI_BY_DATE fpibd,
           most_recent_fact_bi_id 
         where
           fpibd.FPIBD_ID = max_fpibd_id
      and fpibd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    
   if p_end_date is null then
      r_fpibd.D_DATE := v_event_date;
      r_fpibd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fpibd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fpibd.INVENTORY_COUNT := 1;
      r_fpibd.COMPLETION_COUNT := 0;
    else 
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
          
            delete from F_PI_BY_DATE
            where 
              PI_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
              
            with most_recent_fact_bi_id as
              (select 
                 max(FPIBD_ID) max_fpibd_id,
                 max(D_DATE) max_d_date
               from F_PI_BY_DATE
           where PI_BI_ID = p_bi_id) 
           select 
	             fpibd.FPIBD_ID,
	             fpibd.D_DATE,
	             fpibd.CREATION_COUNT,
	             fpibd.COMPLETION_COUNT,
	             most_recent_fact_bi_id.max_d_date,
	             fpibd.DPIIS_ID, 
	             fpibd.DPIIA_ID, 
	             fpibd.DPIIR_ID, 
	            -- fpibd.DPIID_ID, 
	             fpibd.DPIISS_ID,
	             fpibd.DPIJS_ID, 
	             fpibd.DPIES_ID, 
	             fpibd.DPIUB_ID, 
	             fpibd.DPITI_ID, 
	             fpibd."Incident Status Date",
	             fpibd."Last Update Date"
	           into 
	             v_fpibd_id_old,
	             v_d_date_old,
	             v_creation_count_old,
	             v_completion_count_old,
	             v_max_d_date,
	             v_dpiis_id,
	             v_dpiia_id, 
	             v_dpiir_id, 
	           --  v_dpiid_id, 
	             v_dpiiss_id,
	             v_dpijs_id, 
	             v_dpies_id, 
	             v_dpiub_id, 
	             v_dpiti_id, 
	             v_incident_status_dt,
	             v_last_update_date 
	           from 
	             F_PI_BY_DATE fpibd,
	             most_recent_fact_bi_id 
	           where
	             fpibd.FPIBD_ID = max_fpibd_id
          and fpibd.D_DATE = most_recent_fact_bi_id.max_d_date;
          
      end if;
      
      r_fpibd.D_DATE := p_end_date;
      r_fpibd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fpibd.BUCKET_END_DATE := r_fpibd.BUCKET_START_DATE;
      r_fpibd.INVENTORY_COUNT := 0;
      r_fpibd.COMPLETION_COUNT := 1;
      
    end if;    
    
    p_fpibd_id := SEQ_FPIBD_ID.nextval;
    r_fpibd.FPIBD_ID := p_fpibd_id;
    r_fpibd.PI_BI_ID := p_bi_id;
    r_fpibd.DPIIS_ID := v_dpiis_id ;
    r_fpibd.DPIIA_ID := v_dpiia_id ;
    r_fpibd.DPIIR_ID := v_dpiir_id ;
  --  r_fpibd.DPIID_ID :=	v_dpiid_id ;
    r_fpibd.DPIISS_ID:=	v_dpiiss_id ;
    r_fpibd.DPIJS_ID :=	v_dpijs_id ;
    r_fpibd.DPIES_ID :=	v_dpies_id ;
    r_fpibd.DPIUB_ID :=	v_dpiub_id ;
    r_fpibd.DPITI_ID :=	v_dpiti_id ;
    r_fpibd."Incident Status Date" := v_incident_status_dt;
    r_fpibd.CREATION_COUNT := 0;
    r_fpibd."Last Update Date" := v_last_update_date;
 
 -- Validate fact date ranges.
     if r_fpibd.D_DATE < r_fpibd.BUCKET_START_DATE
       or to_date(to_char(r_fpibd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fpibd.BUCKET_END_DATE
       or r_fpibd.BUCKET_START_DATE > r_fpibd.BUCKET_END_DATE
       or r_fpibd.BUCKET_END_DATE < r_fpibd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' || 
         'D_DATE = ' || r_fpibd.D_DATE || 
         ' BUCKET_START_DATE = ' || to_char(r_fpibd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fpibd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
     
   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fpibd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fpibd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_PI_BY_DATE
      set row = r_fpibd
      where FPIBD_ID = v_fpibd_id_old;
        
    else  
    
     -- Different bucket time.
        
          update F_PI_BY_DATE
          set BUCKET_END_DATE = r_fpibd.BUCKET_START_DATE
          where FPIBD_ID = v_fpibd_id_old;
            
          insert into F_PI_BY_DATE
          values r_fpibd;
          
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
        
      v_old_data T_UPD_PI_XML := null;
      v_new_data T_UPD_PI_XML := null;
      
      v_bi_id number := null;
      v_identifier varchar2(100) := null;
        
      v_start_date date := null;
      v_end_date date := null;
      
    v_dpiis_id   number    := null;
    v_dpiia_id   number    := null;
    v_dpiir_id   number    := null;
   -- v_dpiid_id   number    := null;
    v_dpiiss_id  number    := null;
    v_dpijs_id   number    := null;
    v_dpies_id   number    := null;
    v_dpiub_id   number    := null;
    v_dpiti_id   number    := null;
    v_fpibd_id	 number    := null;
    v_jeopardy_status varchar2(2):=null;
    v_receipt_date date := null;
    
    begin
       
        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Incidents in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_UPD_PI_XML(p_old_data_xml,v_old_data);
        GET_UPD_PI_XML(p_new_data_xml,v_new_data);
        
    v_identifier := v_new_data.INCIDENT_ID ;
    v_start_date := to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
 
    select PI_BI_ID 
    into v_bi_id
    from D_PI_CURRENT
    where "Incident ID" = v_identifier;   
      
     v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);   
     v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS,v_new_data.PRIORITY) ; 
        
     GET_DPIES_ID     (v_identifier,v_bi_id ,v_new_data.ENROLLMENT_STATUS ,v_dpies_id )  ;    
     GET_DPIIA_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_ABOUT ,v_dpiia_id )  ;       
     GET_DPIIS_ID     (v_identifier,v_bi_id ,v_new_data.INSTANCE_STATUS ,v_dpiis_id );     
     GET_DPIJS_ID     (v_identifier ,v_bi_id ,v_jeopardy_status ,v_dpijs_id ) ;     
     GET_DPIUB_ID     (v_identifier ,v_bi_id ,v_new_data.LAST_UPDATE_BY_NAME ,v_dpiub_id ) ;     
     GET_DPIIR_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_REASON ,v_dpiir_id );      
     GET_DPITI_ID     (v_identifier ,v_bi_id ,v_new_data.CURRENT_TASK_ID ,v_dpiti_id )   ;   
   --  GET_DPIID_ID     (v_identifier ,v_bi_id ,v_new_data.INCIDENT_DESCRIPTION ,v_dpiid_id );   
     GET_DPIISS_ID    (v_identifier ,v_bi_id ,v_new_data.INCIDENT_STATUS ,v_dpiiss_id )  ;   
     
   -- Update current dimension and fact as a single transaction.
    begin
             
      commit;   
  SET_DPICUR
        ('UPDATE',v_identifier,v_bi_id, 
         v_new_data.INCIDENT_ID,v_new_data.TRACKING_NUMBER,v_new_data.RECEIPT_DT,v_new_data.CREATE_DT,v_new_data.CREATED_BY_GROUP,v_new_data.ORIGIN_ID,v_new_data.CHANNEL, 
	 v_new_data.CLIENT_NOTICE_ID ,v_new_data.INSTANCE_STATUS,v_new_data.CANCEL_DT,v_new_data.INCIDENT_TYPE,v_new_data.INCIDENT_ABOUT,
	 v_new_data.INCIDENT_REASON,v_new_data.ABOUT_PROVIDER_ID,v_new_data.ABOUT_PLAN_CODE,v_new_data.INCIDENT_STATUS,
	 v_new_data.INCIDENT_STATUS_DT,v_new_data.COMPLETE_DT,v_new_data.REPORTED_BY,v_new_data.REPORTER_RELATIONSHIP,v_new_data.CASE_ID,v_new_data.ENROLLMENT_STATUS,v_new_data.PRIORITY,
	 v_new_data.PROGRAM_TYPE,v_new_data.PROGRAM_SUBTYPE,v_new_data.LAST_UPDATE_BY_DT,v_new_data.LAST_UPDATE_BY_NAME,v_new_data.PLAN_CODE,v_new_data.PROVIDER_ID,
	 v_new_data.ACTION_TYPE,v_new_data.RESOLUTION_TYPE,v_new_data.GWF_NOTIFY_CLIENT,v_new_data.ASSD_NOTIFY_CLIENT ,
	 v_new_data.ASED_NOTIFY_CLIENT,v_new_data.ASF_NOTIFY_CLIENT,v_new_data.GWF_ESCALATE_INCIDENT,
	 v_new_data.ESCALATE_DT,v_new_data.CURRENT_TASK_ID,v_new_data.STATE_RECD_APPEAL_DT,v_new_data.HEARING_DT,v_new_data.SELECTION_ID,  
	 v_new_data.EB_FOLLOWUP_NEEDED_IND,v_new_data.OTHER_PARTY_NAME,v_new_data.ASSD_IDENTIFY_RSRCH_INCIDENT,
	 v_new_data.ASED_IDENTIFY_RSRCH_INCIDENT,v_new_data.ASSD_PROCESS_INCIDENT,v_new_data.ASED_PROCESS_INCIDENT,v_new_data.ASF_PROCESS_INCIDENT,
	 v_new_data.GWF_RETURN_INCIDENT,v_new_data.ASSD_RESOLVE_CMPLT_INCIDENT,v_new_data.ASED_RESOLVE_CMPLT_INCIDENT,v_new_data.ASF_RESOLVE_CMPLT_INCIDENT,
	 v_new_data.RETURNED_DT,v_new_data.CREATED_BY_NAME,v_new_data.GENERIC_FIELD1,v_new_data.GENERIC_FIELD2,v_new_data.GENERIC_FIELD3,v_new_data.GENERIC_FIELD4,
	 v_new_data.GENERIC_FIELD5,v_new_data.ASF_IDENTIFY_RSRCH_INCIDENT,v_new_data.cancel_by,v_new_data.cancel_method,v_new_data.cancel_reason,
    v_new_data.ENROLLEE_RIN,	  	        
   v_new_data.REPORTER_NAME,		        
   v_new_data.COUNTY_CODE ,               
   v_new_data.COUNTY_NAME,                
   v_new_data.ACTION_COMMENTS ,            
   v_new_data.INCIDENT_DESCRIPTION ,       
   v_new_data.RESOLUTION_DESCRIPTION,
   v_new_data.CLIENT_ID
	);   
	
  UPD_FPIBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dpiis_id  ,v_dpiia_id  ,v_dpiir_id  ,/*v_dpiid_id  ,*/
         v_dpiiss_id ,v_dpijs_id  ,v_dpies_id  ,v_dpiub_id  ,v_dpiti_id  ,v_new_data.INCIDENT_STATUS_DT ,v_new_data.LAST_UPDATE_BY_DT ,v_new_data.stg_last_update_date,v_fpibd_id 
         );	
    
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
         
	
	