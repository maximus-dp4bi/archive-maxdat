update corp_etl_mfb_batch set batch_complete_dt=sysdate,stg_last_update_date=sysdate,current_batch_module_id='N/A'
where batch_complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-MAIL - 2/12/2014 - 2:57:15 PM - 59152-54382',
'NYSOH-MAIL - 2/19/2014 - 5:02:38 PM - 59152-61116',
'NYSOH-MAIL - 2/20/2014 - 2:30:13 PM - 62819-62599',
'NYSOH-MAIL - 2/5/2014 - 12:29:45 PM - 62819-46129',
'NYSOH-FAX2014-02-20-15-55-25-12');
commit;





