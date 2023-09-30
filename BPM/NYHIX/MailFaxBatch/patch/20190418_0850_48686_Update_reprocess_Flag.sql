alter session set current_schema = MAXDAT;
----  NYHIX-48039/48119/48064
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 1 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 1 records
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-NavCAC2019-04-08-10-33-48-949');




update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/12/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-48686' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/12/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/12/2019', 'mm/dd/yyyy')
where dcn = '18012803';

commit;



