alter session set plsql_code_type = native;

create or replace package        CHIP_ELIG_EVENTS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ChipEligEvents/createdb/TXEB_CHIP_ELIG_EVENTS_pkg.sql $'; 
 SVN_REVISION varchar2(20) := '$Revision: 13366 $'; 
 SVN_REVISION_DATE varchar2(60) := '$Date: 2015-01-06 10:54:30 -0800 (Tue, 06 Jan 2015) $'; 
 SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

procedure CALC_DCEECUR;

function GET_AGE_IN_BUSINESS_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
  
function GET_AGE_IN_CALENDAR_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
	
function GET_JEOPARDY_DT
 (p_create_dt in date)
 return date;
  
function GET_JEOPARDY_DAYS return number result_cache;

function GET_JEOPARDY_DAYS_TYPE return varchar2 result_cache;

function GET_TIMELINESS_DAYS return number result_cache;

function GET_TIMELINESS_DAYS_TYPE return varchar2 result_cache;

function GET_JEOPARDY_FLAG
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2;
	
function GET_TIMELINESS_STATUS
(p_create_dt in date, 
 p_complete_dt in date,
 p_cancel_dt in date)
return varchar2;

function GET_TIMELINESS_DATE
(p_create_dt in date) 
return date;
 
type T_INS_CEE_XML is record
  (ASED_PROCESS_ELIG_EVENT	VARCHAR2(19),
   ASF_PROCESS_ELIG_EVENT	VARCHAR2(1),	
   ASPB_PROCESS_ELIG_EVENT VARCHAR2(100),
   ASSD_PROCESS_ELIG_EVENT	VARCHAR2(19),   
   CANCEL_BY	 VARCHAR2(80),
   CANCEL_DT	 VARCHAR2(19),
   CANCEL_METHOD	 VARCHAR2(40),
   CANCEL_REASON	 VARCHAR2(40),   
   CASE_CIN	 VARCHAR2(30),
   CASE_ID		 VARCHAR2(100),
   CASE_STATUS	 VARCHAR2(2),
   CLIENT_ID	 VARCHAR2(100),
   CLIENT_MED_ID	 VARCHAR2(30),
   COMPLETE_DT	 VARCHAR2(19),
   CREATE_BY_NAME	 VARCHAR2(100),
   CREATE_DT	 VARCHAR2(19),   
   EDG_SYS_TRA_ID	 VARCHAR2(100),
   ENROLL_STAT_DENTAL VARCHAR2(64),
   ENROLL_STAT_MED	 VARCHAR2(64),
   ENROLL_TRAN_TYPE VARCHAR2(30),
   ENR_SYS_TRA_ID	 VARCHAR2(100),
   ERR_INDICATOR	 VARCHAR2(1),
   EVENT_CD	 VARCHAR2(100),
   EVENT_ID	 VARCHAR2(100),
   FEE_STATUS VARCHAR2(10),
   INSTANCE_END_DATE VARCHAR2(19),
   INSTANCE_START_DATE VARCHAR2(19),
   INSTANCE_STATUS	 VARCHAR2(32), 
   JOB_ID		 VARCHAR2(100),
   LAST_EVENT_DATE   VARCHAR2(19),
   LETTER_REQ_ID	 VARCHAR2(100),
   LETTER_TYPE	 VARCHAR2(10),
   PERI_DEN_SEGMENT VARCHAR2(100),
   PRIOR_ENR_TRANS_SENT VARCHAR2(1),
   PROCESS_DT	 VARCHAR2(19),
   PROGRAM		 VARCHAR2(30),   
   SEGMENT_END_DT	 VARCHAR2(19),
   SEGMENT_ID	 VARCHAR2(100),
   SEGMENT_START_DT VARCHAR2(19),   
   STG_LAST_UPDATE_DATE VARCHAR2(19), 
   SYS_TRAN_STAGE_ID VARCHAR2(100),
   SYS_TRAN_STAGE_NAME VARCHAR2(50),
   SYS_TRA_ID	 VARCHAR2(100),
   TECEE_ID 	 VARCHAR2(100),   
   TIERS_SEND_DT	 VARCHAR2(19),
   TRAN_TYPE	 VARCHAR2(30),
   UPDATE_BY_NAME	 VARCHAR2(100),
   UPDATE_DT	 VARCHAR2(19) );
  
