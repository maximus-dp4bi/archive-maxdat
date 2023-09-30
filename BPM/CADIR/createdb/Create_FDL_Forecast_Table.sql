CREATE TABLE S_FORECASTED_FDL
(S_FRCST_ID NUMBER NOT NULL, 
 FORECAST_MONTH DATE, 
 FORECASTED_FDL NUMBER, 
 NOTES VARCHAR2(4000),
 CREATE_DATE   DATE NOT NULL, 
 CREATED_BY  VARCHAR2(100) NOT NULL,
 LAST_UPDATED_DATE   DATE NOT NULL,
 LAST_UPDATED_BY  VARCHAR2(100) NOT NULL
 );
   
ALTER TABLE S_FORECASTED_FDL ADD CONSTRAINT M_FRCST_ID_PK PRIMARY KEY
(
  S_FRCST_ID
)
;   

CREATE INDEX FORECAST_MONTH_INDX ON S_FORECASTED_FDL
(
	FORECAST_MONTH
)
TABLESPACE MAXDAT_INDX LOGGING compute statistics;

CREATE SEQUENCE SEQ_S_FRCST_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE OR REPLACE TRIGGER BIU_S_FORECASTED_FDL
    BEFORE INSERT OR UPDATE ON S_FORECASTED_FDL
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.S_FRCST_ID IS NULL THEN 
          SELECT SEQ_S_FRCST_ID.NEXTVAL INTO :NEW.S_FRCST_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DATE := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATED_DATE := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END;
/


CREATE OR REPLACE VIEW S_FORECASTED_FDL_SV AS
SELECT 
*   
FROM S_FORECASTED_FDL
WITH READ ONLY;