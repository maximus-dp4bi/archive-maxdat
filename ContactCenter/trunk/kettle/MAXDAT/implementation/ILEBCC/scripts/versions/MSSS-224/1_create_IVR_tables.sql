/*
Created on 09/20/2016 by Raj A.
Description: MSSS-224. Consolidating database scripts from CiscoEnterprise to one script. 
These DDLs are to install CSI IVR response related data only.
CC_D_IVR_SELF_SERVICE_PATH is already installed by the initial deploy; So, deploying below two tables
*/
CREATE SEQUENCE SEQ_CC_S_IVR_RESPONSE START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_CC_C_IVR_DNIS START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_CC_C_IVR_CALL_RESULT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;

CREATE TABLE CC_S_IVR_RESPONSE
(
 IVR_RESPONSE_ID          NUMBER(19,0)
,INTERVAL_ID              NUMBER(19,0) NOT NULL
,APPLICATION_NAME	      VARCHAR2(50) NOT NULL					
,CALL_TYPE		          VARCHAR2(50) NOT NULL		
,CALL_DATE		          DATE	NOT NULL
,CALL_START_TIME	      DATE	NOT NULL				
,CALL_END_TIME		      DATE	NOT NULL			
,INBOUND_ANI		      NUMBER(19,0) NOT NULL				
,DESTINATION_DNIS	      NUMBER(19,0)				
,COMPLETION_CODE	      VARCHAR2(50)							
,EXIT_POINT_DESCRIPTION	  VARCHAR2(255)						
,LANGUAGE		          VARCHAR2(50)						
,MAIN_MENU_SELECTION	  VARCHAR2(255)						
,SELF_SERVICE_DESCRIPTION VARCHAR2(250)						
,SKILLSET		          VARCHAR2(50)						
,DESTINATION_TRANSFER	  NUMBER(19,0)						
,LOCATION	              VARCHAR2(50)
,PROJECT_NAME             VARCHAR2(50)
,PROGRAM_NAME             VARCHAR2(50)
,GEOGRAPHY_NAME           VARCHAR2(250)
,ROW_INSERTED_DT          DATE
,ROW_INSERTED_BY          VARCHAR2(30)
,ROW_UPDATED_DT           DATE
,ROW_UPDATED_BY           VARCHAR2(30)
);
ALTER TABLE CC_S_IVR_RESPONSE 
    ADD CONSTRAINT CC_S_IVR_RESPONSE_PK PRIMARY KEY ( IVR_RESPONSE_ID ) ;
ALTER TABLE CC_S_IVR_RESPONSE 
    ADD CONSTRAINT CC_S_IVR_RESPONSE_UN UNIQUE ( APPLICATION_NAME , CALL_TYPE, CALL_DATE, CALL_START_TIME, CALL_END_TIME, INBOUND_ANI  ) ;


ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH MODIFY begin_node VARCHAR2(255) NULL;
ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH MODIFY end_node VARCHAR2(255) NULL; 	
	
create table CC_C_IVR_DNIS
(
  C_DNIS_UOW_ID    NUMBER(19),
  DESTINATION_DNIS NUMBER(19),
  UOW_ID           NUMBER(19),
  CREATE_DATE      DATE default SYSDATE not null,
  RECORD_EFF_DATE  DATE default TO_DATE('1900/01/01', 'YYYY/MM/DD'),
  RECORD_END_DATE  DATE default TO_DATE('2999/12/31', 'YYYY/MM/DD')
);
alter table CC_C_IVR_DNIS
  add constraint CC_C_IVR_DNIS_UOW_ID_FK foreign key (UOW_ID)
  references CC_D_UNIT_OF_WORK (UOW_ID);  
  

create table CC_C_IVR_CALL_RESULT
(
  C_IVR_CALL_RES_ID    NUMBER(19) not null,
  COMPLETION_CODE      VARCHAR2(50) not null,
  COUNT_CREATED        VARCHAR2(1) not null,
  COUNT_OFFERED_TO_ACD VARCHAR2(1) not null,
  COUNT_CONTAINED      VARCHAR2(1) not null,
  CREATE_DATE          DATE default SYSDATE not null,
  RECORD_EFF_DATE      DATE default TO_DATE('1900/01/01', 'YYYY/MM/DD'),
  RECORD_END_DATE      DATE default TO_DATE('2999/12/31', 'YYYY/MM/DD')
);
alter table CC_C_IVR_CALL_RESULT
  add constraint C_IVR_CALL_RES_ID_PK primary key (C_IVR_CALL_RES_ID);  
  
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
/
ALTER TRIGGER BIU_CC_S_IVR_RESPONSE ENABLE;


CREATE OR REPLACE TRIGGER BI_CC_C_IVR_DNIS
    BEFORE INSERT ON CC_C_IVR_DNIS
    FOR EACH ROW

BEGIN
IF INSERTING AND :NEW.C_DNIS_UOW_ID IS NULL THEN
          SELECT SEQ_CC_C_IVR_DNIS.NEXTVAL INTO :NEW.C_DNIS_UOW_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER BI_CC_C_IVR_DNIS ENABLE;

CREATE OR REPLACE TRIGGER BI_CC_C_IVR_CALL_RESULT
    BEFORE INSERT ON CC_C_IVR_CALL_RESULT
    FOR EACH ROW

BEGIN
IF INSERTING AND :NEW.C_IVR_CALL_RES_ID IS NULL THEN
          SELECT SEQ_CC_C_IVR_CALL_RESULT.NEXTVAL INTO :NEW.C_IVR_CALL_RES_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER BI_CC_C_IVR_CALL_RESULT ENABLE;