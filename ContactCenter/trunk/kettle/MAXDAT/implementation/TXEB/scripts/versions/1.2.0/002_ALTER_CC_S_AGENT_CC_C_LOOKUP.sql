CREATE INDEX cc_s_agent_idx1 ON cc_s_agent (login_id asc);

CREATE INDEX cc_c_lookup_idx1 ON cc_c_lookup (lookup_type asc,lookup_key asc);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.0','002','002_ALTER_CC_S_AGENT_CC_C_LOOKUP');

commit;