-- D_TASK_TYPES

UPDATE  D_TASK_TYPES
   SET  sla_days                =   120,
        sla_target_days         =   120,
        sla_jeopardy_days       =   120
 WHERE  task_type_id            =   16;
                        
COMMIT;

-- Sync CORP_ETL_LIST_LKUP and D_BPM_ENTITY with change.

BEGIN
    CAHCO_ETL_MW_UTIL_PKG.populate_corp_etl_list_lkup;
    CAHCO_ETL_MW_UTIL_PKG.sync_task_type_entity_cfg;
END;
/
