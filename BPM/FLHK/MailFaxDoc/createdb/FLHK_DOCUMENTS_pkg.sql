alter session set plsql_code_type = native;

create or replace package flhk_documents as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 svn_file_url varchar2(200) := '$URL$'; 
 svn_revision varchar2(20) := '$Revision$'; 
 svn_revision_date varchar2(60) := '$Date$'; 
 svn_revision_author varchar2(20) := '$Author$';

procedure calc_d_flhk_documents_cur;

function get_age_in_business_days
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
  
function get_age_in_calendar_days
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
	
function get_jeopardy_dt
 (p_create_dt in date)
 return date;

function get_target_days return number result_cache;
    
function get_jeopardy_days return number result_cache;

function get_jeopardy_days_type return varchar2 result_cache;

function get_timeliness_days return number result_cache;

function get_timeliness_days_type return varchar2 result_cache;

function get_jeopardy_flag
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2;
	
function get_timeliness_status
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2;

function get_timeliness_dt
(p_create_dt in date) 
return date;
 

type t_ins_documents_xml is record
  (account_num varchar2(100),
   already_worked varchar2(32),
   ased_create_doc_in_vida varchar2(19),
   asf_create_doc_in_vida varchar2(32),
   assd_create_doc_in_vida varchar2(19),
   batch_id varchar2(100),
   cancel_dt varchar2(19),
   channel varchar2(32),
   dcn varchar2(256),
   dcn_create_dt varchar2(19),
   doc_type varchar2(32),
   ecn varchar2(256),
   eddb_id varchar2(100),
   forward_address varchar2(32),
   gwf_work_required varchar2(32),
   image_location varchar2(256),
   inserted varchar2(32),
   instance_complete_dt varchar2(19),
   instance_end_dt varchar2(19),
   instance_start_dt varchar2(19),
   instance_status varchar2(32),
   instance_status_dt varchar2(19),
   kofax_dcn varchar2(256),
   kofax_ecn varchar2(256),
   last_event_date varchar2(19),
   letter_id varchar2(100),
   missing_pages varchar2(32),
   new_app_flag varchar2(32),
   payment_amt varchar2(100),
   payment_num varchar2(100),
   receipt_dt varchar2(19),
   release_dt varchar2(19),
   renewal_doc_flag varchar2(32),
   scan_dt varchar2(19),
   stg_done_dt varchar2(19),
   stg_extract_dt varchar2(19),
   stg_last_update_dt varchar2(19),
   unreadable varchar2(32),
   updated varchar2(32),
   vida_source varchar2(32),
   web_confirm_id varchar2(100),
   work_complete_dt varchar2(19),
   work_request_id varchar2(100),
   wr_created_date varchar2(19));

type t_upd_documents_xml is record
  (account_num varchar2(100),
   already_worked varchar2(32),
   ased_create_doc_in_vida varchar2(19),
   asf_create_doc_in_vida varchar2(32),
   assd_create_doc_in_vida varchar2(19),
   batch_id varchar2(100),
   cancel_dt varchar2(19),
   channel varchar2(32),
   dcn varchar2(256),
   dcn_create_dt varchar2(19),
   doc_type varchar2(32),
   ecn	varchar2(256),
   eddb_id varchar2(100),
   forward_address varchar2(32),
   gwf_work_required varchar2(32),
   image_location varchar2(256),
   inserted varchar2(1),
   instance_complete_dt varchar2(19),
   instance_end_dt varchar2(19),
   instance_start_dt varchar2(19),
   instance_status varchar2(32),
   instance_status_dt varchar2(19),
   kofax_dcn varchar2(256),
   kofax_ecn varchar2(256),
   last_event_date varchar2(19),
   letter_id varchar2(100),
   missing_pages varchar2(32),
   new_app_flag varchar2(32),
   payment_amt varchar2(100),
   payment_num varchar2(100),
   receipt_dt varchar2(19),
   release_dt varchar2(19),
   renewal_doc_flag varchar2(32),
   scan_dt varchar2(19),
   stg_done_dt varchar2(19),
   stg_extract_dt varchar2(19),
   stg_last_update_dt varchar2(19),
   unreadable varchar2(32),
   updated varchar2(32),
   vida_source varchar2(32),
   web_confirm_id varchar2(100),
   work_complete_dt varchar2(19),
   work_request_id varchar2(100),
   wr_created_date varchar2(19));
  
procedure insert_bpm_semantic
  (p_data_version in number,
   p_new_data_xml in xmltype);
        
procedure update_bpm_semantic
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype);
end;
/

create or replace package body flhk_documents as

  v_bem_id number  := 35; -- 'FLHK DOCUMENTS_V2'
  v_bil_id number  := 1;  -- 'DCN'
  v_bsl_id number  := 35; -- 'FLHK_ETL_DOCUMENTS' --Check
  v_butl_id number := 1;  -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
    
  v_calc_d_flhk_doc_cur_job_name varchar2(30) := 'CALC_D_FLHK_DOCUMENTS_CUR';
  
