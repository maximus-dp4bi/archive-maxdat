
---------------------------
-- CORP_ETL_MFB_BATCH_OLTP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BATCH_OLTP_COVERED;	
-- BATCH_GUID, CREATION_STATION_ID, CREATION_USER_NAME, CREATION_USER_ID, BATCH_CLASS, BATCH_CLASS_DES, CANCEL_DT, BATCH_PRIORITY, BATCH_DELETED

---------------------------
-- CORP_ETL_MFB_BATCH_STG	-- ROWS 5,538,767
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BATCH_STG_COVERED;
--	BATCH_GUID, CREATION_STATION_ID, CREATION_USER_NAME, CREATION_USER_ID, BATCH_CLASS, BATCH_CLASS_DES, CANCEL_DT, BATCH_PRIORITY, BATCH_DELETED
	

---------------------------
-- CORP_ETL_MFB_BATCH_STG_WIP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BATCH_WIP_COVERED;
-- BATCH_GUID, CREATION_STATION_ID, CREATION_USER_NAME, CREATION_USER_ID, BATCH_CLASS, BATCH_CLASS_DES, CANCEL_DT, BATCH_PRIORITY, BATCH_DELETED

---------------------------
-- CORP_ETL_MFB_BATCH
---------------------------

-- DROP INDEX MAXDAT.IDX_CEMFB_BATCH_COVERED;
-- ORA-02429: cannot drop index used for enforcement of unique/primary key
-- BATCH_GUID, CREATION_STATION_ID, CREATION_USER_NAME, CREATION_USER_ID, BATCH_CLASS, BATCH_CLASS_DES, CANCEL_DT, BATCH_PRIORITY, BATCH_DELETED
	
---------------------------
-- CORP_ETL_MFB_BATCH_ARS_OLTP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BARS_OLTP_COVERED;
--	BATCH_GUID, BATCH_PAGE_COUNT, BATCH_TYPE, BATCH_DOC_COUNT, BATCH_ENVELOPE_COUNT, CLASSIFICATION_DT, RECOGNITION_DT, VALIDATION_DT

---------------------------
-- CORP_ETL_MFB_BATCH_ARS_STG
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BARS_STG_COVERED;
-- BATCH_GUID, BATCH_PAGE_COUNT, BATCH_TYPE, BATCH_DOC_COUNT, BATCH_ENVELOPE_COUNT, CLASSIFICATION_DT, RECOGNITION_DT, VALIDATION_DT
	

---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_OLTP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BEVENTS_OLTP_COVERED;
--	BATCH_GUID, BATCH_MODULE_ID, MODULE_CLOSE_ID, MODULE_CLOSE_NAME, MODULE_END_DT, BATCH_STATUS, USER_NAME, STATION_ID, SITE_NAME, SITE_ID, BATCH_DELETED, DOC_PAGES, PAGES_SCANNED, PAGES_DELETED, DOCS_CREATED, DOCS_DELETED, PAGES_REPLACED
	
	
---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_STG
---------------------------
	
DROP INDEX MAXDAT.IDX_CEMFB_BEVENTS_STG_COVERED;	
--	BATCH_GUID, BATCH_MODULE_ID, MODULE_CLOSE_ID, MODULE_CLOSE_NAME, MODULE_END_DT, BATCH_STATUS, USER_NAME, STATION_ID, SITE_NAME, SITE_ID, BATCH_DELETED, DOC_PAGES, PAGES_SCANNED, PAGES_DELETED, DOCS_CREATED, DOCS_DELETED, PAGES_REPLACED


---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_WIP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BEVENTS_WIP_COVERED;
-- BATCH_GUID, BATCH_MODULE_ID, MODULE_CLOSE_ID, MODULE_CLOSE_NAME, MODULE_END_DT, BATCH_STATUS, USER_NAME, STATION_ID, SITE_NAME, SITE_ID, BATCH_DELETED, DOC_PAGES, PAGES_SCANNED, PAGES_DELETED, DOCS_CREATED, DOCS_DELETED, PAGES_REPLACED

---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_BEVENTS_COVERED;	
--	BATCH_GUID, BATCH_MODULE_ID, MODULE_CLOSE_ID, MODULE_CLOSE_NAME, MODULE_END_DT, BATCH_STATUS, USER_NAME, STATION_ID, SITE_NAME, SITE_ID, BATCH_DELETED, DOC_PAGES, PAGES_SCANNED, PAGES_DELETED, DOCS_CREATED, DOCS_DELETED, PAGES_REPLACED
	

