update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('765639-11/7/2018-8:37:22 AM-89436');

commit;