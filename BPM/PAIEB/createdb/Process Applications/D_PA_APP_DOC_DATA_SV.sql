CREATE OR REPLACE VIEW D_PA_APP_DOC_DATA_SV
AS
  SELECT APP_DOC_DATA_ID,
    APPLICATION_ID AS APP_ID,
    LETTER_REQUEST_ID, 
    RECEIVED_DATE,
    ECN,
    DCN,
    DOCUMENT_TYPE_CD,
    DOCUMENT_ID,
    STATUS_CD AS doc_status_cd,
    STATUS_TS,
    DOCUMENT_SET_ID,
    DOCUMENT_SUB_TYPE
  FROM ATS.APP_DOC_DATA ;
    
GRANT SELECT ON D_PA_APP_DOC_DATA_SV TO MAXDAT_REPORTS;