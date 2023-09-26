alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update d_nyhix_mfd_current_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss'),
	doc_status_cd = 'PROCESSED', 
	Doc_status='Processed',
	env_status='Completed - Released',
	env_status_dt=to_date('10-NOV-2015 12:44:13', 'dd-MON-yyyy hh24:mi:ss'),
	sla_complete_dt=to_date('10-NOV-2015 12:44:13', 'dd-MON-yyyy hh24:mi:ss'),
	sla_complete='Y',
--	asf_process_doc='Y',
	recvd_to_scan_age_in_bus_days=4
where dcn in 
('11736799','11736800','11736801');
commit;