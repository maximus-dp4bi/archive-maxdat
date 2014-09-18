alter table CC_F_AGENT_ACTIVITY_BY_DATE modify ACTIVITY_MINUTES number(9,2);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','100','alter_datatype_cc_f_agent_activity_by_date');

commit;