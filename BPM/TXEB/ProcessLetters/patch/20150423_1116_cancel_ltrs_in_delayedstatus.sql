UPDATE corp_etl_proc_letters s
SET cancel_dt = sysdate
   ,instance_status = 'Complete'
   ,status = 'Canceled'
   ,cancel_reason = 'No longer required per modified Dual Demo roll-out schedule'
   ,cancel_method = 'Exception'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_by = 'TXEB-4849'
WHERE EXISTS(SELECT 1 FROM letters_stg t WHERE s.letter_request_id = t.letter_id AND letter_status_cd = 'DELAYED' AND trunc(letter_create_ts) = to_date('02/12/2015','mm/dd/yyyy'))
AND instance_status = 'Active';   

UPDATE corp_etl_proc_letters s
SET cancel_dt = sysdate
   ,instance_status = 'Complete'
   ,status = 'Canceled'
   ,cancel_reason = 'No longer required per modified Dual Demo roll-out schedule'
   ,cancel_method = 'Exception'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_by = 'TXEB-4849'
WHERE EXISTS(SELECT 1 FROM letters_stg t WHERE s.letter_request_id = t.letter_id AND letter_status_cd = 'DELAYED' AND trunc(letter_create_ts) = to_date('03/11/2015','mm/dd/yyyy'))
AND instance_status = 'Active';     

UPDATE corp_etl_proc_letters s
SET cancel_dt = sysdate
   ,instance_status = 'Complete'
   ,status = 'Canceled'
   ,cancel_reason = 'No longer required per modified Dual Demo roll-out schedule'
   ,cancel_method = 'Exception'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_by = 'TXEB-4849'
where letter_request_id in(28774232,
28772305,
28772593,
28772923,
28769397,
28768873,
28765543,
28768678,
28765409,
28764323,
28763666,
28762377,
28762654,
28761979,
28762282,
28761274,
28760794,
28759303,
28759369,
28759045,
28757917)
;
   
   
COMMIT;