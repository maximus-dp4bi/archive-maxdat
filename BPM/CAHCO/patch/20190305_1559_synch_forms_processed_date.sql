 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  hco_d_form s
   USING (select *
          from (
            SELECT dcn,processed_date, date_form_received,reference_type,record_date,
              CASE WHEN reference_type = 'OCRRECORD' THEN record_date
                   WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                   WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
            ELSE processed_date END new_processed_date,form_type
          FROM hco_d_form)
          where processed_date != new_processed_date
          and reference_type = 'OCRRECORD') t ON (s.dcn = t.dcn)
     WHEN matched then update
       set processed_date = t.new_processed_date;
       
 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  hco_d_form s
   USING (select *
          from (
            SELECT dcn,processed_date, date_form_received,reference_type,record_date,manual_enr_create_date,
              CASE WHEN reference_type = 'OCRRECORD' THEN record_date
                    WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                    WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
              ELSE processed_date END new_processed_date,form_type
             FROM hco_d_form
            WHERE reference_type != 'OCRRECORD'
            AND manual_enr_create_date IS NOT NULL)
          where processed_date != new_processed_date) t ON (s.dcn = t.dcn)
     WHEN matched then update
       set processed_date = t.new_processed_date;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  hco_d_form s
   USING (select *
          from (
            SELECT d.dcn,d.enrollment_id, d.processed_date,GREATEST(COALESCE(s.transaction_date,s.modified_date),s.modified_date) new_processed_date,form_type,d.selection_source_code
            FROM hco_d_form d  
              JOIN emrs_d_selection_trans s ON d.enrollment_id = s.selection_transaction_id
            WHERE reference_type = 'ENROLLMENT'
            AND processed_date < date_form_received) ) t ON (s.dcn = t.dcn)
     WHEN matched then update
       set processed_date = t.new_processed_date;      
       
COMMIT;       