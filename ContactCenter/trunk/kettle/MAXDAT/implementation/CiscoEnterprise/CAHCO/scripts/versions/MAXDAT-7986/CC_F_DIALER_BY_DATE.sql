CREATE TABLE CC_F_DIALER_BY_DATE
  (
    F_DIALER_ID                 NUMBER (19) NOT NULL , -- Oracle generated sequence
    DATETIME                    DATE NOT NULL ,
    D_DATE_ID                   NUMBER(19) NOT NULL,
    CALL_BACK_DATETIME          DATE, -- CallbackDateTime
    FIRST_NAME                  VARCHAR2(50),
    LAST_NAME                   VARCHAR2(50),
    D_AGENT_ID                  NUMBER(19),
    AGENT_LOGIN_ID              VARCHAR2(50), -- Pull from AgentPeripheralNumber or FisrtName and LastName from dbo.Agent
    ROUTER_CALL_KEY_DAY         INT,
    ROUTER_CALL_KEY             INT,
    PERIPHERAL_CALL_KEY         INT,
    PERIPHERAL_ID               INT,
    SKILL_GROUP_ID              INT,
    CALLGUID                    VARCHAR2(50),
    CAMPAIGN_ID                 INT, -- have a lookup table created 
    CAMPAIGN_NAME               VARCHAR(50),
    PHONE                       VARCHAR2(20), 
    CUSTOMER_ACCOUNT_NUMBER     VARCHAR2(20), --AccountNumber
    CALL_RESULT                 INT, --- have a look up table created for call result description
    DIALING_MODE                INT, -- have a lookup table created for Dialing mode description
    CALL_DURATION               INT,
    CALL_HANDLE_METHOD          VARCHAR2(20), -- Predictive Dialer
    CALL_DIAL_METHOD            VARCHAR2(20),
    DIALING_LIST_ID             INT,    
    EXTRACT_DATE                DATE DEFAULT SYSDATE NOT NULL,
    LAST_UPDATE_DATE            DATE DEFAULT SYSDATE NOT NULL ,
    LAST_UPDATED_BY             VARCHAR2(30) NOT NULL
  ) ;
  
   CREATE INDEX CC_F_DIALER_BY_DATE_IDX1 ON CC_F_DIALER_BY_DATE
  (
    D_DATE_ID 
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX2 ON CC_F_DIALER_BY_DATE
  (
    D_AGENT_ID 
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX3 ON CC_F_DIALER_BY_DATE
  (
    AGENT_LOGIN_ID 
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX4 ON CC_F_DIALER_BY_DATE
  (
    ROUTER_CALL_KEY_DAY
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX5 ON CC_F_DIALER_BY_DATE
  (
    ROUTER_CALL_KEY
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX6 ON CC_F_DIALER_BY_DATE
  (
    PERIPHERAL_CALL_KEY
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX7 ON CC_F_DIALER_BY_DATE
  (
    PERIPHERAL_ID
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX8 ON CC_F_DIALER_BY_DATE
  (
    SKILL_GROUP_ID
  )
  ;
  
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX9 ON CC_F_DIALER_BY_DATE
  (
    CAMPAIGN_ID
  )
  ;
   
  CREATE INDEX CC_F_DIALER_BY_DATE_IDX10 ON CC_F_DIALER_BY_DATE
  (
    DIALING_LIST_ID
  )
  ; 
  
  ALTER TABLE CC_F_DIALER_BY_DATE ADD CONSTRAINT CC_F_DIALER_BY_DATE_PK PRIMARY KEY
  (
   F_DIALER_ID
  );
 
 
 ALTER TABLE CC_F_DIALER_BY_DATE ADD CONSTRAINT CC_F_DIALER_BY_DATE_UN UNIQUE
 (
    DATETIME                    
    ,D_DATE_ID                   
    ,AGENT_LOGIN_ID              
    ,ROUTER_CALL_KEY_DAY         
    ,ROUTER_CALL_KEY             
    ,PERIPHERAL_CALL_KEY         
    ,PERIPHERAL_ID               
    ,SKILL_GROUP_ID              
    ,CALLGUID                    
    ,CAMPAIGN_ID                 
    ,PHONE                        
    ,CUSTOMER_ACCOUNT_NUMBER     
    ,CALL_RESULT                 
    ,DIALING_MODE                
    ,DIALING_LIST_ID   
 )
 ;
 
CREATE OR REPLACE TRIGGER BIU_CC_F_DIALER_BY_DATE 
      BEFORE INSERT OR UPDATE ON CC_F_DIALER_BY_DATE
      FOR EACH ROW
BEGIN
  IF INSERTING THEN 
            :NEW.EXTRACT_DATE := SYSDATE;
  END IF;
  :NEW.LAST_UPDATE_DATE := SYSDATE;
  :NEW.LAST_UPDATED_BY := USER;
  END; 
  /
 
grant select, insert, update on CC_F_DIALER_BY_DATE to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on CC_F_DIALER_BY_DATE to MAXDAT_OLTP_SIUD;
grant select on CC_F_DIALER_BY_DATE to MAXDAT_READ_ONLY; 

CREATE OR REPLACE VIEW CC_F_DIALER_BY_DATE_SV
AS SELECT * FROM CC_F_DIALER_BY_DATE;

GRANT SELECT ON CC_F_DIALER_BY_DATE_SV TO MAXDAT_READ_ONLY; 

