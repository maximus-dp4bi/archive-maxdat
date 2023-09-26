alter session set plsql_code_type = native;

create or replace package        NYHIX_DOC_NOTIFICATIONS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 SVN_FILE_URL varchar2(200) := '$URL$'; 
 SVN_REVISION varchar2(20) := '$Revision$'; 
 SVN_REVISION_DATE varchar2(60) := '$Date$'; 
 SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

procedure CALC_D_NYHIX_DN_CUR;

function GET_AGE_IN_BUSINESS_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number parallel_enable;
  
function GET_AGE_IN_CALENDAR_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number parallel_enable;
	
function GET_JEOPARDY_DT
 (p_create_dt in date)
 return date parallel_enable;

function GET_TARGET_DAYS return number parallel_enable result_cache;
    
function GET_JEOPARDY_DAYS return number parallel_enable result_cache;

function GET_JEOPARDY_DAYS_TYPE return varchar2 parallel_enable result_cache;

function GET_TIMELINESS_DAYS return number parallel_enable result_cache;

function GET_TIMELINESS_DAYS_TYPE return varchar2 parallel_enable result_cache;

function GET_JEOPARDY_FLAG
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2 parallel_enable;
	
function GET_TIMELINESS_STATUS
(p_create_dt in date, 
 p_complete_dt in date,
 p_cancel_dt in date)
return varchar2 parallel_enable;

function GET_TIMELINESS_DT
(p_create_dt in date) 
return date parallel_enable;
 
type T_INS_DN_XML is record
  (ACCOUNT_ID	VARCHAR2(100),
   ACTION_TYPE  VARCHAR2(64),
   ASED_PROCESS_DN	VARCHAR2(19),
   ASF_VERIFY_DN	VARCHAR2(1),
   ASSD_PROCESS_DN	VARCHAR2(19),
   CANCEL_BY	VARCHAR2(100),
   CANCEL_BY_ID	VARCHAR2(32),
   CANCEL_DT	VARCHAR2(19),
   CANCEL_METHOD	VARCHAR2(32),
   CANCEL_REASON	VARCHAR2(100),
   CHANNEL	VARCHAR2(100),
   COMPLETE_DT	VARCHAR2(19),
   CREATED_BY	VARCHAR2(100),
   CREATED_BY_ID	VARCHAR2(32),
   CREATE_DT	VARCHAR2(19),
   DESCRIPTION	VARCHAR2(512),
   DOC_NOTIFICATION_ID	VARCHAR2(100),
   EDNDB_ID	VARCHAR2(100),
   ERROR_CD	VARCHAR2(256),
   HXID	VARCHAR2(64),
   HX_ACCOUNT_ID	VARCHAR2(64),
   INSTANCE_END_DATE	VARCHAR2(19),
   INSTANCE_START_DATE	VARCHAR2(19),
   INSTANCE_STATUS	VARCHAR2(32),   
   KOFAX_DCN	VARCHAR2(256),
   LAST_EVENT_DATE	VARCHAR2(19),
   NOTIFICATION_DT	VARCHAR2(64),
   PROCESSED_IND	VARCHAR2(1),
   PROCESS_INSTANCE_ID	VARCHAR2(100),
   STAGE_DONE_DATE	VARCHAR2(19),
   STATUS	VARCHAR2(64),
   STATUS_CD	VARCHAR2(64),
   STG_EXTRACT_DATE	VARCHAR2(19),
   STG_LAST_UPDATE_DATE	VARCHAR2(19),
   UPDATED_BY	VARCHAR2(100),
   UPDATED_BY_ID	VARCHAR2(32),
   UPDATE_DT	VARCHAR2(19));
  
