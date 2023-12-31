ALTER TABLE CC_S_IVR_SELF_SERVICE_PATH DROP CONSTRAINT CC_S_SELF_SERVICE_PATH__UN;

ALTER TABLE CC_S_IVR_SELF_SERVICE_PATH ADD CONSTRAINT CC_S_SELF_SERVICE_PATH__UN UNIQUE
(
  BEGIN_NODE , END_NODE , RECORD_EFF_DT, CODE
)
;

ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH DROP CONSTRAINT CC_D_SELF_SERVICE_PATH__UN;

ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH ADD CONSTRAINT CC_D_SELF_SERVICE_PATH__UN UNIQUE
(
  BEGIN_NODE , END_NODE , RECORD_EFF_DT, CODE
)
;


CREATE OR REPLACE VIEW CC_D_IVR_SELF_SERVICE_PATH_SV  AS
SELECT CC_D_IVR_SELF_SERVICE_PATH.* FROM CC_D_IVR_SELF_SERVICE_PATH ;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('0.1','008','008_ALTER_IVR_SELF_SERVICE_PATH_TABLES');

COMMIT;