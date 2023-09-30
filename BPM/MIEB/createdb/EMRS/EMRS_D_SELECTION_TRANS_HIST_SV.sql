CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_HIST_SV
AS
select  selection_trans_history_id,
    source_record_id,
    selection_transaction_id,
    selection_status_id,
    date_created,
    record_time,
    record_name,
    created_by,
    record_date,
    status_cd,
    status_cd selection_status_code
--    ,denial_reason_code    
--    ,denial_reason_label
    , edr_code denial_reason_code
    , edr_label denial_reason_label
 from (
  SELECT sth.selection_txn_status_hist_id selection_trans_history_id,
    sth.selection_txn_status_hist_id source_record_id,
    sth.selection_txn_id selection_transaction_id,
    NULL selection_status_id,
    trunc(sth.create_ts) date_created,
    TO_CHAR(sth.create_ts, 'hh24mi') record_time,
    sth.created_by record_name,
    sth.created_by,
    trunc(sth.create_ts) record_date,
    sth.status_cd 
    , dr.denialreason_cd denial_reason_code
    , edr.description denial_reason_label
    , de.edr_code
    , de.edr_label
    , row_number() over(partition by sth.selection_txn_id, sth.status_cd, trunc(sth.create_ts) order by sth.selection_txn_status_hist_id desc) rown
  FROM selection_txn_status_history sth
  left join etl_l_selectionresponse sr on sr.slct_id = sth.selection_txn_id
  left join etl_l_denialreasons dr on dr.etl_l_slctresponse_id = sr.etl_slctresponse_id and dr.denialreason_num = 1
  left join enum_denial_error_code edr on edr.value = dr.denialreason_cd
  left join (select sr.slct_id, LISTAGG(edr.value, ';' on overflow truncate '') WITHIN GROUP (ORDER BY dr.denialreason_num) AS edr_code
            , LISTAGG(edr.report_label, ';' on overflow truncate '') WITHIN GROUP (ORDER BY dr.denialreason_num) AS edr_label 
            , row_number() over (partition by sr.slct_id order by sr.etl_slctresponse_id desc) edr_num
            from etl_l_selectionresponse sr --on sr.slct_id = sth.selection_txn_id
              join etl_l_denialreasons dr on dr.etl_l_slctresponse_id = sr.etl_slctresponse_id
              join enum_denial_error_code edr on edr.value = dr.denialreason_cd
            group by sr.slct_id, sr.etl_slctresponse_id
            ) de on de.slct_id = sth.selection_txn_id and de.edr_num = 1
  WHERE sth.create_ts>add_months(TRUNC(sysdate,'mm'),-12)
)
where rown = 1;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_HIST_SV TO MAXDAT_REPORTS;
