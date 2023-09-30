DROP INDEX STG_IDX2_CASENUM;

CREATE UNIQUE INDEX EMRS_S_CASES_STG_PK ON EMRS_S_CASES_STG (CASE_ID) TABLESPACE MAXDAT_LAEB_DATA;
ALTER TABLE EMRS_S_CASES_STG ADD CONSTRAINT EMRS_S_CASES_STG_PK PRIMARY KEY (CASE_ID) USING INDEX EMRS_S_CASES_STG_PK ENABLE;

