/*********************************************

    TRUNCATE TABLES

**********************************************/
delete from d_teams;
/*********************************************

    MODIFY TABLE GROUPS_STG

**********************************************/
ALTER TABLE GROUPS_STG DROP COLUMN GROUP_KEY;

ALTER TABLE GROUPS_STG ADD
(
    SOURCE_REFERENCE_TYPE                       VARCHAR2(200),
    SOURCE_REFERENCE_ID                         VARCHAR2(200)
);

DELETE
  FROM  GROUPS_STG;

INSERT 
  INTO  GROUPS_STG (   GROUP_ID,    GROUP_NAME,                     DESCRIPTION,                    PARENT_GROUP_ID,    DEPLOYMENT_NAME,        START_DATE,                                                     END_DATE,                                               TYPE_CD,        SUPERVISOR_STAFF_ID,        CREATED_BY,     CREATE_TS,  UPDATED_BY, UPDATE_TS   ) 
VALUES             (   1,           'Unknown Business Unit',        'Unknown Business Unit',        NULL,               NULL,                   to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),         to_date('3077-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'BIZUNIT',      NULL,                       USER,           SYSDATE,    USER,       SYSDATE     );

INSERT 
  INTO  GROUPS_STG (   GROUP_ID,    GROUP_NAME,                     DESCRIPTION,                    PARENT_GROUP_ID,    DEPLOYMENT_NAME,        START_DATE,                                                     END_DATE,                                               TYPE_CD,        SUPERVISOR_STAFF_ID,        CREATED_BY,     CREATE_TS,  UPDATED_BY, UPDATE_TS   ) 
VALUES             (   0,           'Unknown Team',                 'Unknown Team',                 1,                  NULL,                   to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),         to_date('3077-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'TEAM',         0,                          USER,           SYSDATE,    USER,       SYSDATE     );
/*********************************************

    MODIFY TABLE D_STAFF

**********************************************/
DROP INDEX D_STAFF_UK1;

CREATE UNIQUE INDEX D_STAFF_UK1 ON D_STAFF (EXT_STAFF_NUMBER)
TABLESPACE MAXDAT_INDX;

DROP SEQUENCE SEQ_STAFF_ID;
CREATE SEQUENCE SEQ_STAFF_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;

CREATE OR REPLACE TRIGGER TRG_BIUR_D_STAFF
BEFORE INSERT OR UPDATE ON D_STAFF
FOR EACH ROW
BEGIN

    IF  INSERTING
    THEN
    
        IF :NEW.STAFF_ID IS NULL
        THEN
            :NEW.STAFF_ID := SEQ_STAFF_ID.NEXTVAL; 
            :NEW.UNIQUE_STAFF_ID    :=  :NEW.STAFF_ID;
        END IF;
        
        :NEW.DEFAULT_GROUP_ID   :=  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id;
        
        IF  :NEW.CREATED_BY IS NULL
        THEN
            :NEW.CREATED_BY  :=  USER;
            :NEW.CREATE_TS  :=  SYSDATE;
        END IF;

    END IF;

    IF  :NEW.UPDATED_BY IS NULL
    THEN
        :NEW.UPDATED_BY  :=  USER;
        :NEW.UPDATE_TS      :=  SYSDATE;
    END IF;
        
END;
/
DELETE
  FROM  D_STAFF;
 
INSERT
  INTO  D_STAFF     (   STAFF_ID,   EXT_STAFF_NUMBER,       FIRST_NAME, LAST_NAME,      DEFAULT_GROUP_ID    )
VALUES              (   0,          'UNKNOWN_STAFF',        'Unknown',  'Staff',        0                   );
/*********************************************

    CREATE TABLE STEP_DEFINITION          

**********************************************/

CREATE TABLE STEP_DEFINITION 
(
    STEP_DEFINITION_ID              NUMBER                                  NOT NULL,
    NAME                            VARCHAR2(50),
    DESCRIPTION                     VARCHAR2(4000),
    TIME_TO_COMPLETE                NUMBER,
    TIME_UNIT_CD                    VARCHAR2(32), 
    FORWARDING_RULE_CD              VARCHAR2(32),
    ESCALATION_RULE_CD              VARCHAR2(32), 
    PRIORITY_CD                     VARCHAR2(32), 
    PERFORM_TIMEOUT_IND             NUMBER,
    STEP_TYPE_CD                    VARCHAR2(32), 
    CREATED_BY                      VARCHAR2(80), 
    CREATE_TS                       DATE, 
    UPDATED_BY                      VARCHAR2(80),
    UPDATE_TS                       DATE, 
    MANUAL_TASK_IND                 NUMBER,
    SPRING_BEAN                     VARCHAR2(256), 
    CORRELATION_PARTS               VARCHAR2(4000),
    DISPLAY_NAME                    VARCHAR2(75), 
    CONSTRAINT STEP_DEFINITION_PK PRIMARY KEY 
    (
        STEP_DEFINITION_ID 
    )
    ENABLE 
) 
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE INDEX STEP_DEFINITION_IND02 ON STEP_DEFINITION  (PERFORM_TIMEOUT_IND ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX;

CREATE INDEX STEP_DEFINITION_IND01 ON STEP_DEFINITION  (STEP_TYPE_CD ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX;

CREATE OR REPLACE TRIGGER TRG_BIUR_STEP_DEFINITION 
BEFORE INSERT OR UPDATE ON STEP_DEFINITION 
FOR EACH ROW
BEGIN

    IF  INSERTING
    THEN
        :NEW.CREATE_TS := SYSDATE;
        :NEW.CREATED_BY := USER;
    END IF;
    
    :NEW.UPDATED_BY := USER;
    :NEW.UPDATE_TS := SYSDATE;
END;
/

GRANT SELECT ON STEP_DEFINITION TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON STEP_DEFINITION TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON STEP_DEFINITION TO MAXDAT_OLTP_SIUD;

begin
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   1,                      'VIRTUAL_HUMAN_TASK',   'Sort, Batch',                                                  'Sort, Batch',                                                  'Sort, Batch'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   2,                      'VIRTUAL_HUMAN_TASK',   'OCR Process [OCR],  Scan Mail',                                'OCR Process [OCR],  Scan Mail',                                'OCR Process [OCR],  Scan Mail'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   3,                      'VIRTUAL_HUMAN_TASK',   'Create Enrollment/Disenrollment Transaction',                  'Create Enrollment/Disenrollment Transaction',      'Create Enrollment/Disenrollment Transaction'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   4,                      'VIRTUAL_HUMAN_TASK',   'Create Daily Transaction File for upload to MEDS',             'Create Daily Transaction File for upload to MEDS',             'Create Daily Transaction File for upload to MEDS'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   5,                      'VIRTUAL_HUMAN_TASK',   'Process Daily Transaction file from MEDS',                     'Process Daily Transaction file from MEDS',                     'Process Daily Transaction file from MEDS'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   6,                      'VIRTUAL_HUMAN_TASK',   'E2E Model- Packet Letter to KP',                               'E2E Model- Packet Letter to KP',                               'E2E Model- Packet Letter to KP'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   7,                      'VIRTUAL_HUMAN_TASK',   'Classify Documents [CRM] (manual process)',                    'Classify Documents [CRM] (manual process)',                    'Classify Documents [CRM] (manual process)'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   8,                      'VIRTUAL_HUMAN_TASK',   'EDER Process (manual)',                                        'EDER Process (manual)',                                        'EDER Process (manual)'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   9,                      'VIRTUAL_HUMAN_TASK',   'Exemption Process (manual)',                                   'Exemption Process (manual)',                                   'Exemption Process (manual)'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   10,                      'VIRTUAL_HUMAN_TASK',  'Return mail hand scan and upload into HPE',                    'Return mail hand scan and upload into HPE',                    'Return mail hand scan and upload into HPE'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   11,                      'VIRTUAL_HUMAN_TASK',  'Generate outbound campaign ',                                  'Generate outbound campaign',                                   'Generate outbound campaign'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   12,                      'VIRTUAL_HUMAN_TASK',  'Release to work queue',                                        'Release to work queue',                                        'Release to work queue'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   13,                     'VIRTUAL_HUMAN_TASK',   'Documents go to queue type',                                   'Documents go to queue type',                                   'Documents go to queue type'   );   
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   14,                     'VIRTUAL_HUMAN_TASK',   'Process Choice Form (manual)',                                 'Process Choice Form (manual)',                                 'Process Choice Form (manual)'   );
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   15,                     'VIRTUAL_HUMAN_TASK',   'Correct rejected transactions',                                'Correct rejected transactions',                                'Correct rejected transactions'   );
    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   16,                     'VIRTUAL_HUMAN_TASK',   'Pend Enrollment 120 days (HPE)',                               'Pend Enrollment 120 days (HPE)',                               'Pend Enrollment 120 days (HPE)'   );

    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   20,                     'VIRTUAL_HUMAN_TASK',   'Run Daily Letter/Packet Batch jobs',                           'Run Daily Letter/Packet Batch jobs',                           'Run Daily Letter/Packet Batch jobs');

    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   21,                     'VIRTUAL_HUMAN_TASK',   'Generate Letter/Packet PDF''s',                                'Generate Letter/Packet PDF''s',                                'Generate Letter/Packet PDF''s'     );

    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   22,                     'VIRTUAL_HUMAN_TASK',   'Load Manifest files to HCODB',                                 'Load Manifest files to HCODB',                                 'Load Manifest files to HCODB'      );

    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   23,                     'VIRTUAL_HUMAN_TASK',   'Load Response file from KP to DW',                             'Load Response file from KP to DW',                             'Load Response file from KP to DW'   );


