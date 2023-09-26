--Triggers for phase 2 staging and dimension tables

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_EXPERT_REVIEW
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_EXPERT_REVIEW
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.SCIER_ID IS NULL THEN 
          SELECT SEQ_SCIER_ID.NEXTVAL INTO :NEW.SCIER_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_ISSUES_IN_DISP
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_ISSUES_IN_DISPUTE
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.SCIIID_ID IS NULL THEN 
          SELECT SEQ_SCIIID_ID.NEXTVAL INTO :NEW.SCIIID_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_DECISIONS
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_DECISIONS
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.SCID_ID IS NULL THEN 
          SELECT SEQ_SCID_ID.NEXTVAL INTO :NEW.SCID_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE TRIGGER BI_D_CRS_STATUS
    BEFORE INSERT ON D_CRS_STATUS
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCS_ID IS NULL THEN 
          SELECT SEQ_DCSS_ID.NEXTVAL INTO :NEW.DCS_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_DATA_PROVIDED
    BEFORE INSERT ON D_CRS_DATA_PROVIDED
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCDP_ID IS NULL THEN 
          SELECT SEQ_DCDP_ID.NEXTVAL INTO :NEW.DCDP_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_EXPERTS
    BEFORE INSERT ON D_CRS_EXPERTS
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCE_ID IS NULL THEN 
          SELECT SEQ_DCE_ID.NEXTVAL INTO :NEW.DCE_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_EXPERT_LICENSES
    BEFORE INSERT ON D_CRS_EXPERT_LICENSES
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCEL_ID IS NULL THEN 
          SELECT SEQ_DCEL_ID.NEXTVAL INTO :NEW.DCEL_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_EXPERT_TYPES
    BEFORE INSERT ON D_CRS_EXPERT_TYPES
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCET_ID IS NULL THEN 
          SELECT SEQ_DCET_ID.NEXTVAL INTO :NEW.DCET_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_EXP_SPECLTIES
    BEFORE INSERT ON D_CRS_EXPERT_SPECIALTIES
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCES_ID IS NULL THEN 
          SELECT SEQ_DCES_ID.NEXTVAL INTO :NEW.DCES_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_ISSUE_TYPES
    BEFORE INSERT ON D_CRS_ISSUE_TYPES
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCIT_ID IS NULL THEN 
          SELECT SEQ_DCIT_ID.NEXTVAL INTO :NEW.DCIT_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_DECISION_TYPES
    BEFORE INSERT ON D_CRS_DECISION_TYPES
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCDT_ID IS NULL THEN 
          SELECT SEQ_DCDT_ID.NEXTVAL INTO :NEW.DCDT_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

CREATE OR REPLACE TRIGGER BI_D_CRS_INELIGIBLE_REASONS
    BEFORE INSERT ON D_CRS_INELIGIBLE_REASONS
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCIR_ID IS NULL THEN 
          SELECT SEQ_DCIR_ID.NEXTVAL INTO :NEW.DCIR_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/

--Triggers for ammendment staging and dimension tables

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_PRELIM_REVIEW
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_PRELIMINARY_REVIEW
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.SCIPR_ID IS NULL THEN 
          SELECT SEQ_SCIPR_ID.NEXTVAL INTO :NEW.SCIPR_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE TRIGGER BI_D_CRS_INELIGIBILITY_LETTER
    BEFORE INSERT ON D_CRS_INELIGIBILITY_LETTER
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCIL_ID IS NULL THEN 
          SELECT SEQ_DCIL_ID.NEXTVAL INTO :NEW.DCIL_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END;  
/