type T_UPD_CEE_XML is record
  (ASED_PROCESS_ELIG_EVENT	VARCHAR2(19),
   ASF_PROCESS_ELIG_EVENT	VARCHAR2(1),	
   ASPB_PROCESS_ELIG_EVENT VARCHAR2(100),
   ASSD_PROCESS_ELIG_EVENT	VARCHAR2(19),
   CANCEL_BY	 VARCHAR2(80),
   CANCEL_DT	 VARCHAR2(19),
   CANCEL_METHOD	 VARCHAR2(40),
   CANCEL_REASON	 VARCHAR2(40),   
   CASE_CIN	 VARCHAR2(30),
   CASE_ID		 VARCHAR2(100),
   CASE_STATUS	 VARCHAR2(2),
   CLIENT_ID	 VARCHAR2(100),
   CLIENT_MED_ID	 VARCHAR2(30),
   COMPLETE_DT	 VARCHAR2(19),
   CREATE_BY_NAME	 VARCHAR2(100),
   CREATE_DT	 VARCHAR2(19),   
   EDG_SYS_TRA_ID	 VARCHAR2(100),
   ENROLL_STAT_DENTAL VARCHAR2(64),
   ENROLL_STAT_MED	 VARCHAR2(64),
   ENROLL_TRAN_TYPE VARCHAR2(30),
   ENR_SYS_TRA_ID	 VARCHAR2(100),
   ERR_INDICATOR	 VARCHAR2(1),
   EVENT_CD	 VARCHAR2(100),
   EVENT_ID	 VARCHAR2(100),
   FEE_STATUS VARCHAR2(10),
   INSTANCE_END_DATE VARCHAR2(19),
   INSTANCE_START_DATE VARCHAR2(19),
   INSTANCE_STATUS	 VARCHAR2(32), 
   JOB_ID		 VARCHAR2(100),
   LAST_EVENT_DATE   VARCHAR2(19),
   LETTER_REQ_ID	 VARCHAR2(100),
   LETTER_TYPE	 VARCHAR2(10),
   PERI_DEN_SEGMENT VARCHAR2(100),
   PRIOR_ENR_TRANS_SENT VARCHAR2(1),
   PROCESS_DT	 VARCHAR2(19),
   PROGRAM		 VARCHAR2(30),   
   SEGMENT_END_DT	 VARCHAR2(19),
   SEGMENT_ID	 VARCHAR2(100),
   SEGMENT_START_DT VARCHAR2(19),   
   STG_LAST_UPDATE_DATE VARCHAR2(19), 
   SYS_TRAN_STAGE_ID VARCHAR2(100),
   SYS_TRAN_STAGE_NAME VARCHAR2(50),
   SYS_TRA_ID	 VARCHAR2(100),   
   TIERS_SEND_DT	 VARCHAR2(19),
   TRAN_TYPE	 VARCHAR2(30),
   UPDATE_BY_NAME	 VARCHAR2(100),
   UPDATE_DT	 VARCHAR2(19) );
  
procedure INSERT_BPM_SEMANTIC
  (p_data_version in number,
   p_new_data_xml in xmltype);
        
procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype);
end;
/

create or replace package body               CHIP_ELIG_EVENTS as

  v_bem_id number  := 30; -- 'NYHIX_ETL_DOC_NOTIFICATIONS'
  v_bil_id number  := 22;  -- 'Document Notification ID'
  v_bsl_id number  := 30; -- 'NYHIX_ETL_DOC_NOTIFICATIONS' --Check
  v_butl_id number := 1;  -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
    
  v_CALC_D_NYHX_DN_CR_job_nam varchar2(30) := 'CALC_DCEECUR';
  
function GET_AGE_IN_BUSINESS_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
end;
  
function GET_AGE_IN_CALENDAR_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
end; 
  
function GET_TIMELINESS_DAYS
 return number result_cache
as
 v_timeliness_days varchar2(2):=null;
begin
   begin
     select out_var 
      into v_timeliness_days
     from corp_etl_list_lkup
     where name='CEE_TIMELINESS_DAYS';
    exception
      when no_data_found then
        v_timeliness_days := null;
    end;
  return to_number(v_timeliness_days);
end;

function GET_TIMELINESS_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  begin
    select out_var 
    into v_days_type
    from corp_etl_list_lkup
    where name='CEE_TIMELINESS_DAYS_TYPE';
   exception
     when no_data_found then
        v_days_type := null;
    end;
  return v_days_type;
end;

function GET_JEOPARDY_DAYS
 return number result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
   begin
     select out_var 
     into v_jeopardy_days
     from corp_etl_list_lkup
     where name='CEE_JEOPARDY_DAYS';
   exception
     when no_data_found then
       v_jeopardy_days := null;
   end;
  return to_number(v_jeopardy_days);
end;

function GET_JEOPARDY_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  begin
    select out_var 
    into v_days_type
    from corp_etl_list_lkup
    where name='CEE_JEOPARDY_DAYS_TYPE';
  exception
    when no_data_found then
      v_days_type := null;
  end; 
 return v_days_type;
end;

function GET_TIMELINESS_STATUS
  (p_create_dt in date, 
   p_complete_dt in date,
   p_cancel_dt in date)
 return varchar2
as
 days_type varchar2(2):=null;
 timeliness_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_TIMELINESS_DAYS_TYPE();
  timeliness_days:=GET_TIMELINESS_DAYS();
  bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
  if (p_complete_dt is not null) then
    if (days_type='B') then
      if (bus_days<=timeliness_days)then
        return 'Timely';
      elsif (bus_days>=timeliness_days) then
        return 'Untimely';
      else
        return null;
      end if;
    elsif (days_type='C') then
      if (cal_days<timeliness_days) then
        return 'Timely';
      elsif (cal_days>=timeliness_days) then
        return 'Untimely';
      else
        return null;
      end if;
    else
     return null;
    end if;
  elsif (p_cancel_dt is not null) then
    return 'Not Required';
  elsif (p_complete_dt is null)
    then return 'Not Completed';
  else
    return null;
  end if;
