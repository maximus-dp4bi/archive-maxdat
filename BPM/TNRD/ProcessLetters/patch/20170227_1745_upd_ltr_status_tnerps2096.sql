BEGIN
  FOR x IN(SELECT p.letter_request_id, p.stage_done_date, p.complete_dt,p.status_dt, p.status, s.letter_status, s.letter_update_ts,s.letter_mailed_date, s.letter_sent_on,s.letter_printed_on
            ,CASE WHEN s.letter_status = 'Voided' THEN 'MAXeb'  ELSE null END cancel_by
            ,CASE WHEN s.letter_status = 'Voided' THEN letter_update_ts ELSE NULL END cancel_dt            
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_status <> p.status
             and s.letter_id in(602136,
604382,
604489,
646748,
654797,
705290,
712486,
718942,
726281,
726283,
740480,
741710,
742086,
785975,
872269,
877915,
878646)
            ) LOOP
    UPDATE corp_etl_proc_letters
    SET status = x.letter_status
       ,status_dt = x.letter_update_ts
       ,sent_dt = x.letter_sent_on
       ,print_dt = x.letter_printed_on
       ,mailed_dt = x.letter_mailed_date
       ,instance_status = 'Complete'
       ,complete_dt = x.letter_mailed_date
       ,stage_done_date = sysdate    
       ,cancel_dt = x.cancel_dt
       ,cancel_by = x.cancel_by
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

COMMIT;