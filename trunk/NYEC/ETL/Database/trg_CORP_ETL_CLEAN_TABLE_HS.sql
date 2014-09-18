-- Trigger for creating a record in the history table

CREATE OR REPLACE TRIGGER "MAXDAT"."TR_CORP_ETL_CLEAN_TABLE_HS" 
AFTER DELETE OR INSERT OR UPDATE
ON CORP_ETL_CLEAN_TABLE REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_ChangeType CORP_ETL_CLEAN_TABLE_HS.HS_ACTION%TYPE;

BEGIN

    IF INSERTING THEN
        v_ChangeType :='INSERT';

    ELSIF UPDATING THEN
        v_ChangeType :='UPDATE';

    ELSIF DELETING THEN
        v_ChangeType :='DELETE';

    END IF;

 IF INSERTING OR UPDATING THEN

INSERT INTO CORP_ETL_CLEAN_TABLE_HS(
               
    CECT_HS_ID, 
    CECT_ID,
    TABLE_NAME,
    COLUMN_NAME,
    DELETE_WHERE_CLAUSE,
    DAYS_TILL_DELETE,
    START_DATE,
    END_DATE,
    CREATED_TS,
    LAST_UPDATE_TS,
    ARC_FLAG,
    ARC_TABLE,
    HS_CREATED_TS,               
    HS_LAST_UPDATE_TS,            
    HS_ACTION )                    
    VALUES (
      seq_cect_hs_id.NEXTVAL,
       
    :NEW.CECT_ID,
    :NEW.TABLE_NAME,
    :NEW.COLUMN_NAME,
    :NEW.DELETE_WHERE_CLAUSE,
    :NEW.DAYS_TILL_DELETE,
    :NEW.START_DATE,
    :NEW.END_DATE,
    :NEW.CREATED_TS,
    :NEW.LAST_UPDATE_TS,
    :NEW.ARC_FLAG,
    :NEW.ARC_TABLE,     
      SYSDATE, 
      SYSDATE,
      V_CHANGETYPE
     );
ELSIF DELETING THEN

INSERT INTO CORP_ETL_CLEAN_TABLE_HS(
    
    CECT_HS_ID, 
    CECT_ID,
    TABLE_NAME,
    COLUMN_NAME,
    DELETE_WHERE_CLAUSE,
    DAYS_TILL_DELETE,
    START_DATE,
    END_DATE,
    CREATED_TS,
    LAST_UPDATE_TS,
    ARC_FLAG,
    ARC_TABLE,
    HS_CREATED_TS,
    HS_LAST_UPDATE_TS,
    HS_ACTION)
    VALUES (
       seq_cect_hs_id.NEXTVAL,
       
    :OLD.CECT_ID,
    :OLD.TABLE_NAME,
    :OLD.COLUMN_NAME,
    :OLD.DELETE_WHERE_CLAUSE,
    :OLD.DAYS_TILL_DELETE,
    :OLD.START_DATE,
    :OLD.END_DATE,
    :OLD.CREATED_TS,
    :OLD.LAST_UPDATE_TS,
    :OLD.ARC_FLAG,
    :OLD.ARC_TABLE,    
      SYSDATE, 
      SYSDATE,
      V_CHANGETYPE
     );   
END IF;

EXCEPTION
WHEN OTHERS THEN
RAISE;
END TR_CORP_ETL_CLEAN_TABLE_HS; 
/
ALTER TRIGGER "MAXDAT"."TR_CORP_ETL_CLEAN_TABLE_HS" ENABLE;