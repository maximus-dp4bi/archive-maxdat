CREATE OR REPLACE VIEW EMRS_D_CASE_SV
AS
  SELECT 
    'MEDICAID' AS MANAGED_CARE_PROGRAM ,
    c.case_id AS CASE_NUMBER ,
    '0' AS CSDA_CODE ,
    c.case_head_fname AS FIRST_NAME ,
    SUBSTR(c.case_head_mi,1,1) AS MIDDLE_INITIAL ,
    c.case_head_lname AS LAST_NAME ,
    c.case_head_fname||
    CASE
      WHEN SUBSTR(c.case_head_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(c.case_head_mi,1,1)||' '
    END ||c.case_head_lname AS FULL_NAME ,
    c.case_phone AS PHONE ,
    NULL AS MAILING_ADDRESS1 ,
    NULL AS MAILING_ADDRESS2 ,
    NULL AS MAILING_CITY ,
    NULL AS MAILING_STATE ,
    NULL AS MAILING_ZIP ,
    NULL AS CASE_SEARCH_ELEMENT ,
    c.case_head_fname||
    CASE
      WHEN SUBSTR(c.case_head_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(c.case_head_mi,1,1)||' '
    END ||c.case_head_lname AS GUARDIAN_FULL_NAME ,
    c.creation_date AS RECORD_DATE ,
    TO_CHAR(c.creation_date,'HH24MI') AS RECORD_TIME ,
    c.created_by AS RECORD_NAME ,
    c.last_update_date AS MODIFIED_DATE ,
    TO_CHAR(c.last_update_date,'HH24MI') AS MODIFIED_TIME ,
    c.last_updated_by AS MODIFIED_NAME ,
    1 AS VERSION ,
    c.creation_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    c.created_by AS CREATED_BY ,
    c.creation_date AS DATE_CREATED ,
    c.last_updated_by AS UPDATED_BY ,
    c.last_update_date AS DATE_UPDATED ,
    c.case_id AS SOURCE_RECORD_ID ,
    c.case_id AS CURRENT_CASE_ID ,
    'Y' AS CURRENT_FLAG ,
    c.case_cin AS CASE_CIN ,
    c.family_number AS FAMILY_NUMBER ,
    c.case_status_date AS CASE_STATUS_DATE ,
    c.case_educated_ind AS CASE_EDUCATED_IND ,
    c.case_educated_date AS CASE_EDUCATED_DATE ,
    c.case_need_translator_ind AS CASE_NEED_TRANSLATOR_IND ,
    c.case_phone_reminder_use AS CASE_PHONE_REMINDER_USE ,
    c.case_educated_by AS CASE_EDUCATED_BY ,
    c.case_staff_id AS CASE_STAFF_ID ,
    c.case_language_cd AS CASE_LANGUAGE_CD ,
    c.case_how_educated_cd AS CASE_HOW_EDUCATED_CD ,
    c.case_status AS CASE_STATUS ,
    c.case_head_ssn AS CASE_HEAD_SSN ,
    c.case_team AS CASE_TEAM ,
    c.case_load AS CASE_LOAD ,
    c.clnt_client_id AS CLNT_CLIENT_ID ,
    c.fmnb_id AS FMNB_ID ,
    c.load_type AS LOAD_TYPE ,
    c.case_spoken_language_cd AS CASE_SPOKEN_LANGUAGE_CD ,
    c.note_ref_id AS NOTE_REF_ID ,
    c.anniversary_dt AS ANNIVERSARY_DT ,
    c.state_staff_id_ext AS STATE_STAFF_ID_EXT ,
    c.case_generic_field1_date AS CASE_GENERIC_FIELD1_DATE ,
    c.case_generic_field2_date AS CASE_GENERIC_FIELD2_DATE ,
    c.case_generic_field3_num AS CASE_GENERIC_FIELD3_NUM ,
    c.case_generic_field4_num AS CASE_GENERIC_FIELD4_NUM ,
    c.case_generic_field5_txt AS CASE_GENERIC_FIELD5_TXT ,
    c.case_generic_field6_txt AS CASE_GENERIC_FIELD6_TXT ,
    c.case_generic_field7_txt AS CASE_GENERIC_FIELD7_TXT ,
    c.case_generic_field8_txt AS CASE_GENERIC_FIELD8_TXT ,
    c.case_generic_field9_txt AS CASE_GENERIC_FIELD9_TXT ,
    c.case_generic_field10_txt AS CASE_GENERIC_FIELD10_TXT ,
    c.case_generic_ref11_id AS CASE_GENERIC_REF11_ID ,
    c.case_generic_ref12_id AS CASE_GENERIC_REF12_ID ,
    c.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    c.last_state_updated_by AS LAST_STATE_UPDATED_BY
  FROM cases c ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_SV TO EB_MAXDAT_REPORTS;