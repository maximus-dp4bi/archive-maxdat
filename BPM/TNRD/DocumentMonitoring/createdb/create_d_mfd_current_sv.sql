
CREATE OR REPLACE VIEW d_mfd_current_old_sv AS
SELECT
dcn
,create_dt
,received_dt
,doc_type_cd
,page_count
,ecn
,kofax_dcn
,batch_id
,batch_name
,channel
,doc_status_cd
,doc_status_dt
,doc_update_dt
,doc_updated_by_staff_id
,priority
,app_doc_data_id
,form_type_cd
,scan_dt
,release_dt
,maxe_origination_dt
,rescanned_ind
,return_mail_ind
,return_mail_reason
,rescan_count
,note_id
,expedited_ind
,research_requested_ind
,orig_doc_type_cd
,orig_doc_form_type_cd
,trashed_doc_ind
,trashed_by
,trashed_dt
,form_type
,link_id
,linked_client
,auto_linked_ind
,link_dt
,timeliness_days
,timeliness_days_type
,jeopardy_days
,jeopardy_days_type
,CASE WHEN scan_dt IS NULL THEN TRUNC(sysdate) - COALESCE(facility_receipt_date,TRUNC(received_dt))
    ELSE COALESCE(TRUNC(scan_dt),TRUNC(SYSDATE)) - COALESCE(facility_receipt_date,TRUNC(received_dt)) END curr_age_in_calendar_days
,CASE WHEN scan_dt IS NULL THEN BPM_COMMON.BUS_DAYS_BETWEEN (COALESCE(facility_receipt_date,TRUNC(received_dt)),TRUNC(sysdate))
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(COALESCE(facility_receipt_date,TRUNC(received_dt)) ,TRUNC(scan_dt)) END curr_age_in_business_days    
,CASE WHEN scan_dt IS NOT NULL THEN 'NA' ELSE
  CASE WHEN jeopardy_days_type IS NULL THEN 'NA'
       WHEN jeopardy_days_type = 'B' THEN 
         CASE WHEN BPM_COMMON.BUS_DAYS_BETWEEN( COALESCE(facility_receipt_date,TRUNC(received_dt)), TRUNC(sysdate)) >= jeopardy_days 
           THEN 'Y' ELSE 'N' END
       WHEN jeopardy_days_type = 'C' THEN  
         CASE WHEN TRUNC(sysdate) - COALESCE(facility_receipt_date,TRUNC(received_dt)) >= jeopardy_days THEN 'Y' ELSE 'N' END END
 END curr_jeopardy_flag  
,CASE WHEN scan_dt IS NULL THEN 'Not Processed' ELSE
  CASE WHEN timeliness_days_type IS NULL THEN 'Not Required'
       WHEN timeliness_days_type = 'B' THEN 
         CASE WHEN BPM_COMMON.BUS_DAYS_BETWEEN( COALESCE(facility_receipt_date,TRUNC(received_dt)) , TRUNC(scan_dt)) <= timeliness_days 
           THEN 'Timely' ELSE 'Untimely' END
       WHEN timeliness_days_type = 'C' THEN  
         CASE WHEN TRUNC(scan_dt) - COALESCE(facility_receipt_date,TRUNC(received_dt)) <= timeliness_days THEN 'Timely' ELSE 'Untimely' END END
 END curr_timeliness_status      
,instance_status
,complete_dt
,cancel_dt
,cancel_reason
,cancel_method
,auto_populate
,kofax_station_id
,CASE WHEN scan_dt IS NULL THEN 'Not Processed' ELSE
   CASE WHEN link_sla_days_type = 'B' THEN
     CASE WHEN processed_dt IS NULL THEN 'Not Linked' ELSE
        CASE WHEN link_business_days_age <= link_sla_days THEN 'Timely' ELSE 'Untimely' END END 
   ELSE
     CASE WHEN processed_dt IS NULL THEN 'Not Linked' ELSE
        CASE WHEN link_calendar_days_age <= link_sla_days THEN 'Timely' ELSE 'Untimely' END END 
   END 
  END link_sla_timeliness
