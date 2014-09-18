ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL
  ADD (
    ICR_DEFAULT_ROUTED             NUMBER (7) DEFAULT 0 NOT NULL ,
    NETWORK_DEFAULT_ROUTED         NUMBER (7) DEFAULT 0 NOT NULL ,
    RETURN_BUSY                    NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_RONA                     NUMBER (7) DEFAULT 0 NOT NULL ,
    RETURN_RELEASE                 NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ROUTED_NON_AGENT         NUMBER (7) DEFAULT 0 NOT NULL ,
    ERROR_COUNT                    NUMBER (7) DEFAULT 0 NOT NULL ,
    AGENT_ERROR_COUNT              NUMBER (7) DEFAULT 0 NOT NULL 
  );


CREATE OR REPLACE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACTUALS_QUEUE_INTERVAL.* FROM CC_F_ACTUALS_QUEUE_INTERVAL ;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
  VALUES ('0.1.3','008','008_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL');

COMMIT;
