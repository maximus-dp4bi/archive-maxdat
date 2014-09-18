update bpm_attribute_staging_table set ba_id = 563 where bast_id = (select bast_id from bpm_attribute_staging_table where bsl_id = 9 and staging_table_column = 'INSTANCE_COMPLETE_DT');
      
update bpm_attribute_staging_table set ba_id = 562 where bast_id =  (select bast_id from bpm_attribute_staging_table where bsl_id = 9 and staging_table_column = 'INSTANCE_STATUS');
    

update bpm_update_event_queue set process_bueq_id = null  where bsl_id = 9 and process_bueq_id is not null;

commit;