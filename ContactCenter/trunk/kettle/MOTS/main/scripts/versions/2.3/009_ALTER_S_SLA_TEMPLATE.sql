
ALTER TABLE S_SLA_TEMPLATE ADD (
  IS_ERROR VARCHAR2 (1) DEFAULT 'N'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.3','009','009_ALTER_S_SLA_TEMPLATE');


COMMIT;
