update corp_etl_proc_letters
set mailed_dt = (select letter_mailed_date from letters_stg where letter_id = 35381)
    ,status_dt = (select letter_mailed_date from letters_stg where letter_id = 35381)    
    ,complete_dt = (select letter_mailed_date from letters_stg where letter_id = 35381)    
    ,ased_receive_confirmation = (select letter_mailed_date from letters_stg where letter_id = 35381)    
    ,print_dt = (select letter_printed_on from letters_stg where letter_id = 35381)
    ,last_update_dt = (select letter_update_ts from letters_stg where letter_id = 35381)
where letter_request_id = 35381;

commit;