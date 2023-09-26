create or replace PACKAGE          "NYHIX_MAIL_FAX_DOC_V2" as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/MailFaxDocV2/createdb/NYHIX_MAIL_FAX_DOC_V2_pkg.sql $';
 SVN_REVISION varchar2(20) := '$Revision: 26069 $';
 SVN_REVISION_DATE varchar2(60) := '$Date: 2019-01-25 12:51:02 -0800 (Fri, 25 Jan 2019) $';
 SVN_REVISION_AUTHOR varchar2(20) := '$Author: ps71980 $';

procedure CALC_D_NYHIX_MFD_CUR_V2;

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

function GET_DOC_TYPE
(p_doc_type in varchar2)
return varchar2 parallel_enable;

function GET_DOC_STATUS
 (p_doc_status in varchar2)
return varchar2 parallel_enable;

function GET_JEOPARDY_FLAG
(p_create_dt in date,
 p_complete_dt in date)
return varchar2 parallel_enable;

function GET_TIMELINESS_STATUS
(p_create_dt in date,
 p_complete_dt in date)
return varchar2 parallel_enable;

function GET_TIMELINESS_DT
(p_create_dt in date)
return date parallel_enable;

function GET_SLA_RECEIVED_DT
(p_create_dt in date,
 p_received_dt in date,
 p_scan_dt in date)
return date parallel_enable;

function GET_SLA_TIMELINESS_STATUS
(p_doc_type in varchar2,
 p_sla_complete_flag in varchar2,
 p_sla_complete_dt in date,
 p_create_dt in date,
 p_received_dt in date,
 p_scan_dt in date)
return varchar2 parallel_enable;

function GET_SLA_BUS_DAYS
 (p_create_dt in date,
  p_received_dt in date,
  p_scan_dt in date,
  p_sla_complete_dt in date)
return number parallel_enable;

function GET_SLA_JEOPARDY_FLAG
(p_create_dt in date,
  p_received_dt in date,
 p_scan_dt in date,
  p_sla_complete_dt in date)
return varchar2 parallel_enable;

function GET_RECVD_2_SCAN_AGE_BUS_DAYS
(p_received_dt in date,
 p_scan_dt in date)
 return number parallel_enable;

function GET_RECVD_2_SCAN_AGE_CAL_DAYS
(p_received_dt in date,
 p_scan_dt in date)
 return number parallel_enable;

type T_INS_MFD_V2_XML is record
  (APP_DOC_DATA_ID varchar2(100) ,
   APP_DOC_TRACKER_ID varchar2(100) ,
   APP_DOC_REDACTION_DATA_ID varchar2(100),
   ASF_CANCEL_DOC   varchar2(1) ,
   ASF_PROCESS_DOC varchar2(1) ,
   AUTO_LINKED_IND varchar2(1),
   BATCH_ID varchar2(4000) ,
   BATCH_NAME varchar2(256) ,
   CANCEL_BY varchar2(32) ,
   CANCEL_DT varchar2(19),
   CANCEL_METHOD varchar2(32) ,
   CANCEL_REASON varchar2(32) ,
   CHANNEL varchar2(32) ,
   COMPLETE_DT varchar2(19),
   CREATE_DT varchar2(19),
   DCN varchar2(256) ,
   DOC_STATUS_CD varchar2(32) ,
   DOC_STATUS_DT varchar2(19),
   DOC_TYPE_CD varchar2(256) ,
   DOC_UPDATE_DT varchar2(19),
   DOC_UPDATED_BY varchar2(32) ,
   DOC_UPDATED_BY_STAFF_ID varchar2(50) ,
   ECN varchar2(256) ,
   EEMFDB_ID varchar2(100),
   ENV_STATUS varchar2(256) ,
   ENV_STATUS_CD varchar2(32) ,
   ENV_STATUS_DT varchar2(19),
   ENV_UPDATE_DT varchar2(19),
   ENV_UPDATED_BY varchar2(32) ,
   ENV_UPDATED_BY_STAFF_ID varchar2(50) ,
   EXPEDIATED_IND varchar2(1)   ,
   FORM_TYPE varchar2(256),
   FORM_TYPE_CD varchar2(256) ,
   FREE_FORM_TXT_IND varchar2(1) ,
   INSTANCE_END_DATE varchar2(19),
   INSTANCE_START_DATE varchar2(19),
   INSTANCE_STATUS varchar2(32) ,
   KOFAX_DCN varchar2(256) ,
   LAST_EVENT_DATE varchar2(19),
   LINK_DT varchar2(19),
   LINK_ID varchar2(100),
   LINKED_CLIENT varchar2(100),
   MAXE_ORIGINATION_DT varchar2(19),
   MINOR_APPLICANT_FLAG varchar2(1),
   NOTE_ID varchar2(32) ,
   ORIG_DOC_FORM_TYPE_CD varchar2(256) ,
   ORIG_DOC_TYPE_CD varchar2(256) ,
   PAGE_COUNT varchar2(100) ,
   PREVIOUS_KOFAX_DCN varchar2(256) ,
   PRIORITY varchar2(2) ,
   RECEIVED_DT varchar2(19),
   REDACTED_INFO_FLAG varchar2(1),
   RELEASE_DT varchar2(19),
   RESCAN_COUNT varchar2(100),
   RESCANNED_IND varchar2(1) ,
   RESEARCH_REQ_IND varchar2(1),
   RETURNED_MAIL_IND varchar2(1) ,
   RETURNED_MAIL_REASON varchar2(32) ,
   SCAN_DT varchar2(19),
   SLA_COMPLETE varchar2(1) ,
   SLA_COMPLETE_DT varchar2(19),
   STG_DONE_DATE varchar2(19) ,
   STG_EXTRACT_DATE varchar2(19) ,
   STG_LAST_UPDATE_DATE varchar2(19),
   TR_DOC_STATUS_CD varchar2(32),
   TRASHED_BY varchar2(32) ,
   TRASHED_DT varchar2(19),
   TRASHED_IND varchar2(100));

