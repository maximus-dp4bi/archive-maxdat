UPDATE bpm_d_process_group
   SET group_name = 'BATCH_TYPE'
     , label = 'Mail Fax Batch Types'
   WHERE group_name = 'BATCH_CLASS';

commit;