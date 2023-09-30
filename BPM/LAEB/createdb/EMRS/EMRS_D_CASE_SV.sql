DROP VIEW MAXDAT_SUPPORT.EMRS_D_CASE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CASE_SV
AS
SELECT 
    c.case_id AS CASE_ID,
    c.case_id AS CURRENT_CASE_ID , --do not implement in Microstrategy, there are no multiple open case client records for case, we do not need this
    'Y' AS CURRENT_FLAG , --this is not needed either    
    c.case_cin AS CASE_CIN ,
    c.clnt_client_id AS CLNT_CLIENT_ID ,
    COALESCE(c.case_status, '0') AS CASE_STATUS ,
    c.case_status_date AS CASE_STATUS_DATE ,
    c.case_head_ssn AS CASE_HEAD_SSN ,
    c.case_head_fname AS CASE_HEAD_FNAME,
    SUBSTR(c.case_head_mi,1,1) AS CASE_HEAD_MI ,
    c.case_head_lname AS CASE_HEAD_LNAME,
    CASE WHEN LENGTH(TRIM(case_head_lname)) < 1 THEN TRIM(case_head_fname) 
          WHEN LENGTH(TRIM(case_head_fname)) < 1 THEN TRIM(case_head_lname)
          ELSE TRIM(case_head_lname) || ', ' || TRIM(case_head_fname) 
    END AS CASE_HEAD_FULL_NAME,
    c.case_phone AS PHONE ,
    c.family_number AS FAMILY_NUMBER ,
    c.creation_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    c.case_educated_ind AS CASE_EDUCATED_IND ,
    c.case_need_translator_ind AS CASE_NEED_TRANSLATOR_IND ,
    c.case_phone_reminder_use AS CASE_PHONE_REMINDER_USE ,
    COALESCE(c.case_language_cd, 'AH') AS CASE_LANGUAGE_CD ,
    c.case_how_educated_cd AS CASE_HOW_EDUCATED_CD ,
    COALESCE(c.case_spoken_language_cd, 'AH') AS CASE_SPOKEN_LANGUAGE_CD ,
    c.note_ref_id AS NOTE_REF_ID ,
    c.anniversary_dt AS ANNIVERSARY_DT ,
    c.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    c.last_state_updated_by AS LAST_STATE_UPDATED_BY,
    c.last_update_date AS MODIFIED_DATE ,
    TO_CHAR(c.last_update_date,'HH24MI') AS MODIFIED_TIME ,
    c.last_updated_by AS MODIFIED_NAME ,
    c.creation_date AS RECORD_DATE ,
    TO_CHAR(c.creation_date,'HH24MI') AS RECORD_TIME ,
    c.created_by AS RECORD_NAME 
  FROM EB.cases c;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_SV TO MAXDAT_SUPPORT_READ_ONLY;
