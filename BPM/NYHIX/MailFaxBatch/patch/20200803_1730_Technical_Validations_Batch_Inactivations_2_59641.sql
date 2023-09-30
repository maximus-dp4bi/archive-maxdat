alter session set current_schema = MAXDAT;
----  NYHIX-59641
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('08/03/2020', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-59641' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' 
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');





