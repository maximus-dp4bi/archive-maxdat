update NYHIX_ETL_MAIL_FAX_DOC
set current_step = 'End - Document Processed'
where instance_status = 'Complete';