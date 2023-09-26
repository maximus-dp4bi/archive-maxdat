
update corp_etl_list_lkup
set out_var = '6'
where name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'ELIG_NEW_APP';

update corp_etl_list_lkup
set out_var = '7'
where name = 'ManageWork_SLA_Days'
and value = 'ELIG_NEW_APP';

update corp_etl_list_lkup
set out_var = '4'
where name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'DE_NEW_APP';

update corp_etl_list_lkup
set out_var = '5'
where name = 'ManageWork_SLA_Days'
and value = 'DE_NEW_APP';

update corp_etl_list_lkup
set out_var = '2'
where name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'QC';

update corp_etl_list_lkup
set out_var = '3'
where name = 'ManageWork_SLA_Days'
and value = 'QC';



update d_task_types
set sla_days = 7
  ,sla_target_days = 7
  ,sla_jeopardy_days = 6
where task_name = 'ELIG_NEW_APP';  

update d_task_types
set sla_days = 3
  ,sla_target_days = 3
  ,sla_jeopardy_days = 2
where task_name = 'QC'; 

update d_task_types
set sla_days = 5  
   ,sla_target_days = 5
   ,sla_jeopardy_days = 4
where task_name = 'DE_NEW_APP'; 

update PP_CFG_UNIT_OF_WORK
set jeopardy_inv_age = 6
where unit_of_work_name = 'ELIG_NEW_APP';

update PP_CFG_UNIT_OF_WORK
set jeopardy_inv_age = 2
where unit_of_work_name = 'QC';

update PP_CFG_UNIT_OF_WORK
set jeopardy_inv_age = 4
where unit_of_work_name = 'DE_NEW_APP';

update PP_D_UNIT_OF_WORK
set jeopardy_inv_age = 6
where unit_of_work_name = 'ELIG_NEW_APP';

update PP_D_UNIT_OF_WORK
set jeopardy_inv_age = 2
where unit_of_work_name = 'QC';

update PP_D_UNIT_OF_WORK
set jeopardy_inv_age = 4
where unit_of_work_name = 'DE_NEW_APP';

  update D_MW_TASK_INSTANCE
    set
      AGE_IN_BUSINESS_DAYS = mw.GET_AGE_IN_BUSINESS_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      AGE_IN_CALENDAR_DAYS = mw.GET_AGE_IN_CALENDAR_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      JEOPARDY_FLAG = mw.GET_JEOPARDY_FLAG(TASK_TYPE_ID,
                                        CURR_WORK_RECEIPT_DATE,
                                        INSTANCE_END_DATE
                                       ),
      STATUS_AGE_IN_BUS_DAYS = mw.GET_STATUS_AGE_IN_BUS_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      STATUS_AGE_IN_CAL_DAYS = mw.GET_STATUS_AGE_IN_CAL_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      TIMELINESS_STATUS = mw.GET_TIMELINESS_STATUS(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             );

begin
 LOAD_MW_AND_ACTUALS_PKG.BACKFILL_ACTUALS_INV_AGE;
 LOAD_MW_AND_ACTUALS_PKG.BACKFILL_ACTUALS_INV_COUNT;
end;
/

commit;