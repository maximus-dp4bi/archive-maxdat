delete from corp_etl_mailfaxdoc;

update corp_etl_control set value = '0' 
where name = 'PM_LAST_DCN';

delete from bpm_logging where bsl_id = 9;

commit;