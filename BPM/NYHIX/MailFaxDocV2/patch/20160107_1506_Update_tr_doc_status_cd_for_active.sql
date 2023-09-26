update nyhix_etl_mail_fax_doc_v2 v
set tr_doc_status_cd = (select distinct d.TR_DOC_STATUS_CD from document_stg D where v.DCN = d.DCN)
WHERE v.TR_DOC_STATUS_CD IS NULL
and v.instance_status = 'Active'
;


