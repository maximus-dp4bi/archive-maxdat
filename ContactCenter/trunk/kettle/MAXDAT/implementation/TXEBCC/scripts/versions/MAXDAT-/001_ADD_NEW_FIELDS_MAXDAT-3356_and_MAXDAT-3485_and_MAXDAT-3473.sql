--MAXDAT-3473

ALTER TABLE CC_S_ACD_INTERVAL ADD (MAX_CALLS_QUEUED NUMBER (7) NULL);

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL ADD (MAX_CALLS_QUEUED NUMBER (7) NULL);

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD (MAX_CALLS_QUEUED NUMBER (7) NULL);

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD (MAX_CALLS_QUEUED NUMBER (7) NULL);


ALTER TABLE CC_S_ACD_INTERVAL MODIFY (CALLS_ON_HOLD NUMBER (7) NULL);

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL MODIFY (CALLS_ON_HOLD NUMBER (7) NULL);

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY (CALLS_ON_HOLD NUMBER (7) NULL);

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY (CALLS_ON_HOLD NUMBER (7) NULL);

ALTER TABLE CC_S_TMP_CISCO_A_SG_INTERVAL ADD (INTERNALCALLSTIME NUMBER);


--MAXDAT-3485

ALTER TABLE CC_F_AGENT_BY_DATE ADD (AT_WORK_PAID_TIME NUMBER (7));

ALTER TABLE CC_A_LIST_LKUP MODIFY (LIST_TYPE VARCHAR2(100));

ALTER TABLE CC_A_LIST_LKUP_HIST MODIFY (LIST_TYPE VARCHAR2(100));
