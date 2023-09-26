CREATE OR REPLACE TRIGGER TRG_BIUR_STEP_INSTANCE
BEFORE INSERT OR UPDATE ON STEP_INSTANCE
FOR EACH ROW
DECLARE
    l_rec_change                                                                PLS_INTEGER;
BEGIN

    l_rec_change    :=  0;

    IF          UPDATING
            AND (
                    NVL(:OLD.STATUS, '?')   = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
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

    ELSE

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

        IF      NVL(:NEW.STATUS, '?')       =      CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
            AND NVL(:OLD.STATUS, '?')       !=     CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
        THEN

            :NEW.COMPLETED_TS := :NEW.STATUS_TS;

        ELSE

            IF  NVL(:NEW.COMMENTS, '?') =   CAHCO_ETL_MW_UTIL_PKG.claimed_on_ownership_change
            THEN

                IF       NVL(:OLD.OWNER, '?')            !=  NVL(:NEW.OWNER, '?')
                    AND NVL(:NEW.OWNER, '?')            !=  '?'
                THEN

                    :NEW.STATUS :=  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed;
                    :NEW.CLAIMED_TS := :NEW.STATUS_TS;

                END IF;

            ELSIF       NVL(:NEW.STATUS, '?') =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
                    AND NVL(:OLD.STATUS, '?') !=  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
            THEN

                :NEW.CLAIMED_TS := :NEW.STATUS_TS;

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
-- ETL Data Start Date

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ETL_DATA_START_DATE',           'D',            '1900/01/01 00:00:00',  'The ETL data start date');


-- Daily Transaction Enrollment

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ETL_DTE_CREATE_DATE',           'D',            '1900/01/01 00:00:00',  'The create date of the last daily transaction enrollment record in the source');

INSERT
  INTO  corp_etl_control        (   NAME,                               value_type,     VALUE,                  DESCRIPTION )
VALUES                          (   'MW_ETL_DTE_UPDATE_DATE',           'D',            '1900/01/01 00:00:00',  'The modified date of the last daily transaction enrollment record in the source');
/*********************************************

    CREATE TABLE DAILY_TRANSACTION_ENROLLMENT

**********************************************/
CREATE TABLE DAILY_TRANSACTION_ENROLLMENT
(   
    ENROLLMENT_RECORD_ID                                        NUMBER                  NOT NULL,
    ENROLLMENT_ID                                               NUMBER, 
    FILE_NAME                                                   VARCHAR2(100)           NOT NULL,
    RECORD_DATE                                                 DATE                    NOT NULL,
    MODIFIED_DATE                                               DATE                    NOT NULL,
    CONSTRAINT DAILY_TRANSACTION_ENROLLMENT_PK PRIMARY KEY 
    (
        ENROLLMENT_RECORD_ID
    )
    ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON DAILY_TRANSACTION_ENROLLMENT TO MAXDAT_READ_ONLY; 

CREATE INDEX DAILY_TRANSACTION_ENROLLMENT_I001 ON DAILY_TRANSACTION_ENROLLMENT (ENROLLMENT_ID)
TABLESPACE MAXDAT_INDX;
/*********************************************

    ALTER TABLE HCO_ENROLLMENT_EXT

**********************************************/
ALTER TABLE HCO_ENROLLMENT_EXT ADD
(
    DCN             VARCHAR2(20)
);
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

    MODIFY TABLE HCO_ACTIVITY_QUEUE

**********************************************/
CREATE INDEX HCO_ACTIVITY_QUEUE_I004 ON HCO_ACTIVITY_QUEUE (REC_STATUS, ACT_STATUS_TS, HCO_ACTIVITY_QUEUE_ID)
TABLESPACE MAXDAT_INDX;





