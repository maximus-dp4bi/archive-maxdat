create or replace package MAIL_FAX_BATCH as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxBatch/createdb/MAIL_FAX_BATCH_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 18919 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2016-12-14 15:58:56 -0500 (Wed, 14 Dec 2016) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DMFBCUR;

function GET_AGE_IN_BUSINESS_DAYS
      ( p_create_dt in date,
        p_batch_complete_dt in date
       )
  return number parallel_enable;

function GET_AGE_IN_CALENDAR_DAYS
    (p_create_dt in date,
     p_batch_complete_dt in date
     )
    return number parallel_enable;

function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_batch_complete_dt in date,
     p_cancel_dt in date
    )
return varchar2 parallel_enable;

function GET_TIMELINESS_DAYS
return number parallel_enable;

function GET_TIMELINESS_DAYS_TYPE
return varchar2 parallel_enable;


function GET_TIMELINESS_DT
(p_create_dt in date,
 p_batch_complete_dt in date,
 p_cancel_dt in date
 )
 return date parallel_enable;

function GET_JEOPARDY_FLAG
(p_create_dt in date,
 p_cancel_dt in date,  /**/
 p_batch_complete_dt in date
)
return varchar2 parallel_enable;

function GET_JEOPARDY_DAYS
return number parallel_enable;

function GET_JEOPARDY_DAYS_TYPE
return varchar2 parallel_enable;

function GET_JEOPARDY_DT
(p_create_dt in date,
 p_cancel_dt in date,
 p_batch_complete_dt in date
)
return date parallel_enable;

function GET_TARGET_DAYS
return number parallel_enable;

/*
  Include:
    CEMFBB_ID
    STG_LAST_UPDATE_DATE
  */

type T_INS_MFB_XML is record
    (
     ASED_CLASSIFICATION varchar2(19),
     ASED_CREATE_PDF varchar2(19),
     ASED_PERFORM_QC varchar2(19),
     ASED_POPULATE_REPORTS varchar2(19),
     ASED_RECOGNITION varchar2(19),
     ASED_RELEASE_DMS varchar2(19),
     ASED_SCAN_BATCH varchar2(19),
     ASED_VALIDATE_DATA varchar2(19),
     ASF_CLASSIFICATION varchar2(1),
     ASF_CREATE_PDF varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_POPULATE_REPORTS varchar2(1),
     ASF_RECOGNITION varchar2(1),
     ASF_RELEASE_DMS varchar2(1),
     ASF_SCAN_BATCH varchar2(1),
     ASF_VALIDATE_DATA varchar2(1),
     ASPB_PERFORM_QC varchar2(80),
     ASPB_SCAN_BATCH varchar2(80),
     ASPB_VALIDATE_DATA varchar2(80),
     ASPB_VALIDATE_DATA_USER_ID varchar2(32),
     ASSD_CLASSIFICATION varchar2(19),
     ASSD_CREATE_PDF varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_POPULATE_REPORTS varchar2(19),
     ASSD_RECOGNITION varchar2(19),
     ASSD_RELEASE_DMS varchar2(19),
     ASSD_SCAN_BATCH varchar2(19),
     ASSD_VALIDATE_DATA varchar2(19),
     BATCH_CLASS varchar2(32),
     BATCH_CLASS_DES varchar2(80),
     BATCH_COMPLETE_DT varchar2(19),
     BATCH_DELETED varchar2(1),
     BATCH_DESCRIPTION varchar2(80),
     BATCH_DOC_COUNT varchar2(100),
     BATCH_ENVELOPE_COUNT varchar2(100),
     BATCH_GUID varchar2(38),
     BATCH_ID varchar2(100),
     BATCH_NAME varchar2(255),
     BATCH_PAGE_COUNT varchar2(100),
     BATCH_PRIORITY varchar2(100),
     BATCH_TYPE varchar2(38),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(80),
     CANCEL_REASON varchar2(80),
     CEMFBB_ID varchar2(100),
     CLASSIFICATION_DT varchar2(19),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     CREATION_STATION_ID varchar2(32),
     CREATION_USER_ID varchar2(50),
     CREATION_USER_NAME varchar2(80),
     CURRENT_BATCH_MODULE_ID varchar2(38),
     CURRENT_STEP varchar2(100),
     DOCS_CREATED_FLAG varchar2(1),
     DOCS_DELETED_FLAG varchar2(1),
     GWF_QC_REQUIRED varchar2(1),
     INSTANCE_STATUS varchar2(30),
     INSTANCE_STATUS_DT varchar2(19),
     KOFAX_QC_REASON varchar2(100),
     PAGES_DELETED_FLAG varchar2(1),
     PAGES_REPLACED_FLAG varchar2(1),
     PAGES_SCANNED_FLAG varchar2(1),
     RECOGNITION_DT varchar2(19),
     REPROCESSED_FLAG varchar2(1),
     SOURCE_SERVER varchar2(255),
     STG_LAST_UPDATE_DATE varchar2(19),
     VALIDATION_DT varchar2(19)
);

 /*
  Include:
    STG_LAST_UPDATE_DATE
  */

