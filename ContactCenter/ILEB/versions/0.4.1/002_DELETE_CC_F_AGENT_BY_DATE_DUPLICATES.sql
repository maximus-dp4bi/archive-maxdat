delete from cc_f_agent_by_date
where f_agent_by_date_id in (
  select min(f_agent_by_date_id)
  from cc_f_agent_by_date
  group by d_date_id, d_agent_id, handle_calls_count
  having count(*) > 1
);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.4.1','002','002_DELETE_CC_F_AGENT_BY_DATE_DUPLICATES');

COMMIT; 