ALTER TABLE CC_S_ACD_INTERVAL ADD ( MAX_ABANDON_TIME NUMBER DEFAULT 0  NOT NULL );

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL ADD ( MAX_ABANDON_TIME NUMBER DEFAULT 0  NOT NULL );

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD ( MAX_ABANDON_TIME NUMBER  DEFAULT 0  NOT NULL  );

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD ( MAX_ABANDON_TIME NUMBER  DEFAULT 0  NOT NULL  );

ALTER TABLE CC_S_TMP_AVY_IAPPLICATION ADD ( MAXCALLSABANDONEDDELAY NUMBER );


CREATE OR REPLACE VIEW CC_F_ACD_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACD_QUEUE_INTERVAL.* FROM CC_F_ACD_QUEUE_INTERVAL ;


CREATE OR REPLACE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACTUALS_QUEUE_INTERVAL.* FROM CC_F_ACTUALS_QUEUE_INTERVAL ;