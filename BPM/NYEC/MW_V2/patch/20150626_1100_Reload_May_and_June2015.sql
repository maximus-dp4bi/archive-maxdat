--Reload June/May/Apr 2015 data

delete from d_mw_v2_history
where mw_bi_id in (select mw_bi_id from d_mw_v2_current where trunc(create_date) between to_date('05/18/2015','mm/dd/yyyy') and to_date('06/08/2015','mm/dd/yyyy'));

delete from d_mw_v2_history
where mw_bi_id in (select mw_bi_id from d_mw_v2_current where trunc(create_date) = to_date('05/08/2015','mm/dd/yyyy'));

delete from d_mw_v2_history
where mw_bi_id in (select mw_bi_id from d_mw_v2_current where trunc(create_date) = to_date('04/22/2015','mm/dd/yyyy'));

delete from d_mw_v2_history
where mw_bi_id in (select mw_bi_id from d_mw_v2_current where trunc(create_date) = to_date('04/27/2015','mm/dd/yyyy'));

commit;

delete from d_mw_v2_current
where trunc(create_date) between to_date('05/18/2015','mm/dd/yyyy') and to_date('06/08/2015','mm/dd/yyyy');

delete from d_mw_v2_current
where trunc(create_date) = to_date('05/08/2015','mm/dd/yyyy');

delete from d_mw_v2_current
where trunc(create_date) = to_date('04/22/2015','mm/dd/yyyy');

delete from d_mw_v2_current
where trunc(create_date) = to_date('04/27/2015','mm/dd/yyyy');

commit;

delete from corp_etl_mw_v2
where trunc(create_date) between to_date('05/18/2015','mm/dd/yyyy') and to_date('06/08/2015','mm/dd/yyyy');

delete from corp_etl_mw_v2
where trunc(create_date) = to_date('05/08/2015','mm/dd/yyyy');

delete from corp_etl_mw_v2
where trunc(create_date) = to_date('04/22/2015','mm/dd/yyyy');

delete from corp_etl_mw_v2
where trunc(create_date) = to_date('04/27/2015','mm/dd/yyyy');

commit;

Update step_instance_stg
Set MW_V2_PROCESSED = 'N'
Where trunc(create_ts) between to_date('05/18/2015','mm/dd/yyyy') and to_date('06/08/2015','mm/dd/yyyy');

Update step_instance_stg
Set MW_V2_PROCESSED = 'N'
Where trunc(create_ts) = to_date('05/08/2015','mm/dd/yyyy');

Update step_instance_stg
Set MW_V2_PROCESSED = 'N'
Where trunc(create_ts) = to_date('04/22/2015','mm/dd/yyyy');

Update step_instance_stg
Set MW_V2_PROCESSED = 'N'
Where trunc(create_ts) = to_date('04/27/2015','mm/dd/yyyy');

commit;

