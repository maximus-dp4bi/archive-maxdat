UPDATE letters_stg
SEt letter_status_cd = 'MAIL', letter_status = 'Mailed', letter_update_ts = to_date('12/3/2014  21:00:11','mm/dd/yyyy hh24:mi:ss')
    ,letter_mailed_date = to_date('12/3/2014  00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,letter_printed_on =  to_date('12/3/2014  00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,letter_updated_by = -19
where letter_id in(9446770,
9446790,
9446811,
9446851,
9446894,
9446913,
9446932,
9446935,
9446947,
9446950,
9446957,
9446967,
9446978,
9446988,
9446999,
9447014,
9447022,
9447023,
9447035,
9447043,
9447067,
9447079,
9447086,
9447093,
9447113,
9447114,
9447121,
9447123,
9447182,
9447206,
9447211,
9449895,
9449915,
9449925,
9450024,
9450062,
9450074,
9450097);   

COMMIT;