UPDATE f_metric
SET actual_value = null
WHERE f_metric_id = 1849;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.3', '102','102_update_actual_value_hihix');

COMMIT;