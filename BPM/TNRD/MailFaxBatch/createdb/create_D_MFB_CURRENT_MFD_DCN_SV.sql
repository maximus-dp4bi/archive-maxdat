CREATE OR REPLACE VIEW D_MFB_CURRENT_MFD_DCN_SV AS
select dd.dcn dcn,
b.mfb_bi_id,
b.kofax_dcn 
FROM D_MFB_CURRENT_SV b
JOIN (SELECT TO_CHAR(d.dcn) dcn     
             ,d.kofax_dcn
      FROM dms_documents_stg d
       INNER JOIN dms_batches_stg b
         ON d.batch_id = b.batch_id 
       INNER JOIN dms_activities_stg da
         ON d.dcn = da.dcn    
      WHERE da.status = 'SUCCESS'
      AND da.activity_type = 'ENVELOPERELEASE'
      AND NOT EXISTS(SELECT 1 FROM document_stg s WHERE TO_CHAR(d.dcn) = s.dcn) 
      UNION ALL
      SELECT ad.dcn  
             ,dd.kofax_dcn kofax_dcn
      FROM app_doc_data_stg ad
       INNER JOIN document_stg d
        ON d.document_id = ad.document_id
      INNER JOIN dms_documents_stg dd
        ON TO_CHAR(dd.dcn) = d.dcn) dd on (b.kofax_dcn = dd.kofax_dcn)
WITH READ ONLY;

grant select on D_MFB_CURRENT_MFD_DCN_SV to MAXDAT_READ_ONLY;