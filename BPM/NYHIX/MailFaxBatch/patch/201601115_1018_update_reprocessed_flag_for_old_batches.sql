select 'Before', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch_stg
where batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';

update maxdat.corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';

select 'After', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch_stg
where batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';

select 'Before', reprocessed_flag, batch_id
from maxdat.corp_etl_mfb_batch
where  batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';

update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where  batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';

select 'After', reprocessed_flag, batch_id
from corp_etl_mfb_batch
where  batch_name ='NYSOH-FAX-NavCAC2016-11-04-17-15-53-395';
commit;