end;
/

/*********************************************

    CREATE TABLE STEP_INSTANCE          

**********************************************/
CREATE TABLE STEP_INSTANCE 
(
    STEP_INSTANCE_ID                NUMBER                                  NOT NULL, 
    STATUS                          VARCHAR2(32), 
    CREATE_TS                       DATE, 
    CLAIMED_TS                      DATE,
    COMPLETED_TS                    DATE,
    ESCALATED_IND                   NUMBER,
    STEP_DUE_TS                     DATE, 
    FORWARDED_IND                   NUMBER, 
    ESCALATE_TO                     VARCHAR2(80),
    FORWARDED_BY                    VARCHAR2(80), 
    OWNER                           VARCHAR2(80), 
    LOCKED_ID                       NUMBER,
    GROUP_STEP_DEFINITION_ID        NUMBER,
    GROUP_ID                        NUMBER,
    TEAM_ID                         NUMBER,
    PROCESS_ID                      NUMBER,
    PRIORITY_CD                     VARCHAR2(32),
    PROCESS_ROUTER_ID               NUMBER,
    PROCESS_INSTANCE_ID             NUMBER,
    CASE_ID                         NUMBER,
    CLIENT_ID                       NUMBER,
    REF_ID                          NUMBER,
    REF_TYPE                        VARCHAR2(64),
    STEP_DEFINITION_ID              NUMBER                                  NOT NULL,
    CREATED_BY                      VARCHAR2(80),
    SUSPENDED_TS                    DATE, 
    COMMENTS                        VARCHAR2(4000),
    CREATE_NDT                      NUMBER, 
    STEP_DUE_NDT                    NUMBER, 
    STATUS_TS                       DATE,
    CONSTRAINT STEP_INSTANCE_PK PRIMARY KEY 
    (
        STEP_INSTANCE_ID 
    )
    ENABLE 
) 
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX STEP_INSTANCE_UK1 ON STEP_INSTANCE (REF_TYPE, REF_ID, STEP_DEFINITION_ID, PROCESS_ID, CREATE_TS)
TABLESPACE MAXDAT_INDX;

