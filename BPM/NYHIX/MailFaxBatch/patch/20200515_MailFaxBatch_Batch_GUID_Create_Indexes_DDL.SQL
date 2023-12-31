---------------------------
--CORP_ETL_MFB_BATCH_OLTP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_OLTP_BATCH_GUID PARALLEL 1;	
---------------------------
--CORP_ETL_MFB_BATCH_STG	-- ROWS 5,538,767
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_STG_BATCH_GUID PARALLEL 1;	
---------------------------
--CORP_ETL_MFB_BATCH_STG_WIP
---------------------------
--	BATCH_GUID << ALREADY EXIST

---------------------------
--CORP_ETL_MFB_BATCH
---------------------------

--	BATCH_GUID	<< ALREADY EXIST
	
---------------------------
-- CORP_ETL_MFB_BATCH_ARS_OLTP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP_BATCH_GUID PARALLEL 1;
---------------------------
-- CORP_ETL_MFB_BATCH_ARS_STG
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG_BATCH_GUID PARALLEL 1;

---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_OLTP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_OLTP_BATCH_GUID PARALLEL 1;	
	
---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_STG
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG_BATCH_GUID PARALLEL 1;

---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS_WIP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP_BATCH_GUID PARALLEL 1;
---------------------------
-- CORP_ETL_MFB_BATCH_EVENTS
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_BATCH_GUID PARALLEL 1;
	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_OLTP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_DOCUMENT_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_OLTP_BATCH_GUID PARALLEL 1;	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_STG	-- 6,139,887 ROWS
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_DOCUMENT_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_STG_BATCH_GUID PARALLEL 1;	
---------------------------
-- CORP_ETL_MFB_DOCUMENT_WIP	-- 10,751 ROWS
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP_BATCH_GUID PARALLEL 1;
---------------------------
-- CORP_ETL_MFB_DOCUMENT	-- 6,139,325 ROWS
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_DOCUMENT(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_DOCUMENT_BATCH_GUID PARALLEL 1;
---------------------------
-- CORP_ETL_MFB_FORM_OLTP
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_FORM_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_FORM_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_FORM_OLTP_BATCH_GUID PARALLEL 1;
---------------------------
-- CORP_ETL_MFB_FORM_STG
---------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_FORM_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_FORM_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_FORM_STG_BATCH_GUID PARALLEL 1;

---------------------------
-- CORP_ETL_MFB_FORM_WIP
---------------------------

-- BATCH_GUID << ALREADY EXIST

---------------------------
--	CORP_ETL_MFB_FORM
---------------------------

--	BATCH_GUID  << ALREADY EXIST


------------------------------
--	CORP_ETL_MFB_ENVELOPE_OLTP
------------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_OLTP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_ENVELOPE_OLTP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_OLTP_BATCH_GUID PARALLEL 1;

------------------------------
--	CORP_ETL_MFB_ENVELOPE_STG
------------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_STG_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_ENVELOPE_STG(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_STG_BATCH_GUID PARALLEL 1;
------------------------------
--	CORP_ETL_MFB_ENVELOPE_WIP
------------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP_BATCH_GUID PARALLEL 1;
------------------------------
--	CORP_ETL_MFB_ENVELOPE
------------------------------

CREATE INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_BATCH_GUID
ON MAXDAT.CORP_ETL_MFB_ENVELOPE(BATCH_GUID)
TABLESPACE MAXDAT_INDX PARALLEL 12;

ALTER INDEX MAXDAT.CORP_ETL_MFB_ENVELOPE_BATCH_GUID PARALLEL 1;
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
	
