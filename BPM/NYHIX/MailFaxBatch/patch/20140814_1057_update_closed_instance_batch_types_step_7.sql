update corp_etl_mfb_batch
set batch_type='Undetermined'
where instance_status='Active' 
  and batch_type not in(
    'Application Only',
    'Application + Other Docs',
    'Renewal Only',
    'Renewal + Other Docs',
    'Other Docs Only',
    'Undetermined');
commit;