type T_UPD_DN_XML is record
  (ACCOUNT_ID	VARCHAR2(100),
   ACTION_TYPE  VARCHAR2(64),
   ASED_PROCESS_DN	VARCHAR2(19),
   ASF_VERIFY_DN	VARCHAR2(1),
   ASSD_PROCESS_DN	VARCHAR2(19),
   CANCEL_BY	VARCHAR2(100),
   CANCEL_BY_ID	VARCHAR2(32),
   CANCEL_DT	VARCHAR2(19),
   CANCEL_METHOD	VARCHAR2(32),
   CANCEL_REASON	VARCHAR2(100),
   CHANNEL	VARCHAR2(100),
   COMPLETE_DT	VARCHAR2(19),
   CREATED_BY	VARCHAR2(100),
   CREATED_BY_ID	VARCHAR2(32),
   CREATE_DT	VARCHAR2(19),
   DESCRIPTION	VARCHAR2(512),
   DOC_NOTIFICATION_ID	VARCHAR2(100),
   EDNDB_ID	VARCHAR2(100),
   ERROR_CD	VARCHAR2(256),
   HXID	VARCHAR2(64),
   HX_ACCOUNT_ID	VARCHAR2(64),
   INSTANCE_END_DATE	VARCHAR2(19),
   INSTANCE_START_DATE	VARCHAR2(19),
   INSTANCE_STATUS	VARCHAR2(32),   
   KOFAX_DCN	VARCHAR2(256),
   LAST_EVENT_DATE	VARCHAR2(19),
   NOTIFICATION_DT	VARCHAR2(64),
   PROCESSED_IND	VARCHAR2(1),
   PROCESS_INSTANCE_ID	VARCHAR2(100),
   STAGE_DONE_DATE	VARCHAR2(19),
   STATUS	VARCHAR2(64),
   STATUS_CD	VARCHAR2(64),
   STG_EXTRACT_DATE	VARCHAR2(19),
   STG_LAST_UPDATE_DATE	VARCHAR2(19),
   UPDATED_BY	VARCHAR2(100),
   UPDATED_BY_ID	VARCHAR2(32),
   UPDATE_DT	VARCHAR2(19));
  
procedure INSERT_BPM_SEMANTIC
  (p_data_version in number,
   p_new_data_xml in xmltype);
        
procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype);
end;
/

create or replace package body               NYHIX_DOC_NOTIFICATIONS as

  v_bem_id number  := 30; -- 'NYHIX_ETL_DOC_NOTIFICATIONS'
  v_bil_id number  := 22;  -- 'Document Notification ID'
  v_bsl_id number  := 30; -- 'NYHIX_ETL_DOC_NOTIFICATIONS' --Check
  v_butl_id number := 1;  -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
    
  v_CALC_D_NYHX_DN_CR_job_nam varchar2(30) := 'CALC_D_NYHIX_DN_CUR';
  
function GET_AGE_IN_BUSINESS_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number parallel_enable
as
begin
  return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
end;
  
function GET_AGE_IN_CALENDAR_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number parallel_enable
as
begin
  return trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
end; 
  
function GET_TIMELINESS_DAYS
 return number parallel_enable result_cache
as
 v_timeliness_days varchar2(2):=null;
begin
   select out_var 
    into v_timeliness_days
   from corp_etl_list_lkup
   where name='DN_TIMELINESS_DAYS';
  return to_number(v_timeliness_days);
end;

function GET_TIMELINESS_DAYS_TYPE
 return varchar2 parallel_enable result_cache
as
 v_days_type varchar2(2):=null;
begin
   select out_var 
    into v_days_type
   from corp_etl_list_lkup
   where name='DN_TIMELINESS_DAYS_TYPE';
  return v_days_type;
end;

function GET_JEOPARDY_DAYS
 return number parallel_enable result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
   select out_var 
    into v_jeopardy_days
   from corp_etl_list_lkup
   where name='DN_JEOPARDY_DAYS';
  return to_number(v_jeopardy_days);
end;

function GET_JEOPARDY_DAYS_TYPE
 return varchar2 parallel_enable result_cache
as
 v_days_type varchar2(2):=null;
begin
  select out_var 
  into v_days_type
  from corp_etl_list_lkup
  where name='DN_JEOPARDY_DAYS_TYPE';
 return v_days_type;
end;

function GET_TARGET_DAYS
 return number parallel_enable result_cache
