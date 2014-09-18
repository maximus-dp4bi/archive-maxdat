delete from emrs_d_selection_missing_info s1
where rejection_error_reason_id != 0
and exists(select 1 from emrs_d_selection_missing_info  s2
           where s1.selection_transaction_id = s2.selection_transaction_id           
           and s1.rejection_error_reason_id = s2.rejection_error_reason_id
           and coalesce(s1.supplemental_info,'X') = coalesce(s2. supplemental_info,'X')          
           and s1.selection_missing_info_id < s2.selection_missing_info_id
           )
; 

commit;