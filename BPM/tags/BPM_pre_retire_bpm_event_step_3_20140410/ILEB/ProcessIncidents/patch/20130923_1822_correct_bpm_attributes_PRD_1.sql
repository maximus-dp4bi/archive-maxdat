
delete from bpm_update_event
where bi_id in (select bi_id from bpm_instance
where identifier in ('403402','403407')
and bsl_id=10);

delete from bpm_instance
where identifier in ('403402','403407')
and bsl_id=10;

commit;