CREATE SEQUENCE  "SEQ_CR_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "SEQ_CR_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE TS_IBR_CODE_REVIEWER
(
  CR_ID                		NUMBER(10) not null,
  FIRST_NAME		   		VARCHAR2(50),
  LAST_NAME			   		VARCHAR2(50),
  FULL_NAME			   		VARCHAR2(100),
  SUMMARY_OF_QUALIFICATION  VARCHAR2(2000),
  LICENSE_NUMBER			VARCHAR2(50),
  STATE_OF_PRACTICE			VARCHAR2(50),
  LICENSE_CREDENTIAL		VARCHAR2(50),
  COMMENTS					VARCHAR2(1000),
  START_DATE				DATE,
  END_DATE					DATE,
  CHANGE_STATUS				VARCHAR2(10),
  CHANGE_STATUS_DESC VARCHAR2(15),
  CREATED_BY				VARCHAR2(50),
  CREATED_DATE				DATE,
  MODIFIED_BY				VARCHAR2(50),
  MODIFIED_DATE				DATE
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table TS_IBR_CODE_REVIEWER
  add constraint CR_ID_PK primary key (CR_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
-- Grant/Revoke object privileges 

grant select, insert, update on TS_IBR_CODE_REVIEWER to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on TS_IBR_CODE_REVIEWER to MAXDAT_OLTP_SIUD;
grant select on TS_IBR_CODE_REVIEWER to MAXDAT_READ_ONLY;  

CREATE OR REPLACE TRIGGER "BUIR_IBR_CODE_REVIEWER" 
 BEFORE INSERT OR UPDATE
 ON TS_IBR_CODE_REVIEWER
 FOR EACH ROW
DECLARE
    v_seq_id     TS_IBR_CODE_REVIEWER.cr_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.cr_id IS NULL THEN
      SElECT SEQ_CR_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.CR_ID   := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.created_date := sysdate;
  END IF;
  :NEW.modified_by := user;
  :NEW.modified_date := sysdate;
END BUIR_IBR_CODE_REVIEWER;
/

CREATE OR REPLACE VIEW TS_IBR_CODE_REVIEWER_SV AS
SELECT TS_IBR_CODE_REVIEWER."CR_ID"
      ,TS_IBR_CODE_REVIEWER."FIRST_NAME"
      ,TS_IBR_CODE_REVIEWER."LAST_NAME"
      ,TS_IBR_CODE_REVIEWER."FULL_NAME"
      ,TS_IBR_CODE_REVIEWER."SUMMARY_OF_QUALIFICATION"
      ,TS_IBR_CODE_REVIEWER."LICENSE_NUMBER"
      ,TS_IBR_CODE_REVIEWER."STATE_OF_PRACTICE"
      ,TS_IBR_CODE_REVIEWER."LICENSE_CREDENTIAL"
      ,TS_IBR_CODE_REVIEWER."COMMENTS"
      ,TS_IBR_CODE_REVIEWER."START_DATE"
      ,TS_IBR_CODE_REVIEWER."END_DATE"
      ,TS_IBR_CODE_REVIEWER."CHANGE_STATUS"
      ,TS_IBR_CODE_REVIEWER."CHANGE_STATUS_DESC"
      ,TS_IBR_CODE_REVIEWER."CREATED_BY"
      ,TS_IBR_CODE_REVIEWER."CREATED_DATE"
      ,TS_IBR_CODE_REVIEWER."MODIFIED_BY"
      ,TS_IBR_CODE_REVIEWER."MODIFIED_DATE"
 FROM TS_IBR_CODE_REVIEWER;
 
GRANT SELECT ON "TS_IBR_CODE_REVIEWER_SV" TO "MAXDAT_READ_ONLY";

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Tricia','Brantley','Tricia Brantley','BS. AS in Health Information Technology.  Expertise with ICD-9, ICD-10-CM, CPT and HCPCS coding.  Years of experience includes work as a Sr. Health Plan Claims Examiner, Auditor and Claims System Programmer.','California', 'CPC-A','01-JAN-2018',null,'M');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Dawn', 'Ossont', 'Dawn Ossont','BS.  AAS in Health Information Technology.  Expertise with ICD-9-CM, CPT-4 billing, and bill dispute resolution at the 3rd level. Years of experience include work as Manager for Reimbursement and Provider Data, and Reimbursement Team Leader.','New York','RHIT/CCS','01-JAN-2018',null,'A');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Rachael', 'Silvaggi','Rachael Silvaggi','BS. Liberal Arts. Expertise with ICD-9-CM, ICD-10-CM/PCS, CPT and HCPCS coding.  Years of Hospital, Physician and Aftercare billing and coding.  8 years of Medicare appeals experience in assuring proper application of Medicare Regulations.  5 years of experience in preliminary review and legal with IMR.','New York',null,'13-MAR-2019',null,'A');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Teresa', 'Galllaher','Teresa Galllaher','Experienced California Workers’ Compensation Healthcare Professional with over 20 years’ experience in Bill Review for physician offices and claims administrators. Expertise with ICD-9-CM, ICD-10-CM coding, DRGs, CPT, and HCPCS',null,null,'08-OCT-2019',null,'A');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Mollie','Graves','Mollie Graves', null, 'California','CPC','01-JAN-2018','22-AUG-2018','R');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Daniel', 'Steele','Daniel Steele',null,'Ohio',null,'01-JAN-2018','13-MAR-2019','R');

Insert into TS_IBR_CODE_REVIEWER (  FIRST_NAME ,  LAST_NAME  ,  FULL_NAME  ,  SUMMARY_OF_QUALIFICATION,  STATE_OF_PRACTICE,  LICENSE_CREDENTIAL ,  START_DATE ,  END_DATE  ,  CHANGE_STATUS )
Values ( 'Teresa', 'Picard','Teresa Picard',null,'California','CMA','01-JAN-2018','08-OCT-2019','R');

commit;
  
-- Project wanted to add specific last modified dates for Initial records

ALTER TRIGGER "BUIR_IBR_CODE_REVIEWER" DISABLE;
/

 Update ts_ibr_code_reviewer set Modified_BY = 'Project';
 Update ts_ibr_code_reviewer set Modified_Date =  to_date('10/08/2019 12:00:00 AM','mm/dd/yyyy hh:mi:ss AM')  where CR_ID in (1,4,7);
 Update ts_ibr_code_reviewer set Modified_Date =  to_date('03/13/2019 12:00:00 AM','mm/dd/yyyy hh:mi:ss AM')  where CR_ID in (3,6);
 Update ts_ibr_code_reviewer set Modified_Date =  to_date('08/22/2018 12:00:00 AM','mm/dd/yyyy hh:mi:ss AM')  where CR_ID in (5);
 Update ts_ibr_code_reviewer set Modified_Date =  to_date('01/01/2018 12:00:00 AM','mm/dd/yyyy hh:mi:ss AM')  where CR_ID in (2);
 commit;
 
ALTER TRIGGER "BUIR_IBR_CODE_REVIEWER" ENABLE;
/



