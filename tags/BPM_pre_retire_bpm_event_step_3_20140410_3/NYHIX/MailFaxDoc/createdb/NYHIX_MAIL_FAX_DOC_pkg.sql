alter session set plsql_code_type = native;

create or replace 
package NYHIX_MAIL_FAX_DOC as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

procedure CALC_D_NYHIX_MF_CUR;

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

function GET_TARGET_DAYS return number result_cache;
    
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

function GET_TIMELINESS_DT
 (p_create_dt in date) 
 return date;

function GET_PAPER_SLA_TIME_STATUS
(p_create_dt in date,
 p_complete_dt in date,
 p_channel in varchar2,
 p_cancel_dt in date,
 p_envelope_status in varchar2)
return varchar2;

/*
function GET_SLA_SATISFIED_COUNT
(p_create_dt in date,
 p_channel in varchar2,
 p_cancel_dt in date,
 p_envelope_status in varchar2)
return number;
*/

/*
  select '     '|| 'EEMFDB_ID varchar2(100),' attr_element from dual  
  union 
  select '     '|| 'STG_LAST_UPDATE_DT varchar2(19),' attr_element from dual  
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
    BAST.BSL_ID = 18
    and atc.table_name = 'NYHIX_ETL_MAIL_FAX_DOC'
  order by attr_element asc;
*/
 
type T_INS_MFD_XML is record
  (
     ACCOUNT_ID varchar2(100),
     APPEAL_DE_TASK_ID varchar2(100),
     APP_DOC_TRACKER_ID varchar2(100),
     ASED_CREATE_APPEAL varchar2(19),
     ASED_CREATE_COMPLAINT varchar2(19),
     ASED_DATA_ENTRY varchar2(19),
     ASED_DOCSETLINK_QC varchar2(19),
     ASED_HSDE_QC varchar2(19),
     ASED_MANUAL_LINK_DOC varchar2(19),
     ASED_MAXE_CREATE_DOC varchar2(19),
     ASED_MAXIMUS_QC varchar2(19),
     ASED_RESOLVE_ESC_TASK varchar2(19),
     ASED_RESOLVE_ESC_TASK2 varchar2(19),
     ASED_TRANSMIT_TO_NYHBE varchar2(19),
     ASF_CREATE_APPEAL varchar2(1),
     ASF_CREATE_COMPLAINT varchar2(1),
     ASF_DATA_ENTRY varchar2(1),
     ASF_DOCSETLINK_QC varchar2(1),
     ASF_HSDE_QC varchar2(1),
     ASF_MANUAL_LINK_DOC varchar2(1),
     ASF_MAXE_CREATE_DOC varchar2(1),
     ASF_MAXIMUS_QC varchar2(1),
     ASF_RESOLVE_ESC_TASK varchar2(1),
     ASF_RESOLVE_ESC_TASK2 varchar2(1),
     ASF_TRANSMIT_TO_NYHBE varchar2(1),
     ASSD_CREATE_APPEAL varchar2(19),
     ASSD_CREATE_COMPLAINT varchar2(19),
     ASSD_DATA_ENTRY varchar2(19),
     ASSD_DOCSETLINK_QC varchar2(19),
     ASSD_HSDE_QC varchar2(19),
     ASSD_MANUAL_LINK_DOC varchar2(19),
     ASSD_MAXE_CREATE_DOC varchar2(19),
     ASSD_MAXIMUS_QC varchar2(19),
     ASSD_RESOLVE_ESC_TASK varchar2(19),
     ASSD_RESOLVE_ESC_TASK2 varchar2(19),
     ASSD_TRANSMIT_TO_NYHBE varchar2(19),
     BATCH_ID varchar2(100),
     BATCH_NAME varchar2(255),
     CANCEL_BY varchar2(32),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(32),
     CHANNEL varchar2(32),
     COMPLAINT_DE_TASK_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     DCN varchar2(256),
     DE_TASK_ID varchar2(100),
     DOC_NOTIFICATION_ID varchar2(100),
     DOC_NOTIFICATION_STATUS varchar2(64),
     DOC_SET_ID varchar2(100),
     DOC_STATUS_CD varchar2(32),
     DOC_STATUS_DT varchar2(19),
     DOC_SUBTYPE_CD varchar2(32),
     DOC_TYPE_CD varchar2(32),
     DOCSETLINK_QC_TASK_ID varchar2(100),
     DOCUMENT_ID varchar2(100),
     ECN varchar2(256),
     EEMFDB_ID varchar2(100),
     ENV_STATUS_CD varchar2(32),
     ENV_STATUS_DT varchar2(19),
     ESC_TASK_ID varchar2(100),
     ESC_TASK_ID2 varchar2(100),
     EXPEDITED_IND varchar2(1),
     FORM_TYPE_CD varchar2(70),
     FREE_FORM_TXT_IND varchar2(1),
     GWF_AUTOLINK_SUCCESS varchar2(1),
     GWF_DATA_ENTRY_REQ varchar2(1),
     GWF_DOCSETLINK_QC_REQ varchar2(1),
     GWF_HSDE_QC_REQ varchar2(1),
     GWF_MAXIMUS_QC_REQ varchar2(1),
     HSDE_ERR_IND varchar2(1),
     HSDE_QC_TASK_ID varchar2(100),
     HX_ACCOUNT_ID varchar2(64),
     HXID varchar2(64),
     INCIDENT_ID varchar2(100),
     INSTANCE_STATUS varchar2(32),
     INSTANCE_STATUS_DT varchar2(19),
     KOFAX_DCN varchar2(256),
     LANGUAGE varchar2(32),
     LINK_ID varchar2(100),
     LINK_METHOD varchar2(32),
     LINKED_CLIENT varchar2(100),
     MANUAL_LINK_TASK_ID varchar2(100),
     MAXE_DOC_CREATE_DT varchar2(19),
     MAXIMUS_QC_TASK_ID varchar2(100),
     NOTE_ID varchar2(32),
     ORIG_DOC_FORM_TYPE_CD varchar2(32),
     ORIG_DOC_TYPE_CD varchar2(32),
     ORIGINATION_DT varchar2(19),
     PAGE_COUNT varchar2(100),
     PREVIOUS_KOFAX_DCN varchar2(256),
     RELEASE_DT varchar2(19),
     RESCAN_COUNT varchar2(100),
     RESCANNED_IND varchar2(1),
     RESEARCH_REQ_IND varchar2(1),
     RETURNED_MAIL_IND varchar2(1),
     RETURNED_MAIL_REASON varchar2(32),
     SCAN_DT varchar2(19),
     STG_LAST_UPDATE_DT varchar2(19),
     TRASHED_IND varchar2(1),
     UPDATE_DT varchar2(19),
     UPDATED_BY varchar2(80)
  );
  
/*
    select '     '|| 'STG_LAST_UPDATE_DT varchar2(19),' attr_element from dual  
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
      BAST.BSL_ID = 18
      and atc.table_name = 'NYHIX_ETL_MAIL_FAX_DOC'
    order by attr_element asc;
*/

type T_UPD_MFD_XML is record
  (
     ACCOUNT_ID varchar2(100),
     APPEAL_DE_TASK_ID varchar2(100),
     APP_DOC_TRACKER_ID varchar2(100),
     ASED_CREATE_APPEAL varchar2(19),
     ASED_CREATE_COMPLAINT varchar2(19),
     ASED_DATA_ENTRY varchar2(19),
     ASED_DOCSETLINK_QC varchar2(19),
     ASED_HSDE_QC varchar2(19),
     ASED_MANUAL_LINK_DOC varchar2(19),
     ASED_MAXE_CREATE_DOC varchar2(19),
     ASED_MAXIMUS_QC varchar2(19),
     ASED_RESOLVE_ESC_TASK varchar2(19),
     ASED_RESOLVE_ESC_TASK2 varchar2(19),
     ASED_TRANSMIT_TO_NYHBE varchar2(19),
     ASF_CREATE_APPEAL varchar2(1),
     ASF_CREATE_COMPLAINT varchar2(1),
     ASF_DATA_ENTRY varchar2(1),
     ASF_DOCSETLINK_QC varchar2(1),
     ASF_HSDE_QC varchar2(1),
     ASF_MANUAL_LINK_DOC varchar2(1),
     ASF_MAXE_CREATE_DOC varchar2(1),
     ASF_MAXIMUS_QC varchar2(1),
     ASF_RESOLVE_ESC_TASK varchar2(1),
     ASF_RESOLVE_ESC_TASK2 varchar2(1),
     ASF_TRANSMIT_TO_NYHBE varchar2(1),
     ASSD_CREATE_APPEAL varchar2(19),
     ASSD_CREATE_COMPLAINT varchar2(19),
     ASSD_DATA_ENTRY varchar2(19),
     ASSD_DOCSETLINK_QC varchar2(19),
     ASSD_HSDE_QC varchar2(19),
     ASSD_MANUAL_LINK_DOC varchar2(19),
     ASSD_MAXE_CREATE_DOC varchar2(19),
     ASSD_MAXIMUS_QC varchar2(19),
     ASSD_RESOLVE_ESC_TASK varchar2(19),
     ASSD_RESOLVE_ESC_TASK2 varchar2(19),
     ASSD_TRANSMIT_TO_NYHBE varchar2(19),
     BATCH_ID varchar2(100),
     BATCH_NAME varchar2(255),
     CANCEL_BY varchar2(32),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(32),
     CHANNEL varchar2(32),
     COMPLAINT_DE_TASK_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     DCN varchar2(256),
     DE_TASK_ID varchar2(100),
     DOC_NOTIFICATION_ID varchar2(100),
     DOC_NOTIFICATION_STATUS varchar2(64),
     DOC_SET_ID varchar2(100),
     DOC_STATUS_CD varchar2(32),
     DOC_STATUS_DT varchar2(19),
     DOC_SUBTYPE_CD varchar2(32),
     DOC_TYPE_CD varchar2(32),
     DOCSETLINK_QC_TASK_ID varchar2(100),
     DOCUMENT_ID varchar2(100),
     ECN varchar2(256),
     EEMFDB_ID varchar2(100),
     ENV_STATUS_CD varchar2(32),
     ENV_STATUS_DT varchar2(19),
     ESC_TASK_ID varchar2(100),
     ESC_TASK_ID2 varchar2(100),
     EXPEDITED_IND varchar2(1),
     FORM_TYPE_CD varchar2(70),
     FREE_FORM_TXT_IND varchar2(1),
     GWF_AUTOLINK_SUCCESS varchar2(1),
     GWF_DATA_ENTRY_REQ varchar2(1),
     GWF_DOCSETLINK_QC_REQ varchar2(1),
     GWF_HSDE_QC_REQ varchar2(1),
     GWF_MAXIMUS_QC_REQ varchar2(1),
     HSDE_ERR_IND varchar2(1),
     HSDE_QC_TASK_ID varchar2(100),
     HX_ACCOUNT_ID varchar2(64),
     HXID varchar2(64),
     INCIDENT_ID varchar2(100),
     INSTANCE_STATUS varchar2(32),
     INSTANCE_STATUS_DT varchar2(19),
     KOFAX_DCN varchar2(256),
     LANGUAGE varchar2(32),
     LINK_ID varchar2(100),
     LINK_METHOD varchar2(32),
     LINKED_CLIENT varchar2(100),
     MANUAL_LINK_TASK_ID varchar2(100),
     MAXE_DOC_CREATE_DT varchar2(19),
     MAXIMUS_QC_TASK_ID varchar2(100),
     NOTE_ID varchar2(32),
     ORIG_DOC_FORM_TYPE_CD varchar2(32),
     ORIG_DOC_TYPE_CD varchar2(32),
     ORIGINATION_DT varchar2(19),
     PAGE_COUNT varchar2(100),
     PREVIOUS_KOFAX_DCN varchar2(256),
     RELEASE_DT varchar2(19),
     RESCAN_COUNT varchar2(100),
     RESCANNED_IND varchar2(1),
     RESEARCH_REQ_IND varchar2(1),
     RETURNED_MAIL_IND varchar2(1),
     RETURNED_MAIL_REASON varchar2(32),
     SCAN_DT varchar2(19),
     STG_LAST_UPDATE_DT varchar2(19),
     TRASHED_IND varchar2(1),
     UPDATE_DT varchar2(19),
     UPDATED_BY varchar2(80)
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
package body NYHIX_MAIL_FAX_DOC as

  v_bem_id number  := 18; -- 'NYHIX Mail fax doc'
  v_bil_id number  := 1;  -- 'Document ID'
  v_bsl_id number  := 18; -- 'NYHIX_ETL_MAIL_FAX_DOC'
  v_butl_id number := 1;  -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_CALC_D_NYHIX_MF_CUR_job_name varchar2(30) := 'CALC_D_NYHIX_MF_CUR';
  
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
  select out_var 
  into v_timeliness_days
  from corp_etl_list_lkup
  where name='MFD_TIMELINESS_DAYS';
 return to_number(v_timeliness_days);
end;

function GET_TIMELINESS_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select out_var 
  into v_days_type
  from corp_etl_list_lkup
  where name='MFD_TIMELINESS_DAYS_TYPE';
 return v_days_type;
end;

function GET_JEOPARDY_DAYS
 return number result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
  select out_var 
  into v_jeopardy_days
  from corp_etl_list_lkup
  where name='MFD_JEOPARDY_DAYS';
 return to_number(v_jeopardy_days);
end;

function GET_JEOPARDY_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select out_var 
  into v_days_type
  from corp_etl_list_lkup
  where name='MFD_JEOPARDY_DAYS_TYPE';
 return v_days_type;
end;


function GET_TARGET_DAYS
 return number result_cache
as
 v_target_days varchar2(2):=null;
begin
  select out_var 
  into v_target_days
  from corp_etl_list_lkup
  where name='MFD_TARGET_DAYS';
 return to_number(v_target_days);
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
   if (bus_days<=timeliness_days)
    then return 'Timely';
   elsif (bus_days>=timeliness_days)
    then return 'Untimely';
   else
    return null;
   end if;
 elsif (days_type='C') then
  if (cal_days<timeliness_days)
    then return 'Processed Timely';
  elsif (cal_days>=timeliness_days)
    then return 'Processed Untimely';
    else
      return null;
    end if;
 else
 return null;
 end if;
elsif(p_complete_dt is not null and p_cancel_dt is not null)
then return 'Not Required';
elsif (p_complete_dt is null)
then return 'Not Completed';
else
return null;
end if;
end;
  
function GET_TIMELINESS_DT
 (p_create_dt in date)
 return date
 as
 v_timeliness date:=null;
 begin
  v_timeliness:= p_create_dt + get_timeliness_days();
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
v_jeopardy date:=null;
begin
v_jeopardy:=p_create_dt + get_jeopardy_days();
return v_jeopardy;
 end;

function GET_PAPER_SLA_TIME_STATUS
(p_create_dt in date,
 p_complete_dt in date,
 p_channel in varchar2,
 p_cancel_dt in date,
 p_envelope_status in varchar2)
return varchar2
as
bus_days number := null;
begin
bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,NVL(p_complete_dt,sysdate));
if(p_cancel_dt is not null or p_channel = 'WEB') then
 return 'Not Required';