type T_UPD_MFB_XML is record
    (
     ASED_CLASSIFICATION varchar2(19),
     ASED_CREATE_PDF varchar2(19),
     ASED_PERFORM_QC varchar2(19),
     ASED_POPULATE_REPORTS varchar2(19),
     ASED_RECOGNITION varchar2(19),
     ASED_RELEASE_DMS varchar2(19),
     ASED_SCAN_BATCH varchar2(19),
     ASED_VALIDATE_DATA varchar2(19),
     ASF_CLASSIFICATION varchar2(1),
     ASF_CREATE_PDF varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_POPULATE_REPORTS varchar2(1),
     ASF_RECOGNITION varchar2(1),
     ASF_RELEASE_DMS varchar2(1),
     ASF_SCAN_BATCH varchar2(1),
     ASF_VALIDATE_DATA varchar2(1),
     ASPB_PERFORM_QC varchar2(80),
     ASPB_SCAN_BATCH varchar2(80),
     ASPB_VALIDATE_DATA varchar2(80),
     ASPB_VALIDATE_DATA_USER_ID varchar2(32),
     ASSD_CLASSIFICATION varchar2(19),
     ASSD_CREATE_PDF varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_POPULATE_REPORTS varchar2(19),
     ASSD_RECOGNITION varchar2(19),
     ASSD_RELEASE_DMS varchar2(19),
     ASSD_SCAN_BATCH varchar2(19),
     ASSD_VALIDATE_DATA varchar2(19),
     BATCH_CLASS varchar2(32),
     BATCH_CLASS_DES varchar2(80),
     BATCH_COMPLETE_DT varchar2(19),
     BATCH_DELETED varchar2(1),
     BATCH_DESCRIPTION varchar2(80),
     BATCH_DOC_COUNT varchar2(100),
     BATCH_ENVELOPE_COUNT varchar2(100),
     BATCH_GUID varchar2(38),
     BATCH_ID varchar2(100),
     BATCH_NAME varchar2(255),
     BATCH_PAGE_COUNT varchar2(100),
     BATCH_PRIORITY varchar2(100),
     BATCH_TYPE varchar2(38),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(80),
     CANCEL_REASON varchar2(80),
     CLASSIFICATION_DT varchar2(19),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     CREATION_STATION_ID varchar2(32),
     CREATION_USER_ID varchar2(50),
     CREATION_USER_NAME varchar2(80),
     CURRENT_BATCH_MODULE_ID varchar2(38),
     CURRENT_STEP varchar2(100),
     DOCS_CREATED_FLAG varchar2(1),
     DOCS_DELETED_FLAG varchar2(1),
     GWF_QC_REQUIRED varchar2(1),
     INSTANCE_STATUS varchar2(30),
     INSTANCE_STATUS_DT varchar2(19),
     KOFAX_QC_REASON varchar2(100),
     PAGES_DELETED_FLAG varchar2(1),
     PAGES_REPLACED_FLAG varchar2(1),
     PAGES_SCANNED_FLAG varchar2(1),
     RECOGNITION_DT varchar2(19),
     REPROCESSED_FLAG varchar2(1),
     SOURCE_SERVER varchar2(255),
     STG_LAST_UPDATE_DATE varchar2(19),
     VALIDATION_DT varchar2(19)
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
 
 SHOW ERRORS
 
 create or replace package body MAIL_FAX_BATCH as

  v_bem_id number := 16; -- 'Process Mail fax batch'
  v_bil_id number := 4;
  v_bsl_id number := 16; -- 'CORP_ETL_MFB_BATCH'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD  HH24';

  v_calc_dmfbcur_job_name varchar2(30) := 'CALC_DMFBCUR';

  function GET_AGE_IN_BUSINESS_DAYS
      (p_create_dt in date,
       p_batch_complete_dt in date
       )
      return number parallel_enable
    as
    begin
    return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_batch_complete_dt,sysdate));
  end;

 function GET_AGE_IN_CALENDAR_DAYS
    (p_create_dt in date,
     p_batch_complete_dt in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_batch_complete_dt,sysdate)) - trunc(p_create_dt);
  end;

function GET_TIMELINESS_DAYS
return number parallel_enable
as
v_timeliness_days varchar2(2):=null;
begin
select out_var
into v_timeliness_days
from corp_etl_list_lkup
where name='MFB_TIMELINESS_DAYS';

return to_number(v_timeliness_days);
end;


function GET_TIMELINESS_DAYS_TYPE
return varchar2 parallel_enable
as
v_days_type varchar2(2):=null;
begin
select out_var
into v_days_type
from corp_etl_list_lkup
where name='MFB_TIMELINESS_DAYS_TYPE';

return v_days_type;
end;

function GET_JEOPARDY_DAYS
return number parallel_enable
as
v_jeopardy_days varchar2(2):=null;
begin
select out_var
into v_jeopardy_days
from corp_etl_list_lkup
where name='MFB_JEOPARDY_DAYS';

return to_number(v_jeopardy_days);
end;

function GET_JEOPARDY_DAYS_TYPE
return varchar2 parallel_enable
as
v_days_type varchar2(2):=null;
begin
select out_var
into v_days_type
from corp_etl_list_lkup
where name='MFB_JEOPARDY_DAYS_TYPE';

return v_days_type;
end;

function GET_TARGET_DAYS
return number parallel_enable
as
v_target_days varchar2(2):=null;
begin
select out_var
into v_target_days
from corp_etl_list_lkup
where name='MFB_TARGET_DAYS';

return to_number(v_target_days);
end;

function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_batch_complete_dt in date,
     p_cancel_dt in date
     )
return varchar2 parallel_enable
as
days_type varchar2(2):=null;
timeliness_days number:=null;
bus_days number :=null;
cal_days number :=null;
begin

if p_cancel_dt is not null then
 return 'Not Required';
end if;

days_type:=GET_TIMELINESS_DAYS_TYPE();
timeliness_days:=GET_TIMELINESS_DAYS();
bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_batch_complete_dt,sysdate));
cal_days:=trunc(nvl(p_batch_complete_dt,sysdate)) - trunc(p_create_dt);

if (p_batch_complete_dt is not null) then
 if (days_type='B') then
   if (bus_days<=timeliness_days)
   then return 'Timely';
   elsif (bus_days>timeliness_days)
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
elsif (p_batch_complete_dt is null)
then return 'Not Complete';
else
return null;
end if;
end;

 function GET_TIMELINESS_DT
 (p_create_dt in date,
  p_batch_complete_dt in date,
  p_cancel_dt in date
 )
 return date parallel_enable
 as
 days_type varchar2(2):=null;
 timeliness_days number:=null;
 v_timeliness varchar2(30):=null;
 begin
 v_timeliness:=GET_TIMELINESS_STATUS(p_create_dt,p_batch_complete_dt,p_cancel_dt);
 days_type:=GET_TIMELINESS_DAYS_TYPE();
 timeliness_days:=GET_TIMELINESS_DAYS();

 if(v_timeliness is not null) then
  return p_create_dt+timeliness_days;
  else return null;
 end if;
