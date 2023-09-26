update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = 'NYHIX-12350'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name in(
'NYSOH-FAX2014-03-18-00-54-24-34',
'NYSOH-FAX2014-03-13-22-45-15-6',
'NYSOH-FAX2014-03-14-22-45-12-0',
'NYSOH-FAX2014-03-18-00-59-16-33');


update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159583 3/9/2015 2:12:30 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name in('NYSOH-FAX2015-02-28-11-53-45-0',
'NYSOH-FAX2015-02-28-11-34-08-1');


update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159585 3/9/2015 2:17:48 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name in('NYSOH-FAX2015-02-28-12-18-15-0',
'NYSOH-FAX2015-02-28-11-58-35-1',
'NYSOH-FAX2015-02-28-12-28-49-0',
'NYSOH-FAX2015-02-28-12-23-32-0',
'NYSOH-FAX2015-02-28-12-28-49-1',
'NYSOH-FAX2015-02-28-12-53-29-1',
'NYSOH-FAX2015-02-28-12-48-49-0',
'NYSOH-FAX2015-02-28-12-53-29-2',
'NYSOH-FAX2015-02-28-12-48-49-2',
'NYSOH-FAX2015-02-28-12-53-29-4');

update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159594 3/9/2015 2:30:48 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-12-51-15-1';

update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159597 3/9/2015 2:34:05 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-12-36-29-1';


update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159598 3/9/2015 2:37:30 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-12-56-10-1';

update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159600 3/9/2015 2:40:33 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-12-56-10-0';


update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159606 3/9/2015 2:47:25 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-12-21-13-0';

update corp_etl_mfb_batch 
set complete_dt=sysdate
   ,stg_last_update_date=sysdate
   ,stg_done_date = sysdate
   ,instance_status = 'Complete'
   ,cancel_dt = sysdate
   ,cancel_by = '159612 3/9/2015 3:06:34 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where complete_dt is null and instance_status='Active'
and batch_name = 'NYSOH-FAX-NavCAC2015-02-28-11-31-39-2';


update corp_etl_mfb_batch 
set stg_last_update_date=sysdate
   ,cancel_dt = sysdate
   ,cancel_by = '159630 3/9/2015 4:39:52 PM 72387'
   ,cancel_reason = 'Deleted'
   ,cancel_method = 'Exception'
   ,current_step = 'End - Cancelled'
where batch_name = 'NYSOH-FAX-NavCAC2015-03-02-13-50-10-1';

commit;





