update maxdat.corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2019-01-29-12-00-54-005','804168-1/31/2019-2:14:02 PM-149078');

commit;