function get_age_in_business_days
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return bpm_common.bus_days_between(p_create_dt,nvl(p_complete_dt,sysdate));
end;
  
function get_age_in_calendar_days
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
end; 
  
function get_timeliness_days
 return number result_cache
as
 v_timeliness_days varchar2(2):=null;
begin
   select out_var 
    into v_timeliness_days
   from corp_etl_list_lkup
   where name='DOC_TIMELINESS_DAYS';
  return to_number(v_timeliness_days);
end;

function get_timeliness_days_type
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
   select out_var 
    into v_days_type
   from corp_etl_list_lkup
   where name='DOC_TIMELINESS_DAYS_TYPE';
  return v_days_type;
end;

function get_jeopardy_days
 return number result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
   select out_var 
    into v_jeopardy_days
   from corp_etl_list_lkup
   where name='DOC_JEOPARDY_DAYS';
  return to_number(v_jeopardy_days);
end;

function get_jeopardy_days_type
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select out_var 
  into v_days_type
  from corp_etl_list_lkup
  where name='DOC_JEOPARDY_DAYS_TYPE';
 return v_days_type;
end;

function get_target_days
 return number result_cache
as
 v_target_days varchar2(2):=null;
begin
  select out_var 
  into v_target_days
  from corp_etl_list_lkup
  where name='DOC_TARGET_DAYS';
 return to_number(v_target_days);
end;

function get_timeliness_status
  (p_create_dt in date, 
   p_complete_dt in date)
 return varchar2
as
 days_type varchar2(2):=null;
 timeliness_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=get_timeliness_days_type();
  timeliness_days:=get_timeliness_days();
  bus_days:=bpm_common.bus_days_between(p_create_dt,nvl(p_complete_dt,sysdate));
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
elsif (p_complete_dt is null)
then return 'Timeliness Not Required';
else
return null;
end if;
end;
  
  
function get_timeliness_dt
 (p_create_dt in date)
 return date
 as
 v_timeliness_days number := get_timeliness_days();
 v_timeliness date:=null;
 begin
  v_timeliness:= bpm_common.get_bus_date(p_create_dt,v_timeliness_days);
 return v_timeliness;
 end;

 
function get_jeopardy_flag
 (p_create_dt in date, 
  p_complete_dt in date)
return varchar2
as
 days_type varchar2(3):=null;
 jeopardy_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=get_jeopardy_days_type();
  jeopardy_days:=get_jeopardy_days();
  bus_days:=bpm_common.bus_days_between(p_create_dt,nvl(p_complete_dt,sysdate));
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

function get_jeopardy_dt
(p_create_dt in date)
return date
as
v_jeopardy_days number := get_jeopardy_days();
v_jeopardy date:=null;
begin
    v_jeopardy:=bpm_common.get_bus_date(p_create_dt,v_jeopardy_days);
  return v_jeopardy;
end;
 
procedure calc_d_flhk_documents_cur
as
    v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'CALC_D_FLHK_DOCUMENTS_CUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

  update d_flhk_documents_current_v2
    set
      age_business_days = get_age_in_business_days(dcn_create_dt,instance_complete_dt),
      age_business_days_doc_rcpt_dt = get_age_in_business_days(receipt_dt,dcn_create_dt),
      age_business_hours = get_age_in_business_days(dcn_create_dt,instance_complete_dt) * 24,
      age_calendar_days = get_age_in_calendar_days(dcn_create_dt,instance_complete_dt),
      dcn_timeliness_status = get_timeliness_status(dcn_create_dt,instance_complete_dt),
      jeopardy_flag = get_jeopardy_flag(dcn_create_dt,instance_complete_dt),
      sla_jeopardy_days = get_jeopardy_days(), 
      sla_jeopardy_date = get_jeopardy_dt(dcn_create_dt),
      sla_target_days = get_target_days();
      
     v_num_rows_updated := sql%rowcount;
 
  commit;
 
    v_log_message := v_num_rows_updated  || ' D_FLHK_DOCUMENTS_CURRENT rows updated with calculated attributes by 
