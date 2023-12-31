ALTER TABLE CC_A_SCHEDULED_JOB
ADD (
	DATA_VALIDATION VARCHAR2 (50) DEFAULT 'NOT_TESTED'
	);

ALTER TABLE CC_A_SCHEDULED_JOB ADD CHECK
(
  DATA_VALIDATION IN ('FAILURE', 'IN_PROGRESS', 'NOT_TESTED', 'SUCCESS')
)
;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.7.1','001','001_ADD_DV_FIELD_TO_CC_A_SCHEDULED_JOB');

COMMIT;