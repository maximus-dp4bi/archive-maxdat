SELECT NULL csda_id
               ,'MEDICAID' managed_care_program  
               ,VALUE csda_code
               ,DESCRIPTION csda_name
               ,NULL region_number_category
               ,CASE WHEN effective_end_date IS NULL THEN 'A' ELSE 'I' END status       
               ,NULL source_record_id
               ,create_ts record_date
               ,TO_CHAR(create_ts,'HH24MI') record_time
               ,created_by record_name                                                     
               ,update_ts modified_date
               ,updated_by modified_name                                      
               ,'N' starplus              
               ,effective_start_date  implementation_date                   
               ,TO_CHAR(update_ts,'HH24MI') modified_time
   FROM enum_district 