as
 v_target_days varchar2(2):=null;
begin
  select out_var 
  into v_target_days
  from corp_etl_list_lkup
  where name='DN_TARGET_DAYS';
 return to_number(v_target_days);
end;

function GET_TIMELINESS_STATUS
  (p_create_dt in date, 
   p_complete_dt in date,
   p_cancel_dt in date)
 return varchar2 parallel_enable
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
   if (bus_days<=timeliness_days)
    then return 'Timely';
   elsif (bus_days>=timeliness_days)
    then return 'Untimely';
   else
    return null;
   end if;
 elsif (days_type='C') then
  if (cal_days<timeliness_days)
    then return 'Timely';
  elsif (cal_days>=timeliness_days)
    then return 'Untimely';
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
  
function GET_TIMELINESS_DT
 (p_create_dt in date)
 return date parallel_enable
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
return varchar2 parallel_enable
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
return date parallel_enable
as
v_jeopardy_days number := get_jeopardy_days();
v_jeopardy date:=null;
begin
    v_jeopardy:=BPM_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days);
  return v_jeopardy;
end;
 
procedure CALC_D_NYHIX_DN_CUR
as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'CALC_D_NYHIX_DN_CUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

  update D_NYHIX_DOC_NOTIF_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COALESCE(COMPLETE_DT,CANCEL_DT)),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DT,COALESCE(COMPLETE_DT,CANCEL_DT)),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT,CANCEL_DT),
      TIMELINESS_DAYS = GET_TIMELINESS_DAYS(),
      TIMELINESS_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
      TIMELINESS_DATE = GET_TIMELINESS_DT(CREATE_DT),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(CREATE_DT,COALESCE(COMPLETE_DT,CANCEL_DT)),
      JEOPARDY_DAYS = GET_JEOPARDY_DAYS(), 
      JEOPARDY_DAYS_TYPE = GET_JEOPARDY_DAYS_TYPE(),
      JEOPARDY_DATE = GET_JEOPARDY_DT(CREATE_DT),
      TARGET_DAYS = GET_TARGET_DAYS()
	  where instance_status = 'Active';
      
     v_num_rows_updated := sql%rowcount;
 
  commit;
 
    v_log_message := v_num_rows_updated  || ' D_NYHIX_DN_CURRENT rows updated with calculated attributes by CALC_D_NYHIX_DN_CUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
 
  end; 
 
-- Get record for NYHIX Mail Fax Doc Notif insert XML.
  procedure GET_INS_DN_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_DN_XML)
  as
      v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_INS_DN_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
  select
	extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID')"ACCOUNT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE')"ACTION_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_DN')"ASED_PROCESS_DN",
	extractValue(p_data_xml,'/ROWSET/ROW/ASF_VERIFY_DN')"ASF_VERIFY_DN",	 
	extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_DN')"ASSD_PROCESS_DN",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY_ID')"CANCEL_BY_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
	extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
	extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY')"CREATED_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_ID')"CREATED_BY_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/DESCRIPTION')"DESCRIPTION",
	extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_ID')"DOC_NOTIFICATION_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/EDNDB_ID')"EDNDB_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ERROR_CD')"ERROR_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/HXID')"HXID",
	extractValue(p_data_xml,'/ROWSET/ROW/HX_ACCOUNT_ID')"HX_ACCOUNT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",	
	extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
	extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/NOTIFICATION_DT')"NOTIFICATION_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESSED_IND')"PROCESSED_IND",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_INSTANCE_ID')"PROCESS_INSTANCE_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE')"STAGE_DONE_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/STATUS')"STATUS",
	extractValue(p_data_xml,'/ROWSET/ROW/STATUS_CD')"STATUS_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE')"STG_EXTRACT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY')"UPDATED_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY_ID')"UPDATED_BY_ID",
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
  
