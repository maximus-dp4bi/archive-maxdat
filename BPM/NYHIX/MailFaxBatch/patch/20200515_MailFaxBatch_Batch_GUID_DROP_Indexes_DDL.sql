---------------------------
-- CORP_ETL_MFB_BATCH_OLTP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_OLTP_BATCH_GUID;
	
---------------------------
-- CORP_ETL_MFB_BATCH_STG	-- ROWS 5,538,767
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_STG_BATCH_GUID;
	
---------------------------
-- CORP_ETL_MFB_BATCH_STG_WIP
---------------------------
--	BATCH_GUID << ALREADY EXIST

---------------------------
--CORP_ETL_MFB_BATCH
---------------------------

--	BATCH_GUID	<< ALREADY EXIST
	
---------------------------
-- CORP_ETL_MFB_BATCH_ARS_OLTP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_BATCH_ARS_STG
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG_BATCH_GUID;


---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_OLTP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_OLTP_BATCH_GUID;
	
	
---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_STG
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG_BATCH_GUID;


---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_WIP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_BATCH_GUID;

	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_OLTP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_OLTP_BATCH_GUID;
	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_STG	-- 6,139,887 ROWS
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_STG_BATCH_GUID;
	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_WIP	-- 10,751 ROWS
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_DOCUMENT	-- 6,139,325 ROWS
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_FORM_OLTP
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_FORM_OLTP_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_FORM_STG
---------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_FORM_STG_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_FORM_WIP
---------------------------

--	BATCH_GUID  << ALREADY EXIST


---------------------------
--	CORP_ETL_MFB_FORM
---------------------------

--	BATCH_GUID  << ALREADY EXIST


------------------------------
--	CORP_ETL_MFB_ENVELOPE_OLTP
------------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_OLTP_BATCH_GUID;

------------------------------
--	CORP_ETL_MFB_ENVELOPE_STG
------------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_STG_BATCH_GUID;

------------------------------
--	CORP_ETL_MFB_ENVELOPE_WIP
------------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP_BATCH_GUID;

------------------------------
--	CORP_ETL_MFB_ENVELOPE
------------------------------

DROP INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_BATCH_GUID;

---------------------------
-- CORP_ETL_MFB_ECN_STG
---------------------------

--	CEMFBECN_ID

--	BATCH_GUID, ECN	  << ALREADY EXIST
	

---------------------------
-- CORP_ETL_MFB_SML_OLTP sml,
---------------------------

--	MODULENAME


---------------------------
-- CORP_ETL_MFB_SBM_OLTP sbm,
---------------------------

--	BATCHGUID	<< ALREADY EXIST
--	STARTDATETIME
--	MODULELAUNCHID

---------------------------
-- CORP_ETL_MFB_SB_OLTP sb	
---------------------------

--	BATCHGUID	<< ALREADY EXIST
	
