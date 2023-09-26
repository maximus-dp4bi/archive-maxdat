  DECLARE  
  CURSOR temp_cur IS
  select letter_request_id,sysdate cancel_date
  from corp_etl_proc_letters
  where status in('Canceled','Voided','Combined Similar Requests','Overcome by Events')
  and instance_status = 'Active';

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
           -- v_ased_selection_recd := temp_tab(indx).ASED_SELECTION_RECD; 
          UPDATE corp_etl_proc_letters
            SET complete_dt = temp_tab(indx).cancel_date
                ,cancel_dt = temp_tab(indx).cancel_date
                ,stage_done_date = temp_tab(indx).cancel_date
                ,cancel_by = 'TXEB-3911'
                ,cancel_reason = 'Request cancelled by system due to status'
                ,instance_status = 'Complete'
                ,cancel_method = 'Normal'                
               WHERE letter_request_id = temp_tab(indx).letter_request_id;
        END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


  create table corp_etl_pl_complete_onetime
  as
  select letter_request_id,to_date('11/12/2014','mm/dd/yyyy') complete_date --total : 860406
      ,CASE WHEN assd_receive_confirmation is not null THEN to_date('11/12/2014','mm/dd/yyyy')
        ELSE null END ased_receive_confirmation    
      ,asf_receive_confirmation
    from corp_etl_proc_letters 
    where status = 'Mailed'
    and instance_status = 'Active'
    and mailed_dt is null;

 DECLARE  
  CURSOR temp_cur IS
    select letter_request_id,complete_date --total : 860406
      ,ased_receive_confirmation    
      ,CASE WHEN ased_receive_confirmation is not null then 'Y' ELSE asf_receive_confirmation END asf_receive_confirmation
    from corp_etl_pl_complete_onetime ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
  --v_ased_selection_recd date;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP           
          UPDATE corp_etl_proc_letters
          SET complete_dt = temp_tab(indx).complete_date
              ,stage_done_date = temp_tab(indx).complete_date
              ,gwf_outcome = 'M'
              ,ased_receive_confirmation = temp_tab(indx).ased_receive_confirmation
              ,asf_receive_confirmation = temp_tab(indx).asf_receive_confirmation
              ,cancel_by = 'TXEB-3911' --to mark all records manually completed
	      ,instance_status = 'Complete'
          WHERE letter_request_id = temp_tab(indx).letter_request_id;
        END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

UPDATE corp_etl_proc_letters
SET complete_dt = sysdate
    ,stage_done_date = sysdate
    ,gwf_outcome = 'M'
    ,ased_transmit = sysdate
    ,asf_transmit = 'Y'
    ,assd_receive_confirmation = sysdate
    ,ased_receive_confirmation = sysdate
    ,asf_receive_confirmation = 'Y'
    ,cancel_by = 'TXEB-3911' --to mark all records manually completed
    ,instance_status = 'Complete'
    ,cancel_reason = null
where status = 'Mailed'
and instance_status = 'Active'
and mailed_dt is not null ;

commit;