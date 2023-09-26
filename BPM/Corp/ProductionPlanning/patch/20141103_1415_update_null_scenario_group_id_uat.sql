update pp_bo_task
set scenario_group_id=5
where scenario_group_id is null;

commit;