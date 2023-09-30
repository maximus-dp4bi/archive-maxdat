update  maxdat.pp_bo_event_target_lkup
set ops_group = substr(ops_group,1,25)
where length(ops_group) > 25;

