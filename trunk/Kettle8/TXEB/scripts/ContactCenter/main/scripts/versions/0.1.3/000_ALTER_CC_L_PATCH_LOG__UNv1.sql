
ALTER TABLE CC_L_PATCH_LOG DROP CONSTRAINT CC_L_PATCH_LOG__UNv1;

ALTER TABLE CC_L_PATCH_LOG ADD CONSTRAINT CC_L_PATCH_LOG__UNv1 UNIQUE(PATCH_VERSION, SCRIPT_SEQUENCE);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.3','000','000_ALTER_CC_L_PATCH_LOG__UNv1');

COMMIT;