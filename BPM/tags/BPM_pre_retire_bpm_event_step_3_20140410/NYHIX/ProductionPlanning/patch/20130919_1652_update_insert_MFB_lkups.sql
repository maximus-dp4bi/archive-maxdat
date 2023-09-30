---INSERT MFB SOURCE IN PP_CFG_SOURCE_CONFIG   SELECT * FROM PP_CFG_SOURCE_CONFIG;
UPDATE PP_CFG_SOURCE_CONFIG SET SOURCE_DESCRIPTION = 'New York HIX MAXDAT Manage Work Staging Table - Task Create Date to Completed Date.' WHERE CFG_SOURCE_CONFIG_ID = 1;

INSERT INTO MAXDAT.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (2, 'NYHIX MAIL/FAX BATCH STG', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Review Batch Start Date to End Date.');
  
INSERT INTO MAXDAT.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (3, 'NYHIX MAIL/FAX BATCH SCAN', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Activity Scan Start to Scan End.');  

--INSERT MFB SOURCE IN PP_D_SOURCE   SELECT * FROM PP_D_SOURCE;
INSERT INTO MAXDAT.PP_D_SOURCE
  (SOURCE_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (2, 'NYHIX MAIL/FAX BATCH STG', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Review Batch Start Date to End Date.');
INSERT INTO MAXDAT.PP_D_SOURCE
  (SOURCE_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (3, 'NYHIX MAIL/FAX BATCH SCAN', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Activity Scan Start to Scan End.');
  
--INSERT MFB SOURCE IN PP_D_SOURCE_REF_TYPE   SELECT * FROM PP_D_SOURCE_REF_TYPE SRT;
INSERT INTO MAXDAT.PP_D_SOURCE_REF_TYPE
  (SOURCE_REF_TYPE_ID, SOURCE_REF_TYPE_NAME, SOURCE_ID)
VALUES
  (2, 'BATCH TYPE', 2);
INSERT INTO MAXDAT.PP_D_SOURCE_REF_TYPE
  (SOURCE_REF_TYPE_ID, SOURCE_REF_TYPE_NAME, SOURCE_ID)
VALUES
  (3, 'BATCH CLASS', 3);

--UPDATE AGE DAYS TYPE FOR MFB UOW SELECT * FROM PP_CFG_UNIT_OF_WORK
UPDATE PP_CFG_UNIT_OF_WORK SET AGE_DAYS_TYPE='BUS' WHERE CFG_UOW_ID IN (1,2,3);

COMMIT;

---INSERT/UPDATE PP_D_UOW_SOURCE_REF SELECT * FROM PP_D_UOW_SOURCE_REF USR ORDER BY USR_ID;
UPDATE PP_D_UOW_SOURCE_REF SET SOURCE_REF_TYPE_ID=2, SOURCE_REF_DETAIL_IDENTIFIER = 'BATCH TYPE' WHERE USR_ID IN (1,2);
UPDATE PP_D_UOW_SOURCE_REF SET SOURCE_REF_TYPE_ID=3, SOURCE_REF_DETAIL_IDENTIFIER = 'BATCH CLASS' WHERE USR_ID IN (3);
UPDATE PP_D_UOW_SOURCE_REF SET SOURCE_REF_VALUE='APPLICATION ONLY' WHERE USR_ID=1;
UPDATE PP_D_UOW_SOURCE_REF SET SOURCE_REF_VALUE='VERIFICATION DOCUMENTS ONLY' WHERE USR_ID=2;


--APPLICATION ONLY 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 26, 1, 2, 'APPLICATION + VERIFICATION DOCUMENTS', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 27, 1, 2, 'RENEWALS ONLY', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 28, 1, 2, 'RENEWALS + VERIFICATION DOCUMENTS', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 

--INSERT INTO PP_D_UOW_SOURCE_REF SELECT 2, 2, 2, 'VERIFICATION DOCUMENTS ONLY', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 29, 2, 2, 'EMPLOYER/EMPLOYEE  APPLICATION ONLY', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 30, 2, 2, 'EMPLOYER/EMPLOYEE APPLICATION + VERIFICATION DOCUMENTS', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 31, 2, 2, 'RETURNED MAIL', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 32, 2, 2, 'INCIDENT', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 33, 2, 2, 'NON STANDARD', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

COMMIT;

/