end if;
if(p_envelope_status != 'COMPLETEDRELEASED') then 
 return 'Not Complete';
end if;
if( p_cancel_dt is null and 
   p_envelope_status = 'COMPLETEDRELEASED' and
   (p_channel = 'MAIL' or 
    p_channel = 'FAX')) then
 if(bus_days <= 5) then
 return '5 Day Timely';
 end if;
 if(bus_days > 5 and bus_days <= 10) then
 return '10 Day Timely';
 end if;
 if(bus_days > 10) then
 return 'Untimely';
 end if;
else return 'Not Complete';
end if;
end;

/*
function GET_SLA_SATISFIED_COUNT
(p_create_dt in date,
 p_channel in varchar2,
 p_cancel_dt in date,
 p_envelope_status in varchar2)
return number
as
begin
if(p_cancel_dt is not null or p_channel = 'WEB' or p_envelope_status != 'COMPLETEDRELEASED' ) then
 return 0;
end if;
if( p_cancel_dt is null and 
   p_envelope_status = 'COMPLETEDRELEASED' and
   (p_channel = 'MAIL' or 
    p_channel = 'FAX')) then
   return 1;
else return 0;
 end if;
end;
*/

procedure CALC_D_NYHIX_MF_CUR 
as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_D_NYHIX_MF_CUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

  update D_NYHIX_MFD_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COMPLETE_DT),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DT,COMPLETE_DT),
      TIMELINESS_STATUS    = GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT,CANCEL_DT),
      TIMELINESS_DAYS      = GET_TIMELINESS_DAYS(),
      TIMELINESS_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
      TIMELINESS_DATE      = GET_TIMELINESS_DT(CREATE_DT),
      JEOPARDY_FLAG        = GET_JEOPARDY_FLAG(CREATE_DT,COMPLETE_DT),
      JEOPARDY_DAYS        = GET_JEOPARDY_DAYS(), 
      JEOPARDY_DAYS_TYPE   = GET_JEOPARDY_DAYS_TYPE(),
      JEOPARDY_DATE        = GET_JEOPARDY_DT(CREATE_DT),
      TARGET_DAYS          = GET_TARGET_DAYS(),
      PAPER_SLA_TIME_STATUS = GET_PAPER_SLA_TIME_STATUS(CREATE_DT,ENVELOPE_STATUS_DT,CHANNEL,CANCEL_DT,ENVELOPE_STATUS)
     
    where 
      COMPLETE_DT is null;
--      and CANCEL_DT is null;
    
    v_num_rows_updated := sql%rowcount;
 
  commit;
 
  v_log_message := v_num_rows_updated  || ' D_NYHIX_MFD_CURRENT rows updated with calculated attributes by CALC_D_NYHIX_MF_CUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
 
  end; 

-- Get dimension ID for BPM Semantic model - NYHIX Mail Fax Doc Instance Status.
  procedure GET_DNMFDIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_dnmfdis_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDIS_ID into p_dnmfdis_id
     from D_NYHIX_MFD_INS_STATUS
     where
       Instance_Status = p_ins_status
       or (Instance_Status is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdis_id := SEQ_DNMFDIS_ID.nextval;
       begin
         insert into D_NYHIX_MFD_INS_STATUS (DNMFDIS_ID,Instance_Status)
         values (p_dnmfdis_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDIS_ID into p_dnmfdis_id
           from D_NYHIX_MFD_INS_STATUS
           where
             Instance_Status = p_ins_status
             or (Instance_Status is null and p_ins_status is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document type.
  procedure GET_DNMFDDT_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_doc_type in varchar2,
      p_dnmfddt_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDDT_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDDT_ID into p_dnmfddt_id
     from D_NYHIX_MFD_DOC_TYPE
     where
       Document_Type = p_doc_type
       or (Document_type is null and p_doc_type is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfddt_id := SEQ_DNMFDDT_ID.nextval;
       begin
         insert into D_NYHIX_MFD_DOC_TYPE (DNMFDDT_ID,DOCUMENT_TYPE)
         values (p_dnmfddt_id,p_doc_type);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDDT_ID into p_dnmfddt_id
           from D_NYHIX_MFD_DOC_TYPE
           where
             "DOCUMENT_TYPE" = p_doc_type
             or ("DOCUMENT_TYPE" is null and p_doc_type is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document Status
  procedure GET_DNMFDDS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_doc_status in varchar2,
      p_dnmfdds_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDDS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDDS_ID into p_dnmfdds_id
     from D_NYHIX_MFD_DOC_STATUS
     where
       Document_STATUS = p_doc_status
       or (Document_STATUS is null and p_doc_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdds_id := SEQ_DNMFDDS_ID.nextval;
       begin
         insert into D_NYHIX_MFD_DOC_STATUS (DNMFDDS_ID,"DOCUMENT_STATUS")
         values (p_dnmfdds_id,p_doc_STATUS);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDDS_ID into p_dnmfdds_id
           from D_NYHIX_MFD_DOC_STATUS
           where
             "DOCUMENT_STATUS" = p_doc_status
             or ("DOCUMENT_STATUS" is null and p_doc_status is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - ENVELOPE Status
  procedure GET_DNMFDES_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_env_status in varchar2,
      p_dnmfdes_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDES_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDES_ID into p_dnmfdes_id
     from D_NYHIX_MFD_ENV_STATUS
     where
       "ENVELOPE_STATUS" = p_env_status
       or ("ENVELOPE_STATUS" is null and p_env_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdes_id := SEQ_DNMFDES_ID.nextval;
       begin
         insert into D_NYHIX_MFD_ENV_STATUS (DNMFDES_ID,"ENVELOPE_STATUS")
         values (p_dnmfdes_id,p_env_STATUS);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDES_ID into p_dnmfdes_id
           from D_NYHIX_MFD_ENV_STATUS
           where
             "ENVELOPE_STATUS" = p_env_status
             or ("ENVELOPE_STATUS" is null and p_env_status is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - DOCUMENT SUBTYPE
  procedure GET_DNMFDDST_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_doc_subtype in varchar2,
      p_dnmfddst_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDDST_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDDST_ID into p_dnmfddst_id
     from D_NYHIX_MFD_DOC_SUB_TYPE
     where
       "DOCUMENT_SUBTYPE" = p_doc_subtype
       or ("DOCUMENT_SUBTYPE" is null and p_doc_subtype is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfddst_id := SEQ_DNMFDDST_ID.nextval;
       begin
         insert into D_NYHIX_MFD_DOC_SUB_TYPE (DNMFDDST_ID,"DOCUMENT_SUBTYPE")
         values (p_dnmfddst_id,p_doc_subtype);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDDST_ID into p_dnmfddst_id
           from D_NYHIX_MFD_DOC_SUB_TYPE
           where
             DOCUMENT_SUBTYPE = p_doc_subtype
             or (document_subtype is null and p_doc_subtype is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - FORM TYPE
  procedure GET_DNMFDFT_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_form_type in varchar2,
      p_dnmfdft_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDFT_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDFT_ID into p_dnmfdft_id
     from D_NYHIX_MFD_FORM_TYPE
     where
       "FORM_TYPE" = p_form_type
       or ("FORM_TYPE" is null and p_form_type is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdft_id := SEQ_DNMFDFT_ID.nextval;
       begin
         insert into D_NYHIX_MFD_FORM_TYPE (DNMFDFT_ID,"FORM_TYPE")
         values (p_dnmfdft_id,p_form_type);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDFT_ID into p_dnmfdft_id
           from D_NYHIX_MFD_FORM_TYPE
           where
             FORM_TYPE = p_form_type
             or (form_type is null and p_form_type is null);
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
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Timeliness Status
  procedure GET_DNMFDTS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_timely_status in varchar2,
      p_dnmfdts_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNMFDTS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDTS_ID into p_dnmfdts_id
     from D_NYHIX_MFD_TIME_STATUS
     where
       "DCN_TIMELINESS_STATUS" = p_timely_status
       or ("DCN_TIMELINESS_STATUS" is null and p_timely_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdts_id := SEQ_DNMFDTS_ID.nextval;
       begin
         insert into D_NYHIX_MFD_TIME_STATUS (DNMFDTS_ID,"DCN_TIMELINESS_STATUS")
         values (p_dnmfdts_id,p_timely_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDTS_ID into p_dnmfdts_id
           from D_NYHIX_MFD_TIME_STATUS
           where
             "DCN_TIMELINESS_STATUS" = p_timely_status
             or ("DCN_TIMELINESS_STATUS" is null and p_timely_status is null);
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

-- Get record for NYHIX Mail Fax Doc insert XML.
  procedure GET_INS_MFD_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_MFD_XML)
  as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MFD_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
/*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/EEMFDB_ID'') "' || 'EEMFDB_ID'|| '",' attr_element from dual
      union 
       select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DT'') "' || 'STG_LAST_UPDATE_DT'|| '",' attr_element from dual
        union 
         select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
         from BPM_ATTRIBUTE_STAGING_TABLE bast
       inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
    bast.bsl_id = 18
    and atc.table_name = 'NYHIX_ETL_MAIL_FAX_DOC'
    order by attr_element asc;
*/

  select
		extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID')"ACCOUNT_ID",
                                     extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DE_TASK_ID')"APPEAL_DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_TRACKER_ID')"APP_DOC_TRACKER_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_APPEAL')"ASED_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_COMPLAINT')"ASED_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_DATA_ENTRY')"ASED_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_DOCSETLINK_QC')"ASED_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_HSDE_QC')"ASED_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MANUAL_LINK_DOC')"ASED_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAXE_CREATE_DOC')"ASED_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAXIMUS_QC')"ASED_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_ESC_TASK')"ASED_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_ESC_TASK2')"ASED_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT_TO_NYHBE')"ASED_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_APPEAL')"ASF_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_COMPLAINT')"ASF_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_DATA_ENTRY')"ASF_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_DOCSETLINK_QC')"ASF_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_HSDE_QC')"ASF_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MANUAL_LINK_DOC')"ASF_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAXE_CREATE_DOC')"ASF_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAXIMUS_QC')"ASF_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_ESC_TASK')"ASF_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_ESC_TASK2')"ASF_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT_TO_NYHBE')"ASF_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_APPEAL')"ASSD_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_COMPLAINT')"ASSD_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DATA_ENTRY')"ASSD_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DOCSETLINK_QC')"ASSD_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_HSDE_QC')"ASSD_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MANUAL_LINK_DOC')"ASSD_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAXE_CREATE_DOC')"ASSD_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAXIMUS_QC')"ASSD_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_ESC_TASK')"ASSD_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_ESC_TASK2')"ASSD_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT_TO_NYHBE')"ASSD_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME')"BATCH_NAME",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
		extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
		extractValue(p_data_xml,'/ROWSET/ROW/COMPLAINT_DE_TASK_ID')"COMPLAINT_DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP')"CURRENT_STEP",
		extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID')"CURRENT_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID')"DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_ID')"DOC_NOTIFICATION_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_STATUS')"DOC_NOTIFICATION_STATUS",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_SET_ID')"DOC_SET_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_CD')"DOC_STATUS_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_DT')"DOC_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_SUBTYPE_CD')"DOC_SUBTYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_TYPE_CD')"DOC_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOCSETLINK_QC_TASK_ID')"DOCSETLINK_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_ID')"DOCUMENT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
		extractValue(p_data_xml,'/ROWSET/ROW/EEMFDB_ID')"EEMFDB_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_CD')"ENV_STATUS_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_DT')"ENV_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/ESC_TASK_ID')"ESC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ESC_TASK_ID2')"ESC_TASK_ID2",
		extractValue(p_data_xml,'/ROWSET/ROW/EXPEDITED_IND')"EXPEDITED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE_CD')"FORM_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/FREE_FORM_TXT_IND')"FREE_FORM_TXT_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_AUTOLINK_SUCCESS')"GWF_AUTOLINK_SUCCESS",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_DATA_ENTRY_REQ')"GWF_DATA_ENTRY_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOCSETLINK_QC_REQ')"GWF_DOCSETLINK_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_HSDE_QC_REQ')"GWF_HSDE_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_MAXIMUS_QC_REQ')"GWF_MAXIMUS_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/HSDE_ERR_IND')"HSDE_ERR_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/HSDE_QC_TASK_ID')"HSDE_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/HX_ACCOUNT_ID')"HX_ACCOUNT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/HXID')"HXID",
		extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID')"INCIDENT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
		extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT')"INSTANCE_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE')"LANGUAGE",
		extractValue(p_data_xml,'/ROWSET/ROW/LINK_ID')"LINK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/LINK_METHOD')"LINK_METHOD",
		extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT')"LINKED_CLIENT",
		extractValue(p_data_xml,'/ROWSET/ROW/MANUAL_LINK_TASK_ID')"MANUAL_LINK_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/MAXE_DOC_CREATE_DT')"MAXE_DOC_CREATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/MAXIMUS_QC_TASK_ID')"MAXIMUS_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/NOTE_ID')"NOTE_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_FORM_TYPE_CD')"ORIG_DOC_FORM_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_TYPE_CD')"ORIG_DOC_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIGINATION_DT')"ORIGINATION_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/PAGE_COUNT')"PAGE_COUNT",
		extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_KOFAX_DCN')"PREVIOUS_KOFAX_DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/RESCAN_COUNT')"RESCAN_COUNT",
		extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED_IND')"RESCANNED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REQ_IND')"RESEARCH_REQ_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_IND')"RETURNED_MAIL_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_REASON')"RETURNED_MAIL_REASON",
		extractValue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DT')"STG_LAST_UPDATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_IND')"TRASHED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_DT')"UPDATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY')"UPDATED_BY"
     into p_data_record
  from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
