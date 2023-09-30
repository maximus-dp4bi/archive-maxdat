UPDATE doc_link_stg l
SET mi_task_indicator = 0
where mi_task_indicator = 1
and not exists (select 1 from app_missing_info_stg m where l.link_ref_id = m.application_id and m.create_ts < l.create_ts and (m.satisfied_date is null or m.satisfied_date >= l.create_ts))
;

COMMIT;