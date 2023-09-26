SELECT smi.missing_info_id||selection_txn_id||missing_info_details_id selection_missing_info_id
      ,smi.missing_info_id source_record_id
      ,selection_txn_id selection_transaction_id      
      ,smi.missing_info_type_cd
      ,mit.description missing_info_type
      ,NULL enrollment_error_code_id
      ,smi.create_ts date_created
      ,NULL rejection_error_reason_id
      ,smd.supplemental_info
      ,trunc(smd.create_ts) record_date
      ,TO_CHAR(smd.create_ts, 'hh24mi') record_time
      ,smd.created_by record_name
      ,smi.created_by
      ,NULL send_in_letter_ind          
      ,smd.error_code enrollment_error_code
      ,smd.denial_error_cd rejection_code
      FROM selection_txn st
  INNER JOIN selection_missing_info smi
    ON st.missing_info_id = smi.missing_info_id
  LEFT OUTER JOIN selection_missing_info_details smd
    ON smi.missing_info_id = smd.missing_info_id
    AND st.client_id = smd.client_id
  LEFT OUTER JOIN enum_missing_info_type mit
    ON smi.missing_info_type_cd = mit.value