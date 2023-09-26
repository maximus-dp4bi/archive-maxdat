ALTER TABLE CC_S_ACD_INTERVAL ADD (
    INCOMPLETE_CALLS            NUMBER (7) DEFAULT 0 NOT NULL ,
    RETURN_RING					NUMBER (7) DEFAULT 0 NOT NULL 
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.6','002','002_ALTER_CC_S_ACD_INTERVAL');

COMMIT;