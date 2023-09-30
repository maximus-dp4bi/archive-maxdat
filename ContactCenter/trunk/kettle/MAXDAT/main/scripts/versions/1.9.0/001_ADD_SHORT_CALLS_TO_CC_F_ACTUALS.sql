ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD(SHORT_CALLS NUMBER(7));

update CC_F_ACTUALS_QUEUE_INTERVAL
set short_calls=short_abandons;

commit;

update cc_f_actuals_queue_interval
set short_abandons=CALLS_ABANDONED_PERIOD_1;

commit;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.9.0','001','001_ADD_SHORT_CALLS_TO_CC_F_ACTUALS');

COMMIT;

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL modify (SHORT_CALLS NUMBER(7) not null);

CREATE OR REPLACE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACTUALS_QUEUE_INTERVAL.* FROM CC_F_ACTUALS_QUEUE_INTERVAL ;