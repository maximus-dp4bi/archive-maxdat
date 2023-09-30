Update corp_etl_mfb_batch
set batch_type ='DOH Manual Notice'
where batch_name like '%DOH%'
;

Commit;

