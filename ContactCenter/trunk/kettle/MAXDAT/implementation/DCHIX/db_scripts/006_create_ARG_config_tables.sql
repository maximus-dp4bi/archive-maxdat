CREATE TABLE CC_C_AGENT_RTG_GRP 
    ( 
     C_AGENT_ROUTING_GROUP_ID NUMBER (19)  NOT NULL , 
     AGENT_ROUTING_GROUP_NUMBER NUMBER (19)  NOT NULL , 
     AGENT_ROUTING_GROUP_NAME VARCHAR2 (100) , 
     AGENT_ROUTING_GROUP_TYPE VARCHAR2 (50) , 
     INTERVAL_MINUTES NUMBER , 
     PROJECT_NAME VARCHAR2 (50)  NOT NULL , 
     PROGRAM_NAME VARCHAR2 (50)  NOT NULL , 
     REGION_NAME VARCHAR2 (50)  NOT NULL , 
     STATE_NAME VARCHAR2 (50)  NOT NULL , 
     PROVINCE_NAME VARCHAR2 (50)  NOT NULL , 
     DISTRICT_NAME VARCHAR2 (50)  NOT NULL , 
     COUNTRY_NAME VARCHAR2 (50)  NOT NULL , 
     RECORD_EFF_DT DATE DEFAULT to_date('1900/01/01', 'yyyy/mm/dd')  NOT NULL , 
     RECORD_END_DT DATE DEFAULT to_date('2999/12/31', 'yyyy/mm/dd')  NOT NULL 
    ) 
        TABLESPACE MAXDAT_DATA 
        LOGGING 
;

ALTER TABLE CC_C_AGENT_RTG_GRP 
    ADD CONSTRAINT CC_C_AGT_RTG_GRP_PK PRIMARY KEY ( C_AGENT_ROUTING_GROUP_ID ) ;


ALTER TABLE CC_C_AGENT_RTG_GRP 
    ADD CONSTRAINT CC_C_AGT_RTG_GRP_UN UNIQUE ( AGENT_ROUTING_GROUP_NUMBER, AGENT_ROUTING_GROUP_TYPE  ) ;  


CREATE INDEX CC_C_AGT_RTG_GRP__IDXv1 ON CC_C_AGENT_RTG_GRP 
    ( 
     AGENT_ROUTING_GROUP_NUMBER ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;


CREATE SEQUENCE SEQ_CC_C_AGT_RTG_GRP 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;


CREATE OR REPLACE TRIGGER BIU_CC_C_AGT_RTG_GRP 
    BEFORE INSERT OR UPDATE ON CC_C_AGENT_RTG_GRP 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.C_AGENT_ROUTING_GROUP_ID IS NULL THEN 
  SELECT SEQ_CC_C_AGT_RTG_GRP.NEXTVAL INTO :NEW.C_AGENT_ROUTING_GROUP_ID FROM DUAL;
END IF;
IF INSERTING AND :NEW.AGENT_ROUTING_GROUP_NUMBER IS NULL THEN 
  :NEW.AGENT_ROUTING_GROUP_NUMBER := :NEW.C_AGENT_ROUTING_GROUP_ID;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_C_AGT_RTG_GRP ENABLE; 



