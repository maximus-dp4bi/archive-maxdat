UPDATE NYHIX_ETL_MAIL_FAX_DOC_V2
SET instance_status = 'Complete',stg_done_date = stg_last_update_date
WHERE INSTANCE_END_DATE is not null 
AND instance_status = 'Active' ;

update D_NYHIX_MFD_CURRENT_V2
set complete_dt = null, instance_end_date = cancel_dt
where cancel_dt is not null
and complete_dt is not null
and cancel_dt > instance_end_date;

update D_NYHIX_MFD_CURRENT_V2
set complete_dt = null
where cancel_dt is not null
and complete_dt is not null
;

COMMIT;

