update pp_d_uow_source_ref
   set source_ref_id = 2013024
 where uow_id = 24
   and source_ref_value = 'DPR - SHOP Employee Task'
   and source_ref_detail_identifier = 'TASK ID'
   and end_date > sysdate;
   
commit;  
/ 