end;

 function GET_JEOPARDY_FLAG
 (p_create_dt in date,
  p_cancel_dt in date,  /**/
  p_batch_complete_dt in date
 )
return varchar2 parallel_enable
as
days_type varchar2(2):=null;
jeopardy_days number:=null;
bus_days number :=null;
cal_days number :=null;
begin

if p_cancel_dt is not null or p_batch_complete_dt is not null then
 return 'N/A';
end if;

days_type:=GET_JEOPARDY_DAYS_TYPE();
jeopardy_days:=GET_JEOPARDY_DAYS();
bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_batch_complete_dt,sysdate));
cal_days:=trunc(nvl(p_batch_complete_dt,sysdate)) - trunc(p_create_dt);

if(p_batch_complete_dt is null) then
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
else
return null;
end if;
end;


function GET_JEOPARDY_DT
(p_create_dt in date,
 p_cancel_dt in date, /**/
 p_batch_complete_dt in date
)
return date parallel_enable
as
 days_type varchar2(2):=null;
 jeopardy_days number:=null;
 v_jeopardy varchar2(3):=null;
begin
v_jeopardy:=GET_JEOPARDY_FLAG(p_create_dt,p_cancel_dt,p_batch_complete_dt);
 days_type:=GET_JEOPARDY_DAYS_TYPE();
 jeopardy_days:=GET_JEOPARDY_DAYS();

if (v_jeopardy is not null) then
  return p_create_dt+jeopardy_days;
 else return null;
 end if;
 end;

-- Calculate column values in BPM Semantic table D_MFB_CURRENT.
  procedure CALC_DMFBCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMFBCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

update D_MFB_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,BATCH_COMPLETE_DT),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DT,BATCH_COMPLETE_DT),
      TIMELINESS_STATUS    = GET_TIMELINESS_STATUS(CREATE_DT,BATCH_COMPLETE_DT,CANCEL_DT),
      TIMELINESS_DAYS      = GET_TIMELINESS_DAYS(),
      TIMELINESS_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
      TIMELINESS_DT        = GET_TIMELINESS_DT(CREATE_DT,BATCH_COMPLETE_DT,CANCEL_DT),
      JEOPARDY_FLAG        = GET_JEOPARDY_FLAG(CREATE_DT,CANCEL_DT,BATCH_COMPLETE_DT),
      JEOPARDY_DAYS        = GET_JEOPARDY_DAYS(),
      JEOPARDY_DAYS_TYPE   = GET_JEOPARDY_DAYS_TYPE(),
      JEOPARDY_DT          = GET_JEOPARDY_DT(CREATE_DT,CANCEL_DT,BATCH_COMPLETE_DT),
      TARGET_DAYS          = GET_TARGET_DAYS()

    where
      BATCH_COMPLETE_DT is null
      and CANCEL_DT is null;

    v_num_rows_updated := sql%rowcount;

 commit;

     v_log_message := v_num_rows_updated  || ' D_MFB_CURRENT rows updated with calculated attributes by CALC_DMFBCUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);

   exception

     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;


  -- Get record for Process Mail Fax Batch insert XML.
    procedure GET_INS_MFB_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_MFB_XML)
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MFB_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin

      select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CLASSIFICATION') "ASED_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_PDF') "ASED_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_QC') "ASED_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_POPULATE_REPORTS') "ASED_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECOGNITION') "ASED_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RELEASE_DMS') "ASED_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SCAN_BATCH') "ASED_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_VALIDATE_DATA') "ASED_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLASSIFICATION') "ASF_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_PDF') "ASF_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_POPULATE_REPORTS') "ASF_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECOGNITION') "ASF_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RELEASE_DMS') "ASF_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SCAN_BATCH') "ASF_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_VALIDATE_DATA') "ASF_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SCAN_BATCH') "ASPB_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_DATA') "ASPB_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_DATA_USER_ID') "ASPB_VALIDATE_DATA_USER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CLASSIFICATION') "ASSD_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_PDF') "ASSD_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_POPULATE_REPORTS') "ASSD_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECOGNITION') "ASSD_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RELEASE_DMS') "ASSD_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SCAN_BATCH') "ASSD_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_VALIDATE_DATA') "ASSD_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CLASS') "BATCH_CLASS",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CLASS_DES') "BATCH_CLASS_DES",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_COMPLETE_DT') "BATCH_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DELETED') "BATCH_DELETED",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DESCRIPTION') "BATCH_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DOC_COUNT') "BATCH_DOC_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ENVELOPE_COUNT') "BATCH_ENVELOPE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_GUID') "BATCH_GUID",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID') "BATCH_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME') "BATCH_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_PAGE_COUNT') "BATCH_PAGE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_PRIORITY') "BATCH_PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_TYPE') "BATCH_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CEMFBB_ID') "CEMFBB_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLASSIFICATION_DT') "CLASSIFICATION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_STATION_ID') "CREATION_STATION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_USER_ID') "CREATION_USER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_USER_NAME') "CREATION_USER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_BATCH_MODULE_ID') "CURRENT_BATCH_MODULE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCS_CREATED_FLAG') "DOCS_CREATED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCS_DELETED_FLAG') "DOCS_DELETED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_REQUIRED') "GWF_QC_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT') "INSTANCE_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_QC_REASON') "KOFAX_QC_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_DELETED_FLAG') "PAGES_DELETED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_REPLACED_FLAG') "PAGES_REPLACED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_SCANNED_FLAG') "PAGES_SCANNED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/RECOGNITION_DT') "RECOGNITION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPROCESSED_FLAG') "REPROCESSED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_SERVER') "SOURCE_SERVER",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/VALIDATION_DT') "VALIDATION_DT"
    into p_data_record
       from dual;

     exception

       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise;

  end;

