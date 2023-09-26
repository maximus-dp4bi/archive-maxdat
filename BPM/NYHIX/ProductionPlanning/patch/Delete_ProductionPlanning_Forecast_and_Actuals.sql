--Delete Actuals
delete from pp_f_actuals where 1=1;
delete from pp_d_actual_details where 1=1;

--Delete Forecast
delete from PP_F_FORECAST  where 1=1;
delete from PP_D_PRODUCTION_PLAN_HORIZON where 1=1;
delete from PP_STG_FORECAST where 1=1;
delete from PP_CFG_HORIZON where 1=1;
delete from pp_stg_fcst_by_inv_age where 1=1;
delete from pp_stg_fcst_volume where 1=1;

commit;

/
