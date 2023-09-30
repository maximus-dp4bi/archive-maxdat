SELECT selection_txn_status_hist_id selection_trans_history_id,
 selection_txn_status_hist_id source_record_id,
 selection_txn_id selection_transaction_id,
 NULL selection_status_id,
 create_ts date_created,
 TO_CHAR(create_ts, 'hh24mi') record_time,
 created_by record_name,
 created_by,
 create_ts record_date,
 status_cd selection_status_code
FROM selection_txn_status_history
where create_ts>add_months(trunc(sysdate,'mm'),-2)