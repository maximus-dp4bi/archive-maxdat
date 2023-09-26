/*
Created on 11/19/2014 by Raj A.
Decsription: Issue is explained in the ticket, NYHIX-12133
--From below sql we know all instances had at least one hist record updated in the SIS table on 11/14. So, we can confidently delete the queue rows now.
--633 instances.
SELECT count(distinct  sis.step_instance_id)
FROM step_instance_stg sis
WHERE step_instance_id IN (
  SELECT IDENTIFIER
  FROM bpm_update_event_queue
  WHERE bsl_id = 2001
  AND process_bueq_id IS NOT NULL
  )
AND EXISTS (SELECT 1 FROM step_instance_stg sis_2
                 WHERE sis_2.step_instance_id = sis.step_instance_id
                   and trunc(sis_2.stage_update_ts) = to_date('14-NOV-2014','DD-MON-YYYY') )
order by sis.step_instance_id  
;
*/
--queue rows to delete is below. These are the only errored out recs.
delete bpm_update_event_queue
WHERE bsl_id = 2001
AND process_bueq_id IS NOT NULL;
COMMIT;
