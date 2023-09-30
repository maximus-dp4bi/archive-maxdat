select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');
commit;

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');
 
select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in  ( '442797-11/30/2016-10:18:42 AM-123207',
                      '443459-12/1/2016-11:38:16 AM-116630',
                      'NYSOH-FAX-HRA2016-11-30-12-06-48-401',
                      'NYSOH-FAX-HRA2016-11-29-12-10-24-368',
                      'NYSOH-FAX-11/30/2016-10:00:55 AM',
                      'NYSOH-FAX-11/30/2016-10:18:42 AM',
                      'NYSOH-FAX-12/1/2016-2:00:01 PM');
commit;