-- Get record for NYHIX Mail Fax DOC update XML. 
  procedure GET_UPD_MFD_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MFD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MFD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin   
  
  /*
  select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DT'') "' || 'STG_LAST_UPDATE_DT'|| '",' attr_element from dual
  union 
  select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
  BAST.BSL_ID = 18
  and atc.table_name = 'NYHIX_ETL_MAIL_FAX_DOC'
  order by attr_element asc;
  */
  
  select
		extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID')"ACCOUNT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DE_TASK_ID')"APPEAL_DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_TRACKER_ID')"APP_DOC_TRACKER_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_APPEAL')"ASED_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_COMPLAINT')"ASED_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_DATA_ENTRY')"ASED_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_DOCSETLINK_QC')"ASED_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_HSDE_QC')"ASED_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MANUAL_LINK_DOC')"ASED_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAXE_CREATE_DOC')"ASED_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAXIMUS_QC')"ASED_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_ESC_TASK')"ASED_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_ESC_TASK2')"ASED_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT_TO_NYHBE')"ASED_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_APPEAL')"ASF_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_COMPLAINT')"ASF_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_DATA_ENTRY')"ASF_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_DOCSETLINK_QC')"ASF_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_HSDE_QC')"ASF_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MANUAL_LINK_DOC')"ASF_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAXE_CREATE_DOC')"ASF_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAXIMUS_QC')"ASF_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_ESC_TASK')"ASF_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_ESC_TASK2')"ASF_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT_TO_NYHBE')"ASF_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_APPEAL')"ASSD_CREATE_APPEAL",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_COMPLAINT')"ASSD_CREATE_COMPLAINT",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DATA_ENTRY')"ASSD_DATA_ENTRY",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DOCSETLINK_QC')"ASSD_DOCSETLINK_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_HSDE_QC')"ASSD_HSDE_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MANUAL_LINK_DOC')"ASSD_MANUAL_LINK_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAXE_CREATE_DOC')"ASSD_MAXE_CREATE_DOC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAXIMUS_QC')"ASSD_MAXIMUS_QC",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_ESC_TASK')"ASSD_RESOLVE_ESC_TASK",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_ESC_TASK2')"ASSD_RESOLVE_ESC_TASK2",
		extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT_TO_NYHBE')"ASSD_TRANSMIT_TO_NYHBE",
		extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME')"BATCH_NAME",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
		extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
		extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
		extractValue(p_data_xml,'/ROWSET/ROW/COMPLAINT_DE_TASK_ID')"COMPLAINT_DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP')"CURRENT_STEP",
		extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID')"CURRENT_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID')"DE_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_ID')"DOC_NOTIFICATION_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_NOTIFICATION_STATUS')"DOC_NOTIFICATION_STATUS",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_SET_ID')"DOC_SET_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_CD')"DOC_STATUS_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_DT')"DOC_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_SUBTYPE_CD')"DOC_SUBTYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOC_TYPE_CD')"DOC_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/DOCSETLINK_QC_TASK_ID')"DOCSETLINK_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_ID')"DOCUMENT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
		extractValue(p_data_xml,'/ROWSET/ROW/EEMFDB_ID')"EEMFDB_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_CD')"ENV_STATUS_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_DT')"ENV_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/ESC_TASK_ID')"ESC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ESC_TASK_ID2')"ESC_TASK_ID2",
		extractValue(p_data_xml,'/ROWSET/ROW/EXPEDITED_IND')"EXPEDITED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE_CD')"FORM_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/FREE_FORM_TXT_IND')"FREE_FORM_TXT_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_AUTOLINK_SUCCESS')"GWF_AUTOLINK_SUCCESS",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_DATA_ENTRY_REQ')"GWF_DATA_ENTRY_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOCSETLINK_QC_REQ')"GWF_DOCSETLINK_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_HSDE_QC_REQ')"GWF_HSDE_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/GWF_MAXIMUS_QC_REQ')"GWF_MAXIMUS_QC_REQ",
		extractValue(p_data_xml,'/ROWSET/ROW/HSDE_ERR_IND')"HSDE_ERR_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/HSDE_QC_TASK_ID')"HSDE_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/HX_ACCOUNT_ID')"HX_ACCOUNT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/HXID')"HXID",
		extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID')"INCIDENT_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
		extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT')"INSTANCE_STATUS_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE')"LANGUAGE",
		extractValue(p_data_xml,'/ROWSET/ROW/LINK_ID')"LINK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/LINK_METHOD')"LINK_METHOD",
		extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT')"LINKED_CLIENT",
		extractValue(p_data_xml,'/ROWSET/ROW/MANUAL_LINK_TASK_ID')"MANUAL_LINK_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/MAXE_DOC_CREATE_DT')"MAXE_DOC_CREATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/MAXIMUS_QC_TASK_ID')"MAXIMUS_QC_TASK_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/NOTE_ID')"NOTE_ID",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_FORM_TYPE_CD')"ORIG_DOC_FORM_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_TYPE_CD')"ORIG_DOC_TYPE_CD",
		extractValue(p_data_xml,'/ROWSET/ROW/ORIGINATION_DT')"ORIGINATION_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/PAGE_COUNT')"PAGE_COUNT",
		extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_KOFAX_DCN')"PREVIOUS_KOFAX_DCN",
		extractValue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/RESCAN_COUNT')"RESCAN_COUNT",
		extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED_IND')"RESCANNED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REQ_IND')"RESEARCH_REQ_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_IND')"RETURNED_MAIL_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_REASON')"RETURNED_MAIL_REASON",
		extractValue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DT')"STG_LAST_UPDATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_IND')"TRASHED_IND",
		extractValue(p_data_xml,'/ROWSET/ROW/UPDATE_DT')"UPDATE_DT",
		extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY')"UPDATED_BY"
    into p_data_record
  from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  
  -- Insert fact for BPM Semantic model - Process Mail Fax Doc process. 
