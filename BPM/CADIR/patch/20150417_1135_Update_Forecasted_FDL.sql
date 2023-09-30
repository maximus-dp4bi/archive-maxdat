update s_forecasted_fdl
set forecasted_fdl = 15000
where forecast_month = to_date('03/01/2015','mm/dd/yyyy');

update s_forecasted_fdl
set forecasted_fdl = 15000
where forecast_month = to_date('04/01/2015','mm/dd/yyyy');

update s_forecasted_fdl
set forecasted_fdl = 12258
where forecast_month = to_date('05/01/2015','mm/dd/yyyy');

update s_forecasted_fdl
set forecasted_fdl = 13308
where forecast_month = to_date('06/01/2015','mm/dd/yyyy');

commit;