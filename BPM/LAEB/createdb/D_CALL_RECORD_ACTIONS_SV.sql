DROP VIEW MAXDAT_LAEB.D_CALL_RECORD_ACTIONS_SV;

CREATE OR REPLACE VIEW MAXDAT_LAEB.D_CALL_RECORD_ACTIONS_SV
AS
SELECT
  C.CALL_RECORD_ID AS  CALL_RECORD_ID
, C.CREATE_TS AS CALL_CREATION_DATE
, C.CALL_TYPE_CD AS CALL_TYPE_CD
, C.CALLER_TYPE_CD AS CALLER_TYPE_CD
, C. CALL_START_TS AS CALL_START_TIME
, C. CALL_END_TS AS CALL_END_TIME
, case when  LANGUAGE_CD='EN' then 'ENGLISH' when  LANGUAGE_CD='ES' then 'SPANISH' else 'OTHER' end AS  LANGUAGE
, C.CALLER_FIRST_NAME AS CALLER_FIRST_NAME
,C.CALLER_LAST_NAME AS CALLER_LAST_NAME
, E.EVENT_TYPE_CD AS CALL_EVENT_TYPE_CD
, E.CONTEXT AS CALL_ACTION_CD
, CA.REPORT_LABEL AS CALL_ACTION_DESC
, CA.CATEGORIES AS CATEGORY
,CA.CATEGORY_REPORT_LABEL AS CATEGORY_DESC
,Case when LANGUAGE_CD='EN' then 1 else 0 end COUNT_ENGLISH
,Case when LANGUAGE_CD='ES' then 1 else 0 end COUNT_SPANISH
,Case when LANGUAGE_CD not in ('EN','ES') then 1 else 0 end AS COUNT_OTHER
FROM MAXDAT_LAEB.D_CALL_RECORD C
JOIN MAXDAT_LAEB.D_EVENT E ON E.CALL_RECORD_ID = C.CALL_RECORD_ID
LEFT JOIN MAXDAT_LAEB.ENUM_MANUAL_CALL_ACTION CA
ON E.CONTEXT=CA.VALUE;


GRANT SELECT ON MAXDAT_LAEB.D_CALL_RECORD_ACTIONS_SV TO MAXDAT_LAEB_READ_ONLY;