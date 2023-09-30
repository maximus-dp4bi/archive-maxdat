Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('EMRS_ADHOC_START_TIME','V','23:59:58','Start Time for EMRS Adhoc Medicaid Enrollment process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('EMRS_ADHOC_END_TIME','V','23:59:59','End Time for EMRS Adhoc Medicaid Enrollment process to run',SYSDATE,SYSDATE);


COMMIT;

CREATE TABLE EMRS_S_ENROLLMENT_COUNTS_ADHOC
(ENRL_RECCOUNT_ID NUMBER(*,0) NOT NULL
, CREATION_DATE DATE
, RECORD_COUNT NUMBER(18)
, PROCESSED_COUNT NUMBER(18)
, MIN_SELECTION_SEGMENT_ID NUMBER(*,0)
, MAX_SELECTION_SEGMENT_ID NUMBER(*,0)
, PROCESSED_FLAG VARCHAR(1)
) TABLESPACE MAXDAT_DATA;

CREATE PUBLIC SYNONYM EMRS_S_ENROLLMENT_COUNTS_ADHOC FOR EMRS_S_ENROLLMENT_COUNTS_ADHOC;

alter table EMRS_S_ENROLLMENT_COUNTS_ADHOC add constraint ENROLLMENT_COUNTS_ADHOC_PK primary key (ENRL_RECCOUNT_ID)
using index tablespace MAXDAT_INDX;

drop index IDX2_ENROLLADHOC;
drop index IDX4_ENROLLADHOC;