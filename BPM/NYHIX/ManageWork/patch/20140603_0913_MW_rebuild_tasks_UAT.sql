-- NYHIX-8061 Manage Work queue rows blocked on NYHXMXDU

DELETE FROM corp_etl_manage_work
 WHERE task_id IN (187453, 195071);

DELETE FROM bpm_update_event_queue
 WHERE bsl_id = 1 AND identifier IN ('187453','195071');

DELETE FROM f_mw_by_date WHERE mw_bi_id IN 
  (SELECT mw_bi_id FROM d_mw_current WHERE "Task ID" IN (187453, 195071));

DELETE FROM d_mw_current
 WHERE "Task ID" IN (187453, 195071);

UPDATE step_instance_stg SET mw_processed = 'N'
 WHERE step_instance_id = 187453;

-- Bad complete date (was 8/24/13)
UPDATE step_instance_stg
   SET mw_processed = 'N', completed_ts = TO_DATE('11/18/2013 10:34:18 AM','mm/dd/yyyy hh:mi:ss AM')
 WHERE step_instance_id = 195071;


COMMIT;