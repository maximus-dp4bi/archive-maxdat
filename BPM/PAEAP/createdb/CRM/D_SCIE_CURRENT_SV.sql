CREATE OR REPLACE VIEW D_SCIE_CURRENT_SV
AS
  SELECT cr.CALL_RECORD_ID AS CONTACT_RECORD_ID,
  e.EVENT_ID AS EVENT_ID,
  COALESCE(TRIM(s.LAST_NAME) || DECODE(s.LAST_NAME, NULL, NULL, ',') || TRIM(s.FIRST_NAME) || 
    RTRIM(LPAD(SUBSTR(s.MIDDLE_NAME, 1, 1),2, ' ')), e.CREATED_BY) AS EVENT_CREATED_BY,
  e.CREATE_TS AS EVENT_CREATE_DT,
  e.CONTEXT AS SUPP_EVENT_CONTEXT,
  CASE WHEN e.EVENT_TYPE_CD = 'MANUAL_ACTION' THEN ma.OUT_VAR ELSE ea.OUT_VAR END AS EVENT_ACTION,
  ma.REF_TYPE AS MANUAL_ACTION_CATEGORY,
  e.REF_ID AS EVENT_REF_ID,
  e.REF_TYPE AS EVENT_REF_TYPE
FROM EB.CALL_RECORD cr
LEFT JOIN EB.EVENT e ON (cr.CALL_RECORD_ID = e.CALL_RECORD_ID)
LEFT JOIN EB.STAFF s ON (TO_CHAR(s.staff_id) = e.created_by)
LEFT JOIN MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP ea ON (ea.NAME = 'CLIENT_INQUIRY_EVENT_ACTION' 
                                                    AND ea.REF_TYPE = 'ENUM_BIZ_EVENT_TYPE'
                                                    AND ea.VALUE = e.EVENT_TYPE_CD)
LEFT JOIN MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP ma ON (ma.NAME = 'CLIENT_INQUIRY_MANUAL_ACTION' 
                                                    AND e.EVENT_TYPE_CD = 'MANUAL_ACTION'
                                                    AND ma.VALUE = e.CONTEXT)  
; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_SCIE_CURRENT_SV TO EB_MAXDAT_REPORTS;  