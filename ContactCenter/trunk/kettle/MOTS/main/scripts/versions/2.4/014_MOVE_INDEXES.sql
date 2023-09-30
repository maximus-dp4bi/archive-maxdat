-- move indexes to the MOTS_INDEX tablespace
ALTER INDEX CC_D_ACTIVITY_TYPE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_AGENT__IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_AGENT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_AVAILABILITY_TYPE__IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_CONTACT_QUEUE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_COUNTRY_NAME_UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_COUNTRY_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES_D_DATE_UIX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES_D_WEEK_OF_MONTH_IX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES_MONTH_NAME_IX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DATES__UNV2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DISTRICT_NAME_UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_DISTRICT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_FORECAST_NOTES_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_GROUP__IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_GROUP__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_INTERVAL_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_INTERVAL__IDXV2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_INTERVAL__IDXV3 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_INTERVAL__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PP_HRZN_D_PP_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PRODUCTION_PLAN_HRZN_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PRODUCTION_PLAN_HRZN__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PRODUCTION_PLAN_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PRODUCTION_PLAN__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROD_PLANNING_TARGET_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROD_PLANNING_TARGET__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROD_PLAN_D_GEO_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROD_PLAN_D_PRG_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROD_PLAN_D_PRJ_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROJECT_TARGETS_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROJECT_TARGETS__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROJECT__IDXV1 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROVINCE_NAME_UK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_PROVINCE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_REGION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_REGION_UNK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_SELF_SERVICE_PATH_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_SELF_SERVICE_PATH__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_SITE__IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_SITE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_STATE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_STATE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_TARGET_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_UNIT_OF_WORK_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_D_UNIT_OF_WORK_UK1 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX3 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX4 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX5 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX6 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_IDX7 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_IVR_INTERVAL__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_QUEUE_INTERVAL_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX3 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX4 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX5 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX6 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX7 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX8 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL_IDX9 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_ACTUALS_Q_INTERVAL__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGENT_BY_DATE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_ACT_TYP_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_AGNT_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_DT_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_GEO_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_GRP_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_PRG_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_AVL_DT_D_PRJ_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_D_AGNT_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_D_DT_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_D_GEO_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_D_GRP_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_D_PRG_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_MNGR_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_PRJ_TRG_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_AGNT_BY_DT_SPRVSR_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FCST_INTERVAL__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FORECAST_INTERVAL_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FORECAST_INTERVAL__IDXV2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FORECAST_INTERVAL__IDXV3 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FORECAST_INTERVAL__IDXV4 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_FORECAST_INTERVAL__IDXV5 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SELF_SERVICE_USAGE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SELF_SVC_USAGE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_DT_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_GEO_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_INT_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_PRG_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_PRJ_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_PTH_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_IVR_SLF_SVC_D_UOW_ID_IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_PROJECT_BY_DATE__IDX REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_F_PROJECT_BY_DATE__IDX2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_ERROR_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_PATCH_LOG_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_PATCH_LOG__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_PATCH_LOG__UNV1 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_TRANSFORMATION_IDX1 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX CC_L_TRANSFORMATION_IDX2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX DATA_TYPE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX DIVISION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_DATA_TYPE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_DATA_TYPE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_DIVISION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_DIVISION__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_GEOGRAPHY_MASTER_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_GEO_MASTER_UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_GEO_MASTER_UN2 REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_METRIC_DEFINITION_NAME__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_METRIC_DEFINITION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_METRIC_DEFINITION__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_METRIC_PROJECT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_METRIC_PROJECT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_PROGRAM_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_PROGRAM__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_PROJECT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_PROJECT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_REPORTING_PERIOD_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_REPORTING_PERIOD__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SEGMENT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SEGMENT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SLA_DEFINITION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SLA_DEFINITION_SLA_NAME__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SLA_PROJECT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX D_SLA_PROJECT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX F_AGENT_ACT_BY_DATE__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX F_METRIC_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX F_METRIC__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX F_SERVICE_LEVEL_AGREEMENT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX F_SERVICE_LEVEL_AGREEMENT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX GEOGRAPHY_MASTER_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX METRIC_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX METRIC_REPORTING_PERIOD_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX METRIC_VALUE_DECIMAL_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX METRIC_VALUE_INTEGER_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX METRIC_VALUE_VARCHAR_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX PROGRAM_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX PROJECT_METRIC_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX PROJECT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX SEGMENT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_METRIC_DEFINITION_UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_METRIC_TEMPLATEV1_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_METRIC_TEMPLATE_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_METRIC_TEMPLATE_UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_SLA_DEFINITION_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_SLA_PROJECT_PK REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_SLA_PROJECT__UN REBUILD TABLESPACE MOTS_INDEX;
ALTER INDEX S_SLA_TEMPLATE_PK REBUILD TABLESPACE MOTS_INDEX;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('2.4',014,'014_MOVE_INDEXES');

commit;