--MAXDAT-3962

update cc_c_contact_queue
set queue_name = 'WA'||queue_name
where queue_name like 'DC_PDMS%'
and project_name = 'DC PDMS';

commit;