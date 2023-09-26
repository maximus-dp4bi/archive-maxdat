update maxdat.pp_bo_event_target_lkup  -- 10 rows updated
set end_date = to_date('20190628','yyyymmdd')
where upper(scorecard_group) like 'OTHER%'
and end_date is null;

insert into maxdat.pp_bo_event_target_lkup -- 10 rows inserted
select event_id, name, target, scorecard_flag,  
to_date('20190629','yyyymmdd') as start_date, 
to_date(null) as end_date, 
create_by, create_datetime, 
scorecard_group, 
ee_adherence, 
ops_group, worksubactivity_flag, qc_flag, ee_adherence_v2
from maxdat.pp_bo_event_target_lkup
where upper(scorecard_group) like 'OTHER%'
and end_date = to_date('20190628','yyyymmdd')
and event_id <> 1134;