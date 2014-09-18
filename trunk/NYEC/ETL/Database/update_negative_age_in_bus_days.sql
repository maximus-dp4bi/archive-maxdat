select count(*) from corp_etl_manage_work
where AGE_IN_BUSINESS_DAYS < 0;

update corp_etl_manage_work
set AGE_IN_BUSINESS_DAYS = 0
where AGE_IN_BUSINESS_DAYS < 0;

select count(*) from corp_etl_manage_work
where STATUS_AGE_IN_BUS_DAYS < 0;

update corp_etl_manage_work
set STATUS_AGE_IN_BUS_DAYS = 0
where  STATUS_AGE_IN_BUS_DAYS < 0;

commit;