procedure INS_FNMFDBD
    (
     p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_instance_status_dt in varchar2,
     p_dnmfdis_id in number,
     p_dnmfddt_id in number,
     p_dnmfdds_id in number,
     p_dnmfdes_id in number,
     p_dnmfddst_id in number,
     p_dnmfdft_id in number,
     p_dnmfdts_id in number,
     p_document_status_dt in varchar2,
     p_envelope_status_dt in varchar2,
     p_scan_dt in varchar2,
     p_release_dt in varchar2,
     p_jeopardy_flag in varchar2,
 --    p_sla_satisfied_count in number,
     p_fnmfdbd_id out number
    )
  as  
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FNMFDBD';
     v_sql_code number := null;
     v_log_message clob := null;
     v_BUCKET_START_DATE date := null;
     v_BUCKET_END_DATE date := null;
     v_instance_status_dt date :=null;
     v_document_status_dt date := null;
     v_envelope_status_dt date := null;
     v_scan_dt date := null;
     v_release_dt date := null;
     v_jeopardy_flag Varchar2(3):= null;
 --    v_sla_satisfied_count number := null;
  begin
     v_instance_status_dt:= to_date(p_instance_status_dt,BPM_COMMON.DATE_FMT);
     v_document_status_dt := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
     v_envelope_status_dt := to_date(p_envelope_status_dt,BPM_COMMON.DATE_FMT);
     v_release_dt := to_date(p_release_dt,BPM_COMMON.DATE_FMT);
     v_scan_dt := to_date(p_scan_dt,BPM_COMMON.DATE_FMT);
     v_JEOPARDY_FLAG := p_jeopardy_flag;
  --   v_sla_satisfied_count := p_sla_satisfied_count;
     p_FNMFDBD_ID := SEQ_FNMFDBD_ID.nextval;
     
     v_BUCKET_START_DATE := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
     if p_end_date is null then
        v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
     else 
        v_BUCKET_END_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
     end if;  
     
 -- Validate fact date ranges.
     if p_start_date < v_BUCKET_START_DATE
            or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_BUCKET_END_DATE
            or v_BUCKET_START_DATE > v_BUCKET_END_DATE
            or v_BUCKET_END_DATE < v_BUCKET_START_DATE
        then
            v_sql_code := -20030;
            v_log_message := 'Attempted to insert invalid fact date range.  ' || 'D_DATE=' || p_start_date || 
            'BUCKET_START_DATE=' || to_char(v_BUCKET_START_DATE,v_date_bucket_fmt) ||
            'BUCKET_END_DATE = ' || to_char(v_BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

insert into F_NYHIX_MFD_BY_DATE
  (
    FNMFDBD_ID,
    NYHIX_MFD_BI_ID,
    D_DATE,
    INSTANCE_STATUS_DT,
    DNMFDDT_ID,
    DNMFDDS_ID,
    DNMFDES_ID,
    DNMFDDST_ID,
    DNMFDFT_ID,
    DNMFDTS_ID,
    DNMFDIS_ID,
    CREATION_COUNT,
    INVENTORY_COUNT,
    COMPLETION_COUNT,
    DOCUMENT_STATUS_DT,
    ENVELOPE_STATUS_DT,
    SCAN_DT,
    RELEASE_DT,
    JEOPARDY_FLAG,
 --   SLA_SATISFIED_COUNT,
    BUCKET_START_DATE,
    BUCKET_END_DATE
  )
  VALUES
  (
    p_fnmfdbd_id,
    p_bi_id,
    p_start_date,
    v_instance_status_dt,
    p_dnmfddt_id,
    p_dnmfdds_id,
    p_dnmfdes_id,
    p_dnmfddst_id,
    p_dnmfdft_id,
    p_dnmfdts_id,
    p_dnmfdis_id,
    1,
    case
    when p_end_date is null then 1
    else 0
    end,
    case
    when p_end_date is null then 0
    else 1
    end,
    v_document_status_dt,
    v_envelope_status_dt,
    v_scan_dt,
    v_release_dt,
    v_jeopardy_flag,
  --  v_sla_satisfied_count,
    v_BUCKET_START_DATE,
    v_BUCKET_END_DATE
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
    
    v_identifier VARCHAR2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_new_data T_INS_MFD_XML := null;
begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc in procedure ' ||       
v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_MFD_XML(p_new_data_xml,v_new_data);
  
    v_bi_id := SEQ_BI_ID.nextval;
    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT); 
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    
    insert into BPM_INSTANCE 
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.EEMFDB_ID),to_date(v_new_data.STG_LAST_UPDATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DT,BPM_COMMON.DATE_FMT));
  
    commit;
    
    v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DT,BPM_COMMON.DATE_FMT),'N');

	  /*   select 'BPM_EVENT.INSERT_BIA(v_bi_id, '||b.ba_id || ','||bl.bdl_id || ',v_new_data.'|| stg.staging_table_column || ',v_start_date,v_bue_id);'
      from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
      where b.bal_id = bl.bal_id
      and stg.ba_id = b.ba_id
      and b.when_populated in ('CREATE','BOTH')
      and b.bem_id = 18
      and bsl_id = 18
      order by b.ba_id*/
      
    BPM_EVENT.INSERT_BIA(v_bi_id, 5,3,v_new_data.COMPLETE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 18,3,v_new_data.UPDATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1770,2,v_new_data.CANCEL_METHOD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1772,2,v_new_data.CANCEL_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1961,1,v_new_data.BATCH_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2181,2,v_new_data.CANCEL_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2201,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2202,2,v_new_data.CHANNEL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2203,1,v_new_data.DE_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2205,1,v_new_data.DOCUMENT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2206,2,v_new_data.DOC_TYPE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2207,2,v_new_data.DOC_SUBTYPE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2209,2,v_new_data.ECN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2210,2,v_new_data.RESCANNED_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2211,2,v_new_data.DOC_STATUS_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2212,3,v_new_data.DOC_STATUS_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2213,2,v_new_data.LINK_METHOD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2214,1,v_new_data.LINK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2215,1,v_new_data.INCIDENT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2216,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2217,3,v_new_data.INSTANCE_STATUS_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2219,2,v_new_data.LANGUAGE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2220,2,v_new_data.RETURNED_MAIL_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2221,2,v_new_data.UPDATED_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2222,3,v_new_data.RELEASE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2223,1,v_new_data.APPEAL_DE_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2224,1,v_new_data.COMPLAINT_DE_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2225,3,v_new_data.ASED_CREATE_APPEAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2226,3,v_new_data.ASSD_CREATE_APPEAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2227,3,v_new_data.ASED_CREATE_COMPLAINT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2228,3,v_new_data.ASSD_CREATE_COMPLAINT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2229,3,v_new_data.ASED_DATA_ENTRY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2230,3,v_new_data.ASSD_DATA_ENTRY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2231,3,v_new_data.ASED_DOCSETLINK_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2232,3,v_new_data.ASSD_DOCSETLINK_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2233,1,v_new_data.DOCSETLINK_QC_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2235,1,v_new_data.NOTE_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2236,1,v_new_data.DOC_SET_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2237,2,v_new_data.TRASHED_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2238,2,v_new_data.ENV_STATUS_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2239,3,v_new_data.ENV_STATUS_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2240,1,v_new_data.ESC_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2480,1,v_new_data.CURRENT_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2583,2,v_new_data.CURRENT_STEP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2241,1,v_new_data.ESC_TASK_ID2,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2242,2,v_new_data.EXPEDITED_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2243,2,v_new_data.FORM_TYPE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2244,2,v_new_data.FREE_FORM_TXT_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2245,2,v_new_data.HSDE_ERR_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2246,1,v_new_data.HSDE_QC_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2247,3,v_new_data.ASED_MANUAL_LINK_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2248,3,v_new_data.ASSD_MANUAL_LINK_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2249,1,v_new_data.MANUAL_LINK_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2250,3,v_new_data.ASED_MAXE_CREATE_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2251,3,v_new_data.ASSD_MAXE_CREATE_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2252,3,v_new_data.MAXE_DOC_CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2253,3,v_new_data.ASED_MAXIMUS_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2254,3,v_new_data.ASSD_MAXIMUS_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2255,1,v_new_data.MAXIMUS_QC_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2256,2,v_new_data.ORIG_DOC_TYPE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2257,2,v_new_data.ORIG_DOC_FORM_TYPE_CD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2258,1,v_new_data.PAGE_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2259,1,v_new_data.RESCAN_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2260,2,v_new_data.RESEARCH_REQ_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2261,3,v_new_data.ASED_RESOLVE_ESC_TASK2,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2262,3,v_new_data.ASSD_RESOLVE_ESC_TASK2,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2263,3,v_new_data.ASED_RESOLVE_ESC_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2264,3,v_new_data.ASSD_RESOLVE_ESC_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2265,3,v_new_data.ASED_HSDE_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2266,3,v_new_data.ASSD_HSDE_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2267,2,v_new_data.RETURNED_MAIL_IND,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2268,3,v_new_data.SCAN_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2269,3,v_new_data.ASED_TRANSMIT_TO_NYHBE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2270,3,v_new_data.ASSD_TRANSMIT_TO_NYHBE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2271,2,v_new_data.ASF_MAXE_CREATE_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2272,2,v_new_data.ASF_CREATE_COMPLAINT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2273,2,v_new_data.ASF_CREATE_APPEAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2274,2,v_new_data.ASF_HSDE_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2275,2,v_new_data.ASF_MANUAL_LINK_DOC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2276,2,v_new_data.ASF_DOCSETLINK_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2277,2,v_new_data.ASF_RESOLVE_ESC_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2278,2,v_new_data.ASF_DATA_ENTRY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2279,2,v_new_data.ASF_MAXIMUS_QC,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2280,2,v_new_data.ASF_RESOLVE_ESC_TASK2,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2281,2,v_new_data.ASF_TRANSMIT_TO_NYHBE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2282,2,v_new_data.GWF_HSDE_QC_REQ,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2283,2,v_new_data.GWF_AUTOLINK_SUCCESS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2284,2,v_new_data.GWF_DOCSETLINK_QC_REQ,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2285,2,v_new_data.GWF_DATA_ENTRY_REQ,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2286,2,v_new_data.GWF_MAXIMUS_QC_REQ,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2290,1,v_new_data.LINKED_CLIENT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2294,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2482,2,v_new_data.KOFAX_DCN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2589,2,v_new_data.BATCH_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2598,2,v_new_data.ORIGINATION_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2609,2,v_new_data.PREVIOUS_KOFAX_DCN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2611,1,v_new_data.APP_DOC_TRACKER_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2612,1,v_new_data.DOC_NOTIFICATION_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2613,2,v_new_data.DOC_NOTIFICATION_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2614,2,v_new_data.HX_ACCOUNT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2615,2,v_new_data.HXID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2616,1,v_new_data.ACCOUNT_ID,v_start_date,v_bue_id);
    
   commit;
    
    p_bue_id := v_bue_id;
    
  exception
     
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
    
  end;

  -- Insert or update dimension for BPM Semantic model - Process Mail Fax Doc process - Current.
