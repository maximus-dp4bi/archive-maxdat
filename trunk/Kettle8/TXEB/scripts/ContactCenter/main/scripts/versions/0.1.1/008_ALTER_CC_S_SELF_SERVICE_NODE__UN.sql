
ALTER TABLE CC_S_IVR_SELF_SERVICE_PATH DROP CONSTRAINT CC_S_SELF_SERVICE_NODE__UN;

ALTER TABLE CC_S_IVR_SELF_SERVICE_PATH ADD CONSTRAINT CC_S_SELF_SERVICE_PATH__UN UNIQUE(BEGIN_NODE, END_NODE, RECORD_EFF_DT);

COMMIT;