-- Get record for NYHIX Mail Fax Doc Notification update XML. 
  procedure GET_UPD_DN_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_DN_XML)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_UPD_DN_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin   
  
  select
  
	extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID')"ACCOUNT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE')"ACTION_TYPE",
	extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_DN')"ASED_PROCESS_DN",
	extractValue(p_data_xml,'/ROWSET/ROW/ASF_VERIFY_DN')"ASF_VERIFY_DN",	 
	extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_DN')"ASSD_PROCESS_DN",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY_ID')"CANCEL_BY_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
	extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
	extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
	extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY')"CREATED_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_ID')"CREATED_BY_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/DESCRIPTION')"DESCRIPTION",
	extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_ID')"DOC_NOTIFICATION_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/EDNDB_ID')"EDNDB_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/ERROR_CD')"ERROR_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/HXID')"HXID",
	extractValue(p_data_xml,'/ROWSET/ROW/HX_ACCOUNT_ID')"HX_ACCOUNT_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",	
	extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
	extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/NOTIFICATION_DT')"NOTIFICATION_DT",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESSED_IND')"PROCESSED_IND",
	extractValue(p_data_xml,'/ROWSET/ROW/PROCESS_INSTANCE_ID')"PROCESS_INSTANCE_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE')"STAGE_DONE_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/STATUS')"STATUS",
	extractValue(p_data_xml,'/ROWSET/ROW/STATUS_CD')"STATUS_CD",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE')"STG_EXTRACT_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY')"UPDATED_BY",
	extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY_ID')"UPDATED_BY_ID",
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

-- Insert fact for BPM Semantic model - Process Mail Fax Doc process. 
procedure INS_DDNBD
    (p_identifier in varchar2,
     p_bucket_start_date in varchar2,
     p_bucket_end_date in varchar2,
     p_last_event_date in varchar2,
     p_bi_id in number,
     p_status_cd in varchar2,
     p_status in varchar2,
     p_ddnbd_id out number)
  as  
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INS_DDNBD';
     v_sql_code number := null;
     v_log_message clob := null;
     v_bucket_start_date date := null;
     v_bucket_end_date date := null;
     v_last_event_date date := null;
     v_status_cd varchar2(64) := null;
     v_status varchar2(64) := null;

  begin
     p_ddnbd_id := SEQ_DDNBD_id.nextval;
     v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
     v_status_cd := p_status_cd;
     v_status := p_status;
     v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
     v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

insert into D_NYHIX_DOC_NOTIF_HISTORY
  (DDNBD_ID,
   NYHIX_DN_BI_ID,
   STATUS_CD,
   STATUS,
   BUCKET_START_DATE,
   BUCKET_END_DATE,
   LAST_EVENT_DATE)
values
  (p_ddnbd_id,
   p_bi_id,
   p_status_cd,
   p_status,
   v_bucket_start_date,
   v_bucket_end_date,
   v_last_event_date);

exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
  -- Insert or update dimension for BPM Semantic model - Process Mail Fax Doc process - Current.