procedure SET_D_NYHIX_MF_CUR
  (
  p_set_type in varchar2,
  p_identifier in varchar2,
  p_bi_id in number,
  p_dcn	in varchar2,
  p_kofax_dcn	in varchar2,
  p_create_dt	in varchar2,
  p_ecn	in varchar2,
  p_instance_status	in varchar2,
  p_instance_status_dt	in varchar2,
  p_batch_id	in number,
  p_batch_name	in varchar2,
  p_channel	in varchar2,
  p_page_count	in number,
  p_document_status	in varchar2,
  p_document_status_dt	in varchar2,
  p_envelope_status	in varchar2,
  p_envelope_status_dt	in varchar2,
  p_document_type	in varchar2,
  p_document_subtype	in varchar2,
  p_form_type	in varchar2,
  p_free_form_text	in varchar2,
  p_scan_dt	in varchar2,
  p_release_dt	in varchar2,
  p_maxe_create_doc_start	in varchar2,
  p_maxe_create_doc_end	in varchar2,
  p_document_id	in number,
  p_document_set_id	in number,
  p_maxe_doc_create_dt	in varchar2,
  p_language	in varchar2,
  p_current_task_id in number,
  p_current_step in varchar2,
  p_create_complaint_start	in varchar2,
  p_create_complaint_end	in varchar2,
  p_complaint_data_entry_task_id	in number,
  p_create_appeal_start	in varchar2,
  p_create_appeal_end	in varchar2,
  p_appeal_data_entry_task_id	in number,
  p_incident_id	in number,
  p_resolve_hsde_qc_task_start	in varchar2,
  p_resolve_hsde_qc_task_end	in varchar2,
  p_hsde_error	in varchar2,
  p_hsde_qc_task_id	in number,
  p_manual_link_document_start	in varchar2,
  p_manual_link_document_end	in varchar2,
  p_manual_linking_task_id	in number,
  p_doc_set_link_qc_start	in varchar2,
  p_doc_set_link_qc_end	in varchar2,
  p_doc_set_link_qc_task_id	in number,
  p_resolve_esc_task_start	in varchar2,
  p_resolve_esc_task_end	in varchar2,
  p_escalated_task_id	in number,
  p_data_entry_start	in varchar2,
  p_data_entry_end	in varchar2,
  p_data_entry_task_id	in number,
  p_maximus_qc_start	in varchar2,
  p_maximus_qc_end	in varchar2,
  p_maximus_qc_task_id	in number,
  p_resolve_esc_task2_start	in varchar2,
  p_resolve_esc_task2_end	in varchar2,
  p_escalated_task_id2	in number,
  p_transmit_to_nyhbe_start	in varchar2,
  p_transmit_to_nyhbe_end	in varchar2,
  p_cancel_dt	in varchar2,
  p_cancel_by	in varchar2,
  p_cancel_reason	in varchar2,
  p_cancel_method in varchar2,
  p_link_method	in varchar2,
  p_link_id	in number,
  p_linked_client	in varchar2,
  p_complete_dt	in varchar2,
  p_rescanned	in varchar2,
  p_returned_mail	in varchar2,
  p_returned_mail_reason	in varchar2,
  p_rescan_count	in number,
  p_last_updated_by	in varchar2,
  p_last_updated_dt	in varchar2,
  p_document_trashed	in varchar2,
  p_document_note_id	in number,
  p_original_doc_type	in varchar2,
  p_original_form_type	in varchar2,
  p_expedited	in varchar2,
  p_research_requested	in varchar2,
  p_origination_dt in varchar2,
  p_previous_kofax_dcn in varchar2,
  p_app_doc_tracker_id in number,
  p_doc_notification_id in number,
  p_doc_notification_status in varchar2,
  p_hx_account_id in varchar2,
  p_hxid in varchar2,
  p_account_id in varchar2
  )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_D_NYHIX_MF_CUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_d_nyhix_mdf_cur D_NYHIX_MFD_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(3) := null; 
  begin
  
  r_d_nyhix_mdf_cur. NYHIX_MFD_BI_ID := p_bi_id;
  
  
  r_d_nyhix_mdf_cur.DCN := p_dcn;
  r_d_nyhix_mdf_cur.KOFAX_DCN := p_kofax_dcn;
  r_d_nyhix_mdf_cur.CREATE_DT := to_date(p_create_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.ECN := p_ecn;
  r_d_nyhix_mdf_cur.INSTANCE_STATUS := p_instance_status;
  r_d_nyhix_mdf_cur.INSTANCE_STATUS_DT := to_date(p_instance_status_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.BATCH_ID := p_batch_id;
  r_d_nyhix_mdf_cur.BATCH_NAME := p_batch_NAME;
  r_d_nyhix_mdf_cur.CHANNEL := p_channel;
  r_d_nyhix_mdf_cur.PAGE_COUNT := p_page_count;
  r_d_nyhix_mdf_cur.DOCUMENT_STATUS := p_document_status;
  r_d_nyhix_mdf_cur.DOCUMENT_STATUS_DT := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.ENVELOPE_STATUS := p_envelope_status;
  r_d_nyhix_mdf_cur.ENVELOPE_STATUS_DT := to_date(p_envelope_status_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DOCUMENT_TYPE := p_document_type;
  r_d_nyhix_mdf_cur.DOCUMENT_SUBTYPE := p_document_subtype;
  r_d_nyhix_mdf_cur.FORM_TYPE := p_form_type;
  r_d_nyhix_mdf_cur.FREE_FORM_TEXT := p_free_form_text;
  r_d_nyhix_mdf_cur.SCAN_DT := to_date(p_scan_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.RELEASE_DT := to_date(p_release_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MAXE_CREATE_DOC_START := to_date(p_maxe_create_doc_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MAXE_CREATE_DOC_END := to_date(p_maxe_create_doc_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DOCUMENT_ID := p_document_id;
  r_d_nyhix_mdf_cur.DOCUMENT_SET_ID := p_document_set_id;
  r_d_nyhix_mdf_cur.MAXE_DOC_CREATE_DT := to_date(p_MAXE_DOC_CREATE_DT,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.LANGUAGE := p_language;
  r_d_nyhix_mdf_cur.CREATE_COMPLAINT_START := to_date(p_create_complaint_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.CREATE_COMPLAINT_END := to_date(p_create_complaint_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.COMPLAINT_DATA_ENTRY_TASK_ID := p_complaint_data_entry_task_id;
  r_d_nyhix_mdf_cur.CREATE_APPEAL_START := to_date(p_create_appeal_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.CREATE_APPEAL_END := to_date(p_create_appeal_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.APPEAL_DATA_ENTRY_TASK_ID := p_appeal_data_entry_task_id;
  r_d_nyhix_mdf_cur.INCIDENT_ID := p_incident_id;
  r_d_nyhix_mdf_cur.RESOLVE_HSDE_QC_TASK_START := to_date(p_resolve_hsde_qc_task_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.RESOLVE_HSDE_QC_TASK_END := to_date(p_resolve_hsde_qc_task_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.HSDE_ERROR := p_hsde_error;
  r_d_nyhix_mdf_cur.HSDE_QC_TASK_ID := p_hsde_qc_task_id;
  r_d_nyhix_mdf_cur.MANUAL_LINK_DOCUMENT_START := to_date(p_manual_link_document_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MANUAL_LINK_DOCUMENT_END := to_date(p_manual_link_document_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MANUAL_LINKING_TASK_ID := p_manual_linking_task_id;
  r_d_nyhix_mdf_cur.DOC_SET_LINK_QC_START := to_date(p_doc_set_link_qc_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DOC_SET_LINK_QC_END := to_date(p_doc_set_link_qc_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DOC_SET_LINK_QC_TASK_ID := p_doc_set_link_qc_task_id;
  r_d_nyhix_mdf_cur.RESOLVE_ESC_TASK_START := to_date(p_resolve_esc_task_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.RESOLVE_ESC_TASK_END := to_date(p_resolve_esc_task_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.CURRENT_TASK_ID := p_current_task_id;
  r_d_nyhix_mdf_cur.CURRENT_STEP := p_current_step;
  r_d_nyhix_mdf_cur.ESCALATED_TASK_ID := p_escalated_task_id;
  r_d_nyhix_mdf_cur.DATA_ENTRY_START := to_date(p_data_entry_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DATA_ENTRY_END := to_date(p_data_entry_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DATA_ENTRY_TASK_ID := p_data_entry_task_id;
  r_d_nyhix_mdf_cur.MAXIMUS_QC_START := to_date(p_maximus_qc_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MAXIMUS_QC_END := to_date(p_maximus_qc_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.MAXIMUS_QC_TASK_ID := p_maximus_qc_task_id;
  r_d_nyhix_mdf_cur.RESOLVE_ESC_TASK2_START := to_date(p_resolve_esc_task2_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.RESOLVE_ESC_TASK2_END := to_date(p_resolve_esc_task2_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.ESCALATED_TASK_ID2 := p_escalated_task_id2;
  r_d_nyhix_mdf_cur.TRANSMIT_TO_NYHBE_START := to_date(p_transmit_to_nyhbe_start,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.TRANSMIT_TO_NYHBE_END := to_date(p_transmit_to_nyhbe_end,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.CANCEL_DT := to_date(p_cancel_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.CANCEL_BY := p_cancel_by;
  r_d_nyhix_mdf_cur.CANCEL_REASON := p_cancel_reason;
  r_d_nyhix_mdf_cur.CANCEL_METHOD := p_cancel_method;
  r_d_nyhix_mdf_cur.LINK_METHOD := p_link_method;
  r_d_nyhix_mdf_cur.LINK_ID := p_link_id;
  r_d_nyhix_mdf_cur.LINKED_CLIENT := p_linked_client;
  r_d_nyhix_mdf_cur.COMPLETE_DT := to_date(p_complete_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.RESCANNED := p_rescanned;
  r_d_nyhix_mdf_cur.RETURNED_MAIL := p_returned_mail;
  r_d_nyhix_mdf_cur.RETURNED_MAIL_REASON := p_returned_mail_reason;
  r_d_nyhix_mdf_cur.RESCAN_COUNT := p_rescan_count;
  r_d_nyhix_mdf_cur.LAST_UPDATED_BY := p_last_updated_by;
  r_d_nyhix_mdf_cur.LAST_UPDATED_DT := to_date(p_last_updated_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.DOCUMENT_TRASHED := p_document_trashed;
  r_d_nyhix_mdf_cur.DOCUMENT_NOTE_ID := p_document_note_id;
  r_d_nyhix_mdf_cur.ORIGINAL_DOC_TYPE := p_original_doc_type;
  r_d_nyhix_mdf_cur.ORIGINAL_FORM_TYPE := p_original_form_type;
  r_d_nyhix_mdf_cur.EXPEDITED := p_expedited;
  r_d_nyhix_mdf_cur.RESEARCH_REQUESTED := p_research_requested;
  r_d_nyhix_mdf_cur.ORIGINATION_DT := to_date(p_origination_dt,BPM_COMMON.DATE_FMT);
  r_d_nyhix_mdf_cur.PREVIOUS_KOFAX_DCN := p_previous_kofax_dcn;
  r_d_nyhix_mdf_cur.APP_DOC_TRACKER_ID := p_app_doc_tracker_id;
  r_d_nyhix_mdf_cur.DOC_NOTIFICATION_ID := p_doc_notification_id;
  r_d_nyhix_mdf_cur.DOC_NOTIFICATION_STATUS := p_doc_notification_status;
  r_d_nyhix_mdf_cur.HX_ACCOUNT_ID := p_hx_account_id;
  r_d_nyhix_mdf_cur.HXID := p_hxid;
  r_d_nyhix_mdf_cur.ACCOUNT_ID := p_account_id;
  
  r_d_nyhix_mdf_cur.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_d_nyhix_mdf_cur.create_dt, r_d_nyhix_mdf_cur.complete_dt);
  r_d_nyhix_mdf_cur.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_d_nyhix_mdf_cur.create_dt,r_d_nyhix_mdf_cur.complete_dt);
  r_d_nyhix_mdf_cur.TIMELINESS_STATUS := GET_TIMELINESS_STATUS(r_d_nyhix_mdf_cur.create_dt,r_d_nyhix_mdf_cur.complete_dt,r_d_nyhix_mdf_cur.cancel_dt);
  r_d_nyhix_mdf_cur.TIMELINESS_DAYS := GET_TIMELINESS_DAYS();
  r_d_nyhix_mdf_cur.TIMELINESS_DAYS_TYPE := GET_TIMELINESS_DAYS_TYPE();
  r_d_nyhix_mdf_cur.TIMELINESS_DATE := GET_TIMELINESS_DT(r_d_nyhix_mdf_cur.create_dt);
  r_d_nyhix_mdf_cur.JEOPARDY_FLAG := GET_JEOPARDY_FLAG(r_d_nyhix_mdf_cur.create_dt, r_d_nyhix_mdf_cur.complete_dt);
  r_d_nyhix_mdf_cur.JEOPARDY_DAYS := GET_JEOPARDY_DAYS();
  r_d_nyhix_mdf_cur.JEOPARDY_DAYS_TYPE := GET_JEOPARDY_DAYS_TYPE();
  r_d_nyhix_mdf_cur.JEOPARDY_DATE := GET_JEOPARDY_DT(r_d_nyhix_mdf_cur.create_dt);
  r_d_nyhix_mdf_cur.TARGET_DAYS := GET_TARGET_DAYS();
  r_d_nyhix_mdf_cur.PAPER_SLA_TIME_STATUS := GET_PAPER_SLA_TIME_STATUS(r_d_nyhix_mdf_cur.CREATE_DT,r_d_nyhix_mdf_cur.ENVELOPE_STATUS_DT,r_d_nyhix_mdf_cur.CHANNEL,r_d_nyhix_mdf_cur.CANCEL_DT,r_d_nyhix_mdf_cur.ENVELOPE_STATUS);



if p_set_type = 'INSERT' then
      insert into D_NYHIX_MFD_CURRENT
      values r_d_nyhix_mdf_cur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_NYHIX_MFD_CURRENT
        set row = r_d_nyhix_mdf_cur
        where NYHIX_MFD_BI_ID = p_bi_id;
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
      
    v_new_data T_INS_MFD_XML := null;
      
    v_bi_id number := null;
    v_identifier VARCHAR2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_jeopardy_flag varchar2(2) := null;
--    v_sla_satisfied_count number := null;
    v_dnmfddt_id number := null;
    v_dnmfdds_id number := null;
    v_dnmfdes_id number := null;
    v_dnmfddst_id number := null;
    v_dnmfdft_id number := null;
    v_dnmfdts_id number := null;
    v_dnmfdis_id number := null;
    v_fnmfdbd_id number := null;
begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc in procedure ' || v_procedure_name 
|| '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_MFD_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;   
    
    GET_DNMFDDT_ID(v_identifier,v_bi_id,v_new_data.DOC_TYPE_CD,v_dnmfddt_id);
    GET_DNMFDDS_ID(v_identifier,v_bi_id,v_new_data.DOC_STATUS_CD,v_dnmfdds_id);
    GET_DNMFDES_ID(v_identifier,v_bi_id,v_new_data.ENV_STATUS_CD,v_dnmfdes_id);
    GET_DNMFDDST_ID(v_identifier,v_bi_id,v_new_data.DOC_SUBTYPE_CD,v_dnmfddst_id);
    GET_DNMFDFT_ID(v_identifier,v_bi_id,v_new_data.FORM_TYPE_CD,v_dnmfdft_id);
    GET_DNMFDTS_ID(v_identifier,v_bi_id,GET_TIMELINESS_STATUS(to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT),v_end_date,to_date(v_new_data.cancel_dt,BPM_COMMON.DATE_FMT)),v_dnmfdts_id);
    GET_DNMFDIS_ID(v_identifier,v_bi_id,v_new_data.INSTANCE_STATUS,v_dnmfdis_id);
    v_jeopardy_flag := GET_JEOPARDY_FLAG(to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT),to_date(v_end_date,BPM_COMMON.DATE_FMT));
 /*  v_sla_satisfied_count := GET_SLA_SATISFIED_COUNT(to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT),v_new_data.channel,to_date(v_new_data.cancel_dt,BPM_COMMON.DATE_FMT), v_new_data.ENV_STATUS_CD); */
  
-- Insert current dimension and fact as a single transaction.            
begin
  commit;

 SET_D_NYHIX_MF_CUR
        ('INSERT',
         v_identifier,
         v_bi_id,
         v_new_data.DCN,
         v_new_data.KOFAX_DCN,
         v_new_data.CREATE_DT,
         v_new_data.ECN,
         v_new_data.INSTANCE_STATUS,
         v_new_data.INSTANCE_STATUS_DT,
         v_new_data.BATCH_ID,
         v_new_data.BATCH_NAME,
         v_new_data.CHANNEL,
         v_new_data.PAGE_COUNT,
         v_new_data.DOC_STATUS_CD,
         v_new_data.DOC_STATUS_DT,
         v_new_data.ENV_STATUS_CD,
         v_new_data.ENV_STATUS_DT,
         v_new_data.DOC_TYPE_CD,
         v_new_data.DOC_SUBTYPE_CD,
         v_new_data.FORM_TYPE_CD,
         v_new_data.FREE_FORM_TXT_IND,
         v_new_data.SCAN_DT,
         v_new_data.RELEASE_DT,
         v_new_data.ASSD_MAXE_CREATE_DOC,
         v_new_data.ASED_MAXE_CREATE_DOC,
         v_new_data.DOCUMENT_ID,
         v_new_data.DOC_SET_ID,
         v_new_data.MAXE_DOC_CREATE_DT,
         v_new_data.LANGUAGE,
         v_new_data.CURRENT_TASK_ID,
         v_new_data.CURRENT_STEP,
         v_new_data.ASSD_CREATE_COMPLAINT,
         v_new_data.ASED_CREATE_COMPLAINT,
         v_new_data.COMPLAINT_DE_TASK_ID,
         v_new_data.ASSD_CREATE_APPEAL,
         v_new_data.ASED_CREATE_APPEAL,
         v_new_data.APPEAL_DE_TASK_ID,
         v_new_data.INCIDENT_ID,
         v_new_data.ASSD_HSDE_QC,
         v_new_data.ASED_HSDE_QC,
         v_new_data.HSDE_ERR_IND,
         v_new_data.HSDE_QC_TASK_ID,
         v_new_data.ASSD_MANUAL_LINK_DOC,
         v_new_data.ASED_MANUAL_LINK_DOC,
         v_new_data.MANUAL_LINK_TASK_ID,
         v_new_data.ASSD_DOCSETLINK_QC,
         v_new_data.ASED_DOCSETLINK_QC,
         v_new_data.DOCSETLINK_QC_TASK_ID,
         v_new_data.ASSD_RESOLVE_ESC_TASK,
         v_new_data.ASED_RESOLVE_ESC_TASK,
         v_new_data.ESC_TASK_ID,
         v_new_data.ASSD_DATA_ENTRY,
         v_new_data.ASED_DATA_ENTRY,
         v_new_data.DE_TASK_ID,
         v_new_data.ASSD_MAXIMUS_QC,
         v_new_data.ASED_MAXIMUS_QC,
         v_new_data.MAXIMUS_QC_TASK_ID,
         v_new_data.ASSD_RESOLVE_ESC_TASK2,
         v_new_data.ASED_RESOLVE_ESC_TASK2,
         v_new_data.ESC_TASK_ID2,
         v_new_data.ASSD_TRANSMIT_TO_NYHBE,
         v_new_data.ASED_TRANSMIT_TO_NYHBE,
         v_new_data.CANCEL_DT,
         v_new_data.CANCEL_BY,
         v_new_data.CANCEL_REASON,
         v_new_data.CANCEL_METHOD,
         v_new_data.LINK_METHOD,
         v_new_data.LINK_ID,
         v_new_data.LINKED_CLIENT,
         v_new_data.COMPLETE_DT,
         v_new_data.RESCANNED_IND,
         v_new_data.RETURNED_MAIL_IND,
         v_new_data.RETURNED_MAIL_REASON,
         v_new_data.RESCAN_COUNT,
         v_new_data.UPDATED_BY,
         v_new_data.UPDATE_DT,
         v_new_data.TRASHED_IND,
         v_new_data.NOTE_ID,
         v_new_data.ORIG_DOC_TYPE_CD,
         v_new_data.ORIG_DOC_FORM_TYPE_CD,
         v_new_data.EXPEDITED_IND,
         v_new_data.RESEARCH_REQ_IND,
         v_new_data.ORIGINATION_DT,
         v_new_data.PREVIOUS_KOFAX_DCN,
         v_new_data.APP_DOC_TRACKER_ID,
         v_new_data.DOC_NOTIFICATION_ID,
         v_new_data.DOC_NOTIFICATION_STATUS,
         v_new_data.HX_ACCOUNT_ID,
         v_new_data.HXID,
         v_new_data.ACCOUNT_ID
         ); 

INS_FNMFDBD
        (
        v_identifier,
        v_start_date,
        v_end_date,
        v_bi_id,
        v_new_data.INSTANCE_STATUS_DT,
        v_dnmfdis_id,
        v_dnmfddt_id,
        v_dnmfdds_id,
        v_dnmfdes_id,
        v_dnmfddst_id,
        v_dnmfdft_id,
        v_dnmfdts_id,
        v_new_data.DOC_STATUS_DT,
        v_new_data.ENV_STATUS_DT,
        v_new_data.SCAN_DT,
        v_new_data.RELEASE_DT,
        v_jeopardy_flag,
 --       v_sla_satisfied_count,
        v_fnmfdbd_id        
        );
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
  
-- Update fact for BPM Semantic model - NYHIX Mail Fax Doc. 
procedure UPD_FNMFDBD
    (
     p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_instance_status_dt in varchar2,
     p_dnmfdis_id in number,
     p_dnmfddt_id in number,
     p_dnmfdds_id in number,
     p_dnmfdes_id in number,
     p_dnmfddst_id in number,
     p_dnmfdft_id in number,
     p_dnmfdts_id in number,
     p_document_status_dt in varchar2,
     p_envelope_status_dt in varchar2,
     p_scan_dt in varchar2,
     p_release_dt in varchar2,
     p_jeopardy_flag in varchar2,
 --    p_sla_satisfied_count in number,
     p_stg_last_update_dt in varchar2,
     p_fnmfdbd_id out number
     )
    as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FNMFDBD';
    v_sql_code number := null;
    v_log_message clob := null; 
    
    v_jeopardy_flag_old Varchar2(3):= null;
--    v_sla_satisfied_count_old number := null;
    v_fnmfdbd_id_old number := null;
    v_d_date_old date := null;
    v_creation_count_old number := null;
    v_stg_last_update_dt date := null;
    v_event_date date := null;
    v_max_d_date date :=null;
    v_completion_count_old number := null;
    v_inventory_count_old number := null;
    v_release_dt_old date := null;
    v_envelope_status_dt_old date := null;
    v_document_status_Dt_old date := null;
    v_instance_status_dt_old date := null;
    v_scan_dt_old date := null;
    
    v_dnmfdis_id_old number := null;
    v_dnmfddt_id_old number := null;
    v_dnmfdds_id_old number := null;
    v_dnmfdes_id_old number := null;
    v_dnmfddst_id_old number := null;
    v_dnmfdft_id_old number := null;
    v_dnmfdts_id_old number := null;
   
    
    v_fnmfdbd_id number := null;
    
    r_fnmfdbd F_NYHIX_MFD_BY_DATE%rowtype := null;
 --   r_fnmfdbd_precreate_complete F_NYHIX_MFD_BY_DATE%rowtype := null;
    
    begin
    v_stg_last_update_dt := to_date(p_stg_last_update_dt,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_dt;
    
    v_envelope_status_dt_old := to_date(p_envelope_status_dt,BPM_COMMON.DATE_FMT);
    v_instance_status_dt_old := to_date(p_instance_status_dt,BPM_COMMON.DATE_FMT);
    v_document_status_Dt_old := to_date(p_document_status_Dt,BPM_COMMON.DATE_FMT);
    v_scan_dt_old := to_date(p_scan_dt,BPM_COMMON.DATE_FMT);
    v_release_dt_old := to_date(p_release_dt,BPM_COMMON.DATE_FMT);
    v_jeopardy_flag_old := p_jeopardy_flag;
 --   v_sla_satisfied_count_old := p_sla_satisfied_count;
    v_dnmfdis_id_old  := p_dnmfdis_id;
    v_dnmfddt_id_old  := p_dnmfddt_id;
    v_dnmfdds_id_old  := p_dnmfdds_id;
    v_dnmfdes_id_old  := p_dnmfdes_id;
    v_dnmfddst_id_old := p_dnmfddst_id;
    v_dnmfdft_id_old  := p_dnmfdft_id;
    v_dnmfdts_id_old  := p_dnmfdts_id;
    
    v_fnmfdbd_id  := p_fnmfdbd_id;
    
     with most_recent_fact_bi_id as
      (select 
         max(FNMFDBD_id) max_fnmfdbd_id,
         max(D_DATE) max_d_date
       from F_NYHIX_MFD_BY_DATE
       where NYHIX_MFD_BI_ID = p_bi_id) 
    select 
          fnmfdbd.FNMFDBD_ID,
          fnmfdbd.D_DATE,
          fnmfdbd.CREATION_COUNT,
          fnmfdbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnmfdbd.DNMFDDT_ID,
          fnmfdbd.DNMFDDS_ID,
          fnmfdbd.DNMFDES_ID,
          fnmfdbd.DNMFDDST_ID,
          fnmfdbd.DNMFDFT_ID,
          fnmfdbd.DNMFDTS_ID,
          fnmfdbd.DNMFDIS_ID,
          fnmfdbd.instance_status_dt,
          fnmfdbd.document_status_dt,
          fnmfdbd.envelope_status_dt,
          fnmfdbd.scan_Dt,
          fnmfdbd.release_Dt,
          fnmfdbd.jeopardy_flag
--          fnmfdbd.sla_satisfied_count
        into 
          v_fnmfdbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,    
          v_DNMFDDT_ID_old,
          v_DNMFDDS_ID_old,
          v_DNMFDES_ID_old,
          v_DNMFDDST_ID_old,
          v_DNMFDFT_ID_old,
          v_DNMFDTS_ID_old,
          v_DNMFDIS_ID_old,
          v_instance_status_dt_old,
          v_document_status_dt_old,
          v_envelope_status_dt_old,
          v_scan_Dt_old,
          v_release_Dt_old,
          v_jeopardy_flag_old
   --       v_sla_satisfied_count_old
      from 
      F_NYHIX_MFD_BY_DATE fnmfdbd,
      most_recent_fact_bi_id 
    where
      fnmfdbd.FNMFDBD_ID = max_fnmfdbd_id
      and fnmfdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
-- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
-- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_dt < v_max_d_date then
      v_stg_last_update_dt := v_max_d_date;
    end if;
 
-- Instance not yet completed.
    if p_end_date is null then
    
      r_fnmfdbd.D_DATE := v_event_date;
      r_fnmfdbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnmfdbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnmfdbd.INVENTORY_COUNT := 1;
	    r_fnmfdbd.COMPLETION_COUNT := 0;
	  
  else 
  
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_NYHIX_MFD_BY_DATE
        where 
         NYHIX_MFD_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
         with most_recent_fact_bi_id as
          (select 
             max(FNMFDBD_ID) max_fnmfdbd_id,
             max(D_DATE) max_d_date
           from F_NYHIX_MFD_BY_DATE
           where NYHIX_MFD_BI_ID = p_bi_id) 
        select 
          fnmfdbd.FNMFDBD_ID,
          fnmfdbd.D_DATE,
          fnmfdbd.CREATION_COUNT,
          fnmfdbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnmfdbd.DNMFDDT_ID,
          fnmfdbd.DNMFDDS_ID,
          fnmfdbd.DNMFDES_ID,
          fnmfdbd.DNMFDDST_ID,
          fnmfdbd.DNMFDFT_ID,
          fnmfdbd.DNMFDTS_ID,
          fnmfdbd.DNMFDIS_ID,
          fnmfdbd.instance_status_dt,
          fnmfdbd.document_status_dt,
          fnmfdbd.envelope_status_dt,
          fnmfdbd.scan_Dt,
          fnmfdbd.release_Dt,
          fnmfdbd.jeopardy_flag
 --         fnmfdbd.sla_satisfied_count
        into 
          v_fnmfdbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_DNMFDDT_ID_old,
          v_DNMFDDS_ID_old,
          v_DNMFDES_ID_old,
          v_DNMFDDST_ID_old,
          v_DNMFDFT_ID_old,
          v_DNMFDTS_ID_old,
          v_DNMFDIS_ID_old,
          v_instance_status_dt_old,
          v_document_status_dt_old,
          v_envelope_status_dt_old,
          v_scan_Dt_old,
          v_release_Dt_old,
          v_jeopardy_flag_old
  --        v_sla_satisfied_count_old
          from 
          F_NYHIX_MFD_BY_DATE fnmfdbd,
          most_recent_fact_bi_id 
        where
          fnmfdbd.FNMFDBD_ID = max_fnmfdbd_id
          and fnmfdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
    r_fnmfdbd.D_DATE := p_end_date;
    r_fnmfdbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    r_fnmfdbd.BUCKET_END_DATE := r_fnmfdbd.BUCKET_START_DATE;
    r_fnmfdbd.INVENTORY_COUNT := 0;
	  r_fnmfdbd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fnmfdbd_id := SEQ_FNMFDBD_ID.nextval;
    r_fnmfdbd.FNMFDBD_ID := p_fnmfdbd_id;
    r_fnmfdbd.NYHIX_MFD_BI_ID := p_bi_id;
    r_fnmfdbd.scan_Dt := to_date(p_scan_dt,BPM_COMMON.DATE_FMT);
    r_fnmfdbd.release_Dt := to_date(p_release_dt,BPM_COMMON.DATE_FMT);
    r_fnmfdbd.envelope_status_Dt := to_date(p_envelope_status_dt,BPM_COMMON.DATE_FMT);
    r_fnmfdbd.document_status_Dt := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
    r_fnmfdbd.instance_status_Dt := to_date(p_instance_status_dt,BPM_COMMON.DATE_FMT);
    r_fnmfdbd.jeopardy_flag := p_jeopardy_flag;
--    r_fnmfdbd.sla_satisfied_count := p_sla_satisfied_count;
    r_fnmfdbd.DNMFDDT_ID := p_DNMFDDT_ID;
    r_fnmfdbd.DNMFDDS_ID := p_DNMFDDS_ID;
    r_fnmfdbd.DNMFDES_ID := p_DNMFDES_ID;
    r_fnmfdbd.DNMFDDST_ID := p_DNMFDDST_ID;
    r_fnmfdbd.DNMFDFT_ID := p_DNMFDFT_ID;
    r_fnmfdbd.DNMFDTS_ID := p_DNMFDTS_ID;
    r_fnmfdbd.DNMFDIS_ID := p_DNMFDIS_ID;
    r_fnmfdbd.CREATION_COUNT := 0;
    
    -- Validate fact date ranges.
    if r_fnmfdbd.D_DATE < r_fnmfdbd.BUCKET_START_DATE
      or to_date(to_char(r_fnmfdbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnmfdbd.BUCKET_END_DATE
      or r_fnmfdbd.BUCKET_START_DATE > r_fnmfdbd.BUCKET_END_DATE
      or r_fnmfdbd.BUCKET_END_DATE < r_fnmfdbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnmfdbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnmfdbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnmfdbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnmfdbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fnmfdbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_NYHIX_MFD_BY_DATE
      set row = r_fnmfdbd
      where FNMFDBD_ID = v_fnmfdbd_id_old;
        
    else
    
       -- Different bucket time.
    
      update F_NYHIX_MFD_BY_DATE
      set BUCKET_END_DATE = r_fnmfdbd.BUCKET_START_DATE
      where FNMFDBD_ID = v_fnmfdbd_id_old;
        
      insert into F_NYHIX_MFD_BY_DATE
      values r_fnmfdbd;
      
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
  
    v_identifier VARCHAR2(35) := null;
  
    v_start_date date := null;
    v_end_date date := null;
    v_stg_last_update_dt date := null;

    v_old_data T_UPD_MFD_XML := null;
    v_new_data T_UPD_MFD_XML := null;
  begin

    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYHIX Mail Fax Doc in procedure ' || 
v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if; 

    GET_UPD_MFD_XML(p_old_data_xml,v_old_data);
    GET_UPD_MFD_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_stg_last_update_dt := to_date(v_new_data.STG_LAST_UPDATE_DT,BPM_COMMON.DATE_FMT);
  
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;

    if v_end_date is not null then
    
      update BPM_INSTANCE
      set
        END_DATE = v_end_date,
        LAST_UPDATE_DATE = v_stg_last_update_dt
      where BI_ID = v_bi_id;
      
    else
    
      update BPM_INSTANCE
      set LAST_UPDATE_DATE = v_stg_last_update_dt
      where BI_ID = v_bi_id;
      
    end if;

    commit;
   v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT(BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_dt,'N');
/*
    select 'BPM_EVENT.UPDATE_BIA(v_bi_id, ' ||b.ba_id || ','||bl.bdl_id || ','||''''||b.retain_history_flag||''''||',v_old_data.'|| 
          stg.staging_table_column ||',v_new_data.'|| stg.staging_table_column ||','||'v_bue_id,v_stg_last_update_dt);'
    from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
    where b.bal_id = bl.bal_id
    and stg.ba_id = b.ba_id
    and b.when_populated in ('UPDATE','BOTH')
    and b.bem_id = 18
    and bsl_id = 18
    order by b.ba_id */
  
BPM_EVENT.UPDATE_BIA(v_bi_id, 5,3,'N',v_old_data.COMPLETE_DT,v_new_data.COMPLETE_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 18,3,'N',v_old_data.UPDATE_DT,v_new_data.UPDATE_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1770,2,'N',v_old_data.CANCEL_METHOD,v_new_data.CANCEL_METHOD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1772,2,'N',v_old_data.CANCEL_BY,v_new_data.CANCEL_BY,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1961,1,'N',v_old_data.BATCH_ID,v_new_data.BATCH_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2181,2,'N',v_old_data.CANCEL_REASON,v_new_data.CANCEL_REASON,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2201,3,'N',v_old_data.CANCEL_DT,v_new_data.CANCEL_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2202,2,'N',v_old_data.CHANNEL,v_new_data.CHANNEL,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2203,1,'N',v_old_data.DE_TASK_ID,v_new_data.DE_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2205,1,'N',v_old_data.DOCUMENT_ID,v_new_data.DOCUMENT_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2206,2,'Y',v_old_data.DOC_TYPE_CD,v_new_data.DOC_TYPE_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2207,2,'Y',v_old_data.DOC_SUBTYPE_CD,v_new_data.DOC_SUBTYPE_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2210,2,'N',v_old_data.RESCANNED_IND,v_new_data.RESCANNED_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2211,2,'Y',v_old_data.DOC_STATUS_CD,v_new_data.DOC_STATUS_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2212,3,'Y',v_old_data.DOC_STATUS_DT,v_new_data.DOC_STATUS_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2213,2,'N',v_old_data.LINK_METHOD,v_new_data.LINK_METHOD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2214,1,'N',v_old_data.LINK_ID,v_new_data.LINK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2215,1,'N',v_old_data.INCIDENT_ID,v_new_data.INCIDENT_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2216,2,'Y',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2217,3,'Y',v_old_data.INSTANCE_STATUS_DT,v_new_data.INSTANCE_STATUS_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2219,2,'N',v_old_data.LANGUAGE,v_new_data.LANGUAGE,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2221,2,'N',v_old_data.UPDATED_BY,v_new_data.UPDATED_BY,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2222,3,'Y',v_old_data.RELEASE_DT,v_new_data.RELEASE_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2223,1,'N',v_old_data.APPEAL_DE_TASK_ID,v_new_data.APPEAL_DE_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2224,1,'N',v_old_data.COMPLAINT_DE_TASK_ID,v_new_data.COMPLAINT_DE_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2225,3,'N',v_old_data.ASED_CREATE_APPEAL,v_new_data.ASED_CREATE_APPEAL,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2226,3,'N',v_old_data.ASSD_CREATE_APPEAL,v_new_data.ASSD_CREATE_APPEAL,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2227,3,'N',v_old_data.ASED_CREATE_COMPLAINT,v_new_data.ASED_CREATE_COMPLAINT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2228,3,'N',v_old_data.ASSD_CREATE_COMPLAINT,v_new_data.ASSD_CREATE_COMPLAINT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2229,3,'N',v_old_data.ASED_DATA_ENTRY,v_new_data.ASED_DATA_ENTRY,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2230,3,'N',v_old_data.ASSD_DATA_ENTRY,v_new_data.ASSD_DATA_ENTRY,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2231,3,'N',v_old_data.ASED_DOCSETLINK_QC,v_new_data.ASED_DOCSETLINK_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2232,3,'N',v_old_data.ASSD_DOCSETLINK_QC,v_new_data.ASSD_DOCSETLINK_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2233,1,'N',v_old_data.DOCSETLINK_QC_TASK_ID,v_new_data.DOCSETLINK_QC_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2235,1,'N',v_old_data.NOTE_ID,v_new_data.NOTE_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2236,1,'N',v_old_data.DOC_SET_ID,v_new_data.DOC_SET_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2237,2,'N',v_old_data.TRASHED_IND,v_new_data.TRASHED_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2238,2,'Y',v_old_data.ENV_STATUS_CD,v_new_data.ENV_STATUS_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2239,3,'Y',v_old_data.ENV_STATUS_DT,v_new_data.ENV_STATUS_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2480,1,'N',v_old_data.CURRENT_TASK_ID,v_new_data.CURRENT_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2583,2,'N',v_old_data.CURRENT_STEP,v_new_data.CURRENT_STEP,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2240,1,'N',v_old_data.ESC_TASK_ID,v_new_data.ESC_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2241,1,'N',v_old_data.ESC_TASK_ID2,v_new_data.ESC_TASK_ID2,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2242,2,'N',v_old_data.EXPEDITED_IND,v_new_data.EXPEDITED_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2243,2,'Y',v_old_data.FORM_TYPE_CD,v_new_data.FORM_TYPE_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2244,2,'N',v_old_data.FREE_FORM_TXT_IND,v_new_data.FREE_FORM_TXT_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2245,2,'N',v_old_data.HSDE_ERR_IND,v_new_data.HSDE_ERR_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2246,1,'N',v_old_data.HSDE_QC_TASK_ID,v_new_data.HSDE_QC_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2247,3,'N',v_old_data.ASED_MANUAL_LINK_DOC,v_new_data.ASED_MANUAL_LINK_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2248,3,'N',v_old_data.ASSD_MANUAL_LINK_DOC,v_new_data.ASSD_MANUAL_LINK_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2249,1,'N',v_old_data.MANUAL_LINK_TASK_ID,v_new_data.MANUAL_LINK_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2250,3,'N',v_old_data.ASED_MAXE_CREATE_DOC,v_new_data.ASED_MAXE_CREATE_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2251,3,'N',v_old_data.ASSD_MAXE_CREATE_DOC,v_new_data.ASSD_MAXE_CREATE_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2253,3,'N',v_old_data.ASED_MAXIMUS_QC,v_new_data.ASED_MAXIMUS_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2254,3,'N',v_old_data.ASSD_MAXIMUS_QC,v_new_data.ASSD_MAXIMUS_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2255,1,'N',v_old_data.MAXIMUS_QC_TASK_ID,v_new_data.MAXIMUS_QC_TASK_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2256,2,'N',v_old_data.ORIG_DOC_TYPE_CD,v_new_data.ORIG_DOC_TYPE_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2257,2,'N',v_old_data.ORIG_DOC_FORM_TYPE_CD,v_new_data.ORIG_DOC_FORM_TYPE_CD,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2258,1,'N',v_old_data.PAGE_COUNT,v_new_data.PAGE_COUNT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2259,1,'N',v_old_data.RESCAN_COUNT,v_new_data.RESCAN_COUNT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2260,2,'N',v_old_data.RESEARCH_REQ_IND,v_new_data.RESEARCH_REQ_IND,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2261,3,'N',v_old_data.ASED_RESOLVE_ESC_TASK2,v_new_data.ASED_RESOLVE_ESC_TASK2,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2262,3,'N',v_old_data.ASSD_RESOLVE_ESC_TASK2,v_new_data.ASSD_RESOLVE_ESC_TASK2,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2263,3,'N',v_old_data.ASED_RESOLVE_ESC_TASK,v_new_data.ASED_RESOLVE_ESC_TASK,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2264,3,'N',v_old_data.ASSD_RESOLVE_ESC_TASK,v_new_data.ASSD_RESOLVE_ESC_TASK,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2265,3,'N',v_old_data.ASED_HSDE_QC,v_new_data.ASED_HSDE_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2266,3,'N',v_old_data.ASSD_HSDE_QC,v_new_data.ASSD_HSDE_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2268,3,'Y',v_old_data.SCAN_DT,v_new_data.SCAN_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2269,3,'N',v_old_data.ASED_TRANSMIT_TO_NYHBE,v_new_data.ASED_TRANSMIT_TO_NYHBE,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2271,2,'N',v_old_data.ASF_MAXE_CREATE_DOC,v_new_data.ASF_MAXE_CREATE_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2272,2,'N',v_old_data.ASF_CREATE_COMPLAINT,v_new_data.ASF_CREATE_COMPLAINT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2273,2,'N',v_old_data.ASF_CREATE_APPEAL,v_new_data.ASF_CREATE_APPEAL,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2274,2,'N',v_old_data.ASF_HSDE_QC,v_new_data.ASF_HSDE_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2275,2,'N',v_old_data.ASF_MANUAL_LINK_DOC,v_new_data.ASF_MANUAL_LINK_DOC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2276,2,'N',v_old_data.ASF_DOCSETLINK_QC,v_new_data.ASF_DOCSETLINK_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2277,2,'N',v_old_data.ASF_RESOLVE_ESC_TASK,v_new_data.ASF_RESOLVE_ESC_TASK,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2278,2,'N',v_old_data.ASF_DATA_ENTRY,v_new_data.ASF_DATA_ENTRY,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2279,2,'N',v_old_data.ASF_MAXIMUS_QC,v_new_data.ASF_MAXIMUS_QC,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2280,2,'N',v_old_data.ASF_RESOLVE_ESC_TASK2,v_new_data.ASF_RESOLVE_ESC_TASK2,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2281,2,'N',v_old_data.ASF_TRANSMIT_TO_NYHBE,v_new_data.ASF_TRANSMIT_TO_NYHBE,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2282,2,'N',v_old_data.GWF_HSDE_QC_REQ,v_new_data.GWF_HSDE_QC_REQ,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2283,2,'N',v_old_data.GWF_AUTOLINK_SUCCESS,v_new_data.GWF_AUTOLINK_SUCCESS,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2284,2,'N',v_old_data.GWF_DOCSETLINK_QC_REQ,v_new_data.GWF_DOCSETLINK_QC_REQ,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2285,2,'N',v_old_data.GWF_DATA_ENTRY_REQ,v_new_data.GWF_DATA_ENTRY_REQ,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2286,2,'N',v_old_data.GWF_MAXIMUS_QC_REQ,v_new_data.GWF_MAXIMUS_QC_REQ,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2290,1,'N',v_old_data.LINKED_CLIENT,v_new_data.LINKED_CLIENT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2294,3,'N',v_old_data.CREATE_DT,v_new_data.CREATE_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2482,2,'N',v_old_data.KOFAX_DCN,v_new_data.KOFAX_DCN,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2489,2,'N',v_old_data.BATCH_NAME,v_new_data.BATCH_NAME,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2498,2,'N',v_old_data.ORIGINATION_DT,v_new_data.ORIGINATION_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2252,3,'N',v_old_data.MAXE_DOC_CREATE_DT,v_new_data.MAXE_DOC_CREATE_DT,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2609,2,'N',v_old_data.PREVIOUS_KOFAX_DCN,v_new_data.PREVIOUS_KOFAX_DCN,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2611,1,'N',v_old_data.APP_DOC_TRACKER_ID,v_new_data.APP_DOC_TRACKER_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2612,1,'N',v_old_data.DOC_NOTIFICATION_ID,v_new_data.DOC_NOTIFICATION_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2613,2,'N',v_old_data.DOC_NOTIFICATION_STATUS,v_new_data.DOC_NOTIFICATION_STATUS,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2614,2,'N',v_old_data.HX_ACCOUNT_ID,v_new_data.HX_ACCOUNT_ID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2615,2,'N',v_old_data.HXID,v_new_data.HXID,v_bue_id,v_stg_last_update_dt);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2616,1,'N',v_old_data.ACCOUNT_ID,v_new_data.ACCOUNT_ID,v_bue_id,v_stg_last_update_dt);
    
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
      
    v_old_data T_UPD_MFD_XML := null;
    v_new_data T_UPD_MFD_XML := null;
    
    v_bi_id number := null;
    v_identifier VARCHAR2(35) := null;
      
    v_start_date date := null;
    v_end_date date := null;
    
    v_fnmfdbd_id number := null;
     
    v_DNMFDDT_ID number := null;
    v_DNMFDDS_ID number := null;
    v_DNMFDES_ID number := null;
    v_DNMFDDST_ID number := null;
    v_DNMFDFT_ID number := null;
    v_DNMFDTS_ID number := null;
    v_DNMFDIS_ID number := null;
    
    v_jeopardy_flag varchar(2) := null;
--    v_sla_satisfied_count number := null;
    
    begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_MFD_XML(p_old_data_xml,v_old_data);
    GET_UPD_MFD_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select NYHIX_MFD_BI_ID 
    into v_bi_id
    from D_NYHIX_MFD_CURRENT
    where DCN = v_identifier;
      
      GET_DNMFDDT_ID(v_identifier,v_bi_id,v_new_data.DOC_TYPE_CD,v_dnmfddt_id);
      GET_DNMFDDS_ID(v_identifier,v_bi_id,v_new_data.DOC_STATUS_CD,v_dnmfdds_id);
      GET_DNMFDES_ID(v_identifier,v_bi_id,v_new_data.ENV_STATUS_CD,v_dnmfdes_id);
      GET_DNMFDDST_ID(v_identifier,v_bi_id,v_new_data.DOC_SUBTYPE_CD,v_dnmfddst_id);
      GET_DNMFDFT_ID(v_identifier,v_bi_id,v_new_data.FORM_TYPE_CD,v_dnmfdft_id);
      GET_DNMFDTS_ID(v_identifier,v_bi_id,GET_TIMELINESS_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_end_date,to_date(v_new_data.CANCEL_DT,BPM_COMMON.DATE_FMT)),v_dnmfdts_id);
      GET_DNMFDIS_ID(v_identifier,v_bi_id,v_new_data.INSTANCE_STATUS,v_dnmfdis_id);
      v_jeopardy_flag := GET_JEOPARDY_FLAG(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_end_date);
 /*    v_sla_satisfied_count := GET_SLA_SATISFIED_COUNT(to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT),v_new_data.channel,to_date(v_new_data.cancel_dt,BPM_COMMON.DATE_FMT), v_new_data.ENV_STATUS_CD); */
      
      -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
    SET_D_NYHIX_MF_CUR
        ('UPDATE',
         v_identifier,
         v_bi_id,
         v_new_data.DCN,
         v_new_data.KOFAX_DCN,
         v_new_data.CREATE_DT,
         v_new_data.ECN,
         v_new_data.INSTANCE_STATUS,
         v_new_data.INSTANCE_STATUS_DT,
         v_new_data.BATCH_ID,
         v_new_data.BATCH_NAME,
         v_new_data.CHANNEL,
         v_new_data.PAGE_COUNT,
         v_new_data.DOC_STATUS_CD,
         v_new_data.DOC_STATUS_DT,
         v_new_data.ENV_STATUS_CD,
         v_new_data.ENV_STATUS_DT,
         v_new_data.DOC_TYPE_CD,
         v_new_data.DOC_SUBTYPE_CD,
         v_new_data.FORM_TYPE_CD,
         v_new_data.FREE_FORM_TXT_IND,
         v_new_data.SCAN_DT,
         v_new_data.RELEASE_DT,
         v_new_data.ASSD_MAXE_CREATE_DOC,
         v_new_data.ASED_MAXE_CREATE_DOC,
         v_new_data.DOCUMENT_ID,
         v_new_data.DOC_SET_ID,
         v_new_data.MAXE_DOC_CREATE_DT,
         v_new_data.LANGUAGE,
         v_new_data.CURRENT_TASK_ID,
         v_new_data.CURRENT_STEP,
         v_new_data.ASSD_CREATE_COMPLAINT,
         v_new_data.ASED_CREATE_COMPLAINT,
         v_new_data.COMPLAINT_DE_TASK_ID,
         v_new_data.ASSD_CREATE_APPEAL,
         v_new_data.ASED_CREATE_APPEAL,
         v_new_data.APPEAL_DE_TASK_ID,
         v_new_data.INCIDENT_ID,
         v_new_data.ASSD_HSDE_QC,
         v_new_data.ASED_HSDE_QC,
         v_new_data.HSDE_ERR_IND,
         v_new_data.HSDE_QC_TASK_ID,
         v_new_data.ASSD_MANUAL_LINK_DOC,
         v_new_data.ASED_MANUAL_LINK_DOC,
         v_new_data.MANUAL_LINK_TASK_ID,
         v_new_data.ASSD_DOCSETLINK_QC,
         v_new_data.ASED_DOCSETLINK_QC,
         v_new_data.DOCSETLINK_QC_TASK_ID,
         v_new_data.ASSD_RESOLVE_ESC_TASK,
         v_new_data.ASED_RESOLVE_ESC_TASK,
         v_new_data.ESC_TASK_ID,
         v_new_data.ASSD_DATA_ENTRY,
         v_new_data.ASED_DATA_ENTRY,
         v_new_data.DE_TASK_ID,
         v_new_data.ASSD_MAXIMUS_QC,
         v_new_data.ASED_MAXIMUS_QC,
         v_new_data.MAXIMUS_QC_TASK_ID,
         v_new_data.ASSD_RESOLVE_ESC_TASK2,
         v_new_data.ASED_RESOLVE_ESC_TASK2,
         v_new_data.ESC_TASK_ID2,
         v_new_data.ASSD_TRANSMIT_TO_NYHBE,
         v_new_data.ASED_TRANSMIT_TO_NYHBE,
         v_new_data.CANCEL_DT,
         v_new_data.CANCEL_BY,
         v_new_data.CANCEL_REASON,
         v_new_data.CANCEL_METHOD,
         v_new_data.LINK_METHOD,
         v_new_data.LINK_ID,
         v_new_data.LINKED_CLIENT,
         v_new_data.COMPLETE_DT,
         v_new_data.RESCANNED_IND,
         v_new_data.RETURNED_MAIL_IND,
         v_new_data.RETURNED_MAIL_REASON,
         v_new_data.RESCAN_COUNT,
         v_new_data.UPDATED_BY,
         v_new_data.UPDATE_DT,
         v_new_data.TRASHED_IND,
         v_new_data.NOTE_ID,
         v_new_data.ORIG_DOC_TYPE_CD,
         v_new_data.ORIG_DOC_FORM_TYPE_CD,
         v_new_data.EXPEDITED_IND,
         v_new_data.RESEARCH_REQ_IND,
         v_new_data.ORIGINATION_DT,
         v_new_data.PREVIOUS_KOFAX_DCN,
         v_new_data.APP_DOC_TRACKER_ID,
         v_new_data.DOC_NOTIFICATION_ID,
         v_new_data.DOC_NOTIFICATION_STATUS,
         v_new_data.HX_ACCOUNT_ID,
         v_new_data.HXID,
         v_new_data.ACCOUNT_ID
        ); 
        
   UPD_FNMFDBD
        ( 
        v_identifier,
        v_start_date,
        v_end_date,
        v_bi_id,
        v_new_data.INSTANCE_STATUS_DT,
        v_dnmfdis_id,
        v_dnmfddt_id,
        v_dnmfdds_id,
        v_dnmfdes_id,
        v_dnmfddst_id,
        v_dnmfdft_id,
        v_dnmfdts_id,
        v_new_data.DOC_STATUS_DT,
        v_new_data.ENV_STATUS_DT,
        v_new_data.SCAN_DT,
        v_new_data.RELEASE_DT,
        v_jeopardy_flag,
  --      v_sla_satisfied_count,
        v_new_data.stg_last_update_dt,
        v_fnmfdbd_id 
        );
      
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