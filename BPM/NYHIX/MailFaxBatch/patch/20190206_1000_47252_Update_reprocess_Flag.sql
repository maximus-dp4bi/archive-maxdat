update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('803035-1/30/2019-10:54:50 AM-150802');

commit;