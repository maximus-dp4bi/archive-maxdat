
update pp_d_project
set project_name = 'Eligibility Project';

update pp_d_project
set project_name = 'Eligibility Project';

update PP_CFG_PROJECT_CONFIG
set project_name = 'Eligibility Project'
;

update PP_CFG_PRODUCTION_PLAN
set production_plan_name = 'ELIG_PROJECT_PROD_PLAN'
   ,production_plan_description = 'Eligibility Project Production Planning'
   ;

update PP_D_PRODUCTION_PLAN
set production_plan_name = 'ELIG_PROJECT_PROD_PLAN'
   ,production_plan_description = 'Eligibility Project Production Planning'
   ;
   
update  PP_CFG_PROGRAM_CONFIG
set program_name = 'Eligibility Project';

commit;