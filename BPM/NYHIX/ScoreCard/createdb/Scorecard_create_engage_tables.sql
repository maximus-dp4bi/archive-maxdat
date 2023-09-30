show errors;

ALTER SESSION SET CURRENT_SCHEMA = DP_SCORECARD;
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_FORM_TYPE';
   if c = 1 then
      execute immediate 'drop table ENGAGE_FORM_TYPE cascade constraints';
   end if;
end;
/

CREATE TABLE ENGAGE_FORM_TYPE 
(form_type_id NUMBER
 ,evaluation_form VARCHAR2(512) 
 ,scorecard_score_type VARCHAR2(512)
 ,scorecard_group VARCHAR2(512)  
 ,create_by VARCHAR2(100)
 ,create_datetime DATE
 ,start_date DATE
 ,end_date DATE) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX ENGAGE_FORMTYPE_TYPEID ON ENGAGE_FORM_TYPE(form_type_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX ENGAGE_FORMTYPE_EVAL_FORM ON ENGAGE_FORM_TYPE(evaluation_form) TABLESPACE MAXDAT_INDX;
 
grant select on ENGAGE_FORM_TYPE to MAXDAT_READ_ONLY;  
grant select, insert, delete, update, references on ENGAGE_FORM_TYPE to MAXDAT;  

--create view ENGAGE_FORM_TYPE_SV

CREATE OR REPLACE FORCE VIEW ENGAGE_FORM_TYPE_SV
(form_type_id
 ,evaluation_form 
 ,scorecard_score_type
 ,scorecard_group  
 ,create_by
 ,create_datetime
 ,start_date
 ,end_date	
) 
as
select 
form_type_id
 ,evaluation_form 
 ,scorecard_score_type
 ,scorecard_group  
 ,create_by
 ,create_datetime
 ,start_date
 ,end_date
from ENGAGE_FORM_TYPE
WITH READ ONLY;

grant select on ENGAGE_FORM_TYPE_SV to MAXDAT_READ_ONLY; 
grant select on ENGAGE_FORM_TYPE_SV to MAXDAT; 

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_ACTUALS';
   if c = 1 then
      execute immediate 'drop table ENGAGE_ACTUALS cascade constraints';
   end if;
end;
/

CREATE TABLE ENGAGE_ACTUALS 
(evaluation_reference_id NUMBER
 ,evaluation_reference VARCHAR2(512)
 ,agent_id VARCHAR2(250)
 ,evaluator_id VARCHAR2(250)
 ,score_total NUMBER
 ,evaluation_date_time DATE 
 ,evaluation_form  VARCHAR2(512)
 ,call_date DATE
 ,create_by VARCHAR2(100)
 ,create_datetime DATE
 ,last_update_date DATE 
 ,last_updated_by VARCHAR2(100)
 ,deleted_flag VARCHAR2(1)) TABLESPACE MAXDAT_DATA;
 
 CREATE UNIQUE INDEX ENGAGEACTUALS_EVALREF_ID ON ENGAGE_ACTUALS(evaluation_reference_id) TABLESPACE MAXDAT_INDX;
 CREATE INDEX ENGAGEACTUALS_EVALFORM ON ENGAGE_ACTUALS(evaluation_form) TABLESPACE MAXDAT_INDX;
 CREATE INDEX ENGAGEACTUALS_EVALDT ON ENGAGE_ACTUALS(EVALUATION_DATE_TIME) TABLESPACE MAXDAT_INDX;
 CREATE INDEX ENGAGEACTUALS_EVALREF ON ENGAGE_ACTUALS(EVALUATION_REFERENCE) TABLESPACE MAXDAT_INDX;
 
 grant select on ENGAGE_ACTUALS to MAXDAT_READ_ONLY;  
 grant select, insert, delete, update, references on ENGAGE_ACTUALS to MAXDAT;  

 --create view ENGAGE_ACTUALS_SV

CREATE OR REPLACE FORCE VIEW ENGAGE_ACTUALS_SV
(evaluation_reference_id
 ,evaluation_reference
 ,agent_id
 ,evaluator_id
 ,score_total
 ,evaluation_date_time 
 ,evaluation_form
 ,call_date
 ,create_by
 ,create_datetime
 ,last_update_date 
 ,last_updated_by	
 ,deleted_flag
) 
as
select 
evaluation_reference_id
 ,evaluation_reference
 ,agent_id
 ,evaluator_id
 ,score_total
 ,evaluation_date_time 
 ,evaluation_form
 ,call_date
 ,create_by
 ,create_datetime
 ,last_update_date 
 ,last_updated_by
 ,deleted_flag
from ENGAGE_ACTUALS
WITH READ ONLY;

grant select on ENGAGE_ACTUALS_SV to MAXDAT_READ_ONLY; 
grant select ENGAGE_ACTUALS_SV to MAXDAT; 

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_ACTUALS_STG';
   if c = 1 then
      execute immediate 'drop table ENGAGE_ACTUALS_STG cascade constraints';
   end if;
end;
/
 
CREATE TABLE ENGAGE_ACTUALS_STG 
( evaluation_reference_id NUMBER
 ,evaluation_reference VARCHAR2(512)
 ,agent_id VARCHAR2(250)
 ,evaluator_id VARCHAR2(250)
 ,score_total NUMBER
 ,evaluation_date_time DATE 
 ,evaluation_form  VARCHAR2(512)
 ,call_date DATE
) tablespace MAXDAT_DATA;

CREATE INDEX ENGAGEACTUALSSTG_IDX1 ON ENGAGE_ACTUALS_STG (EVALUATION_REFERENCE) TABLESPACE MAXDAT_INDX;

grant select on ENGAGE_ACTUALS_STG to MAXDAT_READ_ONLY; 
grant select, insert, delete, update, references ENGAGE_ACTUALS_STG to MAXDAT; 

--ENGAGE_ACTUALS_SUP

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_ACTUALS_SUP';
   if c = 1 then
      execute immediate 'drop table ENGAGE_ACTUALS_SUP cascade constraints';
   end if;
end;
/

CREATE TABLE ENGAGE_ACTUALS_SUP 
(
  EVALUATION_REFERENCE_ID NUMBER 
, EVALUATION_REFERENCE VARCHAR2(512 BYTE) 
, EVALUATOR_ID VARCHAR2(250 BYTE) 
, SCORE_TOTAL NUMBER 
, EVALUATION_DATE_TIME DATE 
, EVALUATION_FORM VARCHAR2(512 BYTE) 
, CALL_DATE DATE 
, QC_EVALUATION_ID VARCHAR2(512 BYTE) 
, CREATE_BY VARCHAR2(100 BYTE) 
, CREATE_DATETIME DATE 
, LAST_UPDATE_DATE DATE 
, LAST_UPDATED_BY VARCHAR2(100 BYTE) 
) 
TABLESPACE MAXDAT_DATA; 

CREATE UNIQUE INDEX ENGAGEACTUALSSUP_EVALREF_ID ON ENGAGE_ACTUALS_SUP (EVALUATION_REFERENCE_ID ASC) 
TABLESPACE MAXDAT_INDX;

GRANT INSERT,UPDATE,SELECT,DELETE ON ENGAGE_ACTUALS_SUP TO MAXDAT;
GRANT SELECT ON ENGAGE_ACTUALS_SUP TO MAXDAT_READ_ONLY;
 
CREATE OR REPLACE VIEW ENGAGE_ACTUALS_SUP_SV 
(
  EVALUATION_REFERENCE_ID 
, EVALUATION_REFERENCE 
, EVALUATOR_ID 
, SCORE_TOTAL 
, EVALUATION_DATE_TIME
, EVALUATION_FORM 
, CALL_DATE 
, QC_EVALUATION_ID 
, CREATE_BY 
, CREATE_DATETIME
, LAST_UPDATE_DATE 
, LAST_UPDATED_BY 
)
AS
SELECT 
 EVALUATION_REFERENCE_ID 
, EVALUATION_REFERENCE 
, EVALUATOR_ID 
, SCORE_TOTAL 
, EVALUATION_DATE_TIME
, EVALUATION_FORM 
, CALL_DATE 
, QC_EVALUATION_ID 
, CREATE_BY 
, CREATE_DATETIME
, LAST_UPDATE_DATE 
, LAST_UPDATED_BY 
FROM ENGAGE_ACTUALS_SUP
WITH READ ONLY;

GRANT SELECT ON ENGAGE_ACTUALS_SUP_SV TO MAXDAT;
GRANT SELECT ON ENGAGE_ACTUALS_SUP_SV TO MAXDAT_READ_ONLY;

create or replace trigger TRG_BIU_ENGAGE_ACTUALS_SUP
BEFORE INSERT OR UPDATE ON ENGAGE_ACTUALS_SUP
FOR EACH ROW

BEGIN
  IF INSERTING THEN
    :new.create_by := user;
    :new.create_datetime := sysdate;
  END IF;

 :new.last_updated_by := user;
 :new.last_update_date := sysdate;

end;
/

CREATE OR REPLACE TRIGGER TRG_BIU_ENGAGE_ACTUALS
BEFORE INSERT OR UPDATE ON ENGAGE_ACTUALS
FOR EACH ROW

BEGIN
  IF INSERTING THEN
    :new.create_by := user;
    :new.create_datetime := sysdate;
  END IF;

 :new.last_updated_by := user;
 :new.last_update_date := sysdate;

end;
/

