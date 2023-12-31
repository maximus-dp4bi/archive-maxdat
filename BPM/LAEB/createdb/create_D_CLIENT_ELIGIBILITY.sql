CREATE TABLE MAXDAT_SUPPORT.D_CLIENT_ELIGIBILITY 
   (SEGMENT_CREATE_DATE DATE, 
	COA VARCHAR2(8 BYTE), 
	PRIOR_COA VARCHAR2(8 BYTE), 
	AC_TC VARCHAR2(65 BYTE), 
	AID_CATEGORY VARCHAR2(32 BYTE), 
	TYPE_CASE VARCHAR2(32 BYTE), 
	PREGNANCY_FLAG NUMBER, 
	ME_START_DATE DATE, 
	ME_END_DATE DATE, 
	JOB_ID NUMBER(8,0), 
	ROW_NUM NUMBER(8,0), 
	ERROR_COUNT NUMBER(8,0), 
	ERROR_TEXT VARCHAR2(512 BYTE), 
	CLIENT_ID VARCHAR2(32 BYTE), 
	ID_ORIGINAL VARCHAR2(32 BYTE), 
	CANCEL_RSN VARCHAR2(32 BYTE), 
	MEDS_CASE_ID VARCHAR2(32 BYTE), 
	MEDS_SEQ_ID VARCHAR2(32 BYTE), 
	LAST_ACT_DATE DATE, 
	RECORD_CONTENT VARCHAR2(128 BYTE), 
	SEQUENCE_NUM NUMBER(8,0), 
	APPROVAL_CODE VARCHAR2(32 BYTE)
   );
grant select, references on MAXDAT_SUPPORT.D_CLIENT_ELIGIBILITY to maxdat_reports;

