-- staging
ALTER TABLE CC_S_ACD_INTERVAL MODIFY (MAX_SPEED_OF_ANSWER  NUMBER(12,2) NULL);

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL MODIFY (MAX_SPEED_OF_ANSWER  NUMBER(12,2) NULL);

--facts

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY (MAX_SPEED_OF_ANSWER  NUMBER(12,2) NULL);

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY (MAX_SPEED_OF_ANSWER  NUMBER(12,2) NULL);