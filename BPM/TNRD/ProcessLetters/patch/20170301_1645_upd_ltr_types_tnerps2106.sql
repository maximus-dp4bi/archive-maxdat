BEGIN
  FOR x IN(SELECT p.letter_request_id,s.letter_type new_ltr_type,p.letter_type old_ltr_type          
           FROM corp_etl_proc_letters p, letters_stg s
           WHERE p.letter_request_id = s.letter_id          
            and s.letter_type <> p.letter_type
          
            ) LOOP
    UPDATE corp_etl_proc_letters
    SET letter_type = x.new_ltr_type
    WHERE letter_request_id = x.letter_request_id;
  END LOOP;
END;
/

COMMIT;