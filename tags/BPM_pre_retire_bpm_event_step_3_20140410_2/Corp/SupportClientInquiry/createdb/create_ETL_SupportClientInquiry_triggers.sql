alter session set plsql_code_type = native;

-- Triggers
CREATE OR REPLACE TRIGGER MAXDAT.trg_biu_etl_client_inquiry
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */
  v_dsc   corp_etl_error_log.error_desc%TYPE;
  v_rec   corp_etl_error_log.error_desc%TYPE;
  --
  v_old_worker_id  staff_lkup.staff_id%TYPE;
  v_old_staff_name staff_lkup.display_name%TYPE := '<No staff ID>';
  v_new_staff_name staff_lkup.display_name%TYPE := '<No staff ID>';

  -- 10/17/13 B.Thai Capture staff info
  PROCEDURE get_staff_info IS
  BEGIN
    IF :n.supp_worker_id IS NOT NULL
    THEN FOR s IN (SELECT display_name FROM staff_lkup WHERE staff_id = :n.supp_worker_id)
         LOOP v_new_staff_name := s.display_name;
         END LOOP;
    END IF;
    IF UPDATING THEN
      IF :o.supp_worker_id IS NOT NULL
      THEN v_old_worker_id := :o.supp_worker_id;
           FOR s IN (SELECT display_name FROM staff_lkup WHERE staff_id = :o.supp_worker_id)
           LOOP v_old_staff_name := s.display_name;
           END LOOP;
      END IF;
    END IF;
  END get_staff_info;

BEGIN

  v_rec := SUBSTR(' ASED_CREATE_ROUTE_WORK=' || TO_CHAR(:n.ASED_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASED_HANDLE_CONTACT=' || TO_CHAR(:n.ASED_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASF_CANCEL_CONTACT=' || :n.ASF_CANCEL_CONTACT
                  || ' ASF_CREATE_ROUTE_WORK=' || :n.ASF_CREATE_ROUTE_WORK
                  || ' ASF_HANDLE_CONTACT=' || :n.ASF_HANDLE_CONTACT
                  || ' ASPB_HANDLE_CONTACT=' || :n.ASPB_HANDLE_CONTACT
                  || ' ASSD_CREATE_ROUTE_WORK=' || TO_CHAR(:n.ASSD_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASSD_HANDLE_CONTACT=' || TO_CHAR(:n.ASSD_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_BY=' || :n.CANCEL_BY
                  || ' CANCEL_DT=' || TO_CHAR(:n.CANCEL_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_METHOD=' || :n.CANCEL_METHOD
                  || ' CANCEL_REASON=' || :n.CANCEL_REASON
                  || ' CECI_ID=' || :n.CECI_ID
                  || ' COMPLETE_DT=' || TO_CHAR(:n.COMPLETE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_END_DT=' || TO_CHAR(:n.CONTACT_END_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_GROUP=' || :n.CONTACT_GROUP
                  || ' CONTACT_RECORD_FIELD1=' || :n.CONTACT_RECORD_FIELD1
                  || ' CONTACT_RECORD_FIELD2=' || :n.CONTACT_RECORD_FIELD2
                  || ' CONTACT_RECORD_FIELD3=' || :n.CONTACT_RECORD_FIELD3
                  || ' CONTACT_RECORD_FIELD4=' || :n.CONTACT_RECORD_FIELD4
                  || ' CONTACT_RECORD_FIELD5=' || :n.CONTACT_RECORD_FIELD5
                  || ' CONTACT_RECORD_ID=' || :n.CONTACT_RECORD_ID
                  || ' CONTACT_START_DT=' || TO_CHAR(:n.CONTACT_START_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_TYPE=' || :n.CONTACT_TYPE
                  || ' CREATED_BY=' || :n.CREATED_BY
                  || ' CREATED_BY_ROLE=' || :n.CREATED_BY_ROLE
                  || ' CREATED_BY_UNIT=' || :n.CREATED_BY_UNIT
                  || ' CREATE_DT=' || TO_CHAR(:n.CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EXT_TELEPHONY_REF=' || :n.EXT_TELEPHONY_REF
                  || ' GWF_WORK_IDENTIFIED=' || :n.GWF_WORK_IDENTIFIED
                  || ' INSTANCE_STATUS=' || :n.INSTANCE_STATUS
                  || ' LANGUAGE=' || :n.LANGUAGE
                  || ' LAST_UPDATE_BY_NAME=' || :n.LAST_UPDATE_BY_NAME
                  || ' LAST_UPDATE_DT=' || TO_CHAR(:n.LAST_UPDATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' NOTE_CATEGORY=' || :n.NOTE_CATEGORY
                  || ' NOTE_PRESENT=' || :n.NOTE_PRESENT
                  || ' NOTE_SOURCE=' || :n.NOTE_SOURCE
                  || ' NOTE_TYPE=' || :n.NOTE_TYPE
                  || ' PARENT_RECORD_ID=' || :n.PARENT_RECORD_ID
                  || ' PARTICIPANT_STATUS=' || :n.PARTICIPANT_STATUS
                  || ' STAGE_DONE_DATE=' || TO_CHAR(:n.STAGE_DONE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:n.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:n.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_CONTACT_GROUP_CD=' || :n.SUPP_CONTACT_GROUP_CD
                  || ' SUPP_CONTACT_TYPE_CD=' || :n.SUPP_CONTACT_TYPE_CD
                  || ' SUPP_CREATED_BY=' || :n.SUPP_CREATED_BY
                  || ' SUPP_LANGUAGE_CD=' || :n.SUPP_LANGUAGE_CD
                  || ' SUPP_LATEST_NOTE_ID=' || :n.SUPP_LATEST_NOTE_ID
                  || ' SUPP_UPDATE_BY=' || :n.SUPP_UPDATE_BY
                  || ' SUPP_WORKER_ID=' || :n.SUPP_WORKER_ID
                  || ' SUPP_WORKER_NAME=' || :n.SUPP_WORKER_NAME
                  || ' TRACKING_NUMBER=' || :n.TRACKING_NUMBER
                  || ' TRANSLATION_REQ=' || :n.TRANSLATION_REQ, 1, 3600);

  IF INSERTING THEN
    IF :n.ceci_id IS NULL
    THEN :n.ceci_id := seq_ceci_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date  := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20111);  
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20112);  
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20113);  
  END IF;
  IF (:n.supp_worker_id IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_worker_id IS NOT NULL AND :n.created_by IS NULL)
  THEN get_staff_info;
       v_rec := SUBSTR(' NewStaffName=' || v_new_staff_name || ' OldStaffName=' || v_old_staff_name
                || ' OLD_SUPP_WORKER_ID='|| v_old_worker_id ||CHR(10) || v_rec, 1, 3600);
       v_dsc := 'Value and supplementary do not match: SUPP_WORKER_ID/CREATED_BY' ||CHR(10) || v_rec;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20114);  
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME' ||CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20115);  
  END IF;
END trg_biu_etl_client_inquiry;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_client_inquiry_dtl
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry_dtl
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */

BEGIN
  IF INSERTING THEN
    IF :n.cecid_id IS NULL
    THEN :n.cecid_id := seq_cecid_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
END trg_biu_etl_client_inquiry_dtl;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_client_inqry_event
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry_event
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */
  v_dsc   corp_etl_error_log.error_desc%TYPE;
  v_rec   corp_etl_error_log.error_desc%TYPE;

BEGIN
  IF INSERTING THEN
    IF :n.cecie_id IS NULL
    THEN :n.cecie_id := seq_cecie_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  v_rec := SUBSTR(' CECIE_ID=' || :n.CECIE_ID
                  || ' CECI_ID=' || :n.CECI_ID
                  || ' CONTACT_RECORD_ID=' || :n.CONTACT_RECORD_ID
                  || ' EVENT_ACTION=' || :n.EVENT_ACTION
                  || ' EVENT_CREATED_BY=' || :n.EVENT_CREATED_BY
                  || ' EVENT_CREATE_DT=' || TO_CHAR(:n.EVENT_CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EVENT_ID=' || :n.EVENT_ID
                  || ' EVENT_REF_ID=' || :n.EVENT_REF_ID
                  || ' EVENT_REF_TYPE=' || :n.EVENT_REF_TYPE
                  || ' MANUAL_ACTION_CATEGORY=' || :n.MANUAL_ACTION_CATEGORY
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:n.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:n.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_EVENT_CONTEXT=' || :n.SUPP_EVENT_CONTEXT
                  || ' SUPP_EVENT_CREATED_BY=' || :n.SUPP_EVENT_CREATED_BY
                  || ' SUPP_EVENT_TYPE_CD=' || :n.SUPP_EVENT_TYPE_CD, 1, 3600);
                  
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY' || CHR(10) || v_rec;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.event_id, null, null, v_dsc ,-20116);
  END IF;
END trg_biu_etl_client_inqry_event;
/

CREATE OR REPLACE TRIGGER MAXDAT.trg_biu_etl_clnt_inqry_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */
  v_dsc   corp_etl_error_log.error_desc%TYPE;
  v_rec   corp_etl_error_log.error_desc%TYPE;

BEGIN
  v_rec := SUBSTR(' ASED_CREATE_ROUTE_WORK=' || TO_CHAR(:n.ASED_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASED_HANDLE_CONTACT=' || TO_CHAR(:n.ASED_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASF_CANCEL_CONTACT=' || :n.ASF_CANCEL_CONTACT
                  || ' ASF_CREATE_ROUTE_WORK=' || :n.ASF_CREATE_ROUTE_WORK
                  || ' ASF_HANDLE_CONTACT=' || :n.ASF_HANDLE_CONTACT
                  || ' ASPB_HANDLE_CONTACT=' || :n.ASPB_HANDLE_CONTACT
                  || ' ASSD_CREATE_ROUTE_WORK=' || TO_CHAR(:n.ASSD_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASSD_HANDLE_CONTACT=' || TO_CHAR(:n.ASSD_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_BY=' || :n.CANCEL_BY
                  || ' CANCEL_DT=' || TO_CHAR(:n.CANCEL_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_METHOD=' || :n.CANCEL_METHOD
                  || ' CANCEL_REASON=' || :n.CANCEL_REASON
                  || ' CECI_ID=' || :n.CECI_ID
                  || ' COMPLETE_DT=' || TO_CHAR(:n.COMPLETE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_END_DT=' || TO_CHAR(:n.CONTACT_END_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_GROUP=' || :n.CONTACT_GROUP
                  || ' CONTACT_RECORD_FIELD1=' || :n.CONTACT_RECORD_FIELD1
                  || ' CONTACT_RECORD_FIELD2=' || :n.CONTACT_RECORD_FIELD2
                  || ' CONTACT_RECORD_FIELD3=' || :n.CONTACT_RECORD_FIELD3
                  || ' CONTACT_RECORD_FIELD4=' || :n.CONTACT_RECORD_FIELD4
                  || ' CONTACT_RECORD_FIELD5=' || :n.CONTACT_RECORD_FIELD5
                  || ' CONTACT_RECORD_ID=' || :n.CONTACT_RECORD_ID
                  || ' CONTACT_START_DT=' || TO_CHAR(:n.CONTACT_START_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_TYPE=' || :n.CONTACT_TYPE
                  || ' CREATED_BY=' || :n.CREATED_BY
                  || ' CREATED_BY_ROLE=' || :n.CREATED_BY_ROLE
                  || ' CREATED_BY_UNIT=' || :n.CREATED_BY_UNIT
                  || ' CREATE_DT=' || TO_CHAR(:n.CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EXT_TELEPHONY_REF=' || :n.EXT_TELEPHONY_REF
                  || ' GWF_WORK_IDENTIFIED=' || :n.GWF_WORK_IDENTIFIED
                  || ' INSTANCE_STATUS=' || :n.INSTANCE_STATUS
                  || ' LANGUAGE=' || :n.LANGUAGE
                  || ' LAST_UPDATE_BY_NAME=' || :n.LAST_UPDATE_BY_NAME
                  || ' LAST_UPDATE_DT=' || TO_CHAR(:n.LAST_UPDATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' NOTE_CATEGORY=' || :n.NOTE_CATEGORY
                  || ' NOTE_PRESENT=' || :n.NOTE_PRESENT
                  || ' NOTE_SOURCE=' || :n.NOTE_SOURCE
                  || ' NOTE_TYPE=' || :n.NOTE_TYPE
                  || ' PARENT_RECORD_ID=' || :n.PARENT_RECORD_ID
                  || ' PARTICIPANT_STATUS=' || :n.PARTICIPANT_STATUS
                  || ' STAGE_DONE_DATE=' || TO_CHAR(:n.STAGE_DONE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:n.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:n.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_CONTACT_GROUP_CD=' || :n.SUPP_CONTACT_GROUP_CD
                  || ' SUPP_CONTACT_TYPE_CD=' || :n.SUPP_CONTACT_TYPE_CD
                  || ' SUPP_CREATED_BY=' || :n.SUPP_CREATED_BY
                  || ' SUPP_LANGUAGE_CD=' || :n.SUPP_LANGUAGE_CD
                  || ' SUPP_LATEST_NOTE_ID=' || :n.SUPP_LATEST_NOTE_ID
                  || ' SUPP_UPDATE_BY=' || :n.SUPP_UPDATE_BY
                  || ' SUPP_WORKER_ID=' || :n.SUPP_WORKER_ID
                  || ' SUPP_WORKER_NAME=' || :n.SUPP_WORKER_NAME
                  || ' TRACKING_NUMBER=' || :n.TRACKING_NUMBER
                  || ' TRANSLATION_REQ=' || :n.TRANSLATION_REQ, 1, 3600);

  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20111);  
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20112);  
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE' || CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20113);  
  END IF;
  IF (:n.supp_created_by IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_created_by IS NOT NULL AND :n.created_by IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY' ||CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20114);  
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME' ||CHR(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.contact_record_id, null, null, v_dsc ,-20115);  
  END IF;
END trg_biu_etl_clnt_inqry_wip;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_clnt_inqry_eve_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_event_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */
  v_dsc   corp_etl_error_log.error_desc%TYPE;
  v_rec   corp_etl_error_log.error_desc%TYPE;

BEGIN
  v_rec := SUBSTR(' CECIE_ID=' || :n.CECIE_ID
                  || ' CECI_ID=' || :n.CECI_ID
                  || ' CONTACT_RECORD_ID=' || :n.CONTACT_RECORD_ID
                  || ' EVENT_ACTION=' || :n.EVENT_ACTION
                  || ' EVENT_CREATED_BY=' || :n.EVENT_CREATED_BY
                  || ' EVENT_CREATE_DT=' || TO_CHAR(:n.EVENT_CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EVENT_ID=' || :n.EVENT_ID
                  || ' EVENT_REF_ID=' || :n.EVENT_REF_ID
                  || ' EVENT_REF_TYPE=' || :n.EVENT_REF_TYPE
                  || ' MANUAL_ACTION_CATEGORY=' || :n.MANUAL_ACTION_CATEGORY
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:n.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:n.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_EVENT_CONTEXT=' || :n.SUPP_EVENT_CONTEXT
                  || ' SUPP_EVENT_CREATED_BY=' || :n.SUPP_EVENT_CREATED_BY
                  || ' SUPP_EVENT_TYPE_CD=' || :n.SUPP_EVENT_TYPE_CD, 1, 3600);
                  
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN v_dsc := 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY' || CHR(10) || v_rec;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,NULL ,$$PLSQL_UNIT, 13, NULL, :n.event_id, null, null, v_dsc ,-20117);
  END IF;
  
END trg_biu_etl_clnt_inqry_eve_wip;
/

create or replace trigger TRG_AI_CORP_ETL_CLNT_INQRY_Q
after insert on CORP_ETL_CLIENT_INQUIRY
for each row

declare

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */

  -- Do not use STAGE_DONE_DATE

  v_bsl_id number := 13; -- 'CORP_ETL_CLIENT_INQUIRY'  
  v_bil_id number := 13; -- 'Call Record ID' 
   v_data_version number := 1;
  
  v_event_date date := null;
  v_identifier varchar2(35) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;

  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CONTACT_RECORD_ID;

  /* 
  select '        <' || 'CECI_ID' || '>'' || :new.'  || 'CECI_ID' || ' || ''</' || 'CECI_ID' || '>'  attr_element from dual
  union
  select '        <' || 'PARTICIPANT_STATUS' || '><![CDATA['' || :new.'  || 'PARTICIPANT_STATUS' || ' || '']]></' || 'PARTICIPANT_STATUS' || '>'  attr_element from dual
  union
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>'  attr_element from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 13
    and atc.TABLE_NAME = 'CORP_ETL_CLIENT_INQUIRY'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT',
      'HANDLE_TIME','PARTICIPANT_STATUS')
  order by attr_element asc;
  */ 
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:new.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :new.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :new.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :new.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:new.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CECI_ID>' || :new.CECI_ID || '</CECI_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:new.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :new.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :new.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :new.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :new.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :new.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :new.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :new.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:new.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :new.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :new.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :new.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :new.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :new.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :new.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :new.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :new.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :new.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :new.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :new.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :new.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :new.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :new.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :new.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :new.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :new.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :new.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :new.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :new.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
     </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,null,xmltype(v_xml_string_new));
    
exception
     
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || '
      XML: 
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code); 
    raise;
  
end TRG_AI_CORP_ETL_CLNT_INQRY_Q;
/

create or replace trigger TRG_AU_CORP_ETL_CLNT_INQRY_Q
after update on CORP_ETL_CLIENT_INQUIRY
for each row

declare
  
  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$ 
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */

  -- Do not use STAGE_DONE_DATE

  v_bsl_id number := 13; -- 'CORP_ETL_CLIENT_INQUIRY'  
  v_bil_id number := 13; -- 'Call Record ID' 
  v_data_version number := 1;
  
  v_event_date date := null;
  v_identifier varchar2(35) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
   
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CONTACT_RECORD_ID;
  
  /* 
  select '        <' || 'PARTICIPANT_STATUS' || '><![CDATA['' || :old.'  || 'PARTICIPANT_STATUS' || ' || '']]></' || 'PARTICIPANT_STATUS' || '>'  attr_element from dual
  union
  select 
  case 
    when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:old.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
    when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :old.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
    else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
    end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 13
    and atc.TABLE_NAME = 'CORP_ETL_CLIENT_INQUIRY'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT',
      'HANDLE_TIME','PARTICIPANT_STATUS','CECI_ID')
  order by attr_element asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:old.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:old.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :old.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :old.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :old.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :old.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:old.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:old.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:old.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :old.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :old.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :old.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :old.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :old.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :old.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :old.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:old.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :old.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :old.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :old.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :old.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :old.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :old.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:old.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :old.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :old.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :old.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :old.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :old.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :old.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :old.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :old.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :old.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :old.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :old.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :old.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :old.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :old.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :old.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
     </ROW>
    </ROWSET>
    ';
    
  /*  
  select '        <' || 'PARTICIPANT_STATUS' || '><![CDATA['' || :new.'  || 'PARTICIPANT_STATUS' || ' || '']]></' || 'PARTICIPANT_STATUS' || '>'  attr_element from dual
  union
  select 
  case 
    when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
    when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
    else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
    end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 13
    and atc.TABLE_NAME = 'CORP_ETL_CLIENT_INQUIRY'
    and COLUMN_NAME not in ('AGE_IN_BUSINESS_DAYS','AGE_IN_CALENDAR_DAYS','APP_CYCLE_BUS_DAYS',
      'APP_CYCLE_CAL_DAYS','JEOPARDY_FLAG','TIMELINESS_STATUS','DAYS_UNTIL_TIMEOUT',
      'HANDLE_TIME','PARTICIPANT_STATUS','CECI_ID')
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:new.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :new.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :new.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :new.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:new.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:new.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :new.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :new.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :new.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :new.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :new.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :new.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :new.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:new.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :new.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :new.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :new.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :new.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :new.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :new.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :new.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :new.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :new.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :new.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :new.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :new.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :new.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :new.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :new.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :new.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :new.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :new.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :new.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :new.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
     </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE
      (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
      values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));
  
exception
     
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML (old): 
      ' || v_xml_string_old || ' 
      XML (new): 
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);  
    raise;

end TRG_AU_CORP_ETL_CLNT_INQRY_Q;
/


alter session set plsql_code_type = interpreted;