,link_business_days_age
,link_calendar_days_age
,link_sla_days
,linked_by  
,recipient_id
,ds_task_complete_date
,processed_dt
,processed_month
,cycle_start_date
,cycle_start_month
,CASE WHEN scan_dt IS NULL THEN 'NA' ELSE
   CASE WHEN jeopardy_days_type = 'B' THEN
     CASE WHEN processed_dt IS NOT NULL THEN 'NA' ELSE
        CASE WHEN link_business_days_age >= link_jeopardy_days THEN 'Y' ELSE 'N' END END 
   ELSE
     CASE WHEN processed_dt IS NOT NULL THEN 'NA' ELSE
        CASE WHEN link_calendar_days_age <= link_jeopardy_days THEN 'Y' ELSE 'N' END END 
   END 
  END link_jeopardy_status
,scan_processed_month
,COALESCE(facility_receipt_date,TRUNC(received_dt)) facility_receipt_date
,ds_task_type
,business_unit_name
,folsom_receipt_date
FROM
(
SELECT TO_CHAR(d.dcn) dcn
       ,d.creation_date create_dt
       ,d.date_received received_dt
       ,COALESCE(d.form_type,'N/A') doc_type_cd
       ,d.number_of_pages page_count
       ,COALESCE(TO_CHAR(d.ecn),'N/A')	ecn
       ,d.kofax_dcn
       ,b.batch_id batch_id
       ,(SELECT MAX(batch_name) FROM kofax_maxdat_reporting_stg k WHERE k.kofax_dcn = d.kofax_dcn) batch_name
       ,CASE WHEN b.source = 'SCAN' THEN 'Mail'
             WHEN b.source = 'FAX' THEN 'Fax'
        ELSE b.source END channel
       ,'IN DMS' doc_status_cd
       ,d.creation_date doc_status_dt
       ,null doc_update_dt
       ,null doc_updated_by_staff_id
       ,null priority
       ,null app_doc_data_id
       ,null form_type_cd
       ,null scan_dt
       ,null release_dt       
       ,null maxe_origination_dt
       ,null rescanned_ind
       ,null return_mail_ind
       ,null return_mail_reason
       ,null rescan_count
       ,null note_id
       ,null expedited_ind
       ,null research_requested_ind
       ,null orig_doc_type_cd
       ,null orig_doc_form_type_cd
       ,null trashed_doc_ind
       ,null trashed_by
       ,null trashed_dt
       ,null form_type
       ,null link_id
       ,null linked_client
       ,null auto_linked_ind
       ,null link_dt             
       ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_TIMELINESS_DAYS' AND value = 'APPLICATION') timeliness_days
       ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_TIMELINESS_DAYS_TYPE' AND value = 'APPLICATION') timeliness_days_type      
       ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_JEOPARDY_DAYS' AND value = 'APPLICATION') jeopardy_days
       ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_JEOPARDY_DAYS_TYPE' AND value = 'APPLICATION') jeopardy_days_type         
       ,'Active' instance_status
       ,null complete_dt
       ,null cancel_dt
       ,null cancel_reason
       ,null cancel_method
       ,null auto_populate
       ,b.scan_station kofax_station_id
       ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_SLA_DAYS' AND value = 'LINK') link_sla_days   
       ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_SLA_DAYS_TYPE' AND value = 'LINK') link_sla_days_type           
       ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_JEOPARDY_DAYS' AND value = 'LINK') link_jeopardy_days   
       ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_JEOPARDY_DAYS_TYPE' AND value = 'LINK') link_jeopardy_days_type 
       ,null link_business_days_age
       ,null link_calendar_days_age
       ,null linked_by
       ,null recipient_id
       ,null ds_task_complete_date
       ,null processed_dt
       ,null processed_month
       ,null cycle_start_date
       ,null cycle_start_month
       ,null scan_processed_month
       ,TRUNC(d.date_received) facility_receipt_date
       ,null ds_task_type
       ,null business_unit_name
       ,null folsom_receipt_date
FROM dms_documents_stg d
  INNER JOIN dms_batches_stg b
    ON d.batch_id = b.batch_id 
  INNER JOIN dms_activities_stg da
    ON d.dcn = da.dcn    
WHERE da.status = 'SUCCESS'
AND da.activity_type = 'ENVELOPERELEASE'
AND NOT EXISTS(SELECT 1 FROM document_stg s WHERE TO_CHAR(d.dcn) = s.dcn)    
UNION
SELECT
  ad.dcn
  ,ad.create_ts create_dt
  ,ad.received_date received_dt
  ,ad.document_type_cd doc_type_cd
  ,d.page_count page_count
  ,TO_CHAR(ad.ecn) ecn  
  ,dd.kofax_dcn kofax_dcn
  ,dd.batch_id batch_id
  ,(SELECT MAX(batch_name) FROM kofax_maxdat_reporting_stg k WHERE k.kofax_dcn = dd.kofax_dcn) batch_name
  ,CASE WHEN ds.doc_source_cd IN('MAIL','SCAN') THEN 'Mail'
        WHEN ds.doc_source_cd = 'FAX' THEN 'Fax'
   ELSE ds.doc_source_cd END channel 
  ,ad.status_cd doc_status_cd
  ,ad.status_ts doc_status_dt  
  ,dl.update_ts doc_update_dt
  ,dl.updated_by doc_updated_by_staff_id
  ,ad.priority
  ,ad.app_doc_data_id
  ,ad.document_sub_type form_type_cd
  ,d.scan_date scan_dt
  ,d.release_date release_dt
  ,ad.create_ts maxe_origination_dt
  ,CASE WHEN d.rescan_ind = 0 THEN 'N' ELSE 'Y' END rescanned_ind
  ,CASE WHEN d.return_mail_ind = 0 THEN 'N' ELSE 'Y' END return_mail_ind
  ,d.return_mail_reason_cd return_mail_reason
  ,d.rescan_count
  ,d.note_ref_id note_id
  ,CASE WHEN d.expedited_ind = 0 THEN 'N' ELSE 'Y' END expedited_ind
  ,CASE WHEN d.research_requested_ind = 0 THEN 'N' ELSE 'Y' END research_requested_ind
  ,d.orig_doc_type_cd
  ,d.orig_doc_form_type orig_doc_form_type_cd
  ,CASE WHEN d.trashed_doc_ind = 0 THEN 'N' ELSE 'Y' END  trashed_doc_ind
  ,d.last_trashed_by trashed_by
  ,d.last_trashed_ts trashed_dt
  ,COALESCE((SELECT report_label FROM document_type_lkup t WHERE t.value = ad.document_type_cd)
             ,(SELECT report_label FROM document_type_lkup t WHERE t.value = ad.document_sub_type), ad.document_sub_type) form_type
  ,dl.doc_link_id link_id
  ,dl.client_id linked_client
  ,CASE WHEN dl.auto_linked_ind = 1 THEN 'Y' 
        WHEN dl.auto_linked_ind = 0 THEN 'N'
   ELSE null END auto_linked_ind
   ,dl.create_ts link_dt     
   ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_TIMELINESS_DAYS' AND value = 'APPLICATION') timeliness_days
   ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_TIMELINESS_DAYS_TYPE' AND value = 'APPLICATION') timeliness_days_type    
   ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_JEOPARDY_DAYS' AND value = 'APPLICATION') jeopardy_days
   ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_JEOPARDY_DAYS_TYPE' AND value = 'APPLICATION') jeopardy_days_type  
   ,CASE WHEN ad.status_cd IN('LINKED') THEN 'Complete' ELSE 'Active' END instance_status
   ,CASE WHEN ad.status_cd IN('LINKED') THEN ad.status_ts ELSE null END complete_dt
   ,CASE WHEN ad.status_cd IN('TRASH','DELETED') THEN d.last_trashed_ts ELSE null END cancel_dt
   ,CASE WHEN ad.status_cd IN('TRASH','DELETED') THEN 'Deleted(Trashed)' ELSE null END cancel_reason
   ,CASE WHEN ad.status_cd IN('TRASH','DELETED') THEN 'Normal' ELSE null END cancel_method  
   ,CASE WHEN ad.barcode_data IS NOT NULL AND dl.updated_by < 0 THEN 'Y' ELSE 'N' END auto_populate
   ,ds.scan_station kofax_station_id
   ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_SLA_DAYS' AND value = 'LINK') link_sla_days   
   ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_SLA_DAYS_TYPE' AND value = 'LINK') link_sla_days_type    
   ,(SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_JEOPARDY_DAYS' AND value = 'LINK') link_jeopardy_days   
   ,(SELECT out_var FROM corp_etl_list_lkup WHERE name = 'MFD_LINKING_JEOPARDY_DAYS_TYPE' AND value = 'LINK') link_jeopardy_days_type    
   ,CASE WHEN d.scan_date IS NULL THEN NULL
      ELSE BPM_COMMON.BUS_DAYS_BETWEEN(TRUNC(d.scan_date),COALESCE(TRUNC(LEAST(COALESCE(dl.create_ts,ds_task_complete_date),COALESCE(ds_task_complete_date,dl.create_ts))),TRUNC(sysdate)) ) END link_business_days_age 
   ,CASE WHEN d.scan_date IS NULL THEN NULL 
      ELSE COALESCE(TRUNC(LEAST(COALESCE(dl.create_ts,ds_task_complete_date),COALESCE(ds_task_complete_date,dl.create_ts))),TRUNC(sysdate)) - TRUNC(d.scan_date) END link_calendar_days_age
   ,ss.first_name||' '||ss.last_name linked_by 
   --,ai.client_cin recipient_id
  -- ,(SELECT client_cin FROM app_individual_stg ai WHERE ai.application_id = ad.application_id AND ai.client_id = dl.client_id) recipient_id
   ,clnt_cin recipient_id
   ,ds_task_complete_date
   ,TRUNC(LEAST(COALESCE(dl.create_ts,ds_task_complete_date),COALESCE(ds_task_complete_date,dl.create_ts))) processed_dt
   ,TRUNC(LEAST(COALESCE(dl.create_ts,ds_task_complete_date),COALESCE(ds_task_complete_date,dl.create_ts)),'mm') processed_month
   ,TRUNC(d.scan_date) cycle_start_date
   ,TRUNC(d.scan_date,'mm') cycle_start_month
   ,TRUNC(d.scan_date,'mm') scan_processed_month
   ,TRUNC(facility_receipt_date) facility_receipt_date   
   ,ds_task_type
   ,business_unit_name
   ,TRUNC(facility_receipt_date) folsom_receipt_date
FROM app_doc_data_stg ad
  INNER JOIN document_stg d
     ON d.document_id = ad.document_id
  INNER JOIN dms_documents_stg dd
    ON TO_CHAR(dd.dcn) = d.dcn   
  LEFT OUTER JOIN (SELECT ds.*, to_date(df.value,'mm/dd/yyyy') facility_receipt_date
                   FROM document_set_stg ds
                     LEFT JOIN doc_flex_field_stg df ON ds.document_set_id = df.document_set_id
                       AND name = 'Folsom_Receipt_Date'  ) ds                     
    ON ds.document_set_id = d.document_set_id
  LEFT OUTER JOIN doc_link_stg dl
    ON dl.document_id = d.document_id 
    AND dl.link_type_cd = 'APPLICATION'    
    AND dl.link_ref_id = ad.application_id
  LEFT OUTER JOIN d_staff ss 
    ON dl.created_by = ss.staff_id
  --LEFT JOIN app_individual_stg ai
  --  ON ad.application_id = ai.application_id
  --  AND dl.client_id = ai.client_id    
  LEFT JOIN client_stg clnt ON clnt.client_id = dl.client_id
  LEFT JOIN (SELECT ref_id document_set_id, i.step_instance_id de_task_id, i.completed_ts ds_task_complete_date,dt.task_name ds_task_type,bu.business_unit_name
                    ,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY i.completed_ts) dsrn
             FROM step_instance_stg i                        
                JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                LEFT JOIN d_business_units bu ON bu.business_unit_id = i.group_id
             WHERE ref_type = 'DOCUMENT_SET_ID'             
             AND status = 'COMPLETED'
             AND i.completed_ts IS NOT NULL
                        ) dstask
    ON dstask.document_set_id = ds.document_set_id
    AND ds_task_complete_date >= d.scan_date
    AND dsrn = 1    
    );
    
GRANT SELECT ON d_mfd_current_old_sv TO MAXDAT_READ_ONLY; 