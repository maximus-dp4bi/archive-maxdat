INSERT INTO bpm_d_process_group_detail(
     d_process_definition_id
    ,d_process_group_id
    ,name
    ,label
    ,record_eff_dt
    ,record_end_dt)
  SELECT DISTINCT 
           (SELECT d_process_definition_id FROM bpm_d_process_definition WHERE process_name = 'MAIL_FAX_BATCH')
         , (SELECT d_process_group_id      FROM bpm_d_process_group      WHERE group_name = 'BATCH_TYPE')
         , batch_type
         , batch_type
         , Trunc(sysdate)
         , To_Date('12/31/2099','mm/dd/yyyy')
  FROM d_mfb_current;

COMMIT;
