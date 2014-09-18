delete from cc_f_agent_by_date
where d_agent_id in (
  select d_agent_id
  from cc_d_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_f_agent_activity_by_date
where d_agent_id in (
  select d_agent_id
  from cc_d_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_d_agent
where login_id in (
  '12387'
  ,'10379'
);

delete from cc_s_agent_absence
where agent_id in (
  select agent_id
  from cc_s_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_s_agent_supervisor
where agent_id in (
  select agent_id
  from cc_s_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_s_agent_work_day
where agent_id in (
  select agent_id
  from cc_s_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_s_acd_agent_activity
where agent_id in (
  select agent_id
  from cc_s_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_s_wfm_agent_activity
where agent_id in (
  select agent_id
  from cc_s_agent
  where login_id in (
    '12387'
    ,'10379'
  )
);

delete from cc_s_call_Detail
where agent_id in (select agent_id from cc_s_agent
                   where login_id in (
  '12387'
  ,'10379'
));


delete from cc_s_agent
where login_id in (
  '12387'
  ,'10379'
);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.2.0','005','005_DELETE_SSU_AGENTS');

COMMIT;
