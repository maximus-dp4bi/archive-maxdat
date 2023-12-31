drop table CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY;
drop table CC_C_CALL_CARRIER_LKUP;
drop sequence SEQ_CC_CALL_PT_ID;
drop sequence SEQ_CC_CALL_CARRIER_ID;

CREATE TABLE CC_C_CALL_CARRIER_LKUP  
  (
  CC_CALL_CARRIER_ID NUMBER(38),
  CARRIER_NUMBER  VARCHAR2(20) NOT NULL,
  CARRIER_DISPLAY_NAME VARCHAR2(200) NOT NULL,
  PROJECT_NAME VARCHAR2(50),
  PROGRAM_NAME VARCHAR2(50),
  EFFECTIVE_START_DATE       DATE,
  EFFECTIVE_END_DATE	 DATE,
  CREATE_DATE      DATE DEFAULT SYSDATE NOT NULL ,
  LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL ,
  LAST_UPDATED_BY  VARCHAR2(30)
  ) ;

  
ALTER TABLE  CC_C_CALL_CARRIER_LKUP ADD CONSTRAINT CC_C_CALL_CARRIER_LKUP_PK PRIMARY KEY
(
  CC_CALL_CARRIER_ID
)
;

ALTER TABLE  CC_C_CALL_CARRIER_LKUP ADD CONSTRAINT CC_C_CALL_CARRIER_LKUP_UK UNIQUE 
(
  CARRIER_NUMBER
  , PROJECT_NAME
  , PROGRAM_NAME
);

CREATE SEQUENCE SEQ_CC_CALL_CARRIER_ID MINVALUE 1 MAXVALUE 99999999999999
START WITH 1
INCREMENT BY 1
CACHE 30;

CREATE OR REPLACE TRIGGER BIU_CC_C_CALL_CARRIER_LKUP
      BEFORE INSERT OR UPDATE ON CC_C_CALL_CARRIER_LKUP
      FOR EACH ROW 
  BEGIN 
  IF INSERTING THEN 
	DECLARE
	 V_ID NUMBER(10);
	 BEGIN
	   SELECT SEQ_CC_CALL_CARRIER_ID.NEXTVAL 
	   INTO V_ID
	   FROM DUAL;
		:NEW.CC_CALL_CARRIER_ID := V_ID;
	END;  
     
            :NEW.CREATE_DATE := SYSDATE;
  END IF;
  :NEW.LAST_UPDATE_DATE := SYSDATE;
  :NEW.LAST_UPDATED_BY := USER;
  END; 
/

CREATE OR REPLACE VIEW CC_C_CALL_CARRIER_LKUP_SV AS
SELECT * FROM CC_C_CALL_CARRIER_LKUP;

CREATE SEQUENCE SEQ_CC_CALL_PT_ID MINVALUE 1 MAXVALUE 99999999999999
START WITH 1
INCREMENT BY 1
CACHE 30;
  
  CREATE TABLE CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY 
  (
  CC_CALL_PT_ID 		NUMBER(30)
  , CC_CALL_CARRIER_ID		NUMBER(38)
  , CARRIER_NUMBER  		VARCHAR2(20)
  , D_DATE_ID  			NUMBER(10)
  , CALL_DURATION_SECONDS_DAY 	NUMBER(15)
  , RING_TIME_SECONDS_DAY 	NUMBER(10,2)
  , DELAY_TIME_SECONDS_DAY      NUMBER(10,2)
  , TIME_TO_ABAND_SECONDS_DAY   NUMBER(10,2)
  , HOLD_TIME_SECONDS_DAY       NUMBER(10,2)
  , TALK_TIME_SECONDS_DAY       NUMBER(10,2) 
  , WORK_TIME_SECONDS_DAY       NUMBER(10,2)
  , IVR_TIME_SECONDS_DAY        NUMBER(10,2)
  , TRANSFER_COUNT_DAY          NUMBER(10,2)
  , CALL_TYPE_ID    VARCHAR2(20)  
  , CREATE_DATE			DATE
  , LAST_UPDATE_DATE		DATE
  , LAST_UPDATED_BY  VARCHAR2(30)
  );
  
  
ALTER TABLE  CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY ADD CONSTRAINT CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY_pk PRIMARY KEY
(
  CC_CALL_PT_ID
);

ALTER TABLE  CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY ADD CONSTRAINT CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY_UK UNIQUE 
(
  CC_CALL_CARRIER_ID
  , D_DATE_ID
  , CALL_TYPE_ID
);

CREATE OR REPLACE TRIGGER BIU_CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY
      BEFORE INSERT OR UPDATE ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY
      FOR EACH ROW 
  BEGIN 
    
  IF INSERTING THEN 
     DECLARE
     V_ID NUMBER(10);
     BEGIN
       SELECT SEQ_CC_CALL_PT_ID.NEXTVAL 
       INTO V_ID
       FROM DUAL;
            :NEW.CC_CALL_PT_ID := V_ID;
     END;  
            :NEW.CREATE_DATE := SYSDATE;
  END IF;
  :NEW.LAST_UPDATE_DATE := SYSDATE;
  :NEW.LAST_UPDATED_BY := USER;
  END;
/
   
