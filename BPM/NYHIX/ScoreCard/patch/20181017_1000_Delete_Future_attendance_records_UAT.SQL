delete from dp_scorecard.sc_attendance where to_number(to_char(entry_date,'yyyymm')) > 201810 ;

commit;
/