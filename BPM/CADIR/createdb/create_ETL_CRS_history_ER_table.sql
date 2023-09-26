CREATE SEQUENCE SEQ_SCIERH_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE TABLE S_CRS_IMR_EXP_REVIEW_HIST
(
 SCIERH_ID                                         NUMBER(19,0) NOT NULL
,IMR_ID                                            NUMBER(19,0) NOT NULL
,EXPERT_REVIEW_ID			   	   NUMBER(19,0)
,EXPERT_ID					   NUMBER(19,0)
,EXPERT_REVIEW_SENT_DT				   DATE
,IMR_EXPERT_LICENSE_CODE	        	   VARCHAR2(255)
,VERSION                        		   NUMBER (10) NOT NULL
,RECORD_EFF_DT                  		   DATE DEFAULT SYSDATE NOT NULL
,RECORD_END_DT                  		   DATE DEFAULT to_date('2999/12/31', 'yyyy/mm/dd') NOT NULL
,CREATE_DT                                         DATE
,CREATED_BY                                        VARCHAR2(100)
,LAST_UPDATE_DT                                    DATE
,LAST_UPDATED_BY                                   VARCHAR2(100)
);
      

CREATE OR REPLACE VIEW S_CRS_IMR_EXP_REVIEW_HIST_SV  AS
SELECT S_CRS_IMR_EXP_REVIEW_HIST.* FROM S_CRS_IMR_EXP_REVIEW_HIST;

CREATE PUBLIC SYNONYM S_CRS_IMR_EXP_REVIEW_HIST_SV FOR S_CRS_IMR_EXP_REVIEW_HIST_SV ;

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_EXP_REVIEW_HIST
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_EXP_REVIEW_HIST
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.SCIERH_ID IS NULL THEN 
          SELECT SEQ_SCIERH_ID.NEXTVAL INTO :NEW.SCIERH_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
	  :NEW.RECORD_EFF_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END; 
/
