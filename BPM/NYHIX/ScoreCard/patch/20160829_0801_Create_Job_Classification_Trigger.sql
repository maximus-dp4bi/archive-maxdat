create or replace TRIGGER BIU_PP_WFM_JOB_CLASS
    BEFORE INSERT OR UPDATE ON PP_WFM_JOB_CLASSIFICATION
    FOR EACH ROW 
    BEGIN
if :NEW.DELETE_FLAG = 'Y' THEN
  :NEW.END_DATE := SYSDATE;
END IF;
END;
/
