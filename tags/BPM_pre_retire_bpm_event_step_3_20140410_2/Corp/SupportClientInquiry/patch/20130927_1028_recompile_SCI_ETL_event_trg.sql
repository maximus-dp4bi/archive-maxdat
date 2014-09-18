-- 9/11 For

alter session set plsql_code_type = native;

CREATE OR REPLACE TRIGGER MAXDAT.trg_biu_etl_client_inqry_event
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

CREATE OR REPLACE TRIGGER MAXDAT.trg_biu_etl_clnt_inqry_eve_wip
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

alter session set plsql_code_type = interpreted;
