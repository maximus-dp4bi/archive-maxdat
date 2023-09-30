delete from bpm_instance_attribute where bi_id in (select bi_id from bpm_instance where bsl_id=16 and identifier in(88,179));
delete from bpm_update_event_queue where identifier in(88,179);
delete from bpm_update_event_queue_archive where identifier in(88,179);
delete from bpm_update_event where bi_id in (select bi_id from bpm_instance where bsl_id=16 and identifier in(88,179));
delete from bpm_instance where identifier in(88,179);

delete from F_MFB_BY_DATE where mfb_bi_id in (1694143,1695020);
delete from d_mfb_current where batch_id in(88,179);

delete from corp_etl_mfb_document_stg where batch_id in(88,179);
delete from corp_etl_mfb_envelope_stg where batch_id in(88,179);
delete from corp_etl_mfb_form_stg where batch_id in(88,179);
delete from corp_etl_mfb_batch_events_stg where batch_id in(88,179);
delete from corp_etl_mfb_batch_ars_stg where batch_id in(88,179);
delete from corp_etl_mfb_batch_stg where batch_id in(88,179);

delete from corp_etl_mfb_document where batch_id in(88,179);
delete from corp_etl_mfb_envelope where batch_id in(88,179);
delete from corp_etl_mfb_form where batch_id in(88,179);
delete from corp_etl_mfb_batch_events where batch_id in(88,179);
delete from corp_etl_mfb_batch where batch_id in(88,179);
commit;



