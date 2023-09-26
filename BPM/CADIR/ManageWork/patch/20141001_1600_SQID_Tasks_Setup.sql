CREATE TABLE SQID_TASK_HIST_STG
  (	"TASK_ID" VARCHAR2(50 BYTE), 
	"SOURCE_TASK_ID" VARCHAR2(50 BYTE), 
	"DCN" VARCHAR2(50 BYTE), 
	"DOCUMENT_ID" VARCHAR2(20 BYTE), 
	"DOC_TYPE_CD" VARCHAR2(255 BYTE), 
	"DOC_STATUS_CD" VARCHAR2(50 BYTE), 
	"CHANNEL" VARCHAR2(50 BYTE), 
	"TASK_STATUS" VARCHAR2(50 BYTE), 
	"TASK_PRIORITY" VARCHAR2(50 BYTE), 
	"TASK_TYPE" VARCHAR2(100 BYTE), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"STATUS_DATE" DATE, 
	"RELEASE_DATE" DATE, 
	"RECEIVED_DATE" DATE, 
	"OWNER_NAME" VARCHAR2(50 BYTE), 
	"CASE_ID" VARCHAR2(50 BYTE), 
	"EXECUTION_ID" VARCHAR2(100 BYTE), 
	"CREATE_DATE" DATE, 
	"CREATED_BY" VARCHAR2(50 BYTE), 
	"UPDATE_DATE" DATE, 
	"UPDATED_BY" VARCHAR2(50 BYTE), 
	"IN_PROCESS" VARCHAR2(1 BYTE) DEFAULT 'Y', 
	"STG_EXTRACTION_COMPLETE_DATE" DATE, 
	"STG_LAST_UPDATE_DATE" DATE DEFAULT sysdate
   )
  TABLESPACE "MAXDAT_DATA" ;

Create or Replace public synonym SQID_TASK_HIST_STG for SQID_TASK_HIST_STG;

alter table SQID_TASK_HIST_STG add constraint Source_Task_ID_UK unique (Source_Task_ID) using index tablespace MAXDAT_INDX;

alter table d_person add Login_Name varchar2(50);
alter table d_person add constraint D_Person_login_name_UK unique (login_name) using index tablespace MAXDAT_INDX;

CREATE TABLE SQID_USER_ROLE_STG (
  SEC_USER_ROLE_ID NUMBER,
  SEC_USER_ID NUMBER,
  SEC_ROLE_ID NUMBER );
  
Create public synonym SQID_USER_ROLE_STG for SQID_USER_ROLE_STG;  

Insert into d_person (person_id, first_name, last_name, login_name) values (101,'Batch','Process','BATCH');
Insert into d_person (person_id, first_name, last_name, login_name) values (102,'System','Process','SYSTEM');
  
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS)
values ('SQID_LAST_HIST_TASK_ID','N','0','Used to fetch task history records from SQID for MW process',SYSDATE,SYSDATE);

