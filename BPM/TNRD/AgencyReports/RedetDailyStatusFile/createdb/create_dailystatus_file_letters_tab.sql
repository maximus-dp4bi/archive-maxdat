CREATE TABLE DAILY_STATFILE_LETTERS_STG
(APPLICATION_ID NUMBER
,CASE_ID NUMBER
,CLIENT_ID NUMBER
,LMREQ_ID NUMBER
,LETTER_TYPE_CD VARCHAR2(40)
,LETTER_MAILED_DATE DATE
,LETTER_PROCESS_DATE DATE
,CREATE_DATE DATE) TABLESPACE MAXDAT_DATA;

CREATE INDEX IDX1_DLYSTATFILESTG_LMREQID ON DAILY_STATFILE_LETTERS_STG(LMREQ_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX2_DLYSTATFILESTG_APPID ON DAILY_STATFILE_LETTERS_STG(APPLICATION_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX3_DLYSTATFILESTG_APPID ON DAILY_STATFILE_LETTERS_STG(CLIENT_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX4_DLYSTATFILESTG_APPID ON DAILY_STATFILE_LETTERS_STG(CREATE_DATE) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON DAILY_STATFILE_LETTERS_STG TO MAXDAT_READ_ONLY;

