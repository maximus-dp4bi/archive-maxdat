UPDATE letters_stg
SET letter_status_cd = 'COMBND'
   ,letter_Status = 'Combined Similar Requests'   
WHERE letter_id IN(115780830,115780837);

COMMIT;

UPDATE corp_etl_proc_letters
SET status = 'Combined Similar Requests'
    ,status_dt = to_date('06/06/2019 21:11:28','mm/dd/yyyy hh24:mi:ss')
    ,cancel_dt = to_date('06/06/2019 21:11:28','mm/dd/yyyy hh24:mi:ss')
    ,cancel_by = 'System,LetterRequestsJob'
    ,cancel_method = 'Normal'
    ,cancel_reason = 'Request cancelled by system due to VOID, OBE or Combined status'
    ,instance_status = 'Complete'
    ,complete_dt = to_date('06/06/2019 21:11:28','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
WHERE letter_request_id IN(115780830,115780837);

UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('06/16/2019 21:02:29','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('06/28/2019 21:44:56','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('06/16/2019 21:02:29','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('06/16/2019 21:02:29','mm/dd/yyyy hh24:mi:ss') 
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/16/2019 20:55:11','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('06/16/2019 20:55:11','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('06/28/2019 21:44:46','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN (115870400);

UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('06/30/2019 21:11:06','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('07/08/2019 09:42:23','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('06/30/2019 21:11:06','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('06/30/2019 21:11:06','mm/dd/yyyy hh24:mi:ss')
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/30/2019 20:59:16','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('06/30/2019 20:59:16','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('07/08/2019 09:42:15','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN(117041750);

COMMIT;


