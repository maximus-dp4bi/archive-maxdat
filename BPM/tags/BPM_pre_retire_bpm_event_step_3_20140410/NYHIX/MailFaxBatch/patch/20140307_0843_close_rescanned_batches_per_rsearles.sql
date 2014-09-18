update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A'
where batch_complete_dt is null and cancel_dt is null and complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-MAIL - 2/20/2014 - 3:49:11 PM - 59152-62781',
'NYSOH-MAIL - 2/20/2014 - 3:30:28 PM - 59152-62739',
'NYSOH-MAIL - 2/10/2014 - 2:30:26 PM - 59152-51238',
'NYSOH-MAIL - 2/12/2014 - 4:14:45 PM - 63312-54514',
'NYSOH-MAIL - 2/12/2014 - 1:37:02 PM - 63312-54227',
'NYSOH-MAIL - 2/19/2014 - 10:37:45 AM - 62819-60111',
'NYSOH-MAIL - 2/24/2014 - 10:20:05 AM - 62819-63062',
'NYSOH-MAIL - 2/19/2014 - 10:48:22 AM - 62819-60163',
'NYSOH-MAIL - 2/12/2014 - 2:56:33 PM - 63312-54379',
--'NYSOH-MAIL - 1/17/2014 - 9:49:40 AM - 59152-26826',
'NYSOH-MAIL - 1/17/2014 - 10:42:46 AM - 62819-26937',
'NYSOH-MAIL - 1/17/2014 - 9:36:28 AM - 62819-26817',
'NYSOH-MAIL - 2/12/2014 - 3:04:16 PM - 63312-54389'
);
commit;