DROP SEQUENCE SEQ_STEP_INSTANCE_ID;
CREATE SEQUENCE SEQ_STEP_INSTANCE_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;

CREATE OR REPLACE TRIGGER TRG_BIUR_STEP_INSTANCE
BEFORE INSERT OR UPDATE ON STEP_INSTANCE
FOR EACH ROW
BEGIN

    IF  INSERTING
    THEN
    
        IF :NEW.STEP_INSTANCE_ID IS NULL
        THEN
            :NEW.STEP_INSTANCE_ID := SEQ_STEP_INSTANCE_ID.NEXTVAL; 
        END IF;
        
    END IF;
        
END;
/

GRANT SELECT ON STEP_INSTANCE TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON STEP_INSTANCE TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON STEP_INSTANCE TO MAXDAT_OLTP_SIUD;

/*********************************************

    CREATE TABLE STEP_INSTANCE_HISTORY

**********************************************/
CREATE TABLE STEP_INSTANCE_HISTORY
(
    STEP_INSTANCE_HISTORY_ID        NUMBER                                  NOT NULL ,
    STEP_INSTANCE_ID                NUMBER,
    STATUS                          VARCHAR2(32),
    OWNER                           VARCHAR2(80), 
    ESCALATED_IND                   NUMBER,
    ESCALATE_TO                     VARCHAR2(80),
    FORWARDED_IND                   NUMBER,
    FORWARDED_BY                    VARCHAR2(80),
    GROUP_ID                        NUMBER, 
    TEAM_ID                         NUMBER,
    CREATE_TS                       DATE,
    CREATED_BY                      VARCHAR2(80),
    CONSTRAINT STEP_INSTANCE_HISTORY_PK PRIMARY KEY 
    (
        STEP_INSTANCE_HISTORY_ID 
    )
    ENABLE 
    ) 
LOGGING 
TABLESPACE MAXDAT_DATA;

DROP SEQUENCE SEQ_STEP_INSTANCE_HISTORY_ID;

CREATE SEQUENCE SEQ_STEP_INSTANCE_HISTORY_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;

CREATE INDEX STEP_INSTANCE_HISTORY_I001 ON STEP_INSTANCE_HISTORY (STEP_INSTANCE_ID, STATUS, CREATE_TS)
TABLESPACE MAXDAT_INDX;

