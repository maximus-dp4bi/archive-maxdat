

ALTER TABLE CC_F_AGENT_ACTIVITY_BY_DATE
MODIFY ACTIVITY_MINUTES NUMBER (10,2);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.3.1','011','011_ALTER_CC_F_AGENT_ACTIVITY_BY_DATE');

COMMIT;