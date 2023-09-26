 BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
            ,CASE WHEN s.letter_status = 'Canceled' THEN 'TNERPS-1827' ELSE null END cancel_by
            ,letter_update_ts cancel_dt            
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_status <> p.status
            and letter_status = 'Canceled') LOOP
    UPDATE corp_etl_proc_letters
    SET status = x.letter_status
       ,status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date
       ,instance_status = 'Complete'
       ,complete_dt = x.letter_update_ts
       ,stage_done_date = sysdate
       ,cancel_by = x.cancel_by
       ,cancel_dt = x.cancel_dt
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

 BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
            ,CASE WHEN s.letter_status = 'Canceled' THEN 'TNERPS-1827' ELSE null END cancel_by
            ,letter_update_ts cancel_dt            
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_status <> p.status
            and letter_mailed_date > letter_create_ts) LOOP
    UPDATE corp_etl_proc_letters
    SET status = x.letter_status
       ,status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date
       ,instance_status = 'Complete'
       ,complete_dt = x.letter_update_ts
       ,stage_done_date = sysdate
       ,cancel_by = x.cancel_by
       ,cancel_dt = x.cancel_dt
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

 BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
           ,p.mailed_dt 
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_mailed_date <> p.mailed_dt           ) LOOP
    UPDATE corp_etl_proc_letters
    SET status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date      
       ,complete_dt = x.letter_update_ts
       ,stage_done_date = sysdate
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

commit;