drop table cc_s_tmp_avy_skillset;
drop table cc_s_tmp_avy_skillsetbyagent;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.3.1','102','102_DROP_TMP_AVY_SKILLSET_and_SKILLSETBYAGENT');
commit;