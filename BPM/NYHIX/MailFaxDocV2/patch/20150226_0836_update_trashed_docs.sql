update NYHIX_ETL_MAIL_FAX_DOC_V2
set CANCEL_DT  = trashed_dt
 ,CANCEL_BY = trashed_by
 ,ASF_CANCEL_DOC = 'Y'
 ,CANCEL_REASON = 'Deleted (Trashed)'
 ,CANCEL_METHOD = 'Normal'
 ,INSTANCE_STATUS = 'Complete'
 ,INSTANCE_END_DATE = trashed_dt
 where doc_status_cd = 'TRASHED';
 
 commit;
 