CREATE OR REPLACE VIEW D_DMS_DOCUMENTS_SV
AS
  SELECT  DCN,
  BATCH_ID as DMS_BATCH_ID,
  DATE_RECEIVED,
  ORIGINAL_DOCUMENT,
  AVAILABILITY_STATUS,
  DOCUMENT_CLASS,
  FORM_TYPE,
  NUMBER_OF_PAGES,
  ENDORSING_STRING,
  ECN,
  FAX_NUMBER,
  FAX_STATION_ID,
  ORIGINAL_DCN,
  KOFAX_DCN,
  RELEASE_ACTIVE,
  CREATION_DATE,
  CREATED_BY,
  LAST_UPDATED_BY,
  LAST_UPDATE_DATE
  from PAIEDMS.DOCUMENTS;

GRANT SELECT ON D_DMS_DOCUMENTS_SV TO MAXDAT_REPORTS;