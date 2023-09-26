select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');
					 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-NavCAC2016-11-21-16-48-24-500',
                     '441008-11/23/2016-11:02:30 AM-125350');
commit;
