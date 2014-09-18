/*
Created on 21-Jan-2014 by Raj A.
Description:
This script fixes the "Unique Constraint" error logged for NYHIX IDR Incidents in NYHXMXDU database.
This happened for the below seven IDR incidents only; hence the fix is for these incidents only.
Error: ORA-00001: unique constraint (MAXDAT.FIDRBD_UIX2) violated
*/

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete f_idr_by_date
WHERE idr_bi_id IN ( SELECT bi_id FROM bpm_instance
                    WHERE IDENTIFIER IN (
                                          '26034958',
                                          '26034462',
                                          '26038690',
                                          '26034924',
                                          '26034640',
                                          '26040377',
                                          '26034564'
                                          )
);

delete d_idr_current
WHERE incident_id IN (
26034958,
26034462,
26038690,
26034924,
26034640,
26040377,
26034564
);

insert into bpm_update_event_queue
select * from bpm_update_event_queue_archive
where IDENTIFIER IN (
					  '26034958',
					  '26034462',
					  '26038690',
					  '26034924',
					  '26034640',
					  '26040377',
					  '26034564'
					  );										  

update bpm_update_event_queue
   set process_bueq_id = null,
	   WROTE_BPM_SEMANTIC_DATE = null
where IDENTIFIER IN (
				  '26034958',
				  '26034462',
				  '26038690',
				  '26034924',
				  '26034640',
				  '26040377',
				  '26034564'
				  );
				  
delete bpm_update_event_queue_archive
where IDENTIFIER IN (
					  '26034958',
					  '26034462',
					  '26038690',
					  '26034924',
					  '26034640',
					  '26040377',
					  '26034564'
					  );				  
commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;