CREATE INDEX STEP_INSTANCE_HISTORY_I002 ON STEP_INSTANCE_HISTORY (STEP_INSTANCE_ID ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON STEP_INSTANCE_HISTORY TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON STEP_INSTANCE_HISTORY TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON STEP_INSTANCE_HISTORY TO MAXDAT_OLTP_SIUD;

CREATE OR REPLACE TRIGGER TRG_BIUR_STEP_INSTANCE
BEFORE INSERT OR UPDATE ON STEP_INSTANCE
FOR EACH ROW
DECLARE
    l_rec_change                                                                PLS_INTEGER;
BEGIN

    l_rec_change    :=  0;

/*
    IF          UPDATING
            AND (
                        NVL(:NEW.STATUS, '?')   != 'COMPLETED'
                    AND NVL(:OLD.STATUS, '?')   = 'COMPLETED'
                )
    THEN

        :NEW.STATUS                         :=  :OLD.STATUS;
        :NEW.STATUS_TS                      :=  :OLD.STATUS_TS;
        :NEW.CREATE_TS                      :=  :OLD.CREATE_TS;
        :NEW.CLAIMED_TS                     :=  :OLD.CLAIMED_TS;
        :NEW.COMPLETED_TS                   :=  :OLD.COMPLETED_TS;
        :NEW.ESCALATED_IND                  :=  :OLD.ESCALATED_IND;
        :NEW.STEP_DUE_TS                    :=  :OLD.STEP_DUE_TS;
        :NEW.FORWARDED_IND                  :=  :OLD.FORWARDED_IND;
        :NEW.ESCALATE_TO                    :=  :OLD.ESCALATE_TO;
        :NEW.FORWARDED_BY                   :=  :OLD.FORWARDED_BY;
        :NEW.OWNER                          :=  :OLD.OWNER;
        :NEW.LOCKED_ID                      :=  :OLD.LOCKED_ID;
        :NEW.GROUP_STEP_DEFINITION_ID       :=  :OLD.GROUP_STEP_DEFINITION_ID;
        :NEW.GROUP_ID                       :=  :OLD.GROUP_ID;
        :NEW.TEAM_ID                        :=  :OLD.TEAM_ID;
        :NEW.PROCESS_ID                     :=  :OLD.PROCESS_ID;
        :NEW.PRIORITY_CD                    :=  :OLD.PRIORITY_CD;
        :NEW.PROCESS_ROUTER_ID              :=  :OLD.PROCESS_ROUTER_ID;
        :NEW.PROCESS_INSTANCE_ID            :=  :OLD.PROCESS_INSTANCE_ID;
        :NEW.CASE_ID                        :=  :OLD.CASE_ID;
        :NEW.CLIENT_ID                      :=  :OLD.CLIENT_ID;
        :NEW.REF_ID                         :=  :OLD.REF_ID;
        :NEW.REF_TYPE                       :=  :OLD.REF_TYPE;
        :NEW.STEP_DEFINITION_ID             :=  :OLD.STEP_DEFINITION_ID;
        :NEW.CREATED_BY                     :=  :OLD.CREATED_BY;
        :NEW.SUSPENDED_TS                   :=  :OLD.SUSPENDED_TS;
        :NEW.COMMENTS                       :=  :OLD.COMMENTS;
        :NEW.CREATE_NDT                     :=  :OLD.CREATE_NDT;
        :NEW.STEP_DUE_NDT                   :=  :OLD.STEP_DUE_NDT;

        l_rec_change    :=  0;
*/
    IF       INSERTING                                                           
            OR  (
                        UPDATING                                                        
                    AND (
                                NVL(:OLD.STATUS, '?')       !=      NVL(:NEW.STATUS, '?')           
                            OR  NVL(:OLD.OWNER, '?')        !=      NVL(:NEW.OWNER, '?')            
                            OR  NVL(:OLD.ESCALATED_IND, -1) !=     NVL(:NEW.ESCALATED_IND, -1)      
                            OR  NVL(:OLD.ESCALATE_TO, '?')  !=     NVL(:NEW.ESCALATE_TO, '?')       
                            OR  NVL(:OLD.FORWARDED_IND, -1) !=      NVL(:NEW.FORWARDED_IND, -1)     
                            OR  NVL(:OLD.FORWARDED_BY, '?') !=      NVL(:NEW.FORWARDED_BY, '?')     
                            OR  NVL(:OLD.GROUP_ID, -1)      !=      NVL(:NEW.GROUP_ID, -1)          
                            OR  NVL(:OLD.TEAM_ID, -1)       !=      NVL(:NEW.TEAM_ID, -1)        
                        )
                )
    THEN
        l_rec_change    :=  1;
    END IF;

    IF  l_rec_change    =   1
    THEN

        IF       NVL(:OLD.OWNER, '?')           !=  NVL(:NEW.OWNER, '?')
            AND NVL(:OLD.OWNER, '?')            !=  '?'    
            AND NVL(:NEW.OWNER, '?')            !=  '?'
        THEN
            :NEW.FORWARDED_IND  :=  1;
            :NEW.FORWARDED_BY    :=  :OLD.OWNER;
        END IF;
    
        IF      NVL(:NEW.STATUS, '?')       =      'COMPLETED'
            AND NVL(:OLD.STATUS, '?')       !=     'COMPLETED'
        THEN    

            :NEW.COMPLETED_TS := :NEW.STATUS_TS;
            
        ELSE
        
            IF  NVL(:NEW.COMMENTS, '?') =   CAHCO_ETL_MW_UTIL_PKG.claimed_on_ownership_change
            THEN
        
                IF       NVL(:OLD.OWNER, '?')            !=  NVL(:NEW.OWNER, '?')
                    AND NVL(:NEW.OWNER, '?')            !=  '?'        
                THEN

                    :NEW.STATUS :=  'CLAIMED';
                    :NEW.CLAIMED_TS := :NEW.STATUS_TS;

                END IF;

            ELSIF       NVL(:NEW.STATUS, '?') =   'CLAIMED'
                    AND NVL(:OLD.STATUS, '?') !=  'CLAIMED'
            THEN

                :NEW.CLAIMED_TS := :NEW.STATUS_TS;
                :NEW.COMPLETED_TS   :=  NULL;

            END IF;

        END IF;

        INSERT 
          INTO  STEP_INSTANCE_HISTORY       (   STEP_INSTANCE_HISTORY_ID,               STEP_INSTANCE_ID,       STATUS,         OWNER,          ESCALATED_IND,          ESCALATE_TO,            FORWARDED_IND,          FORWARDED_BY,       GROUP_ID,       TEAM_ID,        CREATE_TS,          CREATED_BY                          )
        VALUES                              (   SEQ_STEP_INSTANCE_HISTORY_ID.NEXTVAL,   :NEW.STEP_INSTANCE_ID,  :NEW.STATUS,    :NEW.OWNER,     :NEW.ESCALATED_IND,     :NEW.ESCALATE_TO,       :NEW.FORWARDED_IND,     :NEW.FORWARDED_BY,  :NEW.GROUP_ID,  :NEW.TEAM_ID,   :NEW.STATUS_TS,     NVL(:NEW.OWNER, :NEW.CREATED_BY)    );
                
    END IF;
    
    -- If updating the current record, then rollback to the original CREATE_TS and CREATE_BY.
    
    IF  UPDATING
    THEN
        :NEW.CREATE_TS  :=  :OLD.CREATE_TS;
        :NEW.CREATED_BY  :=  :OLD.CREATED_BY;
    END IF;

    :NEW.COMMENTS   :=  NULL;
    
END;
/
/*********************************************

    CREATE TABLE HCO_CASE_DCN

**********************************************/
CREATE TABLE HCO_CASE_DCN
(
    CASE_NUMBER                     NUMBER                                  NOT NULL,
    CASE_ID                         VARCHAR2(20),
    DCN                             VARCHAR2(11),
    RECORD_DATE                     DATE,
    MODIFIED_DATE                   DATE,                            
    CONSTRAINT HCO_CASE_DCN_PK PRIMARY KEY 
    (
        CASE_NUMBER
    )
    ENABLE 
    ) 
LOGGING 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_CASE_DCN TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_CASE_DCN TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_CASE_DCN TO MAXDAT_OLTP_SIUD;

DELETE FROM corp_etl_control WHERE NAME IN ('MW_CASE_DCN_CREATE_DATE', 'MW_CASE_DCN_UPDATE_DATE', 'MW_EXEMPTION_PROC_DATE',  'MW_EXEMPTION_SH_PROC_DATE', 'MW_EDER_PROC_DATE',  'MW_EDER_SH_PROC_DATE', 'MW_ENROLLMENT_PROC_DATE', 'MW_RETURN_MAIL_PROC_DATE', 'MW_PROC_CONTROL', 'MW_MAIL_CLIENT_CREATE_DATE', 'MW_MAIL_CLIENT_UPDATE_DATE', 'MW_LETTER_MAILING_PROC_DATE', 'MW_PACKET_MAILING_PROC_DATE', 'MW_ENROLL_EXT_CREATE_DATE', 'MW_ENROLL_EXT_UPDATE_DATE', 'MW_SYSTEM_LOG_DATE', 'MW_BATCH_STATS_SCAN_START_DATE','MW_BATCH_STATS_SCAN_END_DATE', 'MW_LAST_HCO_BATCH_DCN_REC_NUM');

-- Exemption

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_EXEMPTION_PROC_DATE',       'D',            '1900/01/01 00:00:00',  'The modified date of the latest processed Exemption record');

INSERT
  INTO  CORP_ETL_CONTROL        (   NAME,                           VALUE_TYPE,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_EXEMPTION_SH_PROC_DATE',    'D',            '1900/01/01 00:00:00',  'The create date of the latest processed Exemption status history record');

-- EDER

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_EDER_PROC_DATE',            'D',            '1900/01/01 00:00:00',  'The modified date of the latest processed EDER record');

INSERT
  INTO  CORP_ETL_CONTROL        (   NAME,                           VALUE_TYPE,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_EDER_SH_PROC_DATE',         'D',            '1900/01/01 00:00:00',  'The create date of the latest processed EDER status history record');

-- Enrollment

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ENROLLMENT_PROC_DATE',      'D',            '1900/01/01 00:00:00',  'The modified date of the latest processed Enrollment record');

-- Return Mail

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_RETURN_MAIL_PROC_DATE',     'D',            '1900/01/01 00:00:00',  'The modified date of the latest processed returned mail record');

-- Case DCN Date
 
INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_CASE_DCN_CREATE_DATE',      'D',            '1900/01/01 00:00:00',  'The create date of the last case record in the source');

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_CASE_DCN_UPDATE_DATE',      'D',            '1900/01/01 00:00:00',  'The modified date of the last case record in the source');


-- Mail Client Date
 
INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_MAIL_CLIENT_CREATE_DATE',   'D',            '1900/01/01 00:00:00',  'The create date of the last mail beneficiary record in the source');

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_MAIL_CLIENT_UPDATE_DATE',   'D',            '1900/01/01 00:00:00',  'The modified date of the last mail beneficiary record in the source');

-- Letter Mailing Date

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_LETTER_MAILING_PROC_DATE',  'D',            '1900/01/01 00:00:00',  'The modified date of the last processed letter mailing record');

-- Packet Mailing Date

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_PACKET_MAILING_PROC_DATE',  'D',            '1900/01/01 00:00:00',  'The modified date of the last processed packet mailing record');

-- Enrollment Ext Date
 
INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ENROLL_EXT_CREATE_DATE',    'D',            '1900/01/01 00:00:00',  'The create date of the last enrollment record in the source');

INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ENROLL_EXT_UPDATE_DATE',    'D',            '1900/01/01 00:00:00',  'The modified date of the last enrollment record in the source');

-- System Log Date
 
INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_SYSTEM_LOG_DATE',           'D',            '1900/01/01 00:00:00',  'The process start or process end date of the last system log record in the source');

-- Batch Stats Dates
 
INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_BATCH_STATS_SCAN_START_DATE',   'D',            '1900/01/01 00:00:00',  'The batch scan start date of the latest batch record');

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_BATCH_STATS_SCAN_END_DATE',     'D',            '1900/01/01 00:00:00',  'The batch scan end date of the latest batch record');

-- Batch DCN 

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_LAST_HCO_BATCH_DCN_REC_NUM',    'N',            '0',                    'The last read record number that was inserted in the table HCO_BATCH_DCN');

-- MW Process Control
 
INSERT
  INTO  corp_etl_control        (   NAME,                           value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_PROC_CONTROL',              'V',            'STOP',                 'Control parameter that is used to STOP and START MW processes');

-- Last Step Instance History ID

UPDATE  corp_etl_control 
   SET  value               =   '1' 
 WHERE  name                =   'MW_LAST_STEP_INST_HIST_ID';

 
/*********************************************

    CREATE TABLE HCO_ACTIVITY_QUEUE

**********************************************/
CREATE TABLE HCO_ACTIVITY_QUEUE
(
    HCO_ACTIVITY_QUEUE_ID           NUMBER                                  NOT NULL,
    ACT_STATUS                      VARCHAR2(32), 
    ACT_STATUS_TS                   DATE, 
    ACT_OWNER                       VARCHAR2(80), 
    ACT_TEAM_ID                     NUMBER,
    ACT_CASE_ID                     NUMBER,
    ACT_CLIENT_ID                   NUMBER,
    ACT_DCN                         VARCHAR2(11),
    ACT_REF_ID                      NUMBER,
    ACT_REF_TYPE                    VARCHAR2(64),
    ACT_STEP_DEFINITION_ID          NUMBER                                  NOT NULL,
    ACT_PROCESS_ID                  NUMBER,
    ACT_CREATED_BY                  VARCHAR2(80),
    ACT_CREATE_TS                   DATE,
    ACT_COMMENTS                    VARCHAR2(4000),
    REC_CREATE_TS                   DATE                                    DEFAULT SYSDATE NOT NULL,
    REC_CREATED_BY                  VARCHAR2(80)                            DEFAULT USER NOT NULL,
    REC_UPDATE_TS                   DATE,
    REC_UPDATED_BY                  VARCHAR2(80),
    REC_STATUS                      VARCHAR2(5)                             DEFAULT 'P' NOT NULL,    
    CONSTRAINT HCO_ACTIVITY_QUEUE_PK PRIMARY KEY 
    (
        HCO_ACTIVITY_QUEUE_ID
    )
    ENABLE,
    CONSTRAINT HCO_ACTIVITY_QUEUE_CK01 CHECK (REC_STATUS IN ('P', 'IP', 'C'))
    ENABLE
) 
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE INDEX HCO_ACTIVITY_QUEUE_I001 ON HCO_ACTIVITY_QUEUE (ACT_STATUS_TS)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_ACTIVITY_QUEUE_I002 ON HCO_ACTIVITY_QUEUE (REC_STATUS)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_ACTIVITY_QUEUE_I003 ON HCO_ACTIVITY_QUEUE (ACT_REF_ID, ACT_REF_TYPE, ACT_STEP_DEFINITION_ID, ACT_PROCESS_ID, ACT_STATUS)
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON HCO_ACTIVITY_QUEUE TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_ACTIVITY_QUEUE TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_ACTIVITY_QUEUE TO MAXDAT_OLTP_SIUD;

DROP SEQUENCE SEQ_HCO_ACTIVITY_QUEUE_ID;

CREATE SEQUENCE SEQ_HCO_ACTIVITY_QUEUE_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;


CREATE OR REPLACE TRIGGER TRG_BIUR_HCO_ACTIVITY_QUEUE
BEFORE INSERT OR UPDATE ON HCO_ACTIVITY_QUEUE
FOR EACH ROW
BEGIN

    IF  INSERTING
    THEN
        :NEW.REC_CREATE_TS := SYSDATE;
        :NEW.REC_CREATED_BY := USER;
        
        IF :NEW.HCO_ACTIVITY_QUEUE_ID IS NULL
        THEN
            :NEW.HCO_ACTIVITY_QUEUE_ID := SEQ_HCO_ACTIVITY_QUEUE_ID.NEXTVAL; 
        END IF;
        
    END IF;
    
    :NEW.REC_UPDATED_BY := USER;
    :NEW.REC_UPDATE_TS := SYSDATE;
    :NEW.REC_STATUS := UPPER(TRIM(:NEW.REC_STATUS));
    
END;
/
/*********************************************

    CREATE TABLE HCO_MAIL_CLIENT

**********************************************/
CREATE TABLE HCO_MAIL_CLIENT_TRANS
(
    MAIL_ID                         VARCHAR2(20)                            NOT NULL,                 
    MAIL_TYPE_ID                    NUMBER,
    MAIL_LETTER_DATE                DATE,
    CASE_ID                         VARCHAR2(20),
    CLIENT_NUMBER                   NUMBER                                  NOT NULL,
    MAIL_CLIENT_TRANSACTION_ID      NUMBER                                  NOT NULL,
    MAIL_TRANSACTION_ID             NUMBER                                  NOT NULL,    
    ENROLLMENT_ID                   NUMBER,
    EXEMPTION_ID                    NUMBER,
    DCN                             VARCHAR2(20),
    MAIL_RECORD_NAME                VARCHAR2(80),
    MAIL_RECORD_DATE                DATE,
    MAIL_MODIFIED_NAME              VARCHAR2(80),
    MAIL_MODIFIED_DATE              DATE,
    MAIL_RESPONSE_LETTER_DATE       DATE,
    MAIL_RESPONSE_PACKET_DATE       DATE,   
    MT_RECORD_NAME                  VARCHAR2(80),
    MT_RECORD_DATE                  DATE,
    MT_MODIFIED_NAME                VARCHAR2(80),
    MT_MODIFIED_DATE                DATE,    
    CONSTRAINT HCO_MAIL_CLIENT_TRANS_PK PRIMARY KEY 
    (
        MAIL_ID,
        CLIENT_NUMBER,
        MAIL_CLIENT_TRANSACTION_ID,
        MAIL_TRANSACTION_ID
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE INDEX HCO_MAIL_CLIENT_TRANS_I001 ON HCO_MAIL_CLIENT_TRANS (MAIL_ID, CLIENT_NUMBER)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_MAIL_CLIENT_TRANS_I002 ON HCO_MAIL_CLIENT_TRANS (MAIL_MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;

CREATE INDEX HCO_MAIL_CLIENT_TRANS_I003 ON HCO_MAIL_CLIENT_TRANS (MT_MODIFIED_DATE)
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON HCO_MAIL_CLIENT_TRANS TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_MAIL_CLIENT_TRANS TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_MAIL_CLIENT_TRANS TO MAXDAT_OLTP_SIUD;

/*********************************************

    MODIFY TABLE EMRS_D_CASE

**********************************************/
CREATE INDEX IDX4_CASE_ID ON EMRS_D_CASE (CASE_ID)
TABLESPACE MAXDAT_INDX;

/*********************************************

    CREATE TABLE HCO_SYSTEM_LOG

**********************************************/
CREATE TABLE HCO_SYSTEM_LOG
(
    SYSTEM_LOG_ID                   NUMBER                                  NOT NULL ENABLE, 
	PARENT_PROCESS                  VARCHAR2(250), 
	PROCESS_NAME                    VARCHAR2(250), 
	DISABLED                        VARCHAR2(1), 
	PROCESS_START_DATE              DATE, 
	PROCESS_END_DATE                DATE, 
	STATUS                          VARCHAR2(100), 
	DESCRIPTION                     VARCHAR2(4000), 
	DURATION_IN_SECONDS             NUMBER, 
	RECORD_NAME                     VARCHAR2(250), 
    CONSTRAINT HCO_SYSTEM_LOG_PK PRIMARY KEY 
    (
        SYSTEM_LOG_ID
    )
)
TABLESPACE MAXDAT_DATA;

CREATE INDEX HCO_SYSTEM_LOG_I001 ON HCO_SYSTEM_LOG (PROCESS_START_DATE, PROCESS_END_DATE) 
TABLESPACE MAXDAT_INDX;

/*********************************************

    CREATE TABLE HCO_ENROLLMENT_EXT

**********************************************/
CREATE TABLE HCO_ENROLLMENT_EXT
(
    ENROLLMENT_ID                   NUMBER                                  NOT NULL,
    EXPORT_BATCH_DATE               DATE,
    RECORD_NAME                     VARCHAR2(80),
    RECORD_DATE                     DATE,
    MODIFIED_NAME                   VARCHAR2(80),
    MODIFIED_DATE                   DATE,
    CONSTRAINT HCO_ENROLLMENT_EXT_PK PRIMARY KEY 
    (
        ENROLLMENT_ID
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_ENROLLMENT_EXT TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_ENROLLMENT_EXT TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_ENROLLMENT_EXT TO MAXDAT_OLTP_SIUD;

/*********************************************

    CREATE TABLE HCO_BATCH_STATS

**********************************************/
CREATE TABLE HCO_BATCH_STATS
(
    BATCH_GUID                      VARCHAR2(40)                            NOT NULL,
    BATCH_ID                        NUMBER                                  NOT NULL,
    BATCH_NAME                      VARCHAR2(130),
    CREATION_STATION_ID             VARCHAR2(40),
    BATCH_CREATED_BY                VARCHAR2(80),
    CREATION_USER_ID                VARCHAR2(130),
    BATCH_CLASS                     VARCHAR2(40),
    CANCEL_DT                       DATE,
    CANCEL_BY                       VARCHAR2(80),
    PERFORM_SCAN_START              DATE                                    NOT NULL,
    PERFORM_SCAN_END                DATE,
    RECOGNITION_START               DATE,
    RECOGNITION_END                 DATE,
    RELEASE_TO_DMS_START            DATE,
    RELEASE_TO_DMS_END              DATE,
    CONSTRAINT HCO_BATCH_STATS_PK PRIMARY KEY 
    (
        BATCH_GUID
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_BATCH_STATS TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_BATCH_STATS TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_BATCH_STATS TO MAXDAT_OLTP_SIUD;

/*********************************************

    CREATE TABLE HCO_BATCH_DCN

**********************************************/
CREATE TABLE HCO_BATCH_DCN
(
    DB_RECORD_NUM                   NUMBER                                  NOT NULL,
    BATCH_GUID                      VARCHAR2(40)                            NOT NULL,
    BATCH_ID                        NUMBER                                  NOT NULL,
    BATCH_CLASS                     VARCHAR2(50),
    BATCH_EXPORT_DATE               VARCHAR2(50),
    BATCH_CREATE_DATE               VARCHAR2(50),
    BATCH_DESCRIPTION               VARCHAR2(80),
    BATCH_NAME                      VARCHAR2(130),
    BATCH_DOC_COUNT                 NUMBER,
    BATCH_CREATION_STATION_ID       VARCHAR2(50),
    ECN                             VARCHAR2(50),
    DCN                             VARCHAR2(50),
    DOC_TYPE                        VARCHAR2(50),
    DOC_PAGE_COUNT                  VARCHAR2(50),
    DOCUMENT_NUMBER                 VARCHAR2(50),
    BATCH_CREATED_BY                VARCHAR2(80),
    FAX_FILE_NAME                   VARCHAR2(50),
    CONSTRAINT HCO_BATCH_DCN_PK PRIMARY KEY 
    (
        DB_RECORD_NUM
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE INDEX HCO_BATCH_DCN_I001 ON HCO_BATCH_DCN (DCN)
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON HCO_BATCH_DCN TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_BATCH_DCN TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_BATCH_DCN TO MAXDAT_OLTP_SIUD;

/*********************************************

    CREATE TABLE D_HCO_PROCESS_INSTANCE

**********************************************/

DROP TABLE D_HCO_PROCESS_INSTANCE;

CREATE TABLE D_HCO_PROCESS_INSTANCE
(
    HCO_PROCESS_INSTANCE_ID         NUMBER                                  NOT NULL,
    HCO_PROCESS_ID                  NUMBER                                  NOT NULL,
    DCN                             VARCHAR2(20)                            NOT NULL,
    CLIENT_NUMBER                   NUMBER                                  NOT NULL,
    REF_TYPE                        VARCHAR2(64)                            NOT NULL,
    REF_ID                          NUMBER                                  NOT NULL,
    CONSTRAINT D_HCO_PROCESS_INSTANCE_PK PRIMARY KEY 
    (
        HCO_PROCESS_INSTANCE_ID
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX D_HCO_PROCESS_INSTANCE_U001 ON D_HCO_PROCESS_INSTANCE (HCO_PROCESS_ID, DCN, CLIENT_NUMBER, REF_TYPE, REF_ID)
TABLESPACE MAXDAT_INDX;

DROP SEQUENCE SEQ_HCO_PROCESS_INSTANCE_ID;
CREATE SEQUENCE SEQ_HCO_PROCESS_INSTANCE_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;

GRANT SELECT ON D_HCO_PROCESS_INSTANCE TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON D_HCO_PROCESS_INSTANCE TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON D_HCO_PROCESS_INSTANCE TO MAXDAT_OLTP_SIUD;

COMMIT;
