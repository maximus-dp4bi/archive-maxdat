
delete cc_f_agent_activity_by_date fact
where f_agent_activity_by_date_id in (
  select f_agent_activity_by_date_id 
  from cc_f_agent_activity_by_date f
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  inner join cc_d_agent da on f.d_agent_id = da.d_agent_id
  where da.record_eff_dt > d_date
  or da.record_end_dt < d_date
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.10.0', '103', '103_DELETE_DUPLICATE_AGENT_ACTIVITY_FACTS');

COMMIT;