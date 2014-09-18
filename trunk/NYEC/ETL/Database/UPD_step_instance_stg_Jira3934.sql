-- 2/28/13 For Stage Testing
UPDATE step_instance_stg SET reason_cd = NULL WHERE reason_cd IS NOT NULL;
COMMIT;
