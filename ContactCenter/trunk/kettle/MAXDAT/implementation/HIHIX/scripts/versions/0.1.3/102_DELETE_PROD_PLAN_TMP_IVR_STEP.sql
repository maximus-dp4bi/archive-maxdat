
--  delete record causing sequence collision
delete from cc_s_production_plan;

--  delete temp records in advance of patch fix
delete from cc_s_tmp_ivr_step;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.3','102','102_DELETE_PROD_PLAN_TMP_IVR_STEP');

COMMIT;