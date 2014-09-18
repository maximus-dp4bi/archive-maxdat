alter table f_mfb_by_hour enable row movement;

delete from f_mfb_by_hour where creation_count=0 and inventory_count=1 and completion_count=0;

update f_mfb_by_hour f set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where f.creation_count=1 and not exists (select 1 from f_mfb_by_hour f2 where f2.mfb_bi_id=f.mfb_bi_id and completion_count=1);

update BPM_UPDATE_EVENT_QUEUE set PROCESS_BUEQ_ID = null where bsl_id=16;
commit;

alter table f_mfb_by_hour disable row movement;