-- Get record for Process Mail Fax Batch update XML.
  procedure GET_UPD_MFB_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MFB_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MFB_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

      select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CLASSIFICATION') "ASED_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_PDF') "ASED_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_QC') "ASED_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_POPULATE_REPORTS') "ASED_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECOGNITION') "ASED_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RELEASE_DMS') "ASED_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SCAN_BATCH') "ASED_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_VALIDATE_DATA') "ASED_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLASSIFICATION') "ASF_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_PDF') "ASF_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_POPULATE_REPORTS') "ASF_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECOGNITION') "ASF_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RELEASE_DMS') "ASF_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SCAN_BATCH') "ASF_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_VALIDATE_DATA') "ASF_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SCAN_BATCH') "ASPB_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_DATA') "ASPB_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_VALIDATE_DATA_USER_ID') "ASPB_VALIDATE_DATA_USER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CLASSIFICATION') "ASSD_CLASSIFICATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_PDF') "ASSD_CREATE_PDF",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_POPULATE_REPORTS') "ASSD_POPULATE_REPORTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECOGNITION') "ASSD_RECOGNITION",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RELEASE_DMS') "ASSD_RELEASE_DMS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SCAN_BATCH') "ASSD_SCAN_BATCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_VALIDATE_DATA') "ASSD_VALIDATE_DATA",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CLASS') "BATCH_CLASS",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CLASS_DES') "BATCH_CLASS_DES",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_COMPLETE_DT') "BATCH_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DELETED') "BATCH_DELETED",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DESCRIPTION') "BATCH_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_DOC_COUNT') "BATCH_DOC_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ENVELOPE_COUNT') "BATCH_ENVELOPE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_GUID') "BATCH_GUID",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID') "BATCH_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME') "BATCH_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_PAGE_COUNT') "BATCH_PAGE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_PRIORITY') "BATCH_PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_TYPE') "BATCH_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CLASSIFICATION_DT') "CLASSIFICATION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_STATION_ID') "CREATION_STATION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_USER_ID') "CREATION_USER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATION_USER_NAME') "CREATION_USER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_BATCH_MODULE_ID') "CURRENT_BATCH_MODULE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCS_CREATED_FLAG') "DOCS_CREATED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCS_DELETED_FLAG') "DOCS_DELETED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_REQUIRED') "GWF_QC_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS_DT') "INSTANCE_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_QC_REASON') "KOFAX_QC_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_DELETED_FLAG') "PAGES_DELETED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_REPLACED_FLAG') "PAGES_REPLACED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/PAGES_SCANNED_FLAG') "PAGES_SCANNED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/RECOGNITION_DT') "RECOGNITION_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPROCESSED_FLAG') "REPROCESSED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_SERVER') "SOURCE_SERVER",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/VALIDATION_DT') "VALIDATION_DT"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;

-- Insert fact for BPM Semantic model - Process Mail Fax Batch process.
    procedure INS_FMFBBH
    (p_identifier in varchar2,
     p_start_date in date,
     p_start_hour in number,
     p_end_date in date,
     p_bi_id in number,
     p_stg_last_update_date in varchar2,
     p_FMFBBH_ID out number)
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FMFBBH';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
         v_stg_last_update_date date := null;
         v_incident_status_dt date :=null;
         v_last_update_date date:=null;
    begin
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      p_FMFBBH_ID := SEQ_FMFBBH_ID.nextval;

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

