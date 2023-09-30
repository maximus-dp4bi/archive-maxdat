--Update values for instances already completed

update NYHIX_ETL_MAIL_FAX_DOC 
set current_step = 'End - Document Processed'
where complete_dt is not null;