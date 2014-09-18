delete cc_f_agent_by_date f
where f_agent_by_date_id in (
  select min(f_agent_by_date_id)
  from cc_f_agent_by_date i_f
  inner join cc_d_agent da on i_f.d_agent_id = da.d_agent_id
  group by d_date_id, login_id, handle_calls_count
  having count(*) > 1
);


delete cc_f_agent_activity_by_date f
where f_agent_activity_by_date_id in (
  select min(f_agent_activity_by_date_id)
  from cc_f_agent_activity_by_date i_f
  inner join cc_d_agent da on i_f.d_agent_id = da.d_agent_id
  inner join cc_d_activity_type dat on i_f.d_activity_type_id = dat.d_activity_type_id
  group by d_date_id, activity_type_name, login_id
  having count(*) > 1
);


insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('2.4',017,'017_DELETE_FACT_DUPS');

commit;