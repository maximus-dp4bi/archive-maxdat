
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete f_idr_by_date
WHERE fidrbd_id = 11596;

insert into bpm_update_event_queue
select * from bpm_update_event_queue_archive
where bueq_id = 1891878;											  

update bpm_update_event_queue
   set process_bueq_id = null,
	   WROTE_BPM_SEMANTIC_DATE = null
where IDENTIFIER = '26041319' ;	
				  
delete bpm_update_event_queue_archive
where bueq_id = 1891878;	

commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;