---------------------------
--CORP_ETL_MFB_DOCUMENT_OLTP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_DOC_OLTP_COVERED;
--	BATCH_GUID, DOC_ID, DOC_ORDER_NUMBER, TYPE_NAME, DOC_CLASS, DOC_PAGE_COUNT, CLASSIFIED_DOC, DELETED, CONFIDENCE, CONFIDENT
	
	
---------------------------
--CORP_ETL_MFB_DOCUMENT_STG	-- 6,139,887 ROWS
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_DOC_STG_COVERED;
--	BATCH_GUID, DOC_ID, DOC_ORDER_NUMBER, TYPE_NAME, DOC_CLASS, DOC_PAGE_COUNT, CLASSIFIED_DOC, DELETED, CONFIDENCE, CONFIDENT
	
---------------------------
--CORP_ETL_MFB_DOCUMENT_WIP	-- 10,751 ROWS
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_DOC_WIP_COVERED;
--	BATCH_GUID, DOC_ID, DOC_ORDER_NUMBER, TYPE_NAME, DOC_CLASS, DOC_PAGE_COUNT, CLASSIFIED_DOC, DELETED, CONFIDENCE, CONFIDENT


---------------------------
-- CORP_ETL_MFB_DOCUMENT	-- 6,139,325 ROWS
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_DOC_COVERED;
--	BATCH_GUID, DOC_ID, DOC_ORDER_NUMBER, TYPE_NAME, DOC_CLASS, DOC_PAGE_COUNT, CLASSIFIED_DOC, DELETED, CONFIDENCE, CONFIDENT
	


---------------------------
-- CORP_ETL_MFB_FORM_OLTP
---------------------------

DROP INDEX MAXDAT.IDX_CEMFB_FORM_OLTP_COVERED;
--	FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES

---------------------------
-- CORP_ETL_MFB_FORM_STG
---------------------------

	
DROP INDEX MAXDAT.IDX_CEMFB_FORM_STG_COVERED;	
-- FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES

---------------------------
-- CORP_ETL_MFB_FORM_WIP
---------------------------

	
-- DROP INDEX MAXDAT.IDX_CEMFB_FORM_WIP_COVERED;
-- ORA-02429: cannot drop index used for enforcement of unique/primary key
--	FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES

---------------------------
--	CORP_ETL_MFB_FORM
---------------------------


DROP INDEX MAXDAT.IDX_CEMFB_FORM_COVERED;
--	FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES	
	

------------------------------
--	CORP_ETL_MFB_ENVELOPE_OLTP
------------------------------

DROP INDEX MAXDAT.IDX_CEMFB_ENV_OLTP_COVERED;
--	BATCH_GUID, ECN, ENV_RECEIPT_DATE, ENV_CREATION_DATE, ENV_DOC_COUNT, ENV_PAGE_COUNT

------------------------------
--	CORP_ETL_MFB_ENVELOPE_STG
------------------------------

DROP INDEX MAXDAT.IDX_CEMFB_ENV_STG_COVERED;	
-- BATCH_GUID, ECN, ENV_RECEIPT_DATE, ENV_CREATION_DATE, ENV_DOC_COUNT, ENV_PAGE_COUNT

------------------------------
--	CORP_ETL_MFB_ENVELOPE_WIP
------------------------------

DROP INDEX MAXDAT.IDX_CEMFB_ENV_WIP_COVERED;
-- BATCH_GUID, ECN, ENV_RECEIPT_DATE, ENV_CREATION_DATE, ENV_DOC_COUNT, ENV_PAGE_COUNT

------------------------------
--	CORP_ETL_MFB_ENVELOPE
------------------------------


DROP INDEX MAXDAT.IDX_CEMFB_ENV_COVERED;
--	BATCH_GUID, ECN, ENV_RECEIPT_DATE, ENV_CREATION_DATE, ENV_DOC_COUNT, ENV_PAGE_COUNT


---------------------------
-- CORP_ETL_MFB_ECN_STG
---------------------------

---------------------------
-- CORP_ETL_MFB_SML_OLTP sml,
---------------------------

--  BATCH_GUID - Not in table


---------------------------
-- CORP_ETL_MFB_SBM_OLTP sbm,
---------------------------

--	BATCHGUID

---------------------------
-- CORP_ETL_MFB_SB_OLTP sb	
---------------------------

--	BATCHGUID
	