end;
  
function GET_TIMELINESS_DATE
 (p_create_dt in date)
 return date
 as
 v_timeliness_days number := get_timeliness_days();
 v_timeliness date:=null;
 begin
  v_timeliness:= BPM_COMMON.GET_BUS_DATE(p_create_dt,v_timeliness_days);
 return v_timeliness;
 end;

function GET_JEOPARDY_FLAG
 (p_create_dt in date, 
  p_complete_dt in date)
return varchar2
as
 days_type varchar2(3):=null;
 jeopardy_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_JEOPARDY_DAYS_TYPE();
  jeopardy_days:=GET_JEOPARDY_DAYS();
  bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
  if(p_complete_dt is null) then
    if (days_type='B') then
      if (bus_days>=jeopardy_days) then
        return 'Y';
      else
        return 'N';
      end if;
    elsif (days_type='C') then
      if (cal_days>=jeopardy_days) then
        return 'Y';
      else
        return 'N';
      end if;
    else
      return null;
    end if;
  elsif (p_complete_dt is not null) then
    return 'NA';
  else
    return null;
  end if;
end;

function GET_JEOPARDY_DT
(p_create_dt in date)
return date
as
v_jeopardy_days number := get_jeopardy_days();
v_jeopardy date:=null;
begin
  v_jeopardy:=BPM_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days);
  return v_jeopardy;
end;
 
procedure CALC_DCEECUR
as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'CALC_DCEECUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

  update D_CEE_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COALESCE(COMPLETE_DATE,CANCEL_DATE)),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COALESCE(COMPLETE_DATE,CANCEL_DATE))
     -- TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DATE,COMPLETE_DATE,CANCEL_DATE),
     -- SLA_DAYS = GET_TIMELINESS_DAYS(),
     -- SLA_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
     -- TIMELINESS_DATE = GET_TIMELINESS_DATE(CREATE_DATE),
     -- JEOPARDY_FLAG = GET_JEOPARDY_FLAG(CREATE_DATE,COALESCE(COMPLETE_DATE,CANCEL_DATE)),
     -- SLA_JEOPARDY_DAYS = GET_JEOPARDY_DAYS(), 
     -- SLA_JEOPARDY_DAYS_TYPE = GET_JEOPARDY_DAYS_TYPE(),
     -- JEOPARDY_DATE = GET_JEOPARDY_DT(CREATE_DATE)
   where complete_date is null;
      
     v_num_rows_updated := sql%rowcount;
 
  commit;
 
    v_log_message := v_num_rows_updated  || ' D_CEE_CURRENT rows updated with calculated attributes by CALC_DCEECUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
 
  end; 
 
-- Get records for insert XML.
  procedure GET_INS_CEE_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_CEE_XML)
  as
      v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_INS_CEE_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
  select
	extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_ELIG_EVENT')"ASED_PROCESS_ELIG_EVENT",
	extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_ELIG_EVENT')"ASF_PROCESS_ELIG_EVENT",
	extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_ELIG_EVENT')"ASPB_PROCESS_ELIG_EVENT",
  extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_ELIG_EVENT')"ASSD_PROCESS_ELIG_EVENT",	 	
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",	
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN')"CASE_CIN",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID')"CASE_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_STATUS')"CASE_STATUS",	
  extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID')"CLIENT_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_MED_ID')"CLIENT_MED_ID",	  
	extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY_NAME')"CREATE_BY_NAME",	
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/EDG_SYS_TRA_ID')"EDG_SYS_TRA_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_STAT_DENTAL')"ENROLL_STAT_DENTAL",	
	extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_STAT_MED')"ENROLL_STAT_MED",
	extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_TRAN_TYPE')"ENROLL_TRAN_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/ENR_SYS_TRA_ID')"ENR_SYS_TRA_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ERR_INDICATOR')"ERR_INDICATOR",
	extractValue(p_data_xml,'/ROWSET/ROW/EVENT_CD')"EVENT_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/EVENT_ID')"EVENT_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/FEE_STATUS')"FEE_STATUS",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",	
	extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID')"JOB_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_ID')"LETTER_REQ_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/LETTER_TYPE')"LETTER_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/PERI_DEN_SEGMENT')"PERI_DEN_SEGMENT",
  extractValue(p_data_xml,'/ROWSET/ROW/PRIOR_ENR_TRANS_SENT')"PRIOR_ENR_TRANS_SENT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_DT')"PROCESS_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM')"PROGRAM",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_END_DT')"SEGMENT_END_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_ID')"SEGMENT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_START_DT')"SEGMENT_START_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRAN_STAGE_ID')"SYS_TRAN_STAGE_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRAN_STAGE_NAME')"SYS_TRAN_STAGE_NAME",
  extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRA_ID')"SYS_TRA_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/TECEE_ID')"TECEE_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/TIERS_SEND_DT')"TIERS_SEND_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/TRAN_TYPE')"TRAN_TYPE",
  extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_BY_NAME')"UPDATE_BY_NAME",	
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_DT')"UPDATE_DT"
   into p_data_record
  from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
