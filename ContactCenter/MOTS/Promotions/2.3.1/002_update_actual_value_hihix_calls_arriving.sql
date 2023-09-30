UPDATE f_metric
SET actual_value = null
WHERE f_metric_id = 1941;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.3.1', '002','002_update_actual_value_hihix_calls_arriving');

COMMIT;