CREATE OR REPLACE VIEW CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY_SV AS
SELECT 
  CCPT.D_DATE_ID
  , CPROJ.PROJECT_ID D_PROJECT_ID
  , CPROG.PROGRAM_ID D_PROGRAM_ID
  , D.D_DATE RECORD_DATE
  , CCCL.PROJECT_NAME
  , CCCL.PROGRAM_NAME
  , CCCL.CARRIER_NUMBER
  , CCCL.CARRIER_DISPLAY_NAME
  , CCPT.CC_CALL_PT_ID 	
  , CCPT.CC_CALL_CARRIER_ID
  , CCPT.CALL_DURATION_SECONDS_DAY 	
  , CCPT.RING_TIME_SECONDS_DAY 	
  , CCPT.DELAY_TIME_SECONDS_DAY      
  , CCPT.TIME_TO_ABAND_SECONDS_DAY   
  , CCPT.HOLD_TIME_SECONDS_DAY       
  , CCPT.TALK_TIME_SECONDS_DAY        
  , CCPT.WORK_TIME_SECONDS_DAY       
  , IVR_TIME_SECONDS_DAY        
  , TRANSFER_COUNT_DAY          
  , CALL_TYPE_ID      
  , CCPT.CREATE_DATE			
  , CCPT.LAST_UPDATE_DATE		
  , CCPT.LAST_UPDATED_BY  
FROM CC_D_DATES D
JOIN CC_C_CALL_CARRIER_LKUP CCCL ON CCCL.EFFECTIVE_START_DATE <= D.D_DATE AND CCCL.EFFECTIVE_END_DATE >= D.D_DATE
JOIN CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY CCPT ON D.D_DATE_ID = CCPT.D_DATE_ID AND CCCL.CARRIER_NUMBER = CCPT.CARRIER_NUMBER
JOIN CISCO_ENTERPRISE_CC.CC_D_PROJECT CPROJ ON CCCL.PROJECT_NAME = CPROJ.PROJECT_NAME
JOIN CISCO_ENTERPRISE_CC.CC_D_PROGRAM CPROG ON CCCL.PROGRAM_NAME = CPROG.PROGRAM_NAME
WHERE D.D_DATE >= TRUNC(TO_DATE('3/1/2020','MM/DD/YYYY'))
AND D.D_DATE < TRUNC(SYSDATE)
;

CREATE OR REPLACE VIEW CC_CALL_F_PROVIDER_TRANSFERS_BY_MONTH_SV AS
SELECT 
  TRUNC(D.D_DATE,'MM') RECORD_MONTH
  , CPROJ.PROJECT_ID D_PROJECT_ID
  , CPROG.PROGRAM_ID D_PROGRAM_ID
  , CCCL.PROJECT_NAME
  , CCCL.CARRIER_NUMBER
  , CCPT.CC_CALL_CARRIER_ID  
  , CCCL.CARRIER_DISPLAY_NAME
  , SUM(CCPT.CALL_DURATION_SECONDS_DAY)  CALL_DURATION_SECONDS_MONTH	
  , SUM(CCPT.RING_TIME_SECONDS_DAY) RING_TIME_SECONDS_MONTH 	
  , SUM(CCPT.DELAY_TIME_SECONDS_DAY) DELAY_TIME_SECONDS_MONTH      
  , SUM(CCPT.TIME_TO_ABAND_SECONDS_DAY) TIME_TO_ABAND_SECONDS_MONTH   
  , SUM(CCPT.HOLD_TIME_SECONDS_DAY) HOLD_TIME_SECONDS_MONTH       
  , SUM(CCPT.TALK_TIME_SECONDS_DAY) TALK_TIME_SECONDS_MONTH        
  , SUM(CCPT.WORK_TIME_SECONDS_DAY) WORK_TIME_SECONDS_MONTH       
  , SUM(IVR_TIME_SECONDS_DAY) IVR_TIME_SECONDS_MONTH        
  , SUM(TRANSFER_COUNT_DAY) TRANSFER_COUNT_MONTH          
FROM CC_D_DATES D
JOIN CC_C_CALL_CARRIER_LKUP CCCL ON CCCL.EFFECTIVE_START_DATE <= D.D_DATE AND CCCL.EFFECTIVE_END_DATE >= D.D_DATE
JOIN CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY CCPT ON D.D_DATE_ID = CCPT.D_DATE_ID AND CCCL.CARRIER_NUMBER = CCPT.CARRIER_NUMBER
JOIN CISCO_ENTERPRISE_CC.CC_D_PROJECT CPROJ ON CCCL.PROJECT_NAME = CPROJ.PROJECT_NAME
JOIN CISCO_ENTERPRISE_CC.CC_D_PROGRAM CPROG ON CCCL.PROGRAM_NAME = CPROG.PROGRAM_NAME
WHERE D.D_DATE >= TRUNC(TO_DATE('3/1/2020','MM/DD/YYYY'))
AND D.D_DATE < TRUNC(SYSDATE)
GROUP BY TRUNC(D.D_DATE,'MM') 
  , CCCL.PROJECT_NAME
  , CPROJ.PROJECT_ID
  , CPROG.PROGRAM_ID  
  , CCCL.CARRIER_NUMBER
  , CCPT.CC_CALL_CARRIER_ID  
  , CCCL.CARRIER_DISPLAY_NAME
;

GRANT SELECT ON CC_C_CALL_CARRIER_LKUP TO CISCO_READ_ONLY;
GRANT SELECT ON CC_C_CALL_CARRIER_LKUP_SV TO CISCO_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY TO CISCO_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY_SV TO CISCO_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_MONTH_SV TO CISCO_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_C_CALL_CARRIER_LKUP TO SD25802, SR18956;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY TO SD25802, SR18956;
GRANT SELECT ON CC_C_CALL_CARRIER_LKUP TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_C_CALL_CARRIER_LKUP_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_DAY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_CALL_F_PROVIDER_TRANSFERS_BY_MONTH_SV TO MAXDAT_READ_ONLY;

