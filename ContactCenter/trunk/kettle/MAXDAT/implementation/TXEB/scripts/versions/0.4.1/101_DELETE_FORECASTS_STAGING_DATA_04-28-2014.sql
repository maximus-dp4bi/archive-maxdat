delete cc_s_fcst_interval
where production_plan_horizon_id in (
  select production_plan_horizon_id
  from cc_s_production_plan_horizon pph
  inner join cc_s_production_plan pp on pph.production_plan_id = pp.production_plan_id
  where production_plan_name = 'Texas EB CC Tactical'
);


delete cc_s_production_plan_horizon
where production_plan_id in (
  select production_plan_id
  from cc_s_production_plan pp
  where production_plan_name = 'Texas EB CC Tactical'
);

delete cc_s_production_plan
where production_plan_name = 'Texas EB CC Tactical';


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.4.1','101','101_DELETE_FORECASTS_STAGING_DATA_04-28-2014');


commit;