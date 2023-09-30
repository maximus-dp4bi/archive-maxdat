alter session set current_schema = MAXDAT;
----  NYHIX-42297
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-7/17/2018-10:34:41 AM','721065-7/17/2018-10:12:00 AM-149459','720982-7/17/2018-8:53:29 AM-89436');
