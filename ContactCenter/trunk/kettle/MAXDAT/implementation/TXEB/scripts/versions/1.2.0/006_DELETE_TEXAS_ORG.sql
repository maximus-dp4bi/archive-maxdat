delete from cc_c_lookup
where lookup_key='TEXAS';

delete from cc_c_filter
where value='TEXAS';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.0','006','006_DELETE_TEXAS_ORG');

commit;