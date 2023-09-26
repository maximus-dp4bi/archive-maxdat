
-- PRD

update cc_a_schedule
set job_type = 'load_contact_center'
where schedule_id = 8;

update cc_a_schedule
set job_type = 'load_production_planning'
where schedule_id = 10;

commit;