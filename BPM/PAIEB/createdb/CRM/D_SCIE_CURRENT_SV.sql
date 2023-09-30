CREATE OR REPLACE VIEW D_SCIE_CURRENT_SV
AS
  SELECT cr.CALL_RECORD_ID AS CONTACT_RECORD_ID,
  e.EVENT_ID AS EVENT_ID,
  COALESCE(TRIM(s.LAST_NAME) || DECODE(s.LAST_NAME, NULL, NULL, ',') || TRIM(s.FIRST_NAME) || 
    RTRIM(LPAD(SUBSTR(s.MIDDLE_NAME, 1, 1),2, ' ')), e.CREATED_BY) AS EVENT_CREATED_BY,
  e.CREATE_TS AS EVENT_CREATE_DT,
  e.CONTEXT AS SUPP_EVENT_CONTEXT,
  CASE WHEN e.EVENT_TYPE_CD = 'MANUAL_ACTION' THEN ma.report_label ELSE bz.report_label END AS EVENT_ACTION,
  CASE WHEN e.EVENT_TYPE_CD = 'MANUAL_ACTION' THEN e.context ELSE e.event_type_cd END AS EVENT_ACTION_CODE,
  mct.report_label AS MANUAL_ACTION_CATEGORY,
  ma.categories MANUAL_ACTION_CATEGORY_CODE,
  e.REF_ID AS EVENT_REF_ID,
  e.REF_TYPE AS EVENT_REF_TYPE
FROM ATS.CALL_RECORD cr
LEFT JOIN ATS.EVENT e ON (cr.CALL_RECORD_ID = e.CALL_RECORD_ID)
LEFT JOIN ATS.STAFF s ON (TO_CHAR(s.staff_id) = e.created_by)
LEFT JOIN ENUM_BIZ_EVENT_TYPE bz ON (bz.value = e.event_type_cd)
LEFT JOIN ENUM_MANUAL_CALL_ACTION ma ON (ma.value = e.context) 
LEFT JOIN ENUM_MAN_CALL_ACT_CATEGORIES mct ON mct.value = ma.categories ; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_SCIE_CURRENT_SV TO MAXDAT_REPORTS;  