type T_UPD_MFD_V2_XML is record
  (APP_DOC_DATA_ID varchar2(100) ,
   APP_DOC_TRACKER_ID varchar2(100) ,
   APP_DOC_REDACTION_DATA_ID varchar2(100) ,
   ASF_CANCEL_DOC   varchar2(1) ,
   ASF_PROCESS_DOC varchar2(1) ,
   AUTO_LINKED_IND varchar2(1),
   BATCH_ID varchar2(4000) ,
   BATCH_NAME varchar2(256) ,
   CANCEL_BY varchar2(32) ,
   CANCEL_DT varchar2(19),
   CANCEL_METHOD varchar2(32) ,
   CANCEL_REASON varchar2(32) ,
   CHANNEL varchar2(32) ,
   COMPLETE_DT varchar2(19),
   CREATE_DT varchar2(19),
   DCN varchar2(256) ,
   DOC_STATUS_CD varchar2(32) ,
   DOC_STATUS_DT varchar2(19),
   DOC_TYPE_CD varchar2(256) ,
   DOC_UPDATE_DT varchar2(19),
   DOC_UPDATED_BY varchar2(32) ,
   DOC_UPDATED_BY_STAFF_ID varchar2(50) ,
   ECN varchar2(256) ,
   EEMFDB_ID varchar2(100),
   ENV_STATUS varchar2(256) ,
   ENV_STATUS_CD varchar2(32) ,
   ENV_STATUS_DT varchar2(19),
   ENV_UPDATE_DT varchar2(19),
   ENV_UPDATED_BY varchar2(32) ,
   ENV_UPDATED_BY_STAFF_ID varchar2(50) ,
   EXPEDIATED_IND varchar2(1)   ,
   FORM_TYPE varchar2(256),
   FORM_TYPE_CD varchar2(256) ,
   FREE_FORM_TXT_IND varchar2(1) ,
   INSTANCE_END_DATE varchar2(19),
   INSTANCE_START_DATE varchar2(19),
   INSTANCE_STATUS varchar2(32) ,
   KOFAX_DCN varchar2(256) ,
   LAST_EVENT_DATE varchar2(19),
   LINK_DT varchar2(19),
   LINK_ID varchar2(100),
   LINKED_CLIENT varchar2(100),
   MAXE_ORIGINATION_DT varchar2(19),
   MINOR_APPLICANT_FLAG varchar2(1),
   NOTE_ID varchar2(32) ,
   ORIG_DOC_FORM_TYPE_CD varchar2(256) ,
   ORIG_DOC_TYPE_CD varchar2(256) ,
   PAGE_COUNT varchar2(100) ,
   PREVIOUS_KOFAX_DCN varchar2(256) ,
   PRIORITY varchar2(2) ,
   RECEIVED_DT varchar2(19),
   REDACTED_INFO_FLAG varchar2(1),
   RELEASE_DT varchar2(19),
   RESCAN_COUNT varchar2(100),
   RESCANNED_IND varchar2(1) ,
   RESEARCH_REQ_IND varchar2(1),
   RETURNED_MAIL_IND varchar2(1) ,
   RETURNED_MAIL_REASON varchar2(32) ,
   SCAN_DT varchar2(19),
   SLA_COMPLETE varchar2(1) ,
   SLA_COMPLETE_DT varchar2(19),
   STG_DONE_DATE varchar2(19) ,
   STG_EXTRACT_DATE varchar2(19) ,
   STG_LAST_UPDATE_DATE varchar2(19),
   TR_DOC_STATUS_CD varchar2(32),
   TRASHED_BY varchar2(32) ,
   TRASHED_DT varchar2(19),
   TRASHED_IND varchar2(100));

procedure INSERT_BPM_SEMANTIC
  (p_data_version in number,
   p_new_data_xml in xmltype);

procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype);
end;
/
show errors