CALC_D_FLHK_DOCUMENTS_CUR.';
    bpm_common.logger(bpm_common.log_level_info,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := sqlcode;
       v_log_message := sqlerrm;
       bpm_common.logger(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
 
  end; 

-- Get record for FLHK Documents insert XML.
  procedure get_ins_documents_xml
      (p_data_xml in xmltype,
       p_data_record out t_ins_documents_xml)
  as
      v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'GET_INS_DOCUMENTS_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
select
	extractvalue(p_data_xml,'/ROWSET/ROW/ACCOUNT_NUM')"ACCOUNT_NUM",
	extractvalue(p_data_xml,'/ROWSET/ROW/ALREADY_WORKED')"ALREADY_WORKED",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_DOC_IN_VIDA')"ASED_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_DOC_IN_VIDA')"ASF_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_DOC_IN_VIDA')"ASSD_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
	extractvalue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
	extractvalue(p_data_xml,'/ROWSET/ROW/DCN_CREATE_DT')"DCN_CREATE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/DOC_TYPE')"DOC_TYPE",
	extractvalue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
	extractvalue(p_data_xml,'/ROWSET/ROW/EDDB_ID')"EDDB_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/FORWARD_ADDRESS')"FORWARD_ADDRESS",
	extractvalue(p_data_xml,'/ROWSET/ROW/GWF_WORK_REQUIRED')"GWF_WORK_REQUIRED",
	extractvalue(p_data_xml,'/ROWSET/ROW/IMAGE_LOCATION')"IMAGE_LOCATION",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSERTED')"INSERTED",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT')"INSTANCE_COMPLETE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DT')"INSTANCE_END_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DT')"INSTANCE_START_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT')"INSTANCE_STATUS_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
	extractvalue(p_data_xml,'/ROWSET/ROW/KOFAX_ECN')"KOFAX_ECN",
	extractvalue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractvalue(p_data_xml,'/ROWSET/ROW/LETTER_ID')"LETTER_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/MISSING_PAGES')"MISSING_PAGES",
	extractvalue(p_data_xml,'/ROWSET/ROW/NEW_APP_FLAG')"NEW_APP_FLAG",
	extractvalue(p_data_xml,'/ROWSET/ROW/PAYMENT_AMT')"PAYMENT_AMT",
	extractvalue(p_data_xml,'/ROWSET/ROW/PAYMENT_NUM')"PAYMENT_NUM",
	extractvalue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT')"RECEIPT_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/RENEWAL_DOC_FLAG')"RENEWAL_DOC_FLAG",
	extractvalue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_DONE_DT')"STG_DONE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DT')"STG_EXTRACT_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DT')"STG_LAST_UPDATE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/UNREADABLE')"UNREADABLE",
	extractvalue(p_data_xml,'/ROWSET/ROW/UPDATED')"UPDATED",
	extractvalue(p_data_xml,'/ROWSET/ROW/VIDA_SOURCE')"VIDA_SOURCE",
	extractvalue(p_data_xml,'/ROWSET/ROW/WEB_CONFIRM_ID')"WEB_CONFIRM_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/WORK_COMPLETE_DT')"WORK_COMPLETE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/WORK_REQUEST_ID')"WORK_REQUEST_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/WR_CREATED_DATE')"WR_CREATED_DATE"
 into p_data_record
from dual;
     
     exception
     
       when others then
         v_sql_code := sqlcode;
         v_log_message := sqlerrm;
         bpm_common.logger(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
-- Get record for FLHK Documents update XML. 
  procedure get_upd_documents_xml
    (p_data_xml in xmltype,
     p_data_record out t_upd_documents_xml)
  as
    v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'GET_UPD_DOCUMENTS_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin   
  
select
	extractvalue(p_data_xml,'/ROWSET/ROW/ACCOUNT_NUM')"ACCOUNT_NUM",
	extractvalue(p_data_xml,'/ROWSET/ROW/ALREADY_WORKED')"ALREADY_WORKED",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_DOC_IN_VIDA')"ASED_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_DOC_IN_VIDA')"ASF_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_DOC_IN_VIDA')"ASSD_CREATE_DOC_IN_VIDA",
	extractvalue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
	extractvalue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
	extractvalue(p_data_xml,'/ROWSET/ROW/DCN_CREATE_DT')"DCN_CREATE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/DOC_TYPE')"DOC_TYPE",
	extractvalue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
	extractvalue(p_data_xml,'/ROWSET/ROW/EDDB_ID')"EDDB_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/FORWARD_ADDRESS')"FORWARD_ADDRESS",
	extractvalue(p_data_xml,'/ROWSET/ROW/GWF_WORK_REQUIRED')"GWF_WORK_REQUIRED",
	extractvalue(p_data_xml,'/ROWSET/ROW/IMAGE_LOCATION')"IMAGE_LOCATION",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSERTED')"INSERTED",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT')"INSTANCE_COMPLETE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DT')"INSTANCE_END_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DT')"INSTANCE_START_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
	extractvalue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT')"INSTANCE_STATUS_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
	extractvalue(p_data_xml,'/ROWSET/ROW/KOFAX_ECN')"KOFAX_ECN",
	extractvalue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
	extractvalue(p_data_xml,'/ROWSET/ROW/LETTER_ID')"LETTER_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/MISSING_PAGES')"MISSING_PAGES",
	extractvalue(p_data_xml,'/ROWSET/ROW/NEW_APP_FLAG')"NEW_APP_FLAG",
	extractvalue(p_data_xml,'/ROWSET/ROW/PAYMENT_AMT')"PAYMENT_AMT",
	extractvalue(p_data_xml,'/ROWSET/ROW/PAYMENT_NUM')"PAYMENT_NUM",
	extractvalue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT')"RECEIPT_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/RENEWAL_DOC_FLAG')"RENEWAL_DOC_FLAG",
	extractvalue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_DONE_DT')"STG_DONE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DT')"STG_EXTRACT_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DT')"STG_LAST_UPDATE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/UNREADABLE')"UNREADABLE",
	extractvalue(p_data_xml,'/ROWSET/ROW/UPDATED')"UPDATED",
	extractvalue(p_data_xml,'/ROWSET/ROW/VIDA_SOURCE')"VIDA_SOURCE",
	extractvalue(p_data_xml,'/ROWSET/ROW/WEB_CONFIRM_ID')"WEB_CONFIRM_ID",
	extractvalue(p_data_xml,'/ROWSET/ROW/WORK_COMPLETE_DT')"WORK_COMPLETE_DT",
	extractvalue(p_data_xml,'/ROWSET/ROW/WORK_REQUEST_ID')"WORK_REQUEST_ID" ,
	extractvalue(p_data_xml,'/ROWSET/ROW/WR_CREATED_DATE')"WR_CREATED_DATE"
 into p_data_record
