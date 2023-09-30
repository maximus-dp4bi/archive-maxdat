  update D_PL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = process_letters.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = process_letters.GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE)
      where letter_type = 'TN 401 Initial Renewal Packet (MAGI)'
and letter_status not in( 'Voided','Errored','Mailed','Combined similar Requests')
and age_in_business_days = 12
and trunc(create_date) = to_date('09/20/2016','mm/dd/yyyy');

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

commit;