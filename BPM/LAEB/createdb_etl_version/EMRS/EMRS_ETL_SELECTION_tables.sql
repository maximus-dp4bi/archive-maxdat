

CREATE TABLE MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT_STG
	(ETL_SELECTION_SEGMENT_ID NUMBER(18,0)
,JOB_ID NUMBER(18,0)
,ROW_ID NUMBER(18,0)
,PROGRAM_TYPE_CD VARCHAR2(32)
,PLAN_ID_EXT VARCHAR2(30)
,PLAN_TYPE_CD VARCHAR2(32)
,MATCHED_CLIENT_ID NUMBER(18,0)
,MATCHED_PLAN_ID NUMBER(18,0)
,PROCESSED_TO_APP_TS DATE
,CONTRACT_ID NUMBER(18,0)
,SS_GENERIC_FIELD5_TXT VARCHAR2(256)	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);
	
CREATE INDEX IDX1_ETLSELECTIONSEGMENT
	ON MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT_STG (MATCHED_CLIENT_ID)
	;

CREATE INDEX IDX2_ETLSELECTIONSEGMENT
	ON MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT_STG (TRUNC(PROCESSED_TO_APP_TS))
	;

CREATE TABLE MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT
	(ETL_SELECTION_SEGMENT_ID NUMBER(18,0)
,JOB_ID NUMBER(18,0)
,ROW_ID NUMBER(18,0)
,PROGRAM_TYPE_CD VARCHAR2(32)
,PLAN_ID_EXT VARCHAR2(30)
,PLAN_TYPE_CD VARCHAR2(32)
,MATCHED_CLIENT_ID NUMBER(18,0)
,MATCHED_PLAN_ID NUMBER(18,0)
,PROCESSED_TO_APP_TS DATE
,CONTRACT_ID NUMBER(18,0)
,SS_GENERIC_FIELD5_TXT VARCHAR2(256)	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT_STG TO MAXDAT_LAEB_READ_ONLY;
GRANT SELECT ON MAXDAT_LAEB.EMRS_ETL_SELECTION_SEGMENT TO MAXDAT_LAEB_READ_ONLY;

