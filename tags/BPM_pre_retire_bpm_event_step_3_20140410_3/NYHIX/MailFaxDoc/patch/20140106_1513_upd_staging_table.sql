update NYHIX_ETL_MAIL_FAX_DOC 
set instance_status = 'Active', stage_done_dt = NULL, Instance_status_dt = NULL
where instance_status = 'Complete';

commit;