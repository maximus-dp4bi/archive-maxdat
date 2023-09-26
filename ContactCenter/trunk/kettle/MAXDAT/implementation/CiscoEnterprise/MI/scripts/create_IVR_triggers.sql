/*
Created on 02/01/2016 by Raj A.
Description: Created for MAXDAT-3041
Creating triggers for CC_C_IVR_DNIS , CC_C_IVR_CALL_RESULT and CC_S_IVR_RESPONSE tables.
*/
CREATE OR REPLACE TRIGGER BI_CC_C_IVR_DNIS
    BEFORE INSERT ON CC_C_IVR_DNIS 
    FOR EACH ROW 
    
BEGIN
IF INSERTING AND :NEW.C_DNIS_UOW_ID IS NULL THEN 
          SELECT SEQ_CC_C_IVR_DNIS.NEXTVAL INTO :NEW.C_DNIS_UOW_ID FROM DUAL;      
END IF;
END;

CREATE OR REPLACE TRIGGER BI_CC_C_IVR_CALL_RESULT
    BEFORE INSERT ON CC_C_IVR_CALL_RESULT 
    FOR EACH ROW 
    
BEGIN
IF INSERTING AND :NEW.C_IVR_CALL_RES_ID IS NULL THEN 
          SELECT SEQ_CC_C_IVR_CALL_RESULT.NEXTVAL INTO :NEW.C_IVR_CALL_RES_ID FROM DUAL;      
END IF;
END;


CREATE OR REPLACE TRIGGER BIU_CC_S_IVR_RESPONSE
  BEFORE INSERT OR UPDATE ON CC_S_IVR_RESPONSE 
  FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :NEW.IVR_RESPONSE_ID IS NULL THEN 
      SELECT SEQ_CC_S_IVR_RESPONSE.NEXTVAL INTO :NEW.IVR_RESPONSE_ID FROM DUAL;
    END IF;
    :NEW.ROW_INSERTED_DT := SYSDATE;
    :NEW.ROW_INSERTED_BY := USER; 
    :NEW.ROW_UPDATED_DT := SYSDATE;
    :NEW.ROW_UPDATED_BY := USER; 
  END IF;
    :NEW.ROW_UPDATED_DT := SYSDATE;
    :NEW.ROW_UPDATED_BY := USER; 
END;