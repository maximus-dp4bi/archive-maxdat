ALTER TABLE engage_actuals
ADD (LAST_UPDATE_DATE DATE
    ,LAST_UPDATED_BY VARCHAR2(100));

CREATE TABLE ENGAGE_ACTUALS_STG 
(evaluation_reference_id NUMBER
 ,evaluation_reference VARCHAR2(512)
 ,agent_id VARCHAR2(250)
 ,evaluator_id VARCHAR2(250)
 ,score_total NUMBER
 ,evaluation_date_time DATE 
 ,evaluation_form  VARCHAR2(512)) TABLESPACE MAXDAT_DATA;

 CREATE INDEX ENGAGEACTUALSSTG_IDX1 ON ENGAGE_ACTUALS_STG(evaluation_reference) TABLESPACE MAXDAT_INDX;

 grant select on ENGAGE_ACTUALS_STG to MAXDAT_READ_ONLY;  

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