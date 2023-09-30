select count(*) from nyec_etl_monitor_renewal
where AGE_IN_BUSINESS_DAYS <0;
--
update nyec_etl_monitor_renewal
set AGE_IN_BUSINESS_DAYS = 0
where AGE_IN_BUSINESS_DAYS <0;
--
commit;
--**************************************
select count(*) from nyec_etl_process_mi
where AGE_IN_BUSINESS_DAYS <0;
--
update nyec_etl_process_mi
set AGE_IN_BUSINESS_DAYS = 0
where AGE_IN_BUSINESS_DAYS <0;
--
commit;
--**************************************
select count(*) from nyec_etl_process_mi
where MI_CYCLE_BUS_DAYS <0;
--
update nyec_etl_process_mi
set MI_CYCLE_BUS_DAYS = 0
where MI_CYCLE_BUS_DAYS <0;
--
commit;

