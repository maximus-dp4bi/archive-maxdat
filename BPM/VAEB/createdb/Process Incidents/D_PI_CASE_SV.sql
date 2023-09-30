CREATE OR REPLACE VIEW D_PI_CASE_SV
AS
  SELECT cs.CASE_ID,
  cs.CASE_CIN,
  cs.FAMILY_NUMBER,
  cs.CASE_STATUS_DATE,
  cs.CASE_EDUCATED_IND,
  cs.CASE_EDUCATED_DATE,
  cs.CASE_NEED_TRANSLATOR_IND,
  cs.CASE_PHONE,
  cs.CASE_PHONE_REMINDER_USE,
  cs.CASE_EDUCATED_BY,
  cs.CASE_STAFF_ID,
  cs.CREATED_BY,
  cs.CREATION_DATE,
  cs.LAST_UPDATED_BY,
  cs.LAST_UPDATE_DATE,
  cs.CASE_LANGUAGE_CD,
  cs.CASE_HOW_EDUCATED_CD,
  cs.CASE_STATUS,
  cs.CASE_HEAD_FNAME,
  cs.CASE_HEAD_LNAME,
  cs.CASE_HEAD_MI,
  CASE WHEN LENGTH(cs.CASE_HEAD_LNAME) > 1
          THEN cs.CASE_HEAD_FNAME||' '||cs.CASE_HEAD_LNAME 
          ELSE NULL
          END AS CASE_HEAD_FULL_NAME,
  cs.CASE_HEAD_SSN,
  cs.CASE_TEAM,
  cs.CASE_LOAD,
  cs.CLNT_CLIENT_ID,
  cs.FMNB_ID,
  cs.LOAD_TYPE,
  cs.CASE_SPOKEN_LANGUAGE_CD,
  cs.NOTE_REF_ID,
  cs.ANNIVERSARY_DT,
  cs.STATE_STAFF_ID_EXT,
  cs.CASE_GENERIC_FIELD1_DATE,
  cs.CASE_GENERIC_FIELD2_DATE,
  cs.CASE_GENERIC_FIELD3_NUM,
  cs.CASE_GENERIC_FIELD4_NUM,
  cs.CASE_GENERIC_FIELD5_TXT,
  cs.CASE_GENERIC_FIELD6_TXT,
  cs.CASE_GENERIC_FIELD7_TXT,
  cs.CASE_GENERIC_FIELD8_TXT,
  cs.CASE_GENERIC_FIELD9_TXT,
  cs.CASE_GENERIC_FIELD10_TXT,
  cs.CASE_GENERIC_REF11_ID,
  cs.CASE_GENERIC_REF12_ID,
  cs.LAST_STATE_UPDATE_TS,
  cs.LAST_STATE_UPDATED_BY
FROM EB.CASES cs
UNION ALL
SELECT 0 AS CASE_ID,
  '000000000000' AS CASE_CIN,
  NULL FAMILY_NUMBER,
  TO_DATE('01-01-1900 00:00', 'mm-dd-yyyy hh24:mi') AS CASE_STATUS_DATE,
  'N' AS CASE_EDUCATED_IND,
  NULL AS CASE_EDUCATED_DATE,
  'N' AS CASE_NEED_TRANSLATOR_IND,
  NULL AS CASE_PHONE,
  'N' AS CASE_PHONE_REMINDER_USE,
  NULL AS CASE_EDUCATED_BY,
  NULL AS CASE_STAFF_ID,
  NULL AS CREATED_BY,
  TO_DATE('01-01-1900 00:00', 'mm-dd-yyyy hh24:mi') AS CREATION_DATE,
  NULL AS LAST_UPDATED_BY,
  TO_DATE('01-01-1900 00:00', 'mm-dd-yyyy hh24:mi') AS LAST_UPDATE_DATE,
  NULL AS CASE_LANGUAGE_CD,
  NULL AS CASE_HOW_EDUCATED_CD,
  'O' AS CASE_STATUS,
  NULL AS CASE_HEAD_FNAME,
  NULL AS CASE_HEAD_LNAME,
  NULL AS CASE_HEAD_MI,
  NULL AS CASE_HEAD_FULL_NAME,
  NULL AS CASE_HEAD_SSN,
  NULL AS CASE_TEAM,
  NULL AS CASE_LOAD,
  0 AS CLNT_CLIENT_ID,
  NULL AS FMNB_ID,
  NULL AS LOAD_TYPE,
  NULL AS CASE_SPOKEN_LANGUAGE_CD,
  NULL AS NOTE_REF_ID,
  NULL AS ANNIVERSARY_DT,
  NULL AS STATE_STAFF_ID_EXT,
  NULL AS CASE_GENERIC_FIELD1_DATE,
  NULL AS CASE_GENERIC_FIELD2_DATE,
  NULL AS CASE_GENERIC_FIELD3_NUM,
  NULL AS CASE_GENERIC_FIELD4_NUM,
  NULL AS CASE_GENERIC_FIELD5_TXT,
  NULL AS CASE_GENERIC_FIELD6_TXT,
  NULL AS CASE_GENERIC_FIELD7_TXT,
  NULL AS CASE_GENERIC_FIELD8_TXT,
  NULL AS CASE_GENERIC_FIELD9_TXT,
  NULL AS CASE_GENERIC_FIELD10_TXT,
  NULL AS CASE_GENERIC_REF11_ID,
  NULL AS CASE_GENERIC_REF12_ID,
  NULL AS LAST_STATE_UPDATE_TS,
  NULL AS LAST_STATE_UPDATED_BY
FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CASE_SV TO MAXDAT_REPORTS ;