from dual;

  exception

    when others then
      v_sql_code := sqlcode;
      v_log_message := sqlerrm;
      bpm_common.logger(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  

  -- Insert fact for BPM Semantic model - Process Mail Fax Doc process. 
procedure ins_dfdh
    (p_identifier in varchar2,
     p_bucket_start_date in varchar2,
     p_bucket_end_date in varchar2,
     p_last_event_date in varchar2,
     p_bi_id in number,
     p_release_dt in varchar2,
     p_instance_status in varchar2,
     p_instance_status_dt in varchar2,
     p_dfdh_id out number)
  as  
     v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'INS_DFDH';
     v_sql_code number := null;
     v_log_message clob := null;
     v_bucket_start_date date := null;
     v_bucket_end_date date := null;
     v_release_dt date := null;
     v_instance_status_dt date := null;
     v_last_event_date date := null;

  begin
     p_dfdh_id := seq_dfdh_id.nextval;
     v_release_dt := to_date(p_release_dt,bpm_common.date_fmt);
     v_instance_status_dt := to_date(p_instance_status_dt,bpm_common.date_fmt);
     v_last_event_date := to_date(p_last_event_date,bpm_common.date_fmt);

     v_bucket_start_date := to_date(to_char(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
     v_bucket_end_date := to_date(to_char(bpm_common.max_gdate,v_date_bucket_fmt),v_date_bucket_fmt);

insert into d_flhk_documents_history_v2
  (dfdh_id,
   flhk_doc_bi_id,
   release_dt,
   instance_status,
   instance_status_dt,
   bucket_start_date,
   bucket_end_date,
   last_event_date)
values
  (p_dfdh_id,
   p_bi_id,
   v_release_dt,
   p_instance_status,
   v_instance_status_dt,
   v_bucket_start_date,
   v_bucket_end_date,
   v_last_event_date);

exception
  
    when others then
      v_sql_code := sqlcode;
      v_log_message := sqlerrm;
      bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
  -- Insert or update dimension for BPM Semantic model - FLHK Documents process - Current.
procedure set_d_flhk_documents_cur
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
   p_account_num in number,
   p_already_worked in varchar2,
   p_ased_create_doc_in_vida in varchar2,
   p_asf_create_doc_in_vida in varchar2,
   p_assd_create_doc_in_vida in varchar2,
   p_batch_id in number,
   p_cancel_dt in varchar2,
   p_channel in varchar2,
   p_dcn in varchar2,
   p_dcn_create_dt in varchar2,
   p_doc_type in varchar2,
   p_ecn	in varchar2,
   p_eddb_id in number,
   p_forward_address in varchar2,
   p_gwf_work_required in varchar2,
   p_image_location in varchar2,
   p_inserted in varchar2,
   p_instance_complete_dt in varchar2,
   p_instance_end_dt in varchar2,
   p_instance_start_dt in varchar2,
   p_instance_status in varchar2,
   p_instance_status_dt in varchar2,
   p_kofax_dcn in varchar2,
   p_kofax_ecn in varchar2,
   p_last_event_date in varchar2,
   p_letter_id in varchar2,
   p_missing_pages in varchar2,
   p_new_app_flag in varchar2,
   p_payment_amt in number,
   p_payment_num in varchar2,
   p_receipt_dt in varchar2,
   p_release_dt in varchar2,
   p_renewal_doc_flag in varchar2,
   p_scan_dt in varchar2,
   p_stg_done_dt in varchar2,
   p_stg_extract_dt in varchar2,
   p_stg_last_update_dt in varchar2,
   p_unreadable in varchar2,
   p_updated in varchar2,
   p_vida_source in varchar2,
   p_web_confirm_id in varchar2,
   p_work_complete_dt in varchar2,
   p_work_request_id in number,
   p_wr_created_date in varchar2)
 as
    v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'SET_D_FLHK_DOCUMENTS_CUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_d_flhk_documents_cur d_flhk_documents_current_v2%rowtype := null;
    v_jeopardy_flag varchar2(3) := null; 
  begin
    r_d_flhk_documents_cur.flhk_doc_bi_id := p_bi_id;
    r_d_flhk_documents_cur.account_num := p_account_num;
    r_d_flhk_documents_cur.already_worked := p_already_worked;
    r_d_flhk_documents_cur.ased_create_doc_in_vida := to_date(p_ased_create_doc_in_vida,bpm_common.date_fmt);
    r_d_flhk_documents_cur.asf_create_doc_in_vida := p_asf_create_doc_in_vida;
    r_d_flhk_documents_cur.assd_create_doc_in_vida := to_date(p_assd_create_doc_in_vida,bpm_common.date_fmt);
    r_d_flhk_documents_cur.batch_id := p_batch_id;
    r_d_flhk_documents_cur.cancel_dt := to_date(p_cancel_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.channel := p_channel;
    r_d_flhk_documents_cur.dcn := p_dcn;
    r_d_flhk_documents_cur.dcn_create_dt := to_date(p_dcn_create_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.doc_type := p_doc_type;
    r_d_flhk_documents_cur.ecn	:= p_ecn;
    r_d_flhk_documents_cur.eddb_id := p_eddb_id;
    r_d_flhk_documents_cur.forward_address := p_forward_address;
    r_d_flhk_documents_cur.gwf_work_required := p_gwf_work_required;
    r_d_flhk_documents_cur.image_location := p_image_location;
    r_d_flhk_documents_cur.inserted := p_inserted;
    r_d_flhk_documents_cur.instance_complete_dt := to_date(p_instance_complete_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.instance_end_dt := to_date(p_instance_end_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.instance_start_dt := to_date(p_instance_start_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.instance_status := p_instance_status;
    r_d_flhk_documents_cur.instance_status_dt := to_date(p_instance_status_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.kofax_dcn := p_kofax_dcn;
    r_d_flhk_documents_cur.kofax_ecn := p_kofax_ecn;
    r_d_flhk_documents_cur.last_event_date := to_date(p_last_event_date,bpm_common.date_fmt);
    r_d_flhk_documents_cur.letter_id := p_letter_id;
    r_d_flhk_documents_cur.missing_pages := p_missing_pages;
    r_d_flhk_documents_cur.new_app_flag := p_new_app_flag;
    r_d_flhk_documents_cur.payment_amt := p_payment_amt;
    r_d_flhk_documents_cur.payment_num := p_payment_num;
    r_d_flhk_documents_cur.receipt_dt := to_date(p_receipt_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.release_dt := to_date(p_release_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.renewal_doc_flag := p_renewal_doc_flag;
    r_d_flhk_documents_cur.scan_dt := to_date(p_scan_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.stg_done_dt := to_date(p_stg_done_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.stg_extract_dt := to_date(p_stg_extract_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.stg_last_update_dt := to_date(p_stg_last_update_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.unreadable := p_unreadable;
    r_d_flhk_documents_cur.updated := p_updated;
    r_d_flhk_documents_cur.vida_source := p_vida_source;
    r_d_flhk_documents_cur.web_confirm_id := p_web_confirm_id;
    r_d_flhk_documents_cur.work_complete_dt := to_date(p_work_complete_dt,bpm_common.date_fmt);
    r_d_flhk_documents_cur.work_request_id := p_work_request_id;
 r_d_flhk_documents_cur.wr_created_date := to_date(p_wr_created_date,bpm_common.date_fmt);
    r_d_flhk_documents_cur.age_business_days := get_age_in_business_days(r_d_flhk_documents_cur.dcn_create_dt,    
r_d_flhk_documents_cur.instance_complete_dt);
    r_d_flhk_documents_cur.age_business_days_doc_rcpt_dt := get_age_in_business_days(r_d_flhk_documents_cur.receipt_dt, 
r_d_flhk_documents_cur.dcn_create_dt);
    r_d_flhk_documents_cur.age_business_hours := (get_age_in_business_days(r_d_flhk_documents_cur.dcn_create_dt, 
r_d_flhk_documents_cur.instance_complete_dt))*24;
    r_d_flhk_documents_cur.age_calendar_days := get_age_in_calendar_days
(r_d_flhk_documents_cur.dcn_create_dt,r_d_flhk_documents_cur.instance_complete_dt);
    r_d_flhk_documents_cur.dcn_timeliness_status := get_timeliness_status
(r_d_flhk_documents_cur.dcn_create_dt,r_d_flhk_documents_cur.instance_complete_dt);
    r_d_flhk_documents_cur.jeopardy_flag := get_jeopardy_flag(r_d_flhk_documents_cur.dcn_create_dt, 
r_d_flhk_documents_cur.instance_complete_dt);
    r_d_flhk_documents_cur.sla_jeopardy_days := get_jeopardy_days();
    r_d_flhk_documents_cur.sla_jeopardy_date := get_jeopardy_dt(r_d_flhk_documents_cur.dcn_create_dt);
    r_d_flhk_documents_cur.sla_target_days := get_target_days();

  if p_set_type = 'INSERT' then
      insert into d_flhk_documents_current_v2
      values r_d_flhk_documents_cur;
    
    elsif p_set_type = 'UPDATE' then
      begin
        update d_flhk_documents_current_v2
        set row = r_d_flhk_documents_cur
        where flhk_doc_bi_id = p_bi_id;
  end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise_application_error(-20001,v_log_message);
    end if;
      
  exception
    
    when others then
      v_sql_code := sqlcode;
      v_log_message := sqlerrm;
      bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
end;
  
  -- Insert BPM Semantic model data.
  procedure insert_bpm_semantic
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data t_ins_documents_xml := null;
    v_bi_id number := null;
    v_identifier varchar2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_last_event_date date := null;
    v_dfdh_id number := null;
  begin
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for FLHK documents in procedure ' || 
v_procedure_name || '.';
      raise_application_error(-20011,v_log_message);        
    end if;
      
    get_ins_documents_xml(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.dcn;
    v_bucket_start_date := to_date(to_char(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(bpm_common.max_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := seq_bi_id.nextval;   
    v_last_event_date := to_date(v_new_data.last_event_date,bpm_common.date_fmt);

-- Insert current dimension and fact as a single transaction.            
begin
  commit;

 set_d_flhk_documents_cur
  ('INSERT',
   v_identifier,
   v_bi_id,
   v_new_data.account_num,
   v_new_data.already_worked,
   v_new_data.ased_create_doc_in_vida,
   v_new_data.asf_create_doc_in_vida,
   v_new_data.assd_create_doc_in_vida,
   v_new_data.batch_id,
   v_new_data.cancel_dt,
   v_new_data.channel,
   v_new_data.dcn,
   v_new_data.dcn_create_dt,
   v_new_data.doc_type,
   v_new_data.ecn,
   v_new_data.eddb_id,
   v_new_data.forward_address,
   v_new_data.gwf_work_required,
   v_new_data.image_location,
   v_new_data.inserted,
   v_new_data.instance_complete_dt,
   v_new_data.instance_end_dt,
   v_new_data.instance_start_dt,
   v_new_data.instance_status,
   v_new_data.instance_status_dt,
   v_new_data.kofax_dcn,
   v_new_data.kofax_ecn,
   v_new_data.last_event_date,
   v_new_data.letter_id,
   v_new_data.missing_pages,
   v_new_data.new_app_flag,
   v_new_data.payment_amt,
   v_new_data.payment_num,
   v_new_data.receipt_dt,
   coalesce(v_new_data.release_dt,v_new_data.dcn_create_dt),
   v_new_data.renewal_doc_flag,
   v_new_data.scan_dt,
   v_new_data.stg_done_dt,
   v_new_data.stg_extract_dt,
   v_new_data.stg_last_update_dt,
   v_new_data.unreadable,
   v_new_data.updated,
   v_new_data.vida_source,
   v_new_data.web_confirm_id,
   v_new_data.work_complete_dt,
   v_new_data.work_request_id,
   v_new_data.wr_created_date);

 ins_dfdh
   (v_identifier,
    v_bucket_start_date,
    v_bucket_end_date,
    v_new_data.last_event_date,
    v_bi_id,
    coalesce(v_new_data.release_dt,v_new_data.dcn_create_dt),
    v_new_data.instance_status,
    v_new_data.instance_status_dt,
    v_dfdh_id);

 commit;
            
 exception
  when others then
   rollback;
    v_sql_code := sqlcode;
    v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || sqlerrm;
    bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
  raise;
 end;

 exception
 when others then
    v_sql_code := sqlcode;
    v_log_message := sqlerrm;
    bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
 raise; 
      
end;
 
-- Update fact for BPM Semantic model - NYHIX Mail Fax Doc. 
procedure upd_dfdh
  (p_identifier in varchar2,
   p_bucket_start_date in varchar2,
   p_bucket_end_date in varchar2,
   p_bi_id in number,
   p_release_dt in varchar2,
   p_instance_status in varchar2,
   p_instance_status_dt in varchar2,
   p_last_event_date in varchar2,
   p_dfdh_id out number
   )
  as
   v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'UPD_DFDH';
   v_sql_code number := null;
   v_log_message clob := null; 
   v_identifier varchar2(256) := null;
   v_bi_id number := null;
   v_max_last_event_date date :=null;
   v_last_event_date_current date := null;
   v_dfdh_id number := null;
   v_last_event_date date := null;
   v_release_dt date := null;
   v_instance_status varchar2(32) := null;
   v_instance_status_dt date := null;
   v_dfdh_id_old number := null;
   v_flhk_doc_bi_id_old number := null;
   v_release_dt_old date := null;
   v_instance_status_old varchar2(32) := null;
   v_instance_status_dt_old date := null;
   v_last_event_date_old date := null;
   v_max_dfdh_id date := null;
   v_bucket_start_date_old date := null;
   v_bucket_end_date_old date := null;
   
   r_dfdh d_flhk_documents_history_v2%rowtype := null;
    
  begin 

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_dfdh_id  := p_dfdh_id;
   v_last_event_date := to_date(p_last_event_date,bpm_common.date_fmt);
   v_instance_status_dt := to_date(p_instance_status_dt,bpm_common.date_fmt);
   v_instance_status := p_instance_status;
   v_release_dt := to_date(p_release_dt,bpm_common.date_fmt);
   


  with most_recent_fact_bi_id as (   
   select 
    max(dfdh_id) max_dfdh_id,
    max(last_event_date) max_last_event_date
   from d_flhk_documents_history_v2
  where flhk_doc_bi_id = p_bi_id)
   select 
    most_recent_fact_bi_id.max_dfdh_id,
    most_recent_fact_bi_id.max_last_event_date,
    h.bucket_start_date,
    h.bucket_end_date,
    h.instance_status,
    h.instance_status_dt
   into 
    v_dfdh_id_old,
    v_last_event_date_old,
    v_bucket_start_date_old,
    v_bucket_end_date_old,
    v_instance_status_old,
    v_instance_status_dt_old
   from d_flhk_documents_history_v2 h,most_recent_fact_bi_id
   where h.dfdh_id = max_dfdh_id and h.last_event_date = max_last_event_date;
   
   select last_event_date
    into
    v_last_event_date_current
   from d_flhk_documents_history_v2
   where dfdh_id = v_dfdh_id_old;
   
--Validate last_event_date with specific DFDH_ID   
   if(v_last_event_date_old != v_last_event_date_current) then
        v_sql_code := -20030;
        v_log_message := 'MAX(LAST_EVENT_DATE) is not equal to the LAST_EVENT_DATE of MAX(DFDH_ID). ' || ' LAST_EVENT_DATE = ' || to_char
(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char(v_last_event_date_old,v_date_bucket_fmt) || 'MAX(DFDH_ID) = 
'||v_dfdh_id_old;
        bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        raise_application_error(v_sql_code,v_log_message);
     end if;

  
-- Continues updates
--If same day update then set the bucket start date to minimum date and bucket end date to max date
   if trunc(v_last_event_date) = trunc(v_last_event_date_old)  and v_bucket_start_date_old = to_date(to_char
(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt) then 
       r_dfdh.bucket_start_date := to_date(to_char(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
   elsif trunc(v_last_event_date) = trunc(v_last_event_date_old) and v_bucket_start_date_old != to_date(to_char
(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt)  then
       r_dfdh.bucket_start_date := v_bucket_start_date_old;
   elsif trunc(v_last_event_date) > trunc(v_last_event_date_old) then
       r_dfdh.bucket_start_date := trunc(v_last_event_date);
   end if;
   
   r_dfdh.bucket_end_date := to_date(to_char(bpm_common.max_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
   p_dfdh_id := seq_dfdh_id.nextval;
   r_dfdh.dfdh_id := p_dfdh_id;
   r_dfdh.flhk_doc_bi_id := p_bi_id;
   r_dfdh.last_event_date := v_last_event_date;
   r_dfdh.instance_status_dt := v_instance_status_dt;
   r_dfdh.instance_status := v_instance_status;

	
     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and
        (v_release_dt_old <> r_dfdh.release_dt or
         v_instance_status_old <> r_dfdh.instance_status or
         v_instance_status_dt_old <> r_dfdh.instance_status_dt) then
        
     update d_flhk_documents_history_v2
        set bucket_end_date = trunc(v_last_event_date) - 1
        where dfdh_id = v_dfdh_id_old;
     
        insert into d_flhk_documents_history_v2
        values r_dfdh;
	
     end if;
    
     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and
        (v_release_dt_old <> r_dfdh.release_dt or
         v_instance_status_old <> r_dfdh.instance_status or
         v_instance_status_dt_old <> r_dfdh.instance_status_dt) then
         
        update d_flhk_documents_history_v2
        set row = r_dfdh
        where dfdh_id = v_dfdh_id_old;
        
     end if;
    
--validate LAST EVENT DATE 
     if trunc(v_last_event_date) < trunc(v_last_event_date_old) then
        v_sql_code := -20030;
        v_log_message := 'Attempted to insert invalid date range.  ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' 
MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt);
        bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        raise_application_error(v_sql_code,v_log_message);
     end if;
	
     -- Validate fact date ranges.
    if r_dfdh.bucket_start_date > r_dfdh.bucket_end_date
      or r_dfdh.bucket_end_date < r_dfdh.bucket_start_date
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid date range.  ' || 
        ' BUCKET_START_DATE = ' || to_char(r_dfdh.bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_dfdh.bucket_end_date,v_date_bucket_fmt);
      bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise_application_error(v_sql_code,v_log_message);
    end if;
   
    exception
  
    when others then
      v_sql_code := sqlcode;
      v_log_message := sqlerrm || 
        ' BUCKET_START_DATE = ' || to_char(r_dfdh.bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_dfdh.bucket_end_date,v_date_bucket_fmt);
      bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
    raise; 	     
       
  end; 

-- Update BPM Semantic model data.
  procedure update_bpm_semantic
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$plsql_unit || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
    v_old_data t_upd_documents_xml := null;
    v_new_data t_upd_documents_xml := null;
    v_bi_id number := null;
    v_identifier varchar2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_dfdh_id number := null;
    v_instance_status_dt date := null;
    v_release_dt date := null;
    v_instance_status varchar2(32) := null;
    v_last_event_date date := null;
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for FLHK documents procedure ' || 
v_procedure_name ||'.';
      raise_application_error(-20011,v_log_message);        
    end if;
      
    get_upd_documents_xml(p_old_data_xml,v_old_data);
    get_upd_documents_xml(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.dcn;
    v_bucket_start_date := to_date(to_char(bpm_common.min_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(bpm_common.max_gdate,v_date_bucket_fmt),v_date_bucket_fmt);
	
    select flhk_doc_bi_id 
    into v_bi_id
    from d_flhk_documents_current_v2
    where dcn = v_identifier;
      
    v_release_dt := to_date(v_new_data.release_dt,bpm_common.date_fmt);
    v_instance_status_dt := to_date(v_new_data.instance_status_dt,bpm_common.date_fmt);
    v_instance_status := v_new_data.instance_status;
    v_last_event_date := to_date(v_new_data.last_event_date,bpm_common.date_fmt);
      
-- Update current dimension and fact as a single transaction.
  begin
 commit;

 set_d_flhk_documents_cur
  ('UPDATE',
   v_identifier,
   v_bi_id,
   v_new_data.account_num,
   v_new_data.already_worked,
   v_new_data.ased_create_doc_in_vida,
   v_new_data.asf_create_doc_in_vida,
   v_new_data.assd_create_doc_in_vida,
   v_new_data.batch_id,
   v_new_data.cancel_dt,
   v_new_data.channel,
   v_new_data.dcn,
   v_new_data.dcn_create_dt,
   v_new_data.doc_type,
   v_new_data.ecn,
   v_new_data.eddb_id,
   v_new_data.forward_address,
   v_new_data.gwf_work_required,
   v_new_data.image_location,
   v_new_data.inserted,
   v_new_data.instance_complete_dt,
   v_new_data.instance_end_dt,
   v_new_data.instance_start_dt,
   v_new_data.instance_status,
   v_new_data.instance_status_dt,
   v_new_data.kofax_dcn,
   v_new_data.kofax_ecn,
   v_new_data.last_event_date,
   v_new_data.letter_id,
   v_new_data.missing_pages,
   v_new_data.new_app_flag,
   v_new_data.payment_amt,
   v_new_data.payment_num,
   v_new_data.receipt_dt,
   coalesce(v_new_data.release_dt,v_new_data.dcn_create_dt),
   v_new_data.renewal_doc_flag,
   v_new_data.scan_dt,
   v_new_data.stg_done_dt,
   v_new_data.stg_extract_dt,
   v_new_data.stg_last_update_dt,
   v_new_data.unreadable,
   v_new_data.updated,
   v_new_data.vida_source,
   v_new_data.web_confirm_id,
   v_new_data.work_complete_dt,
   v_new_data.work_request_id,
   v_new_data.wr_created_date);
 
      
 upd_dfdh
  (v_identifier,
   v_bucket_start_date,
   v_bucket_end_date,
   v_bi_id,
   coalesce(v_new_data.release_dt,v_new_data.dcn_create_dt),
   v_new_data.instance_status,
   v_new_data.instance_status_dt,
   v_new_data.last_event_date,
   v_dfdh_id);
      
 commit;
            
  exception
   when others then
   rollback;
    v_sql_code := sqlcode;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || sqlerrm || ' BUCKET_START_DATE = ' || to_char
(v_bucket_start_date,v_date_bucket_fmt) || ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
  end;
      
  exception
   when no_data_found then
    v_sql_code := sqlcode;
    v_log_message := 'No BPM_INSTANCE found.'|| sqlerrm;
    bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
  raise; 
        
   when others then
    v_sql_code := sqlcode;
    v_log_message := sqlerrm || ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    bpm_common.logger
(bpm_common.log_level_severe,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
 
  end;

end;
/

alter session set plsql_code_type = interpreted;