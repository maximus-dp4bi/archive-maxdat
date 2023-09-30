MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (select ah.application_id,doc_link_id,rcvd_90day_indicator
         from app_header_stg ah
           join d_mi_processing_timeliness t on ah.application_id = t.application_id
           ) tmp on(s.application_id = tmp.application_id and s.doc_link_id = tmp.doc_link_id)
  when matched then update          
    set rcvd_during_90day_prd = tmp.rcvd_90day_indicator;

commit;

MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (select ah.application_id,rcvd_90day_indicator
         from app_header_stg ah
           join d_app_processing_timeliness t on ah.application_id = t.application_id
           ) tmp on(s.application_id = tmp.application_id)
  when matched then update          
    set rcvd_during_90day_prd = tmp.rcvd_90day_indicator;

commit;