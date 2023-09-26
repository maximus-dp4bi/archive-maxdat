  begin
    for i in 1..3336
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (i, 'CM14-0000000', to_date('01/01/2014','mm/dd/yyyy'),to_date('01/01/2014','mm/dd/yyyy'), to_date('01/01/2014','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;
  
    for j in 1..2620
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (3336+j, 'CM14-0000000', to_date('02/01/2014','mm/dd/yyyy'),to_date('02/01/2014','mm/dd/yyyy'), to_date('02/01/2014','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;    
      
    for k in 1..3317
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (5956+k, 'CM14-0000000', to_date('03/01/2014','mm/dd/yyyy'),to_date('03/01/2014','mm/dd/yyyy'), to_date('03/01/2014','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;     
end;
/