procedure SET_D_NYHIX_DN_CUR
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
   p_account_id	number,
   p_action_type	varchar2,
   p_ased_process_dn	varchar2,
   p_asf_verify_dn	varchar2,
   p_assd_process_dn	varchar2,
   p_cancel_by	varchar2,
   p_cancel_by_id	varchar2,
   p_cancel_dt	varchar2,
   p_cancel_method	varchar2,
   p_cancel_reason	varchar2,
   p_channel	varchar2,
   p_complete_dt	varchar2,
   p_created_by	varchar2,
   p_created_by_id	varchar2,
   p_create_dt	varchar2,
   p_description	varchar2,
   p_doc_notification_id	number,
   p_edndb_id	number,
   p_error_cd	varchar2,
   p_hxid	varchar2,
   p_hx_account_id	varchar2,
   p_instance_end_date	varchar2,
   p_instance_start_date	varchar2,
   p_instance_status	varchar2,   
   p_kofax_dcn	varchar2,
   p_last_event_date	varchar2,
   p_notification_dt	varchar2,
   p_processed_ind	varchar2,
   p_process_instance_id	number,
   p_stage_done_date	varchar2,
   p_status	varchar2,
   p_status_cd	varchar2,
   p_stg_extract_date	varchar2,
   p_stg_last_update_date	varchar2,
   p_updated_by	varchar2,
   p_updated_by_id	varchar2,
   p_update_dt	varchar2)
 as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'SET_D_NYHIX_DN_CUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_d_nyhix_dn_cur D_NYHIX_DOC_NOTIF_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(3) := null; 
  begin
    r_d_nyhix_dn_cur.NYHIX_DN_BI_ID := p_bi_id;
    r_d_nyhix_dn_cur.ACCOUNT_ID:= p_account_id;
	r_d_nyhix_dn_cur.ASED_PROCESS_DN := to_date(p_ased_process_dn,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.ASF_VERIFY_DN := p_asf_verify_dn;
	r_d_nyhix_dn_cur.ASSD_PROCESS_DN := to_date(p_assd_process_dn,BPM_COMMON.DATE_FMT);
	r_d_nyhix_dn_cur.CANCEL_BY:= p_cancel_by;
    r_d_nyhix_dn_cur.CANCEL_BY_ID:= p_cancel_by_id;
    r_d_nyhix_dn_cur.CANCEL_DT:= to_date(p_cancel_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.CANCEL_METHOD:= p_cancel_method;
    r_d_nyhix_dn_cur.CANCEL_REASON:= p_cancel_reason;
    r_d_nyhix_dn_cur.CHANNEL:= p_channel;
    r_d_nyhix_dn_cur.COMPLETE_DT:= to_date(p_complete_dt,BPM_COMMON.DATE_FMT);
	r_d_nyhix_dn_cur.CREATED_BY:= p_created_by;
	r_d_nyhix_dn_cur.CREATED_BY_ID:= p_created_by;
    r_d_nyhix_dn_cur.CREATE_DT:= to_date(p_create_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.DESCRIPTION:= p_description;
    r_d_nyhix_dn_cur.DOC_NOTIFICATION_ID := p_doc_notification_id;
	r_d_nyhix_dn_cur.EDNDB_ID := p_edndb_id;
    r_d_nyhix_dn_cur.ERROR_CD:= p_error_cd;
    r_d_nyhix_dn_cur.HX_ACCOUNT_ID := p_hx_account_id;
    r_d_nyhix_dn_cur.HXID := p_hxid;
    r_d_nyhix_dn_cur.INSTANCE_END_DATE := to_date(p_instance_end_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.INSTANCE_START_DATE := to_date(p_instance_start_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.INSTANCE_STATUS := p_instance_status;	
    r_d_nyhix_dn_cur.KOFAX_DCN:= p_kofax_dcn;
	r_d_nyhix_dn_cur.LAST_EVENT_DATE := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.NOTIFICATION_DT := p_notification_dt;
    r_d_nyhix_dn_cur.PROCESS_INSTANCE_ID := p_process_instance_id;
    r_d_nyhix_dn_cur.PROCESSED_IND := p_processed_ind;
	r_d_nyhix_dn_cur.STAGE_DONE_DATE := to_date(p_stage_done_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.STATUS := p_status;
    r_d_nyhix_dn_cur.STATUS_CD := p_status_cd;
    r_d_nyhix_dn_cur.stg_extract_date := to_date(p_stg_extract_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.updated_by := p_updated_by;
    r_d_nyhix_dn_cur.updated_by_id := p_updated_by_id;
    r_d_nyhix_dn_cur.update_dt := to_date(p_update_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_dn_cur.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_d_nyhix_dn_cur.create_dt, COALESCE(r_d_nyhix_dn_cur.complete_dt,r_d_nyhix_dn_cur.cancel_dt));
    r_d_nyhix_dn_cur.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_d_nyhix_dn_cur.create_dt,COALESCE(r_d_nyhix_dn_cur.complete_dt,r_d_nyhix_dn_cur.cancel_dt));
    r_d_nyhix_dn_cur.TIMELINESS_STATUS := GET_TIMELINESS_STATUS(r_d_nyhix_dn_cur.create_dt,r_d_nyhix_dn_cur.complete_dt,r_d_nyhix_dn_cur.cancel_dt);
    r_d_nyhix_dn_cur.TIMELINESS_DAYS := GET_TIMELINESS_DAYS();
    r_d_nyhix_dn_cur.TIMELINESS_DAYS_TYPE := GET_TIMELINESS_DAYS_TYPE();
    r_d_nyhix_dn_cur.TIMELINESS_DATE := GET_TIMELINESS_DT(r_d_nyhix_dn_cur.create_dt);
    r_d_nyhix_dn_cur.JEOPARDY_FLAG := GET_JEOPARDY_FLAG(r_d_nyhix_dn_cur.create_dt, COALESCE(r_d_nyhix_dn_cur.complete_dt,r_d_nyhix_dn_cur.cancel_dt));
    r_d_nyhix_dn_cur.JEOPARDY_DAYS := GET_JEOPARDY_DAYS();
    r_d_nyhix_dn_cur.JEOPARDY_DAYS_TYPE := GET_JEOPARDY_DAYS_TYPE();
    r_d_nyhix_dn_cur.JEOPARDY_DATE := GET_JEOPARDY_DT(r_d_nyhix_dn_cur.create_dt);
    r_d_nyhix_dn_cur.TARGET_DAYS := GET_TARGET_DAYS();
    r_d_nyhix_dn_cur.action_type := p_action_type;
    

  if p_set_type = 'INSERT' then
      insert into D_NYHIX_DOC_NOTIF_CURRENT
      values r_d_nyhix_dn_cur;
    
    elsif p_set_type = 'UPDATE' then
      begin
        update D_NYHIX_DOC_NOTIF_CURRENT
        set row = r_d_nyhix_dn_cur
        where NYHIX_DN_BI_ID = p_bi_id;
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
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data T_INS_DN_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_DDNBD_id number := null;
    v_last_event_date date := null;
  begin
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc V2 in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_DN_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.DOC_NOTIFICATION_ID;
    v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_BI_ID.nextval;   
    v_last_event_date := to_date(v_new_data.last_event_date,BPM_COMMON.DATE_FMT);

    
  	
-- Insert current dimension and fact as a single transaction.            
begin
  commit;

 SET_D_NYHIX_DN_CUR
  ('INSERT',
   v_identifier,
   v_bi_id,
   v_new_data.account_id,
   v_new_data.action_type,
   v_new_data.ased_process_dn,
   v_new_data.asf_verify_dn,
   v_new_data.assd_process_dn,
   v_new_data.cancel_by,
   v_new_data.cancel_by_id,
   v_new_data.cancel_dt,
   v_new_data.cancel_method,
   v_new_data.cancel_reason,
   v_new_data.channel,
   v_new_data.complete_dt,
   v_new_data.created_by,
   v_new_data.created_by_id,
   v_new_data.create_dt,
   v_new_data.description,
   v_new_data.doc_notification_id,
   v_new_data.edndb_id,
   v_new_data.error_cd,
   v_new_data.hxid,
   v_new_data.hx_account_id,
   v_new_data.instance_end_date,
   v_new_data.instance_start_date,
   v_new_data.instance_status,   
   v_new_data.kofax_dcn,
   v_new_data.last_event_date,
   v_new_data.notification_dt,
   v_new_data.processed_ind,
   v_new_data.process_instance_id,
   v_new_data.stage_done_date,
   v_new_data.status,
   v_new_data.status_cd,
   v_new_data.stg_extract_date,
   v_new_data.stg_last_update_date,
   v_new_data.updated_by,
   v_new_data.updated_by_id,
   v_new_data.update_dt);

 INS_DDNBD
   (v_identifier,
    v_bucket_start_date,
    v_bucket_end_date,
    v_new_data.last_event_date,
    v_bi_id,
    v_new_data.status_cd,
    v_new_data.status,
    v_DDNBD_id);

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
 
-- Update fact for BPM Semantic model - NYHIX Mail Fax Doc Notification. 
procedure UPD_DDNBD
  (p_identifier in varchar2,
   p_bucket_start_date in varchar2,
   p_bucket_end_date in varchar2,
   p_bi_id in number,
   p_status_cd in varchar,
   p_status in varchar,
   p_last_event_date in varchar2,
   p_DDNBD_id out number
   )
  as
   v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'UPD_DDNBD';
   v_sql_code number := null;
   v_log_message clob := null; 
   v_identifier varchar2(256) := null;
   v_bi_id number := null;
   v_max_last_event_date date :=null;
   v_last_event_date_current date := null;
   v_DDNBD_id number := null;
   v_last_event_date date := null;
   v_DDNBD_ID_old number := null;
   v_NYHIX_DN_BI_ID_old number := null;
   v_STATUS_CD_old varchar2(64) := null;
   v_STATUS_old varchar2(64) := null;
   v_LAST_EVENT_DATE_old date := null;
   v_max_ddnbd_id date := null;
   v_bucket_start_date_old date := null;
   v_bucket_end_date_old date := null;
   v_status_cd varchar2(64) := null;
   v_status varchar2(64) := null;
   
   
   r_DDNBD D_NYHIX_DOC_NOTIF_HISTORY%rowtype := null;
    
  begin 

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_DDNBD_id  := p_DDNBD_id;
   v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
   v_status_cd := p_status_cd;
   v_status := p_status;

  with most_recent_fact_bi_id as (   
   select 
    max(DDNBD_ID) MAX_DDNBD_ID,
    max(LAST_EVENT_DATE) MAX_LAST_EVENT_DATE
   from D_NYHIX_DOC_NOTIF_HISTORY
  where NYHIX_DN_BI_ID = P_BI_ID)
   select 
    most_recent_fact_bi_id.MAX_DDNBD_ID,
    most_recent_fact_bi_id.MAX_LAST_EVENT_DATE,
    h.BUCKET_START_DATE,
    h.BUCKET_END_DATE,
    h.STATUS,
    h.STATUS_CD
   into 
    v_DDNBD_ID_old,
    v_LAST_EVENT_DATE_old,
    v_bucket_start_date_old,
    v_bucket_end_date_old,
    v_STATUS_old,
    v_STATUS_CD_old
   from D_NYHIX_DOC_NOTIF_HISTORY h,most_recent_fact_bi_id
   where h.DDNBD_ID = MAX_DDNBD_ID and h.LAST_EVENT_DATE = MAX_LAST_EVENT_DATE;
   
   select LAST_EVENT_DATE
    into
    V_LAST_EVENT_DATE_CURRENT
   from D_NYHIX_DOC_NOTIF_HISTORY
   where DDNBD_ID = V_DDNBD_ID_OLD;
   
--Validate last_event_date with specific DDNBD_ID   
   if(v_LAST_EVENT_DATE_old != v_last_event_date_current) then
        v_sql_code := -20030;
        v_log_message := 'MAX(LAST_EVENT_DATE) is not equal to the LAST_EVENT_DATE of MAX(DDNBD_ID). ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt) || 'MAX(DDNBD_ID) = '||v_DDNBD_ID_old;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

  
-- Continues updates
--If same day update then set the bucket start date to minimum date and bucket end date to max date
   if trunc(v_last_event_date) = trunc(v_last_event_date_old)  and v_bucket_start_date_old = to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt) then 
       r_DDNBD.BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   elsif trunc(v_last_event_date) = trunc(v_last_event_date_old) and v_bucket_start_date_old != to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt)  then
       r_DDNBD.BUCKET_START_DATE := v_bucket_start_date_old;
   elsif trunc(v_last_event_date) > trunc(v_last_event_date_old) then
       r_DDNBD.BUCKET_START_DATE := trunc(v_last_event_date);
   end if;
   
   r_DDNBD.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   p_DDNBD_id := SEQ_DDNBD_ID.nextval;
   r_DDNBD.DDNBD_ID := p_DDNBD_id;
   r_DDNBD.NYHIX_DN_BI_ID := p_bi_id;
   r_DDNBD.last_event_date := v_last_event_date;
   r_DDNBD.status_cd := v_status_cd;
   r_DDNBD.status := v_status;

	
     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and (v_status_cd_old <> r_DDNBD.status_cd or v_status_old <> r_DDNBD.status) then
        
        update D_NYHIX_DOC_NOTIF_HISTORY
        set BUCKET_END_DATE = trunc(v_last_event_date) - 1
        where DDNBD_ID = v_DDNBD_id_old;
     
         insert into D_NYHIX_DOC_NOTIF_HISTORY
         values r_DDNBD;
	
     end if;
    
     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and (v_status_cd_old <> r_DDNBD.status_cd or v_status_old <> r_DDNBD.status) then
         
        update D_NYHIX_DOC_NOTIF_HISTORY
        set row = r_DDNBD
        where DDNBD_ID = v_DDNBD_id_old;
        
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
    if r_DDNBD.BUCKET_START_DATE > r_DDNBD.BUCKET_END_DATE
      or r_DDNBD.BUCKET_END_DATE < r_DDNBD.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid date range.  ' || 
        ' BUCKET_START_DATE = ' || to_char(r_DDNBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DDNBD.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM || 
        ' BUCKET_START_DATE = ' || to_char(r_DDNBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DDNBD.BUCKET_END_DATE,v_date_bucket_fmt);
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
    v_old_data T_UPD_DN_XML := null;
    v_new_data T_UPD_DN_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_status_cd varchar2(64) := null;
    v_status varchar2(64) := null;
    v_last_event_date date := null;
    v_DDNBD_ID number := null;
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc Notification procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_DN_XML(p_old_data_xml,v_old_data);
    GET_UPD_DN_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.DOC_NOTIFICATION_ID;
    v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
	
    select NYHIX_DN_BI_ID 
    into v_bi_id
    from D_NYHIX_DOC_NOTIF_CURRENT
    where DOC_NOTIFICATION_ID = v_identifier;
      
    v_status_cd := v_new_data.status_cd;
    v_status := v_new_data.status;
    v_last_event_date := to_date(v_new_data.last_event_date,BPM_COMMON.DATE_FMT);
      
-- Update current dimension and fact as a single transaction.
  begin
 commit;
 
 SET_D_NYHIX_DN_CUR
  ('UPDATE',
   v_identifier,
   v_bi_id,
   v_new_data.account_id,
   v_new_data.action_type,
   v_new_data.ased_process_dn,
   v_new_data.asf_verify_dn,
   v_new_data.assd_process_dn,
   v_new_data.cancel_by,
   v_new_data.cancel_by_id,
   v_new_data.cancel_dt,
   v_new_data.cancel_method,
   v_new_data.cancel_reason,
   v_new_data.channel,
   v_new_data.complete_dt,
   v_new_data.created_by,
   v_new_data.created_by_id,
   v_new_data.create_dt,
   v_new_data.description,
   v_new_data.doc_notification_id,
   v_new_data.edndb_id,
   v_new_data.error_cd,
   v_new_data.hxid,
   v_new_data.hx_account_id,
   v_new_data.instance_end_date,
   v_new_data.instance_start_date,
   v_new_data.instance_status,   
   v_new_data.kofax_dcn,
   v_new_data.last_event_date,
   v_new_data.notification_dt,
   v_new_data.processed_ind,
   v_new_data.process_instance_id,
   v_new_data.stage_done_date,
   v_new_data.status,
   v_new_data.status_cd,
   v_new_data.stg_extract_date,
   v_new_data.stg_last_update_date,
   v_new_data.updated_by,
   v_new_data.updated_by_id,
   v_new_data.update_dt);
        
 UPD_DDNBD
  (v_identifier,
   v_bucket_start_date,
   v_bucket_end_date,
   v_bi_id,
   v_new_data.STATUS_CD,
   v_new_data.STATUS,
   v_new_data.last_event_date,
   v_DDNBD_id);
      
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

  