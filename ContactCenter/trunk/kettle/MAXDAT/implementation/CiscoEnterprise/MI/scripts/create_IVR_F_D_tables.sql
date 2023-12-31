/*
Created on 02/01/2016 by Raj A.
Description: Created for MAXDAT-3041
Creating tables CC_C_IVR_DNIS and CC_C_IVR_CALL_RESULT.
Altering the existing table, CC_C_UNIT_OF_WORK and CC_D_UNIT_OF_WORK
*/
ALTER TABLE CC_C_UNIT_OF_WORK ADD ACD NUMBER(19) DEFAULT 1;
ALTER TABLE CC_C_UNIT_OF_WORK ADD IVR NUMBER(19) DEFAULT 0;

ALTER TABLE CC_D_UNIT_OF_WORK ADD ACD NUMBER(19) DEFAULT 1;
ALTER TABLE CC_D_UNIT_OF_WORK ADD IVR NUMBER(19) DEFAULT 0;



CREATE TABLE CC_C_IVR_DNIS
(
C_DNIS_UOW_ID    NUMBER(19),
DESTINATION_DNIS NUMBER(19),
UOW_ID           NUMBER(19),
CREATE_DATE	     DATE DEFAULT SYSDATE NOT NULL,
RECORD_EFF_DATE  DATE DEFAULT TO_DATE('1900/01/01', 'YYYY/MM/DD'),
RECORD_END_DATE  DATE DEFAULT TO_DATE('2999/12/31', 'YYYY/MM/DD')
)
TABLESPACE MAXDAT_DATA LOGGING ENABLE ROW MOVEMENT;

alter table CC_C_IVR_DNIS
  add constraint CC_C_IVR_DNIS_UOW_ID_FK foreign key (UOW_ID)
  references CC_D_UNIT_OF_WORK (UOW_ID);
  


CREATE TABLE CC_C_IVR_CALL_RESULT
  (
    C_IVR_CALL_RES_ID     NUMBER (19) NOT NULL,
	COMPLETION_CODE       VARCHAR2 (50) NOT NULL,
    COUNT_CREATED         VARCHAR2 (1) NOT NULL,
    COUNT_OFFERED_TO_ACD  VARCHAR2 (1) NOT NULL,
	COUNT_CONTAINED       VARCHAR2 (1) NOT NULL,
	CREATE_DATE	          DATE DEFAULT SYSDATE NOT NULL,
	RECORD_EFF_DATE       DATE DEFAULT TO_DATE('1900/01/01', 'YYYY/MM/DD'), 
	RECORD_END_DATE       DATE DEFAULT TO_DATE('2999/12/31', 'YYYY/MM/DD')
  )
  TABLESPACE MAXDAT_DATA LOGGING ENABLE ROW MOVEMENT ;
  
ALTER TABLE CC_C_IVR_CALL_RESULT ADD CONSTRAINT C_IVR_CALL_RES_ID_PK PRIMARY KEY (C_IVR_CALL_RES_ID);


CREATE TABLE CC_S_IVR_RESPONSE
(
 IVR_RESPONSE_ID        NUMBER(19,0)
,INTERVAL_ID            NUMBER(19,0) NOT NULL
,APPLICATION_NAME	VARCHAR2(50) NOT NULL					
,CALL_TYPE		VARCHAR2(50) NOT NULL		
,CALL_DATE		DATE	NOT NULL
,CALL_START_TIME	DATE	NOT NULL				
,CALL_END_TIME		DATE	NOT NULL			
,INBOUND_ANI		NUMBER(19,0) NOT NULL				
,DESTINATION_DNIS	NUMBER(19,0)				
,COMPLETION_CODE	VARCHAR2(50)							
,EXIT_POINT_DESCRIPTION	VARCHAR2(50)						
,LANGUAGE		VARCHAR2(50)						
,MAIN_MENU_SELECTION	VARCHAR2(50)						
,SELF_SERVICE_DESCRIPTION VARCHAR2(250)						
,SKILLSET		VARCHAR2(50)						
,DESTINATION_TRANSFER	NUMBER(19,0)						
,LOCATION	        VARCHAR2(50)
,ROW_INSERTED_DT        DATE
,ROW_INSERTED_BY        VARCHAR2(30)
,ROW_UPDATED_DT         DATE
,ROW_UPDATED_BY         VARCHAR2(30)
);

ALTER TABLE CC_S_IVR_RESPONSE 
    ADD CONSTRAINT CC_S_IVR_RESPONSE_PK PRIMARY KEY ( IVR_RESPONSE_ID ) ;


ALTER TABLE CC_S_IVR_RESPONSE 
    ADD CONSTRAINT CC_S_IVR_RESPONSE_UN UNIQUE ( APPLICATION_NAME , CALL_TYPE, CALL_DATE, CALL_START_TIME, CALL_END_TIME, INBOUND_ANI, DESTINATION_DNIS  ) ;