insert into F_MFB_BY_HOUR
        ( FMFBBH_ID,
      D_DATE,
      BUCKET_START_DATE,
      BUCKET_END_DATE,
      MFB_BI_ID,
      INVENTORY_COUNT,
      CREATION_COUNT,
      COMPLETION_COUNT
      )
    values
    ( p_FMFBBH_ID,
      p_start_date,
      v_bucket_start_date,
      v_bucket_end_date,
      p_bi_id,
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


-- Insert or update dimension for BPM Semantic model - Process Mail Fax Batch process - Current.
  procedure SET_DMFBCUR
  (p_set_type               in           varchar2,
   p_identifier                     in           varchar2,
   p_bi_id                          in           number,
   p_batch_id                   in           number,
   p_batch_name             in       varchar2,
   p_creation_station_id        in       varchar2,
   p_batch_created_by           in       varchar2,
   p_creation_user_id           in       varchar2,
   p_batch_class            in       varchar2,
   p_batch_class_description        in       varchar2,
   p_batch_type             in       varchar2,
   p_create_dt                  in       varchar2,
   p_complete_dt                in       varchar2,
   p_instance_status            in       varchar2,
   p_instance_status_dt         in       varchar2,
   p_batch_page_count           in       number,
   p_batch_doc_count            in       number,
   p_batch_envelope_count       in       number,
   p_cancel_dt                  in       varchar2,
   p_cancel_by                      in       varchar2,
   p_scan_batch_flag            in       varchar2,
   p_perform_scan_start         in       varchar2,
   p_perform_scan_end           in       varchar2,
   p_perform_scan_performed_by      in       varchar2,
   p_perform_qc_flag            in       varchar2,
   p_perform_qc_start           in       varchar2,
   p_perform_qc_end             in       varchar2,
   p_perform_qc_performed_by        in       varchar2,
   p_kofax_qc_reason            in       varchar2,
   p_classification_flag        in       varchar2,
   p_classification_start       in       varchar2,
   p_classification_end         in       varchar2,
   p_classification_dt          in       varchar2,
   p_recognition_flag           in       varchar2,
   p_recognition_start          in       varchar2,
   p_recognition_end            in       varchar2,
   p_recognition_dt             in       varchar2,
   p_validate_data_flag         in       varchar2,
   p_validate_data_start        in       varchar2,
   p_validate_data_end          in       varchar2,
   p_validate_data_performed_by     in       varchar2,
   p_validate_data_perf_by_userid     in        varchar2,
   p_validation_dt          in       varchar2,
   p_create_pdf_flag            in       varchar2,
   p_create_pdfs_start          in       varchar2,
   p_create_pdfs_end            in       varchar2,
   p_populate_reports_data_flag     in       varchar2,
   p_populate_reports_data_start    in       varchar2,
   p_populate_reports_data_end      in       varchar2,
   p_release_to_dms_flag        in       varchar2,
   p_release_to_dms_start       in       varchar2,
   p_release_to_dms_end         in       varchar2,
   --p_batch_priority?          in       number,
   p_batch_priority                 in           number,
   p_batch_deleted          in       varchar2,
   p_pages_scanned          in       varchar2,
   p_documents_created          in       varchar2,
   p_documents_deleted          in       varchar2,
   p_pages_replaced_flag        in       varchar2,
   p_pages_deleted_flag         in       varchar2,
   p_cancel_reason                  in           varchar2,
   p_cancel_method                  in           varchar2,
   p_batch_complete_dt                  in           varchar2,
   p_current_batch_module_id                  in           varchar2,
   p_gwf_qc_required                  in           varchar2,
   p_current_step                  in           varchar2,
   p_batch_guid                  in           varchar2,
   p_source_server                  in           varchar2,
   p_batch_description              in           varchar2,
   p_reprocessed_flag               in          varchar2
   )

 as
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMFBCUR';
        v_sql_code number := null;
        v_log_message clob := null;
        r_dmfbcur D_MFB_CURRENT%rowtype := null;
        v_jeopardy_flag varchar2(3) := null;
  begin

r_dmfbcur.MFB_BI_ID              :=   p_bi_id;

r_dmfbcur.BATCH_ID                :=         p_batch_id ;
r_dmfbcur.BATCH_NAME              :=         p_batch_name;
r_dmfbcur.CREATION_STATION_ID         :=         p_creation_station_id;
r_dmfbcur.BATCH_CREATED_BY        :=         p_batch_created_by ;
r_dmfbcur.CREATION_USER_ID        :=         p_creation_user_id ;
r_dmfbcur.BATCH_CLASS             :=         p_batch_class;
r_dmfbcur.BATCH_CLASS_DESCRIPTION     :=         p_batch_class_description  ;
r_dmfbcur.BATCH_TYPE              :=         p_batch_type ;
r_dmfbcur.CREATE_DT                   :=         to_date(p_create_dt,BPM_COMMON.DATE_FMT);
r_dmfbcur.COMPLETE_DT                 :=         to_date(p_complete_dt,BPM_COMMON.DATE_FMT);
r_dmfbcur.INSTANCE_STATUS         :=         p_instance_status ;
r_dmfbcur.INSTANCE_STATUS_DT          :=         to_date(p_instance_status_dt,BPM_COMMON.DATE_FMT);
r_dmfbcur.BATCH_PAGE_COUNT        :=         p_batch_page_count ;
r_dmfbcur.BATCH_DOC_COUNT         :=         p_batch_doc_count  ;
r_dmfbcur.BATCH_ENVELOPE_COUNT        :=         p_batch_envelope_count;
r_dmfbcur.CANCEL_DT                   :=         to_date(p_cancel_dt,BPM_COMMON.DATE_FMT);
r_dmfbcur.CANCEL_BY                       :=         p_cancel_by ;
r_dmfbcur.SCAN_BATCH_FLAG         :=         p_scan_batch_flag ;
r_dmfbcur.PERFORM_SCAN_START          :=         to_date(p_perform_scan_start,BPM_COMMON.DATE_FMT);
r_dmfbcur.PERFORM_SCAN_END        :=         to_date(p_perform_scan_end,BPM_COMMON.DATE_FMT);
r_dmfbcur.PERFORM_SCAN_PERFORMED_BY       :=         p_perform_scan_performed_by ;
r_dmfbcur.PERFORM_QC_FLAG         :=         p_perform_qc_flag;
r_dmfbcur.PERFORM_QC_START        :=         to_date(p_perform_qc_start,BPM_COMMON.DATE_FMT);
r_dmfbcur.PERFORM_QC_END          :=         to_date(p_perform_qc_end ,BPM_COMMON.DATE_FMT);
r_dmfbcur.PERFORM_QC_PERFORMED_BY     :=         p_perform_qc_performed_by ;
r_dmfbcur.KOFAX_QC_REASON         :=         p_kofax_qc_reason ;
r_dmfbcur.CLASSIFICATION_FLAG         :=         p_classification_flag ;
r_dmfbcur.CLASSIFICATION_START        :=         to_date(p_classification_start ,BPM_COMMON.DATE_FMT);
r_dmfbcur.CLASSIFICATION_END          :=         to_date(p_classification_end,BPM_COMMON.DATE_FMT);
r_dmfbcur.CLASSIFICATION_DT           :=         to_date(p_classification_dt ,BPM_COMMON.DATE_FMT);
r_dmfbcur.RECOGNITION_FLAG        :=         p_recognition_flag ;
r_dmfbcur.RECOGNITION_START           :=         to_date(p_recognition_start ,BPM_COMMON.DATE_FMT);
r_dmfbcur.RECOGNITION_END         :=         to_date(p_recognition_end ,BPM_COMMON.DATE_FMT);
r_dmfbcur.RECOGNITION_DT          :=         to_date(p_recognition_dt ,BPM_COMMON.DATE_FMT);
r_dmfbcur.VALIDATE_DATA_FLAG          :=         p_validate_data_flag ;
r_dmfbcur.VALIDATE_DATA_START         :=         to_date(p_validate_data_start,BPM_COMMON.DATE_FMT);
r_dmfbcur.VALIDATE_DATA_END           :=         to_date(p_validate_data_end ,BPM_COMMON.DATE_FMT);
r_dmfbcur.VALIDATE_DATA_PERFORMED_BY      :=         p_validate_data_performed_by  ;
r_dmfbcur.VALIDATE_DATA_PERF_BY_USER_ID       :=            p_validate_data_perf_by_userid  ;
r_dmfbcur.VALIDATION_DT           :=         to_date(p_validation_dt ,BPM_COMMON.DATE_FMT);
r_dmfbcur.CREATE_PDF_FLAG         :=         p_create_pdf_flag ;
r_dmfbcur.CREATE_PDFS_START           :=         to_date(p_create_pdfs_start ,BPM_COMMON.DATE_FMT);
r_dmfbcur.CREATE_PDFS_END         :=         to_date(p_create_pdfs_end,BPM_COMMON.DATE_FMT);
r_dmfbcur.POPULATE_REPORTS_DATA_FLAG      :=         p_populate_reports_data_flag  ;
r_dmfbcur.POPULATE_REPORTS_DATA_START     :=         to_date(p_populate_reports_data_start ,BPM_COMMON.DATE_FMT);
r_dmfbcur.POPULATE_REPORTS_DATA_END       :=         to_date(p_populate_reports_data_end ,BPM_COMMON.DATE_FMT);
r_dmfbcur.RELEASE_TO_DMS_FLAG         :=         p_release_to_dms_flag ;
r_dmfbcur.RELEASE_TO_DMS_START        :=         to_date(p_release_to_dms_start ,BPM_COMMON.DATE_FMT);
r_dmfbcur.RELEASE_TO_DMS_END          :=         to_date(p_release_to_dms_end ,BPM_COMMON.DATE_FMT);
r_dmfbcur.BATCH_PRIORITY                  :=         p_batch_priority;
r_dmfbcur.BATCH_DELETED           :=         p_batch_deleted ;
r_dmfbcur.PAGES_SCANNED           :=         p_pages_scanned ;
r_dmfbcur.DOCUMENTS_CREATED           :=         p_documents_created ;
r_dmfbcur.DOCUMENTS_DELETED           :=         p_documents_deleted ;
r_dmfbcur.PAGES_REPLACED_FLAG         :=         p_pages_replaced_flag ;
r_dmfbcur.PAGES_DELETED_FLAG          :=         p_pages_deleted_flag ;
r_dmfbcur.CANCEL_REASON           :=          p_cancel_reason;
r_dmfbcur.CANCEL_METHOD                   :=          p_cancel_method;
r_dmfbcur.BATCH_COMPLETE_DT           :=       to_date(p_batch_complete_dt ,BPM_COMMON.DATE_FMT);
r_dmfbcur.CURRENT_BATCH_MODULE_ID         :=         p_current_batch_module_id ;
r_dmfbcur.GWF_QC_REQUIRED         :=         p_gwf_qc_required ;
r_dmfbcur.CURRENT_STEP        :=         p_current_step;
r_dmfbcur.batch_guid          :=         p_batch_guid;
r_dmfbcur.SOURCE_SERVER           :=         p_source_server;
r_dmfbcur.BATCH_DESCRIPTION         :=          p_batch_description;
r_dmfbcur.REPROCESSED_FLAG          :=          p_reprocessed_flag;

r_dmfbcur.AGE_IN_BUSINESS_DAYS               :=   GET_AGE_IN_BUSINESS_DAYS(r_dmfbcur.CREATE_DT,r_dmfbcur.BATCH_COMPLETE_DT);
r_dmfbcur.AGE_IN_CALENDAR_DAYS               :=   GET_AGE_IN_CALENDAR_DAYS(r_dmfbcur.CREATE_DT,r_dmfbcur.BATCH_COMPLETE_DT);
r_dmfbcur.TIMELINESS_STATUS                  :=   GET_TIMELINESS_STATUS(r_dmfbcur.CREATE_DT,r_dmfbcur.BATCH_COMPLETE_DT,r_dmfbcur.CANCEL_DT);
r_dmfbcur.TIMELINESS_DAYS            :=   GET_TIMELINESS_DAYS();
r_dmfbcur.TIMELINESS_DAYS_TYPE           :=   GET_TIMELINESS_DAYS_TYPE();
r_dmfbcur.TIMELINESS_DT                  :=   GET_TIMELINESS_DT(r_dmfbcur.CREATE_DT,r_dmfbcur.BATCH_COMPLETE_DT,r_dmfbcur.CANCEL_DT);
r_dmfbcur.JEOPARDY_FLAG              :=   GET_JEOPARDY_FLAG(r_dmfbcur.CREATE_DT,r_dmfbcur.CANCEL_DT,r_dmfbcur.BATCH_COMPLETE_DT);
r_dmfbcur.JEOPARDY_DAYS              :=   GET_JEOPARDY_DAYS();
r_dmfbcur.JEOPARDY_DAYS_TYPE                 :=   GET_JEOPARDY_DAYS_TYPE();
r_dmfbcur.JEOPARDY_DT                :=   GET_JEOPARDY_DT(r_dmfbcur.CREATE_DT,r_dmfbcur.CANCEL_DT,r_dmfbcur.BATCH_COMPLETE_DT);
r_dmfbcur.TARGET_DAYS                :=   GET_TARGET_DAYS();


if p_set_type = 'INSERT' then
       insert into D_MFB_CURRENT
       values r_dmfbcur;
     elsif p_set_type = 'UPDATE' then
       begin
         update D_MFB_CURRENT
         set row = r_dmfbcur
         where MFB_BI_ID = p_bi_id;
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

    v_new_data T_INS_MFB_XML := null;

    v_bi_id number := null;
    v_identifier varchar2(100) := null;

    v_start_date date := null;
    v_end_date date := null;
    v_start_hour number :=null;


    v_FMFBBH_ID number := null;

    begin

        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Mail Fax Batch in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_INS_MFB_XML(p_new_data_xml,v_new_data);

        v_identifier := v_new_data.BATCH_GUID ;
        v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.BATCH_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_start_hour:= to_number(to_char((v_start_date),'HH24'));
        v_bi_id := SEQ_BI_ID.nextval;

 -- Insert current dimension and fact as a single transaction.
    begin

      commit;
   SET_DMFBCUR
   ('INSERT',v_identifier,v_bi_id,
     v_new_data.BATCH_ID,v_new_data.BATCH_NAME,v_new_data.CREATION_STATION_ID,v_new_data.CREATION_USER_NAME,v_new_data.CREATION_USER_ID,v_new_data.BATCH_CLASS,v_new_data.BATCH_CLASS_DES,
     v_new_data.BATCH_TYPE,v_new_data.CREATE_DT,v_new_data.COMPLETE_DT,v_new_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS_DT
     ,v_new_data.BATCH_PAGE_COUNT,v_new_data.BATCH_DOC_COUNT    ,v_new_data.BATCH_ENVELOPE_COUNT,v_new_data.CANCEL_DT,v_new_data.CANCEL_BY,v_new_data.ASF_SCAN_BATCH,
     v_new_data.ASSD_SCAN_BATCH,v_new_data.ASED_SCAN_BATCH,v_new_data.ASPB_SCAN_BATCH,v_new_data.ASF_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.ASED_PERFORM_QC,v_new_data.ASPB_PERFORM_QC
     ,v_new_data.KOFAX_QC_REASON,v_new_data.ASF_CLASSIFICATION,v_new_data.ASSD_CLASSIFICATION,v_new_data.ASED_CLASSIFICATION    ,v_new_data.CLASSIFICATION_DT,v_new_data.ASF_RECOGNITION,
     v_new_data.ASSD_RECOGNITION,v_new_data.ASED_RECOGNITION    ,v_new_data.RECOGNITION_DT,v_new_data.ASF_VALIDATE_DATA ,v_new_data.ASSD_VALIDATE_DATA  ,v_new_data.ASED_VALIDATE_DATA
     ,v_new_data.ASPB_VALIDATE_DATA ,v_new_data.ASPB_VALIDATE_DATA_USER_ID  ,v_new_data.VALIDATION_DT,v_new_data.ASF_CREATE_PDF,v_new_data.ASSD_CREATE_PDF,v_new_data.ASED_CREATE_PDF,v_new_data.ASF_POPULATE_REPORTS
     ,v_new_data.ASSD_POPULATE_REPORTS,v_new_data.ASED_POPULATE_REPORTS,v_new_data.ASF_RELEASE_DMS,v_new_data.ASSD_RELEASE_DMS,v_new_data.ASED_RELEASE_DMS,v_new_data.BATCH_PRIORITY
     ,v_new_data.BATCH_DELETED,v_new_data.PAGES_SCANNED_FLAG,v_new_data.DOCS_CREATED_FLAG,v_new_data.DOCS_DELETED_FLAG,v_new_data.PAGES_REPLACED_FLAG,v_new_data.PAGES_DELETED_FLAG,
     v_new_data.CANCEL_REASON,v_new_data.CANCEL_METHOD,v_new_data.BATCH_COMPLETE_DT,v_new_data.CURRENT_BATCH_MODULE_ID,v_new_data.GWF_QC_REQUIRED,v_new_data.CURRENT_STEP
     ,v_new_data.BATCH_GUID,v_new_data.SOURCE_SERVER,v_new_data.BATCH_DESCRIPTION,v_new_data.REPROCESSED_FLAG
   );

INS_FMFBBH
        (v_identifier ,v_start_date ,v_start_hour,v_end_date ,v_bi_id,v_new_data.stg_last_update_date,v_FMFBBH_ID
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

 -- Update fact for BPM Semantic model - Mail Fax Batch Process
    procedure UPD_FMFBBH
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_stg_last_update_date in varchar2,
       p_FMFBBH_ID out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FMFBBH';
    v_sql_code number := null;
    v_log_message clob := null;

    v_FMFBBH_ID_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_last_update_date date := null;
    v_event_date date := null;


    v_FMFBBH_ID  number    := null;



       r_FMFBBH F_MFB_BY_HOUR%rowtype := null;
  begin

        v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
        v_event_date := v_stg_last_update_date;


     v_FMFBBH_ID  := p_FMFBBH_ID;

  with most_recent_fact_bi_id as
           (select
              max(FMFBBH_ID) max_FMFBBH_ID,
              max(D_DATE) max_d_date
            from F_MFB_BY_HOUR
            where MFB_BI_ID = p_bi_id)
         select
           FMFBBH.FMFBBH_ID,
           FMFBBH.D_DATE,
           FMFBBH.CREATION_COUNT,
           FMFBBH.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into
           v_FMFBBH_ID_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from
           F_MFB_BY_HOUR FMFBBH,
           most_recent_fact_bi_id
         where
           FMFBBH.FMFBBH_ID = max_FMFBBH_ID
      and FMFBBH.D_DATE = most_recent_fact_bi_id.max_d_date;

       -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;

    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;

    if p_end_date is null then
      r_FMFBBH.D_DATE := v_event_date;
      r_FMFBBH.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_FMFBBH.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_FMFBBH.INVENTORY_COUNT := 1;
      r_FMFBBH.COMPLETION_COUNT := 0;
    else
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then

            delete from F_MFB_BY_HOUR
            where
              MFB_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);

 with most_recent_fact_bi_id as
              (select
                 max(FMFBBH_ID) max_FMFBBH_ID,
                 max(D_DATE) max_d_date
               from F_MFB_BY_HOUR
           where MFB_BI_ID = p_bi_id)
           select
                 FMFBBH.FMFBBH_ID,
                 FMFBBH.D_DATE,
               FMFBBH.CREATION_COUNT,
                 FMFBBH.COMPLETION_COUNT,
                 most_recent_fact_bi_id.max_d_date
               into
                 v_FMFBBH_ID_old,
                 v_d_date_old,
                 v_creation_count_old,
                 v_completion_count_old,
                 v_max_d_date
              from
                 F_MFB_BY_HOUR FMFBBH,
                 most_recent_fact_bi_id
               where
                 FMFBBH.FMFBBH_ID = max_FMFBBH_ID
          and FMFBBH.D_DATE = most_recent_fact_bi_id.max_d_date;

      end if;

      r_FMFBBH.D_DATE := p_end_date;
      r_FMFBBH.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_FMFBBH.BUCKET_END_DATE := r_FMFBBH.BUCKET_START_DATE;
      r_FMFBBH.INVENTORY_COUNT := 0;
      r_FMFBBH.COMPLETION_COUNT := 1;

    end if;

     p_FMFBBH_ID := SEQ_FMFBBH_ID.nextval;
    r_FMFBBH.FMFBBH_ID := p_FMFBBH_ID;
    r_FMFBBH.MFB_BI_ID := p_bi_id;
    r_FMFBBH.CREATION_COUNT := 0;

-- Validate fact date ranges.
     if r_FMFBBH.D_DATE < r_FMFBBH.BUCKET_START_DATE
       or to_date(to_char(r_FMFBBH.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_FMFBBH.BUCKET_END_DATE
       or r_FMFBBH.BUCKET_START_DATE > r_FMFBBH.BUCKET_END_DATE
       or r_FMFBBH.BUCKET_END_DATE < r_FMFBBH.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' ||
         'D_DATE = ' || r_FMFBBH.D_DATE ||
         ' BUCKET_START_DATE = ' || to_char(r_FMFBBH.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_FMFBBH.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_FMFBBH.BUCKET_START_DATE then

      -- Same bucket time.

      if v_creation_count_old = 1 then
        r_FMFBBH.CREATION_COUNT := v_creation_count_old;
      end if;

      update F_MFB_BY_HOUR
      set row = r_FMFBBH
      where FMFBBH_ID = v_FMFBBH_ID_old;

    else

     -- Different bucket time.

          update F_MFB_BY_HOUR
          set BUCKET_END_DATE = r_FMFBBH.BUCKET_START_DATE
          where FMFBBH_ID = v_FMFBBH_ID_old;

          insert into F_MFB_BY_HOUR
          values r_FMFBBH;

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

      v_old_data T_UPD_MFB_XML := null;
      v_new_data T_UPD_MFB_XML := null;

      v_bi_id number := null;
      v_identifier varchar2(100) := null;

      v_start_date date := null;
      v_end_date date := null;


    v_FMFBBH_ID  number    := null;

    begin

        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Process Mail Fax Batch in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_UPD_MFB_XML(p_old_data_xml,v_old_data);
        GET_UPD_MFB_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.BATCH_GUID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.BATCH_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select MFB_BI_ID
    into v_bi_id
    from D_MFB_CURRENT
    where BATCH_GUID = v_identifier;

     -- Update current dimension and fact as a single transaction.
    begin

      commit;

SET_DMFBCUR
   ('UPDATE',v_identifier,v_bi_id,
     v_new_data.BATCH_ID,v_new_data.BATCH_NAME,v_new_data.CREATION_STATION_ID,v_new_data.CREATION_USER_NAME,v_new_data.CREATION_USER_ID,v_new_data.BATCH_CLASS,v_new_data.BATCH_CLASS_DES,
     v_new_data.BATCH_TYPE,v_new_data.CREATE_DT,v_new_data.COMPLETE_DT,v_new_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS_DT
     ,v_new_data.BATCH_PAGE_COUNT,v_new_data.BATCH_DOC_COUNT    ,v_new_data.BATCH_ENVELOPE_COUNT,v_new_data.CANCEL_DT,v_new_data.CANCEL_BY,v_new_data.ASF_SCAN_BATCH,
     v_new_data.ASSD_SCAN_BATCH,v_new_data.ASED_SCAN_BATCH,v_new_data.ASPB_SCAN_BATCH,v_new_data.ASF_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.ASED_PERFORM_QC,v_new_data.ASPB_PERFORM_QC
     ,v_new_data.KOFAX_QC_REASON,v_new_data.ASF_CLASSIFICATION,v_new_data.ASSD_CLASSIFICATION,v_new_data.ASED_CLASSIFICATION    ,v_new_data.CLASSIFICATION_DT,v_new_data.ASF_RECOGNITION,
     v_new_data.ASSD_RECOGNITION,v_new_data.ASED_RECOGNITION    ,v_new_data.RECOGNITION_DT,v_new_data.ASF_VALIDATE_DATA ,v_new_data.ASSD_VALIDATE_DATA  ,v_new_data.ASED_VALIDATE_DATA
     ,v_new_data.ASPB_VALIDATE_DATA ,v_new_data.ASPB_VALIDATE_DATA_USER_ID  ,v_new_data.VALIDATION_DT,v_new_data.ASF_CREATE_PDF,v_new_data.ASSD_CREATE_PDF,v_new_data.ASED_CREATE_PDF,v_new_data.ASF_POPULATE_REPORTS
     ,v_new_data.ASSD_POPULATE_REPORTS,v_new_data.ASED_POPULATE_REPORTS,v_new_data.ASF_RELEASE_DMS,v_new_data.ASSD_RELEASE_DMS,v_new_data.ASED_RELEASE_DMS,v_new_data.BATCH_PRIORITY
     ,v_new_data.BATCH_DELETED,v_new_data.PAGES_SCANNED_FLAG,v_new_data.DOCS_CREATED_FLAG,v_new_data.DOCS_DELETED_FLAG,v_new_data.PAGES_REPLACED_FLAG,v_new_data.PAGES_DELETED_FLAG,
     v_new_data.CANCEL_REASON,v_new_data.CANCEL_METHOD,v_new_data.BATCH_COMPLETE_DT,v_new_data.CURRENT_BATCH_MODULE_ID,v_new_data.GWF_QC_REQUIRED,v_new_data.CURRENT_STEP
     ,v_new_data.BATCH_GUID,v_new_data.SOURCE_SERVER,v_new_data.BATCH_DESCRIPTION,v_new_data.REPROCESSED_FLAG
   );

UPD_FMFBBH
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id,v_new_data.stg_last_update_date,v_FMFBBH_ID
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

SHOW ERRORS
