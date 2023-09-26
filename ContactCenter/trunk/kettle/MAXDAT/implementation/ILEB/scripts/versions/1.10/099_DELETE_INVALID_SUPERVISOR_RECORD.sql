

delete cc_s_agent_supervisor sas
where agent_supervisor_id in (
  select agent_supervisor_id
  from cc_s_agent_supervisor sas
  inner join cc_s_agent sa on sas.agent_id = sa.agent_id
  where login_id = '93717'  
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.10.0','099','099_DELETE_INVALID_SUPERVISOR_RECORD');

COMMIT;