-- Get records for update XML. 
  procedure GET_UPD_CEE_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_CEE_XML)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_UPD_CEE_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin   
  
  select
	extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_ELIG_EVENT')"ASED_PROCESS_ELIG_EVENT",
	extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_ELIG_EVENT')"ASF_PROCESS_ELIG_EVENT",
  extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_ELIG_EVENT')"ASPB_PROCESS_ELIG_EVENT",	 	
	extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_ELIG_EVENT')"ASSD_PROCESS_ELIG_EVENT",	 	
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",	
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN')"CASE_CIN",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID')"CASE_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/CASE_STATUS')"CASE_STATUS",	
  extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID')"CLIENT_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_MED_ID')"CLIENT_MED_ID",	  
	extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_BY_NAME')"CREATE_BY_NAME",	
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/EDG_SYS_TRA_ID')"EDG_SYS_TRA_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_STAT_DENTAL')"ENROLL_STAT_DENTAL",	
	extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_STAT_MED')"ENROLL_STAT_MED",
	extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_TRAN_TYPE')"ENROLL_TRAN_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/ENR_SYS_TRA_ID')"ENR_SYS_TRA_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ERR_INDICATOR')"ERR_INDICATOR",
	extractValue(p_data_xml,'/ROWSET/ROW/EVENT_CD')"EVENT_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/EVENT_ID')"EVENT_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/FEE_STATUS')"FEE_STATUS",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",	
	extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID')"JOB_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_ID')"LETTER_REQ_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/LETTER_TYPE')"LETTER_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/PERI_DEN_SEGMENT')"PERI_DEN_SEGMENT",
  extractValue(p_data_xml,'/ROWSET/ROW/PRIOR_ENR_TRANS_SENT')"PRIOR_ENR_TRANS_SENT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_DT')"PROCESS_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM')"PROGRAM",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_END_DT')"SEGMENT_END_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_ID')"SEGMENT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/SEGMENT_START_DT')"SEGMENT_START_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRAN_STAGE_ID')"SYS_TRAN_STAGE_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRAN_STAGE_NAME')"SYS_TRAN_STAGE_NAME",
	extractValue(p_data_xml,'/ROWSET/ROW/SYS_TRA_ID')"SYS_TRA_ID",	
  extractValue(p_data_xml,'/ROWSET/ROW/TIERS_SEND_DT')"TIERS_SEND_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/TRAN_TYPE')"TRAN_TYPE",
  extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_BY_NAME')"UPDATE_BY_NAME",	
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_DT')"UPDATE_DT"
   into p_data_record
  from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := v_procedure_name||' '||SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  

-- Insert history for BPM Semantic model - CHIP Elig Events. 
procedure INS_DCEEBD
    (p_identifier in varchar2,
     p_bucket_start_date in varchar2,
     p_bucket_end_date in varchar2,
     p_last_event_date in varchar2,
     p_bi_id in number,
     p_case_status in varchar2,
     p_enroll_stat_med in varchar2,
     p_enroll_stat_den in varchar2,
     p_fee_status in varchar2,
     p_dceebd_id out number)
  as  
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INS_DCEEBD';
     v_sql_code number := null;
     v_log_message clob := null;
     v_bucket_start_date date := null;
     v_bucket_end_date date := null;
     v_last_event_date date := null;
     v_case_status varchar2(64) := null;
     v_enroll_stat_med varchar2(64) := null;
     v_enroll_stat_den varchar2(64) := null;
     v_fee_status varchar2(10) := null;

  begin
     p_dceebd_id := SEQ_DCEEBD_ID.nextval;
     v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
     v_case_status := p_case_status;
     v_enroll_stat_med := p_enroll_stat_med;
     v_enroll_stat_den := p_enroll_stat_den;
     v_fee_status := p_fee_status;
     v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
     v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

     insert into D_CEE_HISTORY
        (DCEEBD_ID,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         CEEBI_ID,
         ENROLL_STAT_DENTAL, 
         ENROLL_STAT_MED, 
         CASE_STATUS,          
         LAST_EVENT_DATE,
         FEE_STATUS)
     values
      (p_dceebd_id,
       v_bucket_start_date,
       v_bucket_end_date,
       p_bi_id,
       v_enroll_stat_den,
       v_enroll_stat_med,
       v_case_status,       
       v_last_event_date,
       v_fee_status);

exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := v_procedure_name||' '||SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
  -- Insert or update dimension for BPM Semantic model -  Current.
procedure SET_D_CEE_CUR
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
   p_event_id	number	,
   p_event_cd	varchar2	,
   p_sys_tra_id	number	,
   p_tran_type	varchar2	,
   p_job_id	number	,
   p_case_id	number	,
   p_case_cin	varchar2	,
   p_client_id	number	,
   p_client_med_id	varchar2	,
   p_segment_start_date	varchar2	,
   p_segment_end_date	varchar2	,
   p_segment_id	number	,
   p_error_indicator	varchar2	,
   p_create_date	varchar2	,
   p_created_by_name	varchar2	,
   p_tiers_send_date	varchar2	,
   p_process_date	varchar2	,
   p_letter_type	varchar2	,
   p_letter_request_id	number	,
   p_program	varchar2	,
   p_peri_dental_segment	number	,
   p_enroll_stat_dental	varchar2	,
   p_enroll_stat_med	varchar2	,
   p_case_status	varchar2	,
   p_enroll_tran_type	varchar2	,
   p_enr_sys_tra_id	number	,
   p_edg_sys_tra_id	number	,
   p_instance_status	varchar2	,
   p_cancel_date	varchar2	,
   p_cancel_by	varchar2	,
   p_cancel_reason	varchar2	,
   p_cancel_method	varchar2	,
   p_complete_date	varchar2	,
   p_process_elig_event_start_dt	varchar2	,
   p_process_elig_event_end_dt	varchar2	,
   p_process_elig_event_flag	varchar2	,
   p_process_elig_event_by	varchar2	,
   p_prior_enr_trans_sent varchar2,
   p_update_by_name varchar2,
   p_update_date varchar2,
   p_instance_start_date	varchar2	,
   p_instance_end_date	varchar2	,
   p_last_event_date	varchar2	,
   p_stg_last_update_date	varchar2,
   p_sys_tran_stage_id number,
   p_sys_tran_stage_name varchar2,
   p_fee_status varchar2)
 as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'SET_D_CEE_CUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_d_cee_cur D_CEE_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(3) := null; 
  begin
    r_d_cee_cur.CEEBI_ID 	:=	p_bi_id	;
    r_d_cee_cur.EVENT_ID	:=	p_event_id	;
    r_d_cee_cur.EVENT_CD	:=	p_event_cd	;
    r_d_cee_cur.SYS_TRA_ID	:=	p_sys_tra_id	;
    r_d_cee_cur.SYS_TRAN_STAGE_ID	:=	p_sys_tran_stage_id	;
    r_d_cee_cur.SYS_TRAN_STAGE_NAME	:=	p_sys_tran_stage_name	;
    r_d_cee_cur.TRAN_TYPE	:=	p_tran_type	;
    r_d_cee_cur.JOB_ID	:=	p_job_id	;
    r_d_cee_cur.CASE_ID	:=	p_case_id	;
    r_d_cee_cur.CASE_CIN	:=	p_case_cin	;
    r_d_cee_cur.CLIENT_ID	:=	p_client_id	;
    r_d_cee_cur.CLIENT_MED_ID	:=	p_client_med_id	;
    r_d_cee_cur.SEGMENT_START_DATE 	:=	to_date(p_segment_start_date,BPM_COMMON.DATE_FMT);
    r_d_cee_cur.SEGMENT_END_DATE	:=	to_date(p_segment_end_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.SEGMENT_ID	:=	p_segment_id	;
    r_d_cee_cur.ERROR_INDICATOR	:=	p_error_indicator	;
    r_d_cee_cur.CREATE_DATE	:=	to_date(p_create_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.CREATED_BY_NAME	:=	p_created_by_name	;
    r_d_cee_cur.TIERS_SEND_DATE	:=	to_date(p_tiers_send_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.PROCESS_DATE	:=	to_date(p_process_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.LETTER_TYPE	:=	p_letter_type	;
    r_d_cee_cur.LETTER_REQUEST_ID	:=	p_letter_request_id	;
    r_d_cee_cur.PROGRAM	:=	p_program	;
    r_d_cee_cur.PERI_DENTAL_SEGMENT	:=	p_peri_dental_segment	;
    r_d_cee_cur.CURR_ENROLL_STAT_DENTAL	:=	p_enroll_stat_dental	;
    r_d_cee_cur.CURR_ENROLL_STAT_MED	:=	p_enroll_stat_med	;
    r_d_cee_cur.CURR_CASE_STATUS	:=	p_case_status	;
    r_d_cee_cur.ENROLL_TRAN_TYPE 	:=	p_enroll_tran_type	;
    r_d_cee_cur.ENR_SYS_TRA_ID	:=	p_enr_sys_tra_id	;
    r_d_cee_cur.EDG_SYS_TRA_ID	:=	p_edg_sys_tra_id	;
    r_d_cee_cur.INSTANCE_STATUS	:=	p_instance_status	;
    r_d_cee_cur.CANCEL_DATE	:=	to_date(p_cancel_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.CANCEL_BY	:=	p_cancel_by	;
    r_d_cee_cur.CANCEL_REASON	:=	p_cancel_reason	;
    r_d_cee_cur.CANCEL_METHOD	:=	p_cancel_method	;
    r_d_cee_cur.COMPLETE_DATE	:=	to_date(p_complete_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.PROCESS_ELIG_EVENT_START_DATE	:=	to_date(p_process_elig_event_start_dt,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.PROCESS_ELIG_EVENT_END_DATE	:=	to_date(p_process_elig_event_end_dt,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.PROCESS_ELIG_EVENT_FLAG	:=	p_process_elig_event_flag	;
    r_d_cee_cur.PROCESS_ELIG_EVENT_BY	:=	p_process_elig_event_by	;
    r_d_cee_cur.PRIOR_ENR_TRANS_SENT	:=	p_prior_enr_trans_sent	;
    r_d_cee_cur.INSTANCE_START_DATE  	:=	to_date(p_instance_start_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.INSTANCE_END_DATE   	:=	to_date(p_instance_end_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.LAST_EVENT_DATE	:=	to_date(p_last_event_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.STG_LAST_UPDATE_DATE	:=	to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    r_d_cee_cur.UPDATE_DATE	:=	to_date(p_update_date,BPM_COMMON.DATE_FMT); 
    r_d_cee_cur.UPDATE_BY_NAME	:=	p_update_by_name	;
    r_d_cee_cur.AGE_IN_BUSINESS_DAYS	:=	GET_AGE_IN_BUSINESS_DAYS(to_date(p_create_date,BPM_COMMON.DATE_FMT),COALESCE(to_date(p_complete_date,BPM_COMMON.DATE_FMT),to_date(p_cancel_date,BPM_COMMON.DATE_FMT)))	;
    r_d_cee_cur.AGE_IN_CALENDAR_DAYS	:=	GET_AGE_IN_CALENDAR_DAYS(to_date(p_create_date,BPM_COMMON.DATE_FMT),COALESCE(to_date(p_complete_date,BPM_COMMON.DATE_FMT),to_date(p_cancel_date,BPM_COMMON.DATE_FMT)))	;
    r_d_cee_cur.STATUS_AGE_IN_BUSINESS_DAYS 	:=	null	;
    r_d_cee_cur.STATUS_AGE_IN_CALENDAR_DAYS	:=	null	;
    r_d_cee_cur.TIMELINESS_STATUS   	:=	null	;
    r_d_cee_cur.SLA_DAYS 	:=	null	;
    r_d_cee_cur.SLA_DAYS_TYPE 	:=	null	;
    r_d_cee_cur.TIMELINESS_DATE  	:=	null	;
    r_d_cee_cur.JEOPARDY_FLAG 	:=	null	;
    r_d_cee_cur.JEOPARDY_DATE 	:=	null	;
    r_d_cee_cur.SLA_JEOPARDY_DAYS   	:=	null	;
    r_d_cee_cur.SLA_JEOPARDY_DAYS_TYPE 	:=	null	;
    r_d_cee_cur.FEE_STATUS 	:=	p_fee_status	;
    

  if p_set_type = 'INSERT' then
      insert into D_CEE_CURRENT
      values r_d_cee_cur;
    
    elsif p_set_type = 'UPDATE' then
      begin
        update D_CEE_CURRENT
        set row = r_d_cee_cur
        where CEEBI_ID = p_bi_id;
      end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
      
  exception
    
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := v_procedure_name||' '||SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
end;
  
  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data T_INS_CEE_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_dceebd_id number := null;
    v_last_event_date date := null;
  begin
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Chip Elig Events in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
    
    GET_INS_CEE_XML(p_new_data_xml,v_new_data);    
    v_identifier := v_new_data.EVENT_ID;
    v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_BI_ID.nextval;   
    v_last_event_date := to_date(v_new_data.last_event_date,BPM_COMMON.DATE_FMT);
    
-- Insert current dimension and history as a single transaction.            
begin
  commit;
    
 SET_D_CEE_CUR
  ('INSERT',
   v_identifier,
   v_bi_id,
   v_new_data.event_id	,
   v_new_data.event_cd	,
   v_new_data.sys_tra_id	,
   v_new_data.tran_type	,
   v_new_data.job_id	,
   v_new_data.case_id	,
   v_new_data.case_cin	,
   v_new_data.client_id	,
   v_new_data.client_med_id	,
   v_new_data.segment_start_dt	,
   v_new_data.segment_end_dt	,
   v_new_data.segment_id	,
   v_new_data.err_indicator	,
   v_new_data.create_dt	,
   v_new_data.create_by_name	,
   v_new_data.tiers_send_dt	,
   v_new_data.process_dt	,
   v_new_data.letter_type	,
   v_new_data.letter_req_id	,
   v_new_data.program	,
   v_new_data.peri_den_segment	,
   v_new_data.enroll_stat_dental	,
   v_new_data.enroll_stat_med	,
   v_new_data.case_status	,
   v_new_data.enroll_tran_type	,
   v_new_data.enr_sys_tra_id	,
   v_new_data.edg_sys_tra_id	,
   v_new_data.instance_status	,
   v_new_data.cancel_dt	,
   v_new_data.cancel_by	,
   v_new_data.cancel_reason	,
   v_new_data.cancel_method	,
   v_new_data.complete_dt	,
   v_new_data.assd_process_elig_event	,
   v_new_data.ased_process_elig_event	,
   v_new_data.asf_process_elig_event	,
   v_new_data.aspb_process_elig_event	,
   v_new_data.prior_enr_trans_sent	,
   v_new_data.update_by_name	,
   v_new_data.update_dt	,
   v_new_data.instance_start_date	,
   v_new_data.instance_end_date	,
   v_new_data.last_event_date	,
   v_new_data.stg_last_update_date,
   v_new_data.sys_tran_stage_id,
   v_new_data.sys_tran_stage_name,
   v_new_data.fee_status);
    
 INS_DCEEBD
   (v_identifier,
    v_bucket_start_date,
    v_bucket_end_date,
    v_new_data.last_event_date,
    v_bi_id,
    v_new_data.case_status,
    v_new_data.enroll_stat_med,
    v_new_data.enroll_stat_dental,
    v_new_data.fee_status,
    v_dceebd_id);

 

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
    v_log_message := v_procedure_name||' '||SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
 raise; 
      
end;
 
-- Update fact for BPM Semantic model . 
procedure UPD_DCEEBD
  (p_identifier in varchar2,
   p_bucket_start_date in varchar2,
   p_bucket_end_date in varchar2,
   p_last_event_date in varchar2,
   p_bi_id in number,
   p_case_status in varchar2,
   p_enroll_stat_med in varchar2,
   p_enroll_stat_den in varchar2,
   p_fee_status in varchar2,
   p_dceebd_id out number)
        
   
  as
   v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'UPD_DDNBD';
   v_sql_code number := null;
   v_log_message clob := null; 
   v_identifier varchar2(256) := null;
   v_bi_id number := null;
   --v_CEEBI_ID_old number := null;      
   v_max_last_event_date date :=null;
   v_last_event_date date := null;      
   v_last_event_date_current date := null;
   v_LAST_EVENT_DATE_old date := null;
   v_dceebd_id number := null;
   v_dceebd_id_old number := null;
   v_max_dceebd_id date := null;   
   v_bucket_start_date_old date := null;
   v_bucket_end_date_old date := null;
   v_case_status varchar2(64) := null;
   v_case_status_old varchar2(64) := null;
   v_enroll_stat_med varchar2(64) := null;
   v_enroll_stat_med_old varchar2(64) := null;
   v_enroll_stat_den varchar2(64) := null;
   v_enroll_stat_den_old varchar2(64) := null;
   v_fee_status varchar2(10) := null;
   v_fee_status_old varchar2(10) := null;
   
   r_DCEEBD D_CEE_HISTORY%rowtype := null;
    
  begin 

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_dceebd_id  := p_dceebd_id;
   v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
   v_case_status := p_case_status;
   v_enroll_stat_med := p_enroll_stat_med;
   v_enroll_stat_den := p_enroll_stat_den;
   v_fee_status := p_fee_status;

  with most_recent_fact_bi_id as (   
   select 
    max(dceebd_id) max_dceebd_id,
    max(LAST_EVENT_DATE) MAX_LAST_EVENT_DATE
   from D_CEE_HISTORY
  where CEEBI_ID = p_bi_id)
   select 
    most_recent_fact_bi_id.max_dceebd_id,
    most_recent_fact_bi_id.MAX_LAST_EVENT_DATE,
    h.BUCKET_START_DATE,
    h.BUCKET_END_DATE,
    h.case_status,
    h.enroll_stat_med,
    h.enroll_stat_dental,
    h.fee_status
   into 
    v_dceebd_id_old,
    v_LAST_EVENT_DATE_old,
    v_bucket_start_date_old,
    v_bucket_end_date_old,
    v_case_status_old,
    v_enroll_stat_med_old,
    v_enroll_stat_den_old,
    v_fee_status_old
   from D_CEE_HISTORY h,most_recent_fact_bi_id
   where h.dceebd_id = max_dceebd_id and h.LAST_EVENT_DATE = MAX_LAST_EVENT_DATE;
   
   select LAST_EVENT_DATE
    into
    V_LAST_EVENT_DATE_CURRENT
   from D_CEE_HISTORY
   where dceebd_id = v_dceebd_id_old;
   
--Validate last_event_date with specific DCEEBD_ID   
   if(v_LAST_EVENT_DATE_old != v_last_event_date_current) then
        v_sql_code := -20030;
        v_log_message := 'MAX(LAST_EVENT_DATE) is not equal to the LAST_EVENT_DATE of MAX(DCEEBD_ID). ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt) || 'MAX(DCEEBD_ID) = '||v_dceebd_id_old;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

  
-- Continues updates
--If same day update then set the bucket start date to minimum date and bucket end date to max date
   if trunc(v_last_event_date) = trunc(v_last_event_date_old)  and v_bucket_start_date_old = to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt) then 
       r_DCEEBD.BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   elsif trunc(v_last_event_date) = trunc(v_last_event_date_old) and v_bucket_start_date_old != to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt)  then
       r_DCEEBD.BUCKET_START_DATE := v_bucket_start_date_old;
   elsif trunc(v_last_event_date) > trunc(v_last_event_date_old) then
       r_DCEEBD.BUCKET_START_DATE := trunc(v_last_event_date);
   end if;
   
   r_DCEEBD.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   p_dceebd_id := SEQ_DCEEBD_ID.nextval;
   r_DCEEBD.dceebd_id := p_dceebd_id;
   r_DCEEBD.CEEBI_ID := p_bi_id;
   r_DCEEBD.last_event_date := v_last_event_date;
   r_DCEEBD.case_status := v_case_status;
   r_DCEEBD.enroll_stat_med := v_enroll_stat_med;
   r_DCEEBD.enroll_stat_dental := v_enroll_stat_den;
   r_DCEEBD.fee_status := v_fee_status;

	
     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and 
        (v_case_status_old <> r_DCEEBD.case_status or v_enroll_stat_med_old <> r_DCEEBD.enroll_stat_med or v_enroll_stat_den_old <> r_DCEEBD.enroll_stat_dental) then
        
        update D_CEE_HISTORY
        set BUCKET_END_DATE = trunc(v_last_event_date) - 1
        where dceebd_id = v_dceebd_id_old;
     
         insert into D_CEE_HISTORY
         values r_DCEEBD;
	
     end if;
    
     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and 
      (v_case_status_old <> r_DCEEBD.case_status or v_enroll_stat_med_old <> r_DCEEBD.enroll_stat_med or v_enroll_stat_den_old <> r_DCEEBD.enroll_stat_dental) then
         
        update D_CEE_HISTORY
        set row = r_DCEEBD
        where dceebd_id = v_dceebd_id_old;
        
     end if;
    
--validate LAST EVENT DATE 
     if trunc(v_last_event_date) < trunc(v_last_event_date_old) then
        v_sql_code := -20030;
        v_log_message := 'Attempted to insert invalid date range.  ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt);
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
	
     -- Validate fact date ranges.
    if r_DCEEBD.BUCKET_START_DATE > r_DCEEBD.BUCKET_END_DATE
      or r_DCEEBD.BUCKET_END_DATE < r_DCEEBD.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid date range.  ' || 
        ' BUCKET_START_DATE = ' || to_char(r_DCEEBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DCEEBD.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM || 
        ' BUCKET_START_DATE = ' || to_char(r_DCEEBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DCEEBD.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
    raise; 	     
       
  end; 

-- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
    v_old_data T_UPD_CEE_XML := null;
    v_new_data T_UPD_CEE_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null; 
    v_dceebd_id number := null;
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for CHIP Elig Events procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_CEE_XML(p_old_data_xml,v_old_data);
    GET_UPD_CEE_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.EVENT_ID;
    v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
	
    select CEEBI_ID 
    into v_bi_id
    from D_CEE_CURRENT
    where event_id = v_identifier;
      

-- Update current dimension and fact as a single transaction.
  begin
 commit;
 
 SET_D_CEE_CUR
  ('UPDATE',
   v_identifier,
   v_bi_id,
   v_new_data.event_id	,
   v_new_data.event_cd	,
   v_new_data.sys_tra_id	,
   v_new_data.tran_type	,
   v_new_data.job_id	,
   v_new_data.case_id	,
   v_new_data.case_cin	,
   v_new_data.client_id	,
   v_new_data.client_med_id	,
   v_new_data.segment_start_dt	,
   v_new_data.segment_end_dt	,
   v_new_data.segment_id	,
   v_new_data.err_indicator	,
   v_new_data.create_dt	,
   v_new_data.create_by_name	,
   v_new_data.tiers_send_dt	,
   v_new_data.process_dt	,
   v_new_data.letter_type	,
   v_new_data.letter_req_id	,
   v_new_data.program	,
   v_new_data.peri_den_segment	,
   v_new_data.enroll_stat_dental	,
   v_new_data.enroll_stat_med	,
   v_new_data.case_status	,
   v_new_data.enroll_tran_type	,
   v_new_data.enr_sys_tra_id	,
   v_new_data.edg_sys_tra_id	,
   v_new_data.instance_status	,
   v_new_data.cancel_dt	,
   v_new_data.cancel_by	,
   v_new_data.cancel_reason	,
   v_new_data.cancel_method	,
   v_new_data.complete_dt	,
   v_new_data.assd_process_elig_event	,
   v_new_data.ased_process_elig_event	,
   v_new_data.asf_process_elig_event	,
   v_new_data.aspb_process_elig_event	,
   v_new_data.prior_enr_trans_sent	,
   v_new_data.update_by_name	,
   v_new_data.update_dt	,
   v_new_data.instance_start_date	,
   v_new_data.instance_end_date	,
   v_new_data.last_event_date	,
   v_new_data.stg_last_update_date,
   v_new_data.sys_tran_stage_id,
   v_new_data.sys_tran_stage_name,
   v_new_data.fee_status);
        
 UPD_DCEEBD
   (v_identifier,
    v_bucket_start_date,
    v_bucket_end_date,
    v_new_data.last_event_date,
    v_bi_id,
    v_new_data.case_status,
    v_new_data.enroll_stat_med,
    v_new_data.enroll_stat_dental,
    v_new_data.fee_status,
    v_dceebd_id);
      
 commit;
            
  exception
   when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM || 
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
  end;
      
  exception
   when NO_DATA_FOUND then
    v_sql_code := SQLCODE;
    v_log_message := 'No BPM_INSTANCE found.'|| SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
  raise; 
        
   when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
 
  end;

end;
/

alter session set plsql_code_type = interpreted;

-- NOTE:BPM_COMMON in TX is not updated - check if it is ok to deploy BPM_COMMON or if it will cause issues.  Modified currently in AST to have the min/max GDATES available