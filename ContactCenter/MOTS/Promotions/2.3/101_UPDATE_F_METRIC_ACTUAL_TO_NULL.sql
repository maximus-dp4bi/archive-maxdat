UPDATE F_METRIC
SET ACTUAL_VALUE = NULL
WHERE F_METRIC_ID = 1790; --HI HIX 4/26 'Calls Arriving' Record

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.3', '101','101_UPDATE_F_METRIC_ACTUAL_TO_NULL');

COMMIT;