delete from cc_f_actuals_queue_interval a
where rowid > ( select min(rowid) from cc_f_actuals_queue_interval b
where a.d_date_id=b.d_date_id
and a.d_project_id=b.d_project_id
and a.d_program_id=b.d_program_id
and a.d_geography_master_id=b.d_geography_master_id
and a.d_unit_of_work_id=b.d_unit_of_work_id
and a.d_interval_id=b.d_interval_id
and a.d_contact_queue_id=b.d_contact_queue_id
and a.d_agent_id=b.d_agent_id);

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL
ENABLE CONSTRAINT CC_F_ACTUALS_Q_INTERVAL__UN;

COMMIT;