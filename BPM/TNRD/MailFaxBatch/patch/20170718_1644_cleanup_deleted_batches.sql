 update corp_etl_mfb_batch
 set instance_status = 'Complete'
     ,instance_status_dt = sysdate
     ,complete_dt = sysdate
     ,cancel_dt = sysdate
     ,stg_done_date = sysdate
     ,cancel_reason = 'TNERPS-2684'
     ,cancel_by = 'TNERPS-2684'
     ,cancel_method = 'Normal'
 where batch_guid IN('{5fff6797-2d96-43e3-ade9-d34f23c32a01}',
 '{6223ff49-a4eb-4145-8cd3-81d6a81998c7}',
 '{9e3775e4-d7b1-4b73-8d3f-75985c4585c5}',
 '{af0a07ba-bf28-4f4d-b502-f2cd572bf3dc}',
 '{d3843dda-2749-41fa-a845-4137017e0234}',
 '{e80ecf75-8f5a-4fe7-988c-d89e8da2dbbf}');
 
 commit;