
CREATE TABLE CC_S_TMP_AGENT_SKILL_GROUP
  (
    SKILLTARGETID           NUMBER ,
    PERIPHERALNUMBER        NUMBER ,
    SKILLGROUPSKILLTARGETID NUMBER ,
    FIRSTNAME               VARCHAR2 (50) ,
    LASTNAME                VARCHAR2 (50)
  );



INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.4','003','003_CREATE_CC_S_TMP_AGENT_SKILL_GROUP');

COMMIT;

