  begin
    for i in 1..1823
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (i+9273, 'CM13-0000000', to_date('09/01/2013','mm/dd/yyyy'),to_date('09/01/2013','mm/dd/yyyy'), to_date('09/01/2013','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;
  
    for j in 1..2286
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (11096+j, 'CM13-0000000', to_date('10/01/2013','mm/dd/yyyy'),to_date('10/01/2013','mm/dd/yyyy'), to_date('10/01/2013','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;    
      
    for k in 1..2778
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (13382+k, 'CM13-0000000', to_date('11/01/2013','mm/dd/yyyy'),to_date('11/01/2013','mm/dd/yyyy'), to_date('11/01/2013','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;  
      
    for l in 1..3730
     loop
    	insert into s_crs_imr (imr_id, case_number, imr_received_date, imr_duplicate_date, imr_closed_date, updated, dummy_records_flg)
      values (16160+l, 'CM13-0000000', to_date('12/01/2013','mm/dd/yyyy'),to_date('12/01/2013','mm/dd/yyyy'), to_date('12/01/2013','mm/dd/yyyy'), 'N', 'Y');
      end loop;
      commit;       
end;
/