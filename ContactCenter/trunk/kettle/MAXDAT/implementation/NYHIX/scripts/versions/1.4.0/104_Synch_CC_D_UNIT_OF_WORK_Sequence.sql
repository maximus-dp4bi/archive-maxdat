
SELECT SEQ_CC_D_UNIT_OF_WORK.NEXTVAL FROM CC_D_UNIT_OF_WORK;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
VALUES ('1.4.0',104,'104_Synch_CC_D_UNIT_OF_WORK_Sequence');

COMMIT;