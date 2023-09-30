create or replace trigger TRG_BIUR_STEP_INSTANCE
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