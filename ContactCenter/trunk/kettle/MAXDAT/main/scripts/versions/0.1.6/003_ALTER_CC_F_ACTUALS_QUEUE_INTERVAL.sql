ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD (
	INCOMPLETE_CALLS            NUMBER (7) DEFAULT 0 NOT NULL ,
	RETURN_RING					NUMBER (7) DEFAULT 0 NOT NULL 
);


CREATE OR REPLACE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACTUALS_QUEUE_INTERVAL.* FROM CC_F_ACTUALS_QUEUE_INTERVAL ;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.6','003','003_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL');

COMMIT;
