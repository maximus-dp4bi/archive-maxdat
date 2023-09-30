-- ***** Truncate all tables except these tables ***** --

declare

    cursor c_tables is
    select  at.*
      from  all_tables          at
     where  at.owner        =   (select sys_context( 'userenv', 'current_schema' ) from dual)
       and  (at.owner, at.table_name) not in (select table_owner, table_name from PRESERVE_TBL_DATA_RLD);
/*
                                        'PP_D_STATE', 
                                        'PP_D_UNIT_OF_WORK',
                                        'PP_D_UOW_SOURCE_REF',
                                        'PP_D_PROJECT',
                                        'BPM_PROCESS_LKUP',
                                        'BPM_PROGRAM_LKUP', 
                                        'BPM_PROJECT_LKUP', 
                                        'BPM_REGION_LKUP',
                                        'BPM_SOURCE_LKUP',
                                        'BPM_SOURCE_TYPE_LKUP', 
                                        'BPM_UPDATE_TYPE_LKUP',
                                        'BPM_D_DATES',
                                        'PP_D_PROGRAM',
                                        'PP_D_PROVINCE',
                                        'PP_D_REGION',
                                        'PP_D_SEGMENT',
                                        'PP_D_SITE',
                                        'PP_D_SOURCE',
                                        'PP_D_SOURCE_REF_TYPE',
                                        'PBQJ_ADJUST_REASON_LKUP',
                                        'PROCESS_BPM_QUEUE_JOB_CTRL_CFG',
                                        'PROCESS_BPM_QUEUE_JOB_CONFIG',
                                        'PROCESS_BPM_CALC_JOB_CONFIG',
                                        'MAXDAT_ADMIN_AUDIT_LOGGING',
                                        'PP_D_COUNTRY',
                                        'PP_D_DATES',
                                        'PP_D_DISTRICT',
                                        'PP_D_GEOGRAPHY_MASTER',
                                        'PP_D_HOURS',
                                        'PP_D_PRODUCTION_PLAN',
                                        'BPM_DATATYPE_LKUP',
                                        'BPM_D_HOURS',
                                        'BPM_D_OPS_GROUP_TASK',
                                        'BPM_EVENT_MASTER',
                                        'BPM_IDENTIFIER_TYPE_LKUP',
                                        'D_TASK_TYPES',
                                        'D_TEAMS',
                                        'D_BPM_PROCESS',
                                        'D_BPM_PROCESS_SEGMENT',
                                        'D_BPM_TASK_TYPE_ENTITY',
                                        'D_BPM_FLOW',
                                        'PP_CFG_FORECAST_FILE_CONTROL',
                                        'PP_CFG_GEOGRAPHY_CONFIG',
                                        'PP_CFG_PRODUCTION_PLAN',
                                        'PP_CFG_PROJECT_CONFIG',
                                        'PP_CFG_PROGRAM_CONFIG',
                                        'PP_CFG_SOURCE_CONFIG',
                                        'PP_CFG_UNIT_OF_WORK',
                                        'PP_CFG_ACTUALS_FILE_CONTROL',
                                        'CORP_ETL_CONTROL',
                                        'CORP_ETL_LIST_LKUP',
                                        'CORP_ETL_LIST_LKUP_HIST',
                                        'HOLIDAYS',
                                        'BPM_ACTIVITY_EVENT_TYPE_LKUP',
                                        'BPM_ACTIVITY_TYPE_LKUP',
                                        'BPM_DATA_MODEL',
                                        'D_MW_TASK_TYPE',
                                        'D_BPM_ENTITY',
                                        'D_BPM_ENTITY_TYPE'
                                    );*/
       


    l_row_count                 NUMBER;
    l_sql                       VARCHAR2(1000);
    l_found_tables_with_data    NUMBER;

BEGIN

    l_found_tables_with_data    :=  1;
        
    WHILE (l_found_tables_with_data = 1)
    LOOP
    
        l_found_tables_with_data    :=  0;
    
        FOR t IN c_tables
        LOOP
            l_sql :=
            
            '
            SELECT  COUNT(*)
              FROM  ' || t.owner || '.' || t.table_name ||
            ' 
            WHERE  rownum = 1
            ';
            
            EXECUTE IMMEDIATE l_sql INTO l_row_count;
            
            IF
            (
                NVL(l_row_count, 0) > 0
            )
            THEN

                l_found_tables_with_data    :=  1;
        
                BEGIN        
                    l_sql   := 'TRUNCATE TABLE ' || t.owner || '.' || t.table_name;
                    EXECUTE IMMEDIATE l_sql;
                EXCEPTION
                    WHEN    OTHERS
                    THEN    BEGIN
                                l_sql   := 'DELETE FROM ' || t.owner || '.' || t.table_name;
                                EXECUTE IMMEDIATE l_sql;
                            EXCEPTION
                                WHEN    OTHERS
                                THEN    NULL;
                            END;

                END;
                
                COMMIT;
                
            END IF;
            
        END LOOP;     

    END LOOP;

END;

