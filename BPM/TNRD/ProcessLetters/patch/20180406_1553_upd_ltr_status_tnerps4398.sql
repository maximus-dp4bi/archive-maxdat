BEGIN
  FOR x IN(SELECT p.letter_request_id,p.mailed_dt, s.letter_mailed_date
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_mailed_date <> p.mailed_dt               
            ) LOOP
    UPDATE corp_etl_proc_letters
    SET mailed_dt = x.letter_mailed_date       
       ,complete_dt = x.letter_mailed_date       
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

COMMIT;

