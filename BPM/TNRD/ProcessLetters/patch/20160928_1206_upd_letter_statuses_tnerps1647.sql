BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id
           AND instance_status = 'Complete'
           AND status not in('Mailed','Voided','Errored','Combined similar Requests')) LOOP
    UPDATE corp_etl_proc_letters
    SET status = x.letter_status
       ,status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;  

/

BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id
            and trunc(create_dt) = to_date('06/07/2016','mm/dd/yyyy')
            and p.letter_type = 'TN 411 Termination for Failure to Respond'
            and s.letter_status <> p.status) LOOP
    UPDATE corp_etl_proc_letters
    SET status = x.letter_status
       ,status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date
       ,instance_status = 'Complete'
       ,complete_dt = x.letter_update_ts
       ,stage_done_date = sysdate
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

   UPDATE corp_etl_proc_letters
    SET status = 'Voided'
       ,status_dt = to_date('09/28/2016 14:03:24','mm/dd/yyyy hh24:mi:ss')
       ,sent_dt = to_date('09/26/2016 22:24:12','mm/dd/yyyy hh24:mi:ss')
    WHERE letter_request_id = 213539;


commit;