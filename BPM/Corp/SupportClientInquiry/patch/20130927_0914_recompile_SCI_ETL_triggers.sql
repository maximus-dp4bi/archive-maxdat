-- 9/11 For

alter session set plsql_code_type = native;

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
END trg_biu_etl_client_inquiry;
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

alter session set plsql_code_type = interpreted;
