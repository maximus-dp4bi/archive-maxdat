--Reload June 10 2015 data

delete from d_mw_v2_history
where mw_bi_id in (select mw_bi_id from d_mw_v2_current where trunc(create_date) = to_date('06/10/2015','mm/dd/yyyy'));

delete from d_mw_v2_current
where trunc(create_date) = to_date('06/10/2015','mm/dd/yyyy');

commit;

delete from corp_etl_mw_v2
where trunc(create_date) = to_date('06/10/2015','mm/dd/yyyy');

commit;

Update step_instance_stg
     Set MW_V2_PROCESSED = 'N'
Where trunc(create_ts) = to_date('06/10/2015','mm/dd/yyyy');

commit;

