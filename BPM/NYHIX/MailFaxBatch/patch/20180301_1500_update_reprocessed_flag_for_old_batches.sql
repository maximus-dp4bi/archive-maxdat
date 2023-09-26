alter session set current_schema = MAXDAT;
----  NYHIX-38553, NYHIX-38544, NYHIX-38655 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005');


commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005');




update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-2/26/2018-12:06:44 PM',
'667788-2/23/2018-7:25:32 PM-147036',
'667277-2/22/2018-3:56:08 PM-139890',
'666738-2/21/2018-4:11:27 PM-139890',
'668603-2/27/2018-2:15:45 PM-149459',
'668406-2/27/2018-9:53:33 AM-134005');





 