DROP TABLE CC_C_IVR_HOLIDAYS;
CREATE TABLE CC_C_IVR_HOLIDAYS (
IVR_HOLIDAYS_ID                NUMBER(38)
, D_PROJECT_ID                        NUMBER(38)
, D_PROGRAM_ID                        NUMBER(38)
, HOLIDAY_YEAR                        NUMBER(4)
, HOLIDAY_DATE                        DATE
, DESCRIPTION                         VARCHAR2(80)
, CREATE_DT                           DATE
, CREATED_BY                          VARCHAR2(50)
, UPDATE_DT                           DATE
, UPDATED_BY                          VARCHAR2(50)
);


ALTER TABLE CC_C_IVR_HOLIDAYS 
    ADD CONSTRAINT CC_C_IVR_HOLIDAYS_PK PRIMARY KEY ( IVR_HOLIDAYS_ID ) ;


ALTER TABLE CC_C_IVR_HOLIDAYS 
    ADD CONSTRAINT CC_C_IVR_HOLIDAYS_UN UNIQUE (D_PROJECT_ID, D_PROGRAM_ID, HOLIDAY_YEAR, HOLIDAY_DATE) ;
    
DROP SEQUENCE SEQ_IVR_HOLIDAYS_ID;
CREATE SEQUENCE SEQ_IVR_HOLIDAYS_ID;  

CREATE OR REPLACE TRIGGER BIU_CC_C_IVR_HOLIDAYS
    BEFORE INSERT OR UPDATE ON CC_C_IVR_HOLIDAYS 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.IVR_HOLIDAYS_ID IS NULL THEN 
          SELECT SEQ_IVR_HOLIDAYS_ID.NEXTVAL INTO :NEW.IVR_HOLIDAYS_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATE_DT := SYSDATE;
:NEW.UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE VIEW CC_C_IVR_HOLIDAYS_SV AS 
SELECT 
IVR_HOLIDAYS_ID             
,IHS.D_PROJECT_ID                       
,IHS.D_PROGRAM_ID                       
,HOLIDAY_YEAR                        
,HOLIDAY_DATE                         
,DESCRIPTION                           
,CREATE_DT                          
,CREATED_BY                         
,UPDATE_DT                          
,UPDATED_BY                         
, PROJ.PROJECT_NAME
, PROG.PROGRAM_NAME
 FROM CC_C_IVR_HOLIDAYS IHS
JOIN CC_D_PROJECT PROJ ON PROJ.PROJECT_ID = IHS.D_PROJECT_ID
JOIN CC_D_PROGRAM PROG ON PROG.PROGRAM_ID = IHS.D_PROGRAM_ID;

GRANT SELECT ON CC_C_IVR_HOLIDAYS TO CISCO_READ_ONLY;
GRANT SELECT ON CC_C_IVR_HOLIDAYS_SV TO CISCO_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_C_IVR_HOLIDAYS TO SD25802, SR18956;
GRANT SELECT ON CC_C_IVR_HOLIDAYS TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_C_IVR_HOLIDAYS_SV TO MAXDAT_READ_ONLY;
