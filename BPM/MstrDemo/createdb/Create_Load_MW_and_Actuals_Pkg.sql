CREATE OR REPLACE PACKAGE LOAD_MW_AND_ACTUALS_PKG AS
  PROCEDURE LOAD_MW_SIM_DATA;
  PROCEDURE TRUNCATE_ACTUALS_TABLE;
  PROCEDURE LOAD_MW_ARRIVALS;
  PROCEDURE LOAD_MW_COMPLETIONS;
  PROCEDURE LOAD_MW_INVENTORY_JEOPARDY;
  PROCEDURE LOAD_MW_INVENTORY_MINMAX;
  PROCEDURE LOAD_MW_HANDLE_TIME;
  PROCEDURE LOAD_MW_INVENTORY_AVG_AGE;
  PROCEDURE LOAD_MW_STAFF_HOURS;
  PROCEDURE LOAD_MW_ACTUAL_DTL_ARRIVALS;
  PROCEDURE LOAD_MW_ACTUAL_DTL_COMPLETIONS;
  PROCEDURE LOAD_ACTUALS_BACKFILL;
  PROCEDURE BACKFILL_ACTUALS_INV_AGE;
  PROCEDURE BACKFILL_ACTUALS_INV_COUNT;
  PROCEDURE  LOAD_ACTUALS_DATA;
  PROCEDURE POPULATE_PROCESS_INSTANCE;
  PROCEDURE REFRESH_MW_DATA;
END;
/

CREATE OR REPLACE PACKAGE BODY LOAD_MW_AND_ACTUALS_PKG AS

  PROCEDURE LOAD_MW_SIM_DATA AS
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE corp_etl_mw_wip';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE corp_etl_mw';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE D_MW_TASK_HISTORY';
    DELETE FROM D_MW_TASK_INSTANCE;
    
    COMMIT;
    
    INSERT INTO corp_etl_mw_wip (task_id,task_type_id,task_status,create_date,complete_date,instance_start_date,instance_end_date,stage_done_date,status_date,last_update_date,work_receipt_date,claim_date,source_process_instance_id,owner_staff_id,team_id)
    SELECT task_id
      ,task_type_id
      ,task_status
      ,create_date
      ,complete_date
      ,instance_start_date
      ,complete_date instance_end_date
      ,complete_date stage_done_date
      ,status_date
      ,last_update_date
      ,work_receipt_date
      ,claim_date
      ,source_process_instance_id
      ,COALESCE(owner_staff_id,0) owner_staff_id
      ,COALESCE(t.team_id,0) team_id
    FROM arena_task_data ad
     LEFT JOIN arena_staff_stg s ON COALESCE(ad.owner_staff_id,0)  = to_number(s.staff_id)
     LEFT JOIN d_teams t on to_number(s.sup_staff_id) = t.team_supervisor_staff_id  
    ;
    
    INSERT INTO corp_etl_mw (cemw_id,task_id,task_type_id,task_status,create_date,complete_date,instance_start_date,instance_end_date,stage_done_date,status_date,last_update_date,work_receipt_date,claim_date,source_process_instance_id,owner_staff_id,team_id)
    SELECT cemw_id
      ,task_id
      ,task_type_id
      ,task_status
      ,create_date
      ,complete_date
      ,instance_start_date
      ,complete_date instance_end_date
      ,complete_date stage_done_date
      ,status_date
      ,last_update_date
      ,work_receipt_date
      ,claim_date
      ,source_process_instance_id
      ,owner_staff_id
      ,team_id
    FROM corp_etl_mw_wip;
    
    COMMIT;
        
    FOR x IN(SELECT data_version,new_data,old_data
             FROM bpm_update_event_queue
             WHERE bsl_id = 2002)
    LOOP         
      MW.INSERT_BPM_SEMANTIC(x.data_version ,x.new_data );
    END LOOP;
    
    DELETE FROM bpm_update_event_queue
    WHERE bsl_id = 2002;
    
    COMMIT;
  END;
  
  PROCEDURE TRUNCATE_ACTUALS_TABLE AS
    BEGIN
      DELETE FROM PP_F_ACTUALS;
      DELETE FROM PP_D_ACTUAL_DETAILS;
      
      COMMIT;    
    END;
  
  --MW Arrivals  
  PROCEDURE LOAD_MW_ARRIVALS AS    
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT X.CREATE_DATE, X.CREATE_HOUR, X.CFG_UOW_ID, X.PROJECT_ID, X.PROGRAM_ID, X.GEOGRAPHY_MASTER_ID,X.CREATION_COUNT, 
            (SELECT ACTUALS_ID FROM PP_F_ACTUALS WHERE D_DATE=X.CREATE_DATE AND D_HOUR=X.CREATE_HOUR AND UOW_ID=X.CFG_UOW_ID AND PROJECT_ID=X.PROJECT_ID AND PROGRAM_ID=X.PROGRAM_ID AND GEOGRAPHY_MASTER_ID=X.GEOGRAPHY_MASTER_ID) AS ACTUALS_ID 
            FROM
            (
            SELECT ARRIVAL.CREATE_DATE,
                                  0 AS CREATE_HOUR,
                                  ARRIVAL.CFG_UOW_ID,
                                  ARRIVAL.CREATION_COUNT,
                                  (SELECT CFG_PROJECT_CONFIG_ID
                                     FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                                  (SELECT CFG_PROGRAM_CONFIG_ID
                                     FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                                  (SELECT CFG_GEOGRAPHY_CONFIG_ID
                                     FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                             FROM (SELECT TRUNC(CREATE_DATE) AS CREATE_DATE,
                                          UOW.CFG_UOW_ID,
                                          COUNT(1) AS CREATION_COUNT
                                     FROM PP_CFG_UNIT_OF_WORK UOW
                                    INNER JOIN PP_D_UOW_SOURCE_REF USR
                                       ON UOW.CFG_UOW_ID = USR.UOW_ID
                                      AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND
                                          USR.END_DATE
                                    INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                       ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                                      AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                                    INNER JOIN PP_D_SOURCE S
                                       ON SRT.SOURCE_ID = S.SOURCE_ID
                                      AND S.SOURCE_NAME = 'MANAGE WORK STG'
                                    INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                                    WHERE MW.CREATE_DATE >= TRUNC(SYSDATE - 730) 
                                      AND UOW.HOURLY_FLAG = 'N'
                                    GROUP BY TRUNC(MW.CREATE_DATE), UOW.CFG_UOW_ID) ARRIVAL
                           UNION ALL
                           SELECT ARRIVAL.CREATE_DATE,
                                  TO_NUMBER(ARRIVAL.CREATE_HOUR),
                                  ARRIVAL.CFG_UOW_ID,
                                  ARRIVAL.CREATION_COUNT,
                                  (SELECT CFG_PROJECT_CONFIG_ID
                                     FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                                  (SELECT CFG_PROGRAM_CONFIG_ID
                                     FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                                  (SELECT CFG_GEOGRAPHY_CONFIG_ID
                                     FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                             FROM (SELECT TRUNC(CREATE_DATE) AS CREATE_DATE,
                                          TO_CHAR(CREATE_DATE, 'HH24') AS CREATE_HOUR,
                                          UOW.CFG_UOW_ID,
                                          COUNT(1) AS CREATION_COUNT
                                     FROM PP_CFG_UNIT_OF_WORK UOW
                                    INNER JOIN PP_D_UOW_SOURCE_REF USR
                                       ON UOW.CFG_UOW_ID = USR.UOW_ID
                                      AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND
                                          USR.END_DATE
                                    INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                       ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                                      AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                                    INNER JOIN PP_D_SOURCE S
                                       ON SRT.SOURCE_ID = S.SOURCE_ID
                                      AND S.SOURCE_NAME = 'MANAGE WORK STG'
                                    INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                                    WHERE MW.CREATE_DATE >= TRUNC(SYSDATE - 730)
                                      AND UOW.HOURLY_FLAG = 'Y'
                                    GROUP BY TRUNC(MW.CREATE_DATE),
                                             TO_CHAR(MW.CREATE_DATE, 'HH24'),
                                             UOW.CFG_UOW_ID) ARRIVAL
            ) X
        ) 
        LOOP
            CASE
                WHEN (RECS.ACTUALS_ID >=0) THEN 
                  UPDATE PP_F_ACTUALS
                     SET ACTL_ARRIVAL = RECS.CREATION_COUNT
                   WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                ELSE 
                  INSERT INTO PP_F_ACTUALS
                    (ACTUALS_ID,
                     D_DATE,
                     D_HOUR,
                     UOW_ID,
                     PROJECT_ID,
                     PROGRAM_ID,
                     GEOGRAPHY_MASTER_ID,
                     ACTL_ARRIVAL)
                  VALUES
                    (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
                     RECS.CREATE_DATE,
                     RECS.CREATE_HOUR,
                     RECS.CFG_UOW_ID,
                     RECS.PROJECT_ID,
                     RECS.PROGRAM_ID,
                     RECS.GEOGRAPHY_MASTER_ID,
                     RECS.CREATION_COUNT);
              END CASE;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Arrivals - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Arrivals - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;

--MW Completions
  PROCEDURE LOAD_MW_COMPLETIONS AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT X.COMPLETE_DATE, X.COMPLETE_HOUR, X.CFG_UOW_ID, X.PROJECT_ID, X.PROGRAM_ID, X.GEOGRAPHY_MASTER_ID,X.COMPLETION_COUNT, 
            (SELECT ACTUALS_ID FROM PP_F_ACTUALS WHERE D_DATE=X.COMPLETE_DATE AND D_HOUR=X.COMPLETE_HOUR AND UOW_ID=X.CFG_UOW_ID AND PROJECT_ID=X.PROJECT_ID AND PROGRAM_ID=X.PROGRAM_ID AND GEOGRAPHY_MASTER_ID=X.GEOGRAPHY_MASTER_ID) AS ACTUALS_ID 
            FROM
            (
            SELECT COMPLETIONS.COMPLETE_DATE,
                                  0 AS COMPLETE_HOUR,
                                  COMPLETIONS.CFG_UOW_ID,
                                  COMPLETIONS.COMPLETION_COUNT,
                                  (SELECT CFG_PROJECT_CONFIG_ID
                                     FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                                  (SELECT CFG_PROGRAM_CONFIG_ID
                                     FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                                  (SELECT CFG_GEOGRAPHY_CONFIG_ID
                                     FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                             FROM (SELECT TRUNC(MW.COMPLETE_DATE) AS COMPLETE_DATE,
                                          UOW.CFG_UOW_ID,
                                          COUNT(1) AS COMPLETION_COUNT
                                     FROM PP_CFG_UNIT_OF_WORK UOW
                                    INNER JOIN PP_D_UOW_SOURCE_REF USR
                                       ON UOW.CFG_UOW_ID = USR.UOW_ID
                                      AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND
                                          USR.END_DATE
                                    INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                       ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                                      AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                                    INNER JOIN PP_D_SOURCE S
                                       ON SRT.SOURCE_ID = S.SOURCE_ID
                                      AND S.SOURCE_NAME = 'MANAGE WORK STG'
                                    INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                                    WHERE MW.COMPLETE_DATE >= TRUNC(SYSDATE - 730) 
                                      AND UOW.HOURLY_FLAG = 'N'
                                    GROUP BY TRUNC(MW.COMPLETE_DATE), UOW.CFG_UOW_ID) COMPLETIONS
                           UNION ALL
                           SELECT COMPLETIONS.COMPLETE_DATE,
                                  TO_NUMBER(COMPLETIONS.COMPLETE_HOUR) AS COMPLETE_HOUR,
                                  COMPLETIONS.CFG_UOW_ID,
                                  COMPLETIONS.COMPLETION_COUNT,
                                  (SELECT CFG_PROJECT_CONFIG_ID
                                     FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                                  (SELECT CFG_PROGRAM_CONFIG_ID
                                     FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                                  (SELECT CFG_GEOGRAPHY_CONFIG_ID
                                     FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                             FROM (SELECT TRUNC(COMPLETE_DATE) AS COMPLETE_DATE,
                                          TO_CHAR(COMPLETE_DATE, 'HH24') AS COMPLETE_HOUR,
                                          UOW.CFG_UOW_ID,
                                          COUNT(1) AS COMPLETION_COUNT
                                     FROM PP_CFG_UNIT_OF_WORK UOW
                                    INNER JOIN PP_D_UOW_SOURCE_REF USR
                                       ON UOW.CFG_UOW_ID = USR.UOW_ID
                                      AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND
                                          USR.END_DATE
                                    INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                       ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                                      AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                                    INNER JOIN PP_D_SOURCE S
                                       ON SRT.SOURCE_ID = S.SOURCE_ID
                                      AND S.SOURCE_NAME = 'MANAGE WORK STG'
                                    INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                                    WHERE MW.COMPLETE_DATE >= TRUNC(SYSDATE - 730) 
                                      AND UOW.HOURLY_FLAG = 'Y'
                                    GROUP BY TRUNC(MW.COMPLETE_DATE),
                                             TO_CHAR(MW.COMPLETE_DATE, 'HH24'),
                                             UOW.CFG_UOW_ID) COMPLETIONS
            ) X
        ) 
        LOOP
            CASE
                WHEN (RECS.ACTUALS_ID >=0) THEN 
                  UPDATE PP_F_ACTUALS
                     SET ACTL_COMPLETION = RECS.COMPLETION_COUNT
                   WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                ELSE 
                  INSERT INTO PP_F_ACTUALS
                    (ACTUALS_ID,
                     D_DATE,
                     D_HOUR,
                     UOW_ID,
                     PROJECT_ID,
                     PROGRAM_ID,
                     GEOGRAPHY_MASTER_ID,
                     ACTL_COMPLETION)
                  VALUES
                    (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
                     RECS.COMPLETE_DATE,
                     RECS.COMPLETE_HOUR,
                     RECS.CFG_UOW_ID,
                     RECS.PROJECT_ID,
                     RECS.PROGRAM_ID,
                     RECS.GEOGRAPHY_MASTER_ID,
                     RECS.COMPLETION_COUNT);
              END CASE;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Completions - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Completions - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;     

--MW Inventory Jeopardy
  PROCEDURE LOAD_MW_INVENTORY_JEOPARDY AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
            SELECT X.INVENTORY_DATE,
                   X.INVENTORY_HOUR,
                   X.CFG_UOW_ID,
                   X.PROJECT_ID,
                   X.PROGRAM_ID,
                   X.GEOGRAPHY_MASTER_ID,
                   X.INVENTORY_COUNT,
                   (SELECT ACTUALS_ID
                      FROM PP_F_ACTUALS
                     WHERE D_DATE = X.INVENTORY_DATE
                       AND D_HOUR = X.INVENTORY_HOUR
                       AND UOW_ID = X.CFG_UOW_ID
                       AND PROJECT_ID = X.PROJECT_ID
                       AND PROGRAM_ID = X.PROGRAM_ID
                       AND GEOGRAPHY_MASTER_ID =
                           X.GEOGRAPHY_MASTER_ID) AS ACTUALS_ID
              FROM (SELECT INVENTORY.INVENTORY_DATE,
                           0 AS INVENTORY_HOUR,
                           INVENTORY.CFG_UOW_ID,
                           INVENTORY.INVENTORY_COUNT,
                           (SELECT CFG_PROJECT_CONFIG_ID
                              FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                           (SELECT CFG_PROGRAM_CONFIG_ID
                              FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                           (SELECT CFG_GEOGRAPHY_CONFIG_ID
                              FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                      FROM (SELECT INVENTORY_DATE,
                                   CFG_UOW_ID,
                                   COUNT(1) AS INVENTORY_COUNT
                              FROM (SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
                                           UOW.CFG_UOW_ID,
                                           CASE
                                             WHEN UOW.AGE_DAYS_TYPE =
                                                  'BUS' AND
                                                  BUS_DAYS_BETWEEN(CREATE_DATE,
                                                                   SYSDATE) >=
                                                  UOW.JEOPARDY_INV_AGE THEN
                                              'Y'
                                             WHEN UOW.AGE_DAYS_TYPE =
                                                  'CAL' AND
                                                  TRUNC(SYSDATE) -
                                                  TRUNC(CREATE_DATE) >=
                                                  UOW.JEOPARDY_INV_AGE THEN
                                              'Y'
                                             ELSE
                                              'N'
                                           END AS JP_FLAG,
                                           UOW.AGE_DAYS_TYPE
                                      FROM PP_CFG_UNIT_OF_WORK UOW
                                     INNER JOIN PP_D_UOW_SOURCE_REF USR
                                        ON UOW.CFG_UOW_ID =
                                           USR.UOW_ID
                                       AND SYSDATE BETWEEN
                                           USR.EFFECTIVE_DATE AND
                                           USR.END_DATE
                                     INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                        ON USR.SOURCE_REF_TYPE_ID =
                                           SRT.SOURCE_REF_TYPE_ID
                                       AND SRT.SOURCE_REF_TYPE_NAME =
                                           'TASK TYPE'
                                     INNER JOIN PP_D_SOURCE S
                                        ON SRT.SOURCE_ID =
                                           S.SOURCE_ID
                                       AND S.SOURCE_NAME =
                                           'MANAGE WORK STG'
                                     INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                                     WHERE COMPLETE_DATE IS NULL
                                       AND CANCEL_WORK_DATE IS NULL
                                       AND UOW.HOURLY_FLAG = 'N') X
                             WHERE JP_FLAG = 'Y'
                             GROUP BY INVENTORY_DATE, CFG_UOW_ID) INVENTORY
                    UNION ALL
                    SELECT INVENTORY.INVENTORY_DATE,
                           TO_NUMBER(INVENTORY.INVENTORY_HOUR) AS INVENTORY_HOUR,
                           INVENTORY.CFG_UOW_ID,
                           INVENTORY.INVENTORY_COUNT,
                           (SELECT CFG_PROJECT_CONFIG_ID
                              FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                           (SELECT CFG_PROGRAM_CONFIG_ID
                              FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                           (SELECT CFG_GEOGRAPHY_CONFIG_ID
                              FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                      FROM (SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
                                   TO_CHAR(SYSDATE, 'HH24') AS INVENTORY_HOUR,
                                   UOW.CFG_UOW_ID,
                                   COUNT(1) AS INVENTORY_COUNT
                              FROM PP_CFG_UNIT_OF_WORK UOW
                             INNER JOIN PP_D_UOW_SOURCE_REF USR
                                ON UOW.CFG_UOW_ID = USR.UOW_ID
                               AND SYSDATE BETWEEN
                                   USR.EFFECTIVE_DATE AND
                                   USR.END_DATE
                             INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                ON USR.SOURCE_REF_TYPE_ID =
                                   SRT.SOURCE_REF_TYPE_ID
                               AND SRT.SOURCE_REF_TYPE_NAME =
                                   'TASK TYPE'
                             INNER JOIN PP_D_SOURCE S
                                ON SRT.SOURCE_ID = S.SOURCE_ID
                               AND S.SOURCE_NAME =
                                   'MANAGE WORK STG'
                             INNER JOIN D_MW_TASK_INSTANCE_SV MW
                                       ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                             WHERE COMPLETE_DATE IS NULL
                               AND CANCEL_WORK_DATE IS NULL
                               AND JEOPARDY_FLAG = 'Y'
                               AND UOW.HOURLY_FLAG = 'Y'
                             GROUP BY TRUNC(SYSDATE),
                                      TO_CHAR(SYSDATE, 'HH24'),
                                      UOW.CFG_UOW_ID) INVENTORY) X
        ) 
        LOOP
            CASE
                WHEN (RECS.ACTUALS_ID >=0) THEN 
                  UPDATE PP_F_ACTUALS
                     SET ACTL_INVENTORY_JEOPARDY = RECS.INVENTORY_COUNT
                   WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                ELSE 
                  INSERT INTO PP_F_ACTUALS
                    (ACTUALS_ID,
                     D_DATE,
                     D_HOUR,
                     UOW_ID,
                     PROJECT_ID,
                     PROGRAM_ID,
                     GEOGRAPHY_MASTER_ID,
                     ACTL_INVENTORY_JEOPARDY)
                  VALUES
                    (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
                     RECS.INVENTORY_DATE,
                     RECS.INVENTORY_HOUR,
                     RECS.CFG_UOW_ID,
                     RECS.PROJECT_ID,
                     RECS.PROGRAM_ID,
                     RECS.GEOGRAPHY_MASTER_ID,
                     RECS.INVENTORY_COUNT);
              END CASE;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Jeopardy - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Jeopardy - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;


--MW Inventory Min/Max
  PROCEDURE LOAD_MW_INVENTORY_MINMAX AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT X.INVENTORY_DATE,
           X.INVENTORY_HOUR,
           X.CFG_UOW_ID,
           X.PROJECT_ID,
           X.PROGRAM_ID,
           X.GEOGRAPHY_MASTER_ID,
           X.INVENTORY_COUNT,
           X.INV_AGE_MIN,
           X.INV_AGE_MAX,
           X.INV_AGE_MEAN,
           X.INV_AGE_MEDIAN,
           X.INV_AGE_STDDEV,
           (SELECT ACTUALS_ID
              FROM PP_F_ACTUALS
             WHERE D_DATE = X.INVENTORY_DATE
               AND D_HOUR = X.INVENTORY_HOUR
               AND UOW_ID = X.CFG_UOW_ID
               AND PROJECT_ID = X.PROJECT_ID
               AND PROGRAM_ID = X.PROGRAM_ID
               AND GEOGRAPHY_MASTER_ID = X.GEOGRAPHY_MASTER_ID) AS ACTUALS_ID
      FROM (SELECT DISTINCT INVENTORY.INVENTORY_DATE,
                            0 AS INVENTORY_HOUR,
                            INVENTORY.CFG_UOW_ID,
                            SUM(INVENTORY.INVENTORY_COUNT) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) as INVENTORY_COUNT,
                            MIN(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) AS INV_AGE_MIN,
                            MAX(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) AS INV_AGE_MAX,
                            AVG(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) AS INV_AGE_MEAN,
                            MEDIAN(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) AS INV_AGE_MEDIAN,
                            STDDEV(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.CFG_UOW_ID) AS INV_AGE_STDDEV,
                            (SELECT CFG_PROJECT_CONFIG_ID
                               FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                            (SELECT CFG_PROGRAM_CONFIG_ID
                               FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                            (SELECT CFG_GEOGRAPHY_CONFIG_ID
                               FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
              FROM (SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
                           UOW.CFG_UOW_ID,
                           1 AS INVENTORY_COUNT,
                           CASE
                             WHEN UOW.AGE_DAYS_TYPE = 'BUS' THEN 
                               BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE),TRUNC(SYSDATE))
                             ELSE
                              (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL)  
                           END AS INV_AGE
                      FROM PP_CFG_UNIT_OF_WORK UOW
                     INNER JOIN PP_D_UOW_SOURCE_REF USR
                        ON UOW.CFG_UOW_ID = USR.UOW_ID
                       AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
                     INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                        ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                       AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                     INNER JOIN PP_D_SOURCE S
                        ON SRT.SOURCE_ID = S.SOURCE_ID
                       AND S.SOURCE_NAME = 'MANAGE WORK STG'
                     INNER JOIN D_MW_TASK_INSTANCE_SV MW 
                        ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                     WHERE  
                       COMPLETE_DATE IS NULL
                       AND UOW.HOURLY_FLAG = 'N'
                       AND CANCEL_WORK_DATE IS NULL) INVENTORY
            
            UNION ALL
            SELECT DISTINCT INVENTORY.INVENTORY_DATE,
                            TO_NUMBER(INVENTORY.INVENTORY_HOUR) AS INVENTORY_HOUR,
                            INVENTORY.CFG_UOW_ID,
                            SUM(INVENTORY.INVENTORY_COUNT) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) as INVENTORY_COUNT,
                            MIN(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) AS INV_AGE_MIN,
                            MAX(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) AS INV_AGE_MAX,
                            AVG(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) AS INV_AGE_MEAN,
                            MEDIAN(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) AS INV_AGE_MEDIAN,
                            STDDEV(INVENTORY.INV_AGE) OVER(PARTITION BY INVENTORY.INVENTORY_DATE, INVENTORY.INVENTORY_HOUR, INVENTORY.CFG_UOW_ID) AS INV_AGE_STDDEV,
                            (SELECT CFG_PROJECT_CONFIG_ID
                               FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                            (SELECT CFG_PROGRAM_CONFIG_ID
                               FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                            (SELECT CFG_GEOGRAPHY_CONFIG_ID
                               FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
              FROM (SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
                           TO_CHAR(SYSDATE, 'HH24') AS INVENTORY_HOUR,
                           UOW.CFG_UOW_ID,
                           1 AS INVENTORY_COUNT,
                           CASE
                             WHEN UOW.AGE_DAYS_TYPE = 'BUS' THEN 
                               BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE),TRUNC(SYSDATE))
                             ELSE
                              (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL)  
                           END AS INV_AGE
                      FROM PP_CFG_UNIT_OF_WORK UOW
                     INNER JOIN PP_D_UOW_SOURCE_REF USR
                        ON UOW.CFG_UOW_ID = USR.UOW_ID
                       AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
                     INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                        ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                       AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                     INNER JOIN PP_D_SOURCE S
                        ON SRT.SOURCE_ID = S.SOURCE_ID
                       AND S.SOURCE_NAME = 'MANAGE WORK STG'
                     INNER JOIN D_MW_TASK_INSTANCE_SV MW
                        ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                     WHERE  
                       COMPLETE_DATE IS NULL
                       AND UOW.HOURLY_FLAG = 'Y'
                       AND CANCEL_WORK_DATE IS NULL) INVENTORY) X
        ) 
        LOOP
            CASE
                WHEN (RECS.ACTUALS_ID >=0) THEN 
                  UPDATE PP_F_ACTUALS
                     SET ACTL_INVENTORY=RECS.INVENTORY_COUNT,
                         ACTL_INVENTORY_AGE_MIN=RECS.INV_AGE_MIN,
                         ACTL_INVENTORY_AGE_MAX=RECS.INV_AGE_MAX,
                         ACTL_INVENTORY_AGE_MEAN=RECS.INV_AGE_MEAN,
                         ACTL_INVENTORY_AGE_MEDIAN=RECS.INV_AGE_MEDIAN,
                         ACTL_INVENTORY_AGE_SD=RECS.INV_AGE_STDDEV
                   WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                ELSE 
                  INSERT INTO PP_F_ACTUALS
                    (ACTUALS_ID,
                     D_DATE,
                     D_HOUR,
                     UOW_ID,
                     PROJECT_ID,
                     PROGRAM_ID,
                     GEOGRAPHY_MASTER_ID,
             ACTL_INVENTORY,
                     ACTL_INVENTORY_AGE_MIN,
                     ACTL_INVENTORY_AGE_MAX,
                     ACTL_INVENTORY_AGE_MEAN,
                     ACTL_INVENTORY_AGE_MEDIAN,
                     ACTL_INVENTORY_AGE_SD)
                  VALUES
                    (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
                     RECS.INVENTORY_DATE,
                     RECS.INVENTORY_HOUR,
                     RECS.CFG_UOW_ID,
                     RECS.PROJECT_ID,
                     RECS.PROGRAM_ID,
                     RECS.GEOGRAPHY_MASTER_ID,
                     RECS.INVENTORY_COUNT,
             RECS.INV_AGE_MIN,
                     RECS.INV_AGE_MAX,
                     RECS.INV_AGE_MEAN,
                     RECS.INV_AGE_MEDIAN,
                     RECS.INV_AGE_STDDEV);
              END CASE;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Min,Max, etc - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Min,Max, etc - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;
 
 --Handle Time/Staff
  PROCEDURE LOAD_MW_HANDLE_TIME AS 
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT ACTUALS_ID
          FROM PP_F_ACTUALS
          WHERE ACTL_HANDLE_TIME_AVG IS NULL
            OR ACTL_HANDLE_TIME_MIN IS NULL
            OR ACTL_HANDLE_TIME_MAX IS NULL
            OR ACTL_HANDLE_TIME_MEAN IS NULL
            OR ACTL_HANDLE_TIME_MEDIAN IS NULL
            OR ACTL_HANDLE_TIME_SD IS NULL
            OR ACTL_STAFF_HOURS IS NULL
        ) 
        LOOP
    
                  UPDATE PP_F_ACTUALS
               SET ACTL_HANDLE_TIME_AVG    = 0,
                   ACTL_HANDLE_TIME_MIN    = 0,
                     ACTL_HANDLE_TIME_MAX    = 0,
                   ACTL_HANDLE_TIME_MEAN   = 0,
                   ACTL_HANDLE_TIME_MEDIAN = 0,
                   ACTL_HANDLE_TIME_SD     = 0,
                   ACTL_STAFF_HOURS        = 0
           WHERE ACTUALS_ID = RECS.ACTUALS_ID;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Zero HandleTime and Staff - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Zero HandleTime and Staff - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;                  
      
    --MW Inventory Avg Age
  PROCEDURE LOAD_MW_INVENTORY_AVG_AGE AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT X.INVENTORY_DATE,
           X.INVENTORY_HOUR,
           X.CFG_UOW_ID,
           X.PROJECT_ID,
           X.PROGRAM_ID,
           X.GEOGRAPHY_MASTER_ID,
           X.AVG_AGE,
           (SELECT ACTUALS_ID
              FROM PP_F_ACTUALS
             WHERE D_DATE = X.INVENTORY_DATE
               AND D_HOUR = X.INVENTORY_HOUR
               AND UOW_ID = X.CFG_UOW_ID
               AND PROJECT_ID = X.PROJECT_ID
               AND PROGRAM_ID = X.PROGRAM_ID
               AND GEOGRAPHY_MASTER_ID = X.GEOGRAPHY_MASTER_ID) AS ACTUALS_ID
      FROM 
      (
          SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
               '0' AS INVENTORY_HOUR,
               UOW.CFG_UOW_ID,
               AVG(CASE
                     WHEN UOW.AGE_DAYS_TYPE = 'BUS' THEN
                      (CASE
                        WHEN BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE), TRUNC(SYSDATE)) >=
                             UOW.INV_AVG_AGE THEN
                         UOW.INV_AVG_AGE
                        ELSE
                         BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE), TRUNC(SYSDATE))
                      END)
                     ELSE
                      (CASE
                        WHEN (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL) >=
                             UOW.INV_AVG_AGE THEN
                         UOW.INV_AVG_AGE
                        ELSE
                         (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL)
                      END)
                   END) as AVG_AGE,
               (SELECT CFG_PROJECT_CONFIG_ID FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
               (SELECT CFG_PROGRAM_CONFIG_ID FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
               (SELECT CFG_GEOGRAPHY_CONFIG_ID FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
          FROM PP_CFG_UNIT_OF_WORK UOW
          INNER JOIN PP_D_UOW_SOURCE_REF USR
            ON UOW.CFG_UOW_ID = USR.UOW_ID
           AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
          INNER JOIN PP_D_SOURCE_REF_TYPE SRT
            ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
           AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
          INNER JOIN PP_D_SOURCE S
            ON SRT.SOURCE_ID = S.SOURCE_ID
           AND S.SOURCE_NAME = 'MANAGE WORK STG'
          INNER JOIN D_MW_TASK_INSTANCE_SV MW
            ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
          WHERE 
            COMPLETE_DATE IS NULL
           AND UOW.HOURLY_FLAG = 'N'
           AND CANCEL_WORK_DATE IS NULL
          GROUP BY TRUNC(SYSDATE), UOW.CFG_UOW_ID
          UNION ALL
          SELECT TRUNC(SYSDATE) AS INVENTORY_DATE,
               TO_CHAR(SYSDATE, 'HH24') AS INVENTORY_HOUR,
               UOW.CFG_UOW_ID,
               AVG(CASE
                     WHEN UOW.AGE_DAYS_TYPE = 'BUS' THEN
                      (CASE
                        WHEN BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE), TRUNC(SYSDATE)) >=
                             UOW.INV_AVG_AGE THEN
                         UOW.INV_AVG_AGE
                        ELSE
                         BUS_DAYS_BETWEEN(TRUNC(CREATE_DATE), TRUNC(SYSDATE))
                      END)
                     ELSE
                      (CASE
                        WHEN (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL) >=
                             UOW.INV_AVG_AGE THEN
                         UOW.INV_AVG_AGE
                        ELSE
                         (SELECT TRUNC(SYSDATE) - TRUNC(CREATE_DATE) AS AGE FROM DUAL)
                      END)
                   END) as AVG_AGE,
               (SELECT CFG_PROJECT_CONFIG_ID FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
               (SELECT CFG_PROGRAM_CONFIG_ID FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
               (SELECT CFG_GEOGRAPHY_CONFIG_ID FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
          FROM PP_CFG_UNIT_OF_WORK UOW
          INNER JOIN PP_D_UOW_SOURCE_REF USR
            ON UOW.CFG_UOW_ID = USR.UOW_ID
           AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
          INNER JOIN PP_D_SOURCE_REF_TYPE SRT
            ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
           AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
          INNER JOIN PP_D_SOURCE S
            ON SRT.SOURCE_ID = S.SOURCE_ID
           AND S.SOURCE_NAME = 'MANAGE WORK STG'
          INNER JOIN D_MW_TASK_INSTANCE_SV MW
            ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID
          WHERE 
           COMPLETE_DATE IS NULL
           AND UOW.HOURLY_FLAG = 'Y'
           AND CANCEL_WORK_DATE IS NULL
          GROUP BY TRUNC(SYSDATE), TO_CHAR(SYSDATE, 'HH24'), UOW.CFG_UOW_ID           
          ) X
        ) 
        LOOP
            CASE
                WHEN (RECS.ACTUALS_ID >=0) THEN 
                  UPDATE PP_F_ACTUALS
                     SET ACTL_INVENTORY_AGE_AVG=RECS.AVG_AGE
                   WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                ELSE 
                  INSERT INTO PP_F_ACTUALS
                    (ACTUALS_ID,
                     D_DATE,
                     D_HOUR,
                     UOW_ID,
                     PROJECT_ID,
                     PROGRAM_ID,
                     GEOGRAPHY_MASTER_ID,
                     ACTL_INVENTORY_AGE_AVG)
                  VALUES
                    (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
                     RECS.INVENTORY_DATE,
                     RECS.INVENTORY_HOUR,
                     RECS.CFG_UOW_ID,
                     RECS.PROJECT_ID,
                     RECS.PROGRAM_ID,
                     RECS.GEOGRAPHY_MASTER_ID,
                     RECS.AVG_AGE);
              END CASE;
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Avg Age - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Inventory Avg Age - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END; 

--Avg Handle Times and Staff Hours From MW_Tasks
  PROCEDURE LOAD_MW_STAFF_HOURS AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','Avg Handle Times and Staff Hours From MW_Tasks - Begin', SYSDATE); 
      COMMIT;
      FOR RECS IN 
        (
            with ht as
            ( 
              select mw.task_id, 
                   MW.task_type_id,
                    trunc(MW.COMPLETE_DATE) as D_DATE,
            (MW.COMPLETE_DATE - COALESCE(MW.CURR_CLAIM_DATE,MW.CREATE_DATE)) as Handle_Time
              from D_MW_TASK_INSTANCE_SV MW
                 where trunc(MW.COMPLETE_DATE) > trunc(sysdate - 500)
                   and MW.CURR_CLAIM_DATE IS NOT NULL
                   and MW.task_type_id in
                       (SELECT USR.SOURCE_REF_ID
                          FROM PP_CFG_UNIT_OF_WORK UOW
                         INNER JOIN PP_D_UOW_SOURCE_REF USR
                            ON UOW.CFG_UOW_ID = USR.UOW_ID
                           AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
                         INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                            ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                           AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                         INNER JOIN PP_D_SOURCE S
                            ON SRT.SOURCE_ID = S.SOURCE_ID
                           AND S.SOURCE_NAME = 'MANAGE WORK STG'
                         WHERE UOW.HOURLY_FLAG = 'N')
           )
            select 
                   distinct ht.D_DATE,  
                   usr.uow_id,
                   AVG(Handle_Time) over (partition by D_DATE, uow_id) as avg_handle_time, 
                   MIN(Handle_Time) over (partition by D_DATE, uow_id) as min_handle_time,
                   STDDEV(Handle_Time) over (partition by D_DATE, uow_id) as stdev_handle_time,
                   MEDIAN(Handle_Time) over (partition by D_DATE, uow_id) as median_handle_time,
                   MAX(Handle_Time) over (partition by D_DATE, uow_id) as max_handle_time,
                   (SUM(Handle_Time) over (partition by D_DATE, uow_id)*24) as staff_hours, --Handle Times are in days and staff hours are converted to hours
                   SUM(Handle_Time) over (partition by D_DATE, uow_id) as sum_ht,
                   count(1) over (partition by D_DATE, uow_id) as count_ht
              from ht
              join pp_d_uow_source_ref usr
               on ht.task_type_id = usr.source_ref_id
               and usr.source_ref_detail_identifier='TASK ID' and 
               SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
    
    ) 
        LOOP
                  
                  
                  UPDATE PP_F_ACTUALS 
                     SET actl_handle_time_avg=RECS.avg_handle_time,
                         actl_handle_time_min=RECS.min_handle_time,
                         actl_handle_time_max=RECS.max_handle_time,
                         actl_handle_time_mean=RECS.avg_handle_time,
                         actl_handle_time_median=RECS.median_handle_time,
                         actl_handle_time_sd=RECS.stdev_handle_time,
                         actl_staff_hours=RECS.staff_hours
                   WHERE d_date=RECS.d_date and uow_id=RECS.uow_id;
                   
    
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','Avg Handle Times and Staff Hours From MW_Tasks - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','Avg Handle Times and Staff Hours From MW_Tasks - Processed - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;
    
--MW Actual Details Arrivals
  PROCEDURE LOAD_MW_ACTUAL_DTL_ARRIVALS AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
          SELECT X.D_DATE, X.D_HOUR, X.USR_ID, X.TASK_ID, X.ACTUAL_CNT, X.COMPLETE_DATE, X.JEOPARDY_FLAG
          FROM (SELECT DISTINCT TRUNC(CREATE_DATE) AS D_DATE,
                                0 AS D_HOUR,
                                USR.USR_ID,
                                MW.TASK_ID,
                                TRUNC(MW.COMPLETE_DATE) AS COMPLETE_DATE,
                                1 AS ACTUAL_CNT,
                                CASE
                                   WHEN UOW.AGE_DAYS_TYPE = 'BUS' AND BUS_DAYS_BETWEEN(CREATE_DATE, SYSDATE) >= UOW.JEOPARDY_INV_AGE THEN
                                    'Y'
                                   WHEN UOW.AGE_DAYS_TYPE = 'CAL' AND TRUNC(SYSDATE) - TRUNC(CREATE_DATE) >= UOW.JEOPARDY_INV_AGE THEN
                                    'Y'
                                   ELSE
                                    'N'
                                 END AS JEOPARDY_FLAG
                  FROM PP_CFG_UNIT_OF_WORK UOW
                 INNER JOIN PP_D_UOW_SOURCE_REF USR
                    ON UOW.CFG_UOW_ID = USR.UOW_ID
                   AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
                 INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                    ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                 INNER JOIN PP_D_SOURCE S
                    ON SRT.SOURCE_ID = S.SOURCE_ID
                   AND S.SOURCE_NAME = 'MANAGE WORK STG'
                 INNER JOIN D_MW_TASK_INSTANCE_SV MW
                    ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                 WHERE CREATE_DATE >= TRUNC(SYSDATE - 730) 
                   AND UOW.HOURLY_FLAG = 'N'
                UNION ALL
                SELECT DISTINCT TRUNC(CREATE_DATE) AS D_DATE,
                                TO_NUMBER(TO_CHAR(CREATE_DATE, 'HH24')) AS D_HOUR,
                                USR.USR_ID,
                                MW.TASK_ID,
                                TRUNC(MW.COMPLETE_DATE) AS COMPLETE_DATE,
                                1 AS ACTUAL_CNT,
                                CASE
                                   WHEN UOW.AGE_DAYS_TYPE = 'BUS' AND BUS_DAYS_BETWEEN(CREATE_DATE, SYSDATE) >= UOW.JEOPARDY_INV_AGE THEN
                                    'Y'
                                   WHEN UOW.AGE_DAYS_TYPE = 'CAL' AND TRUNC(SYSDATE) - TRUNC(CREATE_DATE) >= UOW.JEOPARDY_INV_AGE THEN
                                    'Y'
                                   ELSE
                                    'N'
                                 END AS JEOPARDY_FLAG
                  FROM PP_CFG_UNIT_OF_WORK UOW
                 INNER JOIN PP_D_UOW_SOURCE_REF USR
                    ON UOW.CFG_UOW_ID = USR.UOW_ID
                   AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
                 INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                    ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
                   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                 INNER JOIN PP_D_SOURCE S
                    ON SRT.SOURCE_ID = S.SOURCE_ID
                   AND S.SOURCE_NAME = 'MANAGE WORK STG'
                 INNER JOIN D_MW_TASK_INSTANCE_SV MW
                    ON USR.SOURCE_REF_ID = MW.TASK_TYPE_ID 
                 WHERE CREATE_DATE >= TRUNC(SYSDATE - 730) 
                   AND UOW.HOURLY_FLAG = 'Y') X
                 WHERE NOT EXISTS (SELECT DAD_ID
                        FROM PP_D_ACTUAL_DETAILS
                       WHERE D_DATE = X.D_DATE
                         AND D_HOUR = X.D_HOUR
                         AND USR_ID = X.USR_ID
                         AND SOURCE_DETAIL_ID = X.TASK_ID)  
          ORDER BY X.D_DATE, X.D_HOUR, X.TASK_ID
    ) 
        LOOP
                  INSERT INTO PP_D_ACTUAL_DETAILS
                    (DAD_ID,
                     D_DATE,
                     D_HOUR,
                     USR_ID,
                     SOURCE_DETAIL_ID,
                     ACTUAL_ARRIVAL,
                     ACTUAL_COMPLETION,
                     ACTUAL_INVENTORY,
                     ACTUAL_INVENTORY_AGE,
                     ACTUAL_HANDLE_TIME,
                     ACTUAL_STAFF_HOURS,
                     BUCKET_START_DATE,
                     BUCKET_END_DATE,
                     JEOPARDY_FLAG)
                  VALUES
                    (SEQ_PP_DAD_ID.NEXTVAL,
                     RECS.D_DATE,
                     RECS.D_HOUR,
                     RECS.USR_ID,
                     RECS.TASK_ID,
                     1,
                     0,
                     1,
                     0,
                     0,
                     0,
                     RECS.D_DATE,
                     TO_DATE('07/07/2077','MM/DD/YYYY'),
                     RECS.JEOPARDY_FLAG
    );
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Actual Details Arrivals - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Actual Details Arrivals - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END; 

--MW Actual Details Completions
  PROCEDURE LOAD_MW_ACTUAL_DTL_COMPLETIONS AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR RECS IN 
        (
           SELECT DAD_ID,
                 SOURCE_DETAIL_ID,
                 D_HOUR,
                 D_DATE,
                 USR_ID,
                 TASK_ID,
                 COMPLETE_DATE,
                 JEOPARDY_FLAG,
                 COMPLETED_SAME_DAY
           FROM      
           (SELECT DAD.DAD_ID,
                 DAD.SOURCE_DETAIL_ID,
                 DAD.D_HOUR,
                 DAD.D_DATE,
                 DAD.USR_ID,
                 MW.TASK_ID,
                 CASE WHEN MW.CANCEL_WORK_DATE IS NOT NULL THEN TRUNC(MW.CANCEL_WORK_DATE)
                                               ELSE TRUNC(MW.COMPLETE_DATE)
                                          END AS COMPLETE_DATE,
                 CASE
                   WHEN UOW.AGE_DAYS_TYPE = 'BUS' AND BUS_DAYS_BETWEEN(CREATE_DATE, SYSDATE) >= UOW.JEOPARDY_INV_AGE THEN
                    'Y'
                   WHEN UOW.AGE_DAYS_TYPE = 'CAL' AND TRUNC(SYSDATE) - TRUNC(CREATE_DATE) >= UOW.JEOPARDY_INV_AGE THEN
                    'Y'
                   ELSE
                    'N'
                 END AS JEOPARDY_FLAG,
                 DAD.JEOPARDY_FLAG AS DAD_JEOPARDY_FLAG,
                 CASE WHEN TRUNC(MW.CREATE_DATE) = TRUNC(MW.COMPLETE_DATE)
                   THEN 'Y'
                     ELSE 'N'
                 END AS COMPLETED_SAME_DAY,
                 MW.CANCEL_WORK_DATE
              FROM PP_D_SOURCE S
           INNER JOIN PP_D_SOURCE_REF_TYPE SRT
              ON SRT.SOURCE_ID = S.SOURCE_ID
             AND S.SOURCE_NAME = 'MANAGE WORK STG'
             AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
           INNER JOIN PP_D_UOW_SOURCE_REF USR
              ON USR.SOURCE_REF_TYPE_ID = SRT.SOURCE_REF_TYPE_ID
             AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND USR.END_DATE
           INNER JOIN PP_CFG_UNIT_OF_WORK UOW
                ON UOW.CFG_UOW_ID = USR.UOW_ID  
           INNER JOIN PP_D_ACTUAL_DETAILS DAD
              ON DAD.USR_ID = USR.USR_ID
           INNER JOIN D_MW_TASK_INSTANCE_SV MW
              ON MW.TASK_ID = DAD.SOURCE_DETAIL_ID
           WHERE DAD.BUCKET_END_DATE = TO_DATE('07/07/2077', 'MM/DD/YYYY')) R
             WHERE (R.COMPLETE_DATE IS NOT NULL OR R.CANCEL_WORK_DATE IS NOT NULL
              OR R.JEOPARDY_FLAG <> R.DAD_JEOPARDY_FLAG)    
    ) 
        LOOP
             CASE WHEN RECS.COMPLETE_DATE IS NOT NULL AND RECS.COMPLETED_SAME_DAY='Y' THEN
                    UPDATE PP_D_ACTUAL_DETAILS
                       SET BUCKET_END_DATE=RECS.COMPLETE_DATE, ACTUAL_INVENTORY=0, ACTUAL_COMPLETION=1
                     WHERE DAD_ID=RECS.DAD_ID;
             ELSE
                     UPDATE PP_D_ACTUAL_DETAILS
                           SET BUCKET_END_DATE=
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN TRUNC(SYSDATE)
                                ELSE RECS.COMPLETE_DATE
                           END
                         WHERE DAD_ID=RECS.DAD_ID;
                   
                     INSERT INTO PP_D_ACTUAL_DETAILS
                          (DAD_ID,
                           D_DATE,
                           D_HOUR,
                           USR_ID,
                           SOURCE_DETAIL_ID,
                           ACTUAL_ARRIVAL,
                           ACTUAL_COMPLETION,
                           ACTUAL_INVENTORY,
                           ACTUAL_INVENTORY_AGE,
                           ACTUAL_HANDLE_TIME,
                           ACTUAL_STAFF_HOURS,
                           BUCKET_START_DATE,
                           BUCKET_END_DATE,
                           JEOPARDY_FLAG)
                        VALUES
                          (SEQ_PP_DAD_ID.NEXTVAL,
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN TRUNC(SYSDATE)
                                ELSE RECS.COMPLETE_DATE
                           END,
                           RECS.D_HOUR,
                           RECS.USR_ID,
                           RECS.TASK_ID,
                           0,
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN 0
                                ELSE 1
                           END,
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN 1
                                ELSE 0
                           END,
                           0,
                           0,
                           0,
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN TRUNC(SYSDATE)
                                ELSE RECS.COMPLETE_DATE
                           END,
                           CASE
                               WHEN RECS.COMPLETE_DATE IS NULL THEN TO_DATE('07/07/2077','MM/DD/YYYY')
                                ELSE RECS.COMPLETE_DATE
                           END,
                           RECS.JEOPARDY_FLAG                 
                           );
             END CASE;              
      END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','MW Actual Details Completions - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','MW Actual Details Completions - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;

--Actuals Backfill Missing Days
  PROCEDURE LOAD_ACTUALS_BACKFILL AS
    V_ERRCODE varchar2(50);
    V_ERRMSG varchar2(3000);
    
    BEGIN
      FOR 
        RECS IN
        (               
                     WITH DAYS AS
                      (SELECT TRUNC(SYSDATE - 730) + ROWNUM missing_date
                         FROM ALL_OBJECTS
                        WHERE ROWNUM <= 730),
                     ALL_DAYS AS
                      (SELECT DAYS.missing_date FROM DAYS)
                     
                     SELECT Y.D_DATE,
                            Y.D_HOUR,
                            Y.UOW_ID,
                            Y.PROJECT_ID,
                            Y.PROGRAM_ID,
                            Y.GEOGRAPHY_MASTER_ID
                       FROM (SELECT AD.MISSING_DATE AS D_DATE,
                                    X.CFG_UOW_ID AS UOW_ID,
                                    0 AS D_HOUR,
                                    (SELECT CFG_PROJECT_CONFIG_ID
                                       FROM PP_CFG_PROJECT_CONFIG) AS PROJECT_ID,
                                    (SELECT CFG_PROGRAM_CONFIG_ID
                                       FROM PP_CFG_PROGRAM_CONFIG) AS PROGRAM_ID,
                                    (SELECT CFG_GEOGRAPHY_CONFIG_ID
                                       FROM PP_CFG_GEOGRAPHY_CONFIG) AS GEOGRAPHY_MASTER_ID
                               FROM ALL_DAYS AD,
                                    (SELECT DISTINCT UOW.CFG_UOW_ID
                                       FROM PP_CFG_UNIT_OF_WORK UOW
                                      INNER JOIN PP_D_UOW_SOURCE_REF USR
                                         ON UOW.CFG_UOW_ID = USR.UOW_ID
                                        AND SYSDATE BETWEEN USR.EFFECTIVE_DATE AND
                                            USR.END_DATE
                                      INNER JOIN PP_D_SOURCE_REF_TYPE SRT
                                         ON USR.SOURCE_REF_TYPE_ID =
                                            SRT.SOURCE_REF_TYPE_ID
                                        AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE'
                                      INNER JOIN PP_D_SOURCE S
                                         ON SRT.SOURCE_ID = S.SOURCE_ID
                                        AND S.SOURCE_NAME = 'MANAGE WORK STG') X) Y
                      WHERE (SELECT ACTUALS_ID
                               FROM PP_F_ACTUALS
                              WHERE D_DATE = Y.D_DATE
                                AND D_HOUR = Y.D_HOUR
                                AND UOW_ID = Y.UOW_ID
                                AND PROJECT_ID = Y.PROJECT_ID
                                AND PROGRAM_ID = Y.PROGRAM_ID
                                AND GEOGRAPHY_MASTER_ID = Y.GEOGRAPHY_MASTER_ID) IS NULL
                      ORDER BY Y.D_DATE, Y.D_HOUR, Y.UOW_ID
        ) 
        LOOP  
            INSERT INTO PP_F_ACTUALS
              (ACTUALS_ID,
               D_DATE,
               D_HOUR,
               UOW_ID,
               PROJECT_ID,
               PROGRAM_ID,
               GEOGRAPHY_MASTER_ID,
               ACTL_ARRIVAL,
               ACTL_COMPLETION,
               ACTL_INVENTORY,
               ACTL_INVENTORY_AGE_AVG,
               ACTL_INVENTORY_AGE_MIN,
               ACTL_INVENTORY_AGE_MAX,
               ACTL_INVENTORY_AGE_MEAN,
               ACTL_INVENTORY_AGE_MEDIAN,
               ACTL_INVENTORY_AGE_SD,
               ACTL_INVENTORY_JEOPARDY,
               ACTL_HANDLE_TIME_AVG,
               ACTL_HANDLE_TIME_MIN,
               ACTL_HANDLE_TIME_MAX,
               ACTL_HANDLE_TIME_MEAN,
               ACTL_HANDLE_TIME_MEDIAN,
               ACTL_HANDLE_TIME_SD,
               ACTL_STAFF_HOURS)
            VALUES
              (SEQ_PP_F_ACTUALS_ID.NEXTVAL,
               RECS.D_DATE,
               RECS.D_HOUR,
               RECS.UOW_ID,
               RECS.PROJECT_ID,
               RECS.PROGRAM_ID,
               RECS.GEOGRAPHY_MASTER_ID,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0,
               0);
        END LOOP;
      INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Process_v3','Actuals Backfill Missing Days - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Process_v3','Actuals Backfill Missing Days - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
    END;
    
PROCEDURE BACKFILL_ACTUALS_INV_AGE AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  
  BEGIN
    
    INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Begin', SYSDATE); 
    COMMIT;
    FOR RECS IN 
      (
          with cal_usr as
          (
          select usr.usr_id, usr.uow_id, uow.age_days_type, uow.inv_avg_age
            from pp_d_uow_source_ref usr
            join pp_cfg_unit_of_work uow on uow.cfg_uow_id=usr.uow_id
           where usr.source_ref_detail_identifier in
                 ('TASK ID', 'BATCH TYPE', 'BATCH CLASS')
             and usr.end_date > sysdate                                 
          ),
          cal_ad_all as
          (
          select dad_id, u.age_days_type,u.inv_avg_age,u.uow_id
            from pp_d_actual_details ad
            join cal_usr u on u.usr_id=ad.usr_id   
          ),
          cal_adv_w_age as 
          (
          select adv.dad_id,
                 adv.d_date,
                 adv.usr_id,
                 ada.inv_avg_age,
                 ada.uow_id,
                 CASE
                       WHEN ada.age_days_type = 'BUS' THEN
                         BUS_DAYS_BETWEEN(min(adv.d_date) over(partition by adv.dad_id), adv.d_date)
                       ELSE
                         adv.d_date - min(adv.d_date) over(partition by adv.dad_id)
                  END as age
            from pp_d_actual_details_sv adv
            join cal_ad_all ada on ada.dad_id=adv.dad_id
           where actual_inventory=1
          ),
          cal_adv_inv_avg_age as
          (
          select dad_id, d_date, cal_adv_w_age.usr_id, uow_id, 
          inv_avg_age,
          case when age > inv_avg_age then inv_avg_age
            else age
          end as age
          from cal_adv_w_age
  
          )
          select distinct d_date,
                          uow_id,
                          AVG(age) over(partition by d_date, uow_id) as avg_age,
                          MIN(age) over(partition by d_date, uow_id) as min_age,
                          MAX(age) over(partition by d_date, uow_id) as max_age,
                          STDDEV(age) over(partition by d_date, uow_id) as stddev_age,
                          MEDIAN(age) over(partition by d_date, uow_id) as median_age
            from cal_adv_inv_avg_age
  ) 
      LOOP
                UPDATE PP_F_ACTUALS
                   SET actl_inventory_age_avg=RECS.AVG_AGE,
                       actl_inventory_age_min=RECS.Min_Age,
                       actl_inventory_age_max=RECS.MAX_AGE,
                       actl_inventory_age_mean=RECS.AVG_AGE,
                       actl_inventory_age_median=RECS.MEDIAN_AGE,
                       actl_inventory_age_sd=RECS.STDDEV_AGE
                 WHERE d_date=RECS.D_DATE and uow_id=RECS.UOW_ID;
                 
                 INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script',RECS.D_DATE || ' --- ' || RECS.UOW_ID , SYSDATE); 
  
    END LOOP;
    INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Processed', SYSDATE); 
    COMMIT;
  
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Processed - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

PROCEDURE BACKFILL_ACTUALS_INV_COUNT AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  
  BEGIN
    FOR RECS IN 
      (
         with usr as
           (select uow_id, usr_id from pp_d_uow_source_ref_sv)
          ,f as
          (
           select actuals_id, d_date, uow_id from pp_f_actuals
          )
          , results_inv as
          (
          select distinct ad.D_DATE, u.UOW_ID, 
          count(1) over(partition by ad.D_DATE, u.UOW_ID) as INVENTORY
            from pp_d_actual_details_sv ad
           inner join usr u
              on u.usr_id = ad.USR_ID
           where ad.actual_inventory = 1
           )
           , results_jeop as
          (
           select distinct ad.D_DATE, u.UOW_ID, 
          count(1) over(partition by ad.D_DATE, u.UOW_ID) as INVENTORY_Jeopardy
            from pp_d_actual_details_sv ad
           inner join usr u
              on u.usr_id = ad.USR_ID
           where ad.actual_inventory = 1 and ad.JEOPARDY_FLAG='Y'
           )
           select results_inv.D_DATE, results_inv.UOW_ID, results_inv.INVENTORY, results_jeop.INVENTORY_Jeopardy, f.ACTUALS_ID
            from results_inv 
          inner join results_jeop on results_jeop.d_date=results_inv.d_date and results_jeop.uow_id=results_inv.uow_id
          inner join f on results_inv.d_date=f.d_date and results_inv.uow_id=f.uow_id
      ) 
      LOOP
                UPDATE PP_F_ACTUALS
                   SET ACTL_INVENTORY=RECS.INVENTORY,
                       actl_inventory_jeopardy=RECS.INVENTORY_Jeopardy
                 WHERE ACTUALS_ID=RECS.ACTUALS_ID;
                 
                 INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script',RECS.ACTUALS_ID || ' --- ' || RECS.INVENTORY , SYSDATE); 
  
    END LOOP;
    INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory counts for all UOW - Processed', SYSDATE); 
   -- COMMIT;
  
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory counts for all UOW - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

PROCEDURE LOAD_ACTUALS_DATA AS
BEGIN
  TRUNCATE_ACTUALS_TABLE;
  LOAD_MW_ARRIVALS;
  LOAD_MW_COMPLETIONS;
  LOAD_MW_INVENTORY_JEOPARDY;
  LOAD_MW_INVENTORY_MINMAX;
  LOAD_MW_HANDLE_TIME;
  LOAD_MW_INVENTORY_AVG_AGE;
  LOAD_MW_STAFF_HOURS;
  LOAD_MW_ACTUAL_DTL_ARRIVALS;
  LOAD_MW_ACTUAL_DTL_COMPLETIONS;
  LOAD_ACTUALS_BACKFILL;
  BACKFILL_ACTUALS_INV_AGE;
  BACKFILL_ACTUALS_INV_COUNT;
END;  


PROCEDURE POPULATE_PROCESS_INSTANCE AS
  BEGIN

    EXECUTE IMMEDIATE 'TRUNCATE TABLE GTT_MW_TASK_INSTANCE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE D_BPM_PROCESS_SEGMENT_INSTANCE';        
    EXECUTE IMMEDIATE 'TRUNCATE TABLE D_BPM_FLOW_INSTANCE';
    
    DELETE FROM D_BPM_ENTITY_INSTANCE;
    DELETE FROM D_BPM_PROCESS_INSTANCE;
    DELETE FROM F_BPM_PROCESS_BY_DATE;
    COMMIT;
            -----------------------------------------------------------------------------
            --  Insert/Update into Process Instance
            ----------------------------------------------------------------------------
    INSERT INTO GTT_MW_TASK_INSTANCE
    SELECT ti.*
    FROM D_MW_TASK_INSTANCE              ti
       JOIN D_BPM_TASK_TYPE_ENTITY          tt   ON (ti.task_type_id         =   tt.task_type_id ) ;
   
   MERGE  
        INTO    
            D_BPM_PROCESS_INSTANCE      pi
        USING
        (
            WITH 
                task_types                  AS 
                ( -- Generate a distinct list of task_type_ids that are part of a process
                    SELECT 
                        DISTINCT 
                        task_type_id, 
                        entity_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                task_type_entity            AS 
                ( -- Generate a distinct list of task_type_ids and entity_id sthat are part of a process
                    SELECT 
                        DISTINCT 
                        task_type_id, 
                        entity_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                tte_start_terminator        AS
                (
                    SELECT  
                        tte.task_type_id, 
                        tte.entity_id, 
                        e.is_starting_entity, 
                        e.is_terminating_entity 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY          tte, 
                        D_BPM_ENTITY                    e
                    WHERE 
                        tte.entity_id               =   e.entity_id
                ),
                new_updated_processes       AS 
                ( -- Generate a list of the new and updated process instances
                    SELECT 
                        DISTINCT 
                        m1.source_process_instance_id                                                                   AS  PROCESS_INSTANCE_ID,
                        p.process_id,
                        p.process_name,
                        p.process_description,
                        p.parent_process_id,
                        (
                            SELECT  
                                MIN(m11.create_date) 
                            FROM 
                                GTT_MW_TASK_INSTANCE                    m11, 
                                tte_start_terminator                    tte_st 
                            WHERE 
                                m11.source_process_instance_id      =   m1.source_process_instance_id       AND
                                m11.task_type_id                    =   tte_st.task_type_id                 AND 
                                tte_st.is_starting_entity           =   'Y'
                        )                                                                                               AS  PROCESS_START_DATE,
                        (
                            SELECT
                                MAX(m11.COMPLETE_DATE) 
                            FROM 
                                GTT_MW_TASK_INSTANCE                m11, 
                                tte_start_terminator                tte_st 
                            WHERE 
                                m11.source_process_instance_id  =   m1.source_process_instance_id           AND
                                m11.task_type_id                =   tte_st.task_type_id                     AND 
                                tte_st.is_terminating_entity    =   'Y'                                     AND
                                m11.CREATE_DATE =   (
                                                        SELECT 
                                                            MAX(create_date) 
                                                        FROM 
                                                            GTT_MW_TASK_INSTANCE                    m12, 
                                                            tte_start_terminator                    tte_st 
                                                        WHERE 
                                                            m12.source_process_instance_id      =   m11.source_process_instance_id      AND
                                                            m12.task_type_id                    =   tte_st.task_type_id                 AND 
                                                            tte_st.is_terminating_entity        =   'Y'
                                                    )
                        )                                                                                               AS  PROCESS_COMPLETE_DATE,
                        'UNKN'                                                                                          AS  TIMELINESS_STATUS
                    FROM    
                        GTT_MW_TASK_INSTANCE            m1
                        JOIN 
                            task_type_entity                tte
                        ON
                        (
                            m1.task_type_id         =   tte.task_type_id
                        )
                        JOIN 
                            D_BPM_ENTITY               e
                        ON 
                        (
                            tte.entity_id           =   e.entity_id
                        )
                        JOIN    
                            D_BPM_PROCESS               p
                        ON 
                        (
                            p.process_id            =   e.process_id
                        )
                        LEFT JOIN 
                            D_BPM_PROCESS_INSTANCE      pi
                        ON 
                        (
                            m1.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                    WHERE   
                        m1.source_process_instance_id IS NOT NULL           AND
                        pi.PROCESS_INSTANCE_ID  IS NULL
                    UNION ALL
                    SELECT 
                        DISTINCT 
                        pi.process_instance_id,
                        pi.process_id,
                        pi.process_name,
                        pi.process_description,
                        pi.parent_process_id,
                        NVL
                        (
                            pi.process_start_date,
                            (
                                SELECT 
                                    MIN(m10.create_date) 
                                FROM 
                                    D_MW_TASK_INSTANCE              m10, 
                                    tte_start_terminator            tte_st 
                                WHERE 
                                    m10.source_process_instance_id  =   mw.source_process_instance_id               AND
                                    m10.task_type_id                =   tte_st.task_type_id                         AND
                                    tte_st.is_starting_entity       =   'Y'
                            )
                        )                                                                                               AS  PROCESS_START_DATE,
                        NVL
                        (
                            pi.process_complete_date, 
                            (
                                SELECT  
                                    MAX(m11.COMPLETE_DATE) 
                                FROM 
                                    D_MW_TASK_INSTANCE                  m11, 
                                    tte_start_terminator                tte_st 
                                WHERE 
                                    m11.source_process_instance_id  =   mw.source_process_instance_id               AND
                                    m11.task_type_id                =   tte_st.task_type_id                         AND
                                    tte_st.is_terminating_entity    =   'Y'                                         AND
                                    m11.CREATE_DATE =   (
                                                            SELECT 
                                                                MAX(create_date) 
                                                            FROM 
                                                                D_MW_TASK_INSTANCE                      m12, 
                                                                tte_start_terminator                    tte_st 
                                                            WHERE 
                                                                m12.source_process_instance_id      =   m11.source_process_instance_id      AND
                                                                m12.task_type_id                    =   tte_st.task_type_id                 AND
                                                                tte_st.is_terminating_entity        =   'Y'
                                                        )
                            )
                        )                                                                                               AS  PROCESS_COMPLETE_DATE,
                        'UNKN'                                                                                          AS  TIMELINESS_STATUS
                    FROM 
                        D_MW_TASK_INSTANCE                  mw
                        JOIN 
                            D_BPM_PROCESS_INSTANCE          pi
                        ON
                        (
                            mw.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                    WHERE 
                        (
                            pi.PROCESS_COMPLETE_DATE IS NULL                AND
                            EXISTS  (
                                        SELECT 
                                            m11.COMPLETE_DATE 
                                        FROM 
                                            D_MW_TASK_INSTANCE                      m11, 
                                            tte_start_terminator                    tte_st 
                                        WHERE 
                                            m11.source_process_instance_id      =   mw.source_process_instance_id       AND
                                            m11.task_type_id                    =   tte_st.task_type_id                 AND
                                            tte_st.is_terminating_entity        =   'Y'                                 AND
                                            m11.complete_date is not null
                                    )
                        )                                                   OR
                        ( 
                                pi.PROCESS_START_DATE IS NULL       AND 
                                EXISTS  (
                                            SELECT  
                                                m10.create_date 
                                            FROM    
                                                D_MW_TASK_INSTANCE          m10, 
                                                tte_start_terminator        tte_st 
                                            WHERE 
                                                m10.source_process_instance_id  =   mw.source_process_instance_id       AND
                                                m10.task_type_id                =   tte_st.task_type_id                 AND
                                                tte_st.is_starting_entity       =   'Y'                                 AND
                                                m10.create_date is not null
                                        )
                        )

                )
            SELECT 
                nup.process_instance_id,
                nup.process_id,
                nup.process_name,
                nup.process_description,
                nup.parent_process_id,
                nup.process_start_date,
                nup.process_complete_date,
                CASE    
                    WHEN    nup.process_complete_date IS NULL 
                    THEN    'In Process'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                            round((nup.process_complete_date - nup.process_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Timely'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                            round((nup.process_complete_date - nup.process_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Untimely'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'B'    AND 
                            round(Bus_days_between(nup.process_start_date, nup.process_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Timely'
                ELSE 
                    'Untimely' 
                END                                                                                                     AS  TIMELINESS_STATUS
            FROM 
                new_updated_processes           nup
                JOIN 
                    D_BPM_PROCESS               p
                ON 
                (
                    p.process_id            =   nup.process_id
                )                                   
        )                                                                                                                   nu
        ON 
        (
            pi.process_instance_id  =   nu.process_instance_id
        )
        WHEN MATCHED 
        THEN
            UPDATE SET
                pi.process_start_date       =   nu.process_start_date,
                pi.process_complete_date    =   nu.process_complete_date,
                pi.timeliness_status        =   nu.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (    
                PROCESS_INSTANCE_ID,
                PROCESS_ID,
                PROCESS_NAME,
                PROCESS_DESCRIPTION,
                PARENT_PROCESS_ID,
                PROCESS_START_DATE,
                PROCESS_COMPLETE_DATE,
                TIMELINESS_STATUS
            )
            VALUES
            (    
                nu.process_instance_id,
                nu.process_id,
                nu.process_name,
                nu.process_description,
                nu.parent_process_id,
                nu.process_start_date,
                nu.process_complete_date,
                nu.timeliness_status
            )   
        ;

       -----------------------------------------------------------------------------
        --  Insert/Update into Entity Instance
        ----------------------------------------------------------------------------        
    MERGE 
        INTO    
            D_BPM_ENTITY_INSTANCE   ei
        USING
        (
            WITH    
                task_types              AS 
                ( -- Generate a distinct list of task_type_ids that are part of a process
                    SELECT
                        DISTINCT 
                        task_type_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                new_entity_instance     AS 
                ( -- Generate a list of new entity instance records

                    SELECT  
                        DISTINCT 
                        NULL                                AS  ENTITY_INSTANCE_ID, 
                        e.entity_id, 
                        e.entity_type_id, 
                        ti.source_process_instance_id       AS  PROCESS_INSTANCE_ID, 
                        e.entity_name, 
                        e.entity_description,
                        5                  AS  ENTITY_REFERENCE_TYPE,
                        ti.task_id                          AS  ENTITY_REFERENCE_ID ,
                        ti.create_date                      AS  START_DATE, 
                        ti.complete_date, 
                        'UNKN'                              AS  TIMELINESS_STATUS,
                        CASE    WHEN    TI.complete_date IS NULL 
                                THEN    'Y' 
                                ELSE    'N' 
                        END                                 AS  IS_ACTIVE, 
                        e.is_starting_entity, 
                        e.is_terminating_entity
                    FROM    
                        GTT_MW_TASK_INSTANCE                        ti
                        JOIN 
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON 
                        (
                            ti.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                        JOIN 
                            D_BPM_TASK_TYPE_ENTITY                  te
                        ON
                        (
                            ti.task_type_id                 =   te.task_type_id
                        )
                        JOIN 
                            D_BPM_ENTITY                            e 
                        ON
                        (
                            te.entity_id                    =   e.entity_id     AND
                            e.process_id                    =   pi.process_id
                        )
                    WHERE
                        NOT EXISTS  (
                                        SELECT  
                                            1
                                        FROM
                                            D_BPM_ENTITY_INSTANCE               ei
                                        WHERE
                                            ei.entity_reference_type        =   5               AND
                                            ei.entity_reference_id          =   ti.task_id
                                    )
                ),
                updated_entity_instance AS 
                ( -- Generate a list of updated entity instance records

                    SELECT  
                        ei.entity_instance_id,
                        ei.entity_id, 
                        ei.entity_type_id, 
                        ei.process_instance_id, 
                        ei.entity_name, 
                        ei.entity_description, 
                        ei.entity_reference_type,
                        ei.entity_reference_id,                    
                        ei.start_date, 
                        utl1.complete_date, 
                        'UNKN'                                          AS  TIMELINESS_STATUS,
                        CASE    
                            WHEN    utl1.complete_date IS NULL 
                            THEN    'Y' 
                        ELSE    
                            'N' 
                        END                                             AS  IS_ACTIVE, 
                        ei.IS_STARTING_ENTITY, 
                        ei.IS_TERMINATING_ENTITY
                    FROM    
                        D_BPM_ENTITY_INSTANCE                       ei
                        JOIN 
                            GTT_MW_TASK_INSTANCE                    utl1
                        ON 
                        (
                            ei.entity_reference_type            =   5      AND
                            ei.entity_reference_id              =   utl1.task_id            AND
                            ei.COMPLETE_DATE    IS NULL                                     AND
                            utl1.COMPLETE_DATE  IS NOT NULL
                        )
                ),
                new_updated_entities    AS 
                (
                    SELECT  
                        entity_instance_id,
                        entity_id,
                        entity_type_id,
                        process_instance_id,
                        entity_name,
                        entity_description,
                        entity_reference_type,
                        entity_reference_id,                              
                        start_date,
                        complete_date,
                        timeliness_status,
                        is_active,
                        is_starting_entity,
                        is_terminating_entity 
                    FROM    
                        new_entity_instance
                    UNION ALL
                    SELECT  
                        entity_instance_id,
                        entity_id,
                        entity_type_id,
                        process_instance_id,
                        entity_name,
                        entity_description,
                        entity_reference_type,
                        entity_reference_id,                              
                        start_date,
                        complete_date,
                        timeliness_status,
                        is_active,
                        is_starting_entity,
                        is_terminating_entity 
                    FROM    
                        updated_entity_instance
                )
                SELECT  
                    neu.entity_instance_id,              
                    neu.entity_id,
                    neu.entity_type_id,
                    neu.process_instance_id,
                    neu.entity_name,
                    neu.entity_description,
                    neu.entity_reference_type,
                    neu.entity_reference_id,                          
                    neu.start_date,
                    neu.complete_date,
                    CASE    
                        WHEN    neu.complete_date IS NULL 
                        THEN    'In Process'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'C'  AND 
                                round((neu.complete_date - neu.start_date),0) <= dbe.TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'C' AND 
                                round((neu.complete_date - neu.start_date),0) > dbe.TIMELINESS_THRESHOLD 
                        THEN    'Untimely'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'B' AND 
                                round(Bus_days_between(neu.start_date, neu.complete_date),0) <= dbe.TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                    ELSE    
                        'Untimely' 
                    END                                     AS  TIMELINESS_STATUS,
                    neu.IS_ACTIVE,
                    neu.IS_STARTING_ENTITY,
                    neu.IS_TERMINATING_ENTITY
                FROM    
                    new_updated_entities neu
                    JOIN 
                        D_BPM_ENTITY                                dbe
                    ON 
                    (
                        dbe.ENTITY_ID = neu.entity_id
                    )
        )                                                           nu
        ON
        (
            NU.entity_instance_id   =   ei.entity_instance_id   
        )
        WHEN MATCHED 
        THEN
            UPDATE SET 
                ei.complete_date        =   nu.complete_date,
                ei.is_active            =   nu.is_active,
                ei.timeliness_status    =   nu.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (
                ENTITY_INSTANCE_ID,
                ENTITY_ID,
                ENTITY_TYPE_ID,
                PROCESS_INSTANCE_ID,
                ENTITY_NAME,
                ENTITY_DESCRIPTION,
                ENTITY_REFERENCE_TYPE,
                ENTITY_REFERENCE_ID,      
                START_DATE,
                COMPLETE_DATE,
                TIMELINESS_STATUS,
                IS_ACTIVE,
                IS_STARTING_ENTITY,
                IS_TERMINATING_ENTITY
            )
            VALUES
            (
                SEQ_D_BPM_ENTITY_INSTANCE.NEXTVAL,
                nu.entity_id,
                nu.entity_type_id,
                nu.process_instance_id,
                nu.entity_name,
                nu.entity_description,
                nu.entity_reference_type,
                nu.entity_reference_id,                      
                nu.start_date,
                nu.complete_date,
                nu.timeliness_status,
                nu.is_active,
                nu.is_starting_entity,
                nu.is_terminating_entity
            );
            
        -----------------------------------------------------------------------------
        --  Insert into FLOW Instance
        ----------------------------------------------------------------------------            
 INSERT 
        INTO 
            D_BPM_FLOW_INSTANCE
            (    
                FLOW_INSTANCE_ID,
                FLOW_ID,
                PROCESS_INSTANCE_ID,
                FLOW_NAME,
                FLOW_DESCRIPTION,
                FLOW_SOURCE_ENTITY_INSTANCE_ID,
                FLOW_DEST_ENTITY_INST_ID,
                CREATED_DATE
            )
        SELECT 
            SEQ_D_BPM_FLOW_INSTANCE.NEXTVAL, 
            F.*
        FROM 
        (
            WITH 
                curr_flow_list      AS 
                ( -- Generate a list of all possible flow records by task_type_id
                    SELECT 
                        f.flow_id, 
                        f.process_id, 
                        f.flow_name, 
                        f.flow_description, 
                        f.flow_source_entity_id,
                        f.flow_destination_entity_id
                    FROM 
                        D_BPM_FLOW                      f
                ),
                new_flow_instance   AS 
                ( -- Generate a list of new flow instance records
                    SELECT 
                        DISTINCT 
                        cfl.flow_id, 
                        eis.process_instance_id                 AS  PROCESS_INSTANCE_ID, 
                        cfl.flow_name, 
                        cfl.flow_description, 
                        eis.entity_instance_id                  AS  FLOW_SOURCE_ENTITY_INSTANCE_ID,
                        eis.complete_date, 
                        eid.entity_instance_id                  AS  FLOW_DEST_ENTITY_INST_ID,
                        eid.start_date                          AS  CREATED_DATE
                    FROM 
                        curr_flow_list                              cfl
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                   eis
                        ON
                        (
                            eis.entity_id                       =   cfl.flow_source_entity_id
                        )
                        JOIN    
                            D_BPM_ENTITY_INSTANCE                   eid
                        ON
                        (
                            eid.entity_id                       =   cfl.flow_destination_entity_id
                        )
                        JOIN
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON
                        (
                            pi.process_instance_id              =   eis.process_instance_id
                        )                        
                    WHERE
                        eis.process_instance_id                 =   eid.process_instance_id     AND
                        eis.entity_instance_id                  !=  eid.entity_instance_id      AND
                        NOT EXISTS  ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                                        SELECT  
                                            1
                                        FROM  
                                            D_BPM_ENTITY_INSTANCE               eio          
                                        WHERE  
                                            eio.entity_id                   =   eid.entity_id               AND
                                            eio.start_date                  <   eid.start_date              AND
                                            eio.start_date                  >   eis.start_date              AND
                                            eio.entity_instance_id          !=  eid.entity_instance_id      AND
                                            eio.process_instance_id         =   eis.process_instance_id
                                    )
                )              
                SELECT 
                    DISTINCT 
                    nf.flow_id, 
                    nf.process_instance_id, 
                    nf.flow_name, 
                    nf.flow_description, 
                    nf.flow_source_entity_instance_id, 
                    nf.flow_dest_entity_inst_id, 
                    nf.created_date
                FROM 
                    new_flow_instance                   nf
                LEFT JOIN 
                    D_BPM_FLOW_INSTANCE                 fi
                ON 
                (
                    nf.flow_id                              =   fi.flow_id                          AND 
                    nf.process_instance_id                  =   fi.process_instance_id              AND 
                    nf.flow_source_entity_instance_id       =   fi.flow_source_entity_instance_id   AND 
                    nf.flow_dest_entity_inst_id             =   fi.flow_dest_entity_inst_id
                )
                WHERE 
                    fi.flow_id IS NULL
        ) F;          

        -----------------------------------------------------------------------------
        --  Insert into Process Segment Instance
        -----------------------------------------------------------------------------
 MERGE 
        INTO    
            D_BPM_PROCESS_SEGMENT_INSTANCE                      psi
        USING
        (
            WITH    
                curr_segment_list           AS 
                ( -- Generate a list of all possible segment records
                    SELECT 
                        DISTINCT 
                        ps.process_segment_id, 
                        ps.process_id, 
                        ps.process_segment_name, 
                        ps.process_segment_description, 
                        ps.process_timeliness_threshold, 
                        ps.process_timeliness_days_type,
                        ps.segment_start_entity_id,
                        ps.segment_finish_entity_id
                    FROM 
                        D_BPM_PROCESS_SEGMENT                   ps
                ),
                new_segment_instance        AS 
                ( -- Generate a list of new segment instance records
                    SELECT 
                        DISTINCT 
                        csl.process_segment_id,
                        eis.process_instance_id,
                        csl.process_segment_name,
                        csl.process_segment_description,
                        eis.entity_instance_id                      AS  SEGMENT_START_ENTITY_INST_ID,
                        eid.entity_instance_id                      AS  SEGMENT_END_ENTITY_INST_ID,
                        eis.start_date                              AS  PROCESS_SEGMENT_START_DATE,
                        eid.complete_date                           AS  PROCESS_SEGMENT_COMPLETE_DATE,
                        'UNKN' timeliness_status
                    FROM 
                        curr_segment_list                           csl
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                   eis
                        ON
                        (
                            eis.entity_id                       =   csl.segment_start_entity_id
                        )
                        JOIN    
                            D_BPM_ENTITY_INSTANCE                   eid
                        ON
                        (
                            eid.entity_id                       =   csl.segment_finish_entity_id
                        )
                        JOIN
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON
                        (
                            pi.process_instance_id              =   eis.process_instance_id
                        )                        
                        LEFT JOIN 
                            D_BPM_PROCESS_SEGMENT_INSTANCE          si
                        ON 
                        (
                            csl.process_segment_id              =   si.process_segment_id           AND 
                            eis.process_instance_id             =   si.process_instance_id          AND 
                            eis.entity_instance_id              =   si.segment_start_entity_inst_id AND 
                            eis.start_date                      =   si.process_segment_start_date   AND 
                            eid.entity_instance_id              =   si.segment_end_entity_inst_id
                        )
                    WHERE 
                        eis.process_instance_id                 =   eid.process_instance_id     AND
                        (
                            eis.entity_instance_id          !=  eid.entity_instance_id      OR
                            csl.segment_start_entity_id     =   csl.segment_finish_entity_id
                        )                                                                       AND
                        NOT EXISTS  ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                                        SELECT  
                                            1
                                        FROM  
                                            D_BPM_ENTITY_INSTANCE               eio          
                                        WHERE  
                                            eio.entity_id                   =   eid.entity_id               AND
                                            eio.start_date                  <   eid.start_date              AND
                                            eio.start_date                  >   eis.start_date              AND
                                            eio.entity_instance_id          !=  eid.entity_instance_id      AND
                                            eio.process_instance_id         =   eis.process_instance_id
                                    )                                                                       AND
                        si.PROCESS_INSTANCE_ID IS NULL
                ),
                updated_segment_instance        AS 
                ( -- Generate a list of updated segment instance records
                    SELECT 
                        si.PROCESS_SEGMENT_INSTANCE_ID,
                        si.PROCESS_SEGMENT_ID,
                        si.PROCESS_INSTANCE_ID,
                        si.PROCESS_SEGMENT_NAME,
                        si.PROCESS_SEGMENT_DESCRIPTION,
                        si.SEGMENT_START_ENTITY_INST_ID,
                        si.SEGMENT_END_ENTITY_INST_ID,
                        si.PROCESS_SEGMENT_START_DATE,
                        eid.complete_date                                       AS  PROCESS_SEGMENT_COMPLETE_DATE,
                        'UNKN'                                                  AS  TIMELINESS_STATUS
                    FROM 
                        D_BPM_PROCESS_SEGMENT_INSTANCE                              si
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                                   eid
                        ON 
                        (
                            si.SEGMENT_END_ENTITY_INST_ID       =   eid.entity_instance_id
                        )
                    WHERE 
                        COALESCE(eid.complete_date,to_date('1/1/1900','dd/mm/yyyy')) != COALESCE(si.process_segment_complete_date,to_date('1/1/1900','dd/mm/yyyy'))
                ),
                new_updated_segments       AS 
                (
                    SELECT 
                        1       AS  process_segment_instance_id, 
                        si.* 
                    FROM 
                        new_segment_instance            si
                    UNION
                    SELECT 
                        * 
                    FROM 
                        updated_segment_instance
                )
                SELECT 
                    nus.process_segment_instance_id,
                    nus.process_segment_id,
                    nus.process_instance_id,
                    nus.process_segment_name,
                    nus.process_segment_description,
                    nus.segment_start_entity_inst_id,
                    nus.segment_end_entity_inst_id,
                    nus.process_segment_start_date,
                    nus.process_segment_complete_date,
                    CASE 
                        WHEN    nus.process_segment_complete_date IS NULL 
                        THEN    'In Process'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                                round((nus.process_segment_complete_date - nus.process_segment_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                                round((nus.process_segment_complete_date - nus.process_segment_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Untimely'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'B'    AND
                                round(Bus_days_between(nus.process_segment_start_date, nus.process_segment_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                    ELSE        
                        'Untimely' 
                    END timeliness_status
                FROM 
                    new_updated_segments        nus
                    JOIN 
                        D_BPM_PROCESS_SEGMENT   p
                    ON 
                    (
                        p.process_segment_id    =   nus.process_segment_id
                    )
        ) nu
        ON 
        (
            psi.process_segment_instance_id     =   NU.process_segment_instance_id
        )
        WHEN MATCHED 
        THEN
            UPDATE SET 
                psi.process_segment_complete_date   =   NU.process_segment_complete_date,
                psi.timeliness_status               =   NU.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (    
                PROCESS_SEGMENT_INSTANCE_ID,
                PROCESS_SEGMENT_ID,
                PROCESS_INSTANCE_ID,
                PROCESS_SEGMENT_NAME,
                PROCESS_SEGMENT_DESCRIPTION,
                SEGMENT_START_ENTITY_INST_ID,
                SEGMENT_END_ENTITY_INST_ID,
                PROCESS_SEGMENT_START_DATE,
                PROCESS_SEGMENT_COMPLETE_DATE,
                TIMELINESS_STATUS
            )
            VALUES
            (    
                SEQ_D_BPM_SEGMENT_INSTANCE.NEXTVAL,
                NU.PROCESS_SEGMENT_ID,
                NU.PROCESS_INSTANCE_ID,
                NU.PROCESS_SEGMENT_NAME,
                NU.PROCESS_SEGMENT_DESCRIPTION,
                NU.SEGMENT_START_ENTITY_INST_ID,
                NU.SEGMENT_END_ENTITY_INST_ID,
                NU.PROCESS_SEGMENT_START_DATE,
                NU.PROCESS_SEGMENT_COMPLETE_DATE,
                NU.TIMELINESS_STATUS
            )        ;

 -----------------------------------------------------------------------------
        --  Insert/Upadte Fact Process By Date
        -----------------------------------------------------------------------------
 MERGE 
        INTO 
            F_BPM_PROCESS_BY_DATE           pbd
        USING
        (
            SELECT 
                DISTINCT
                pi.process_id,
                ddate.d_date                                                                    AS  D_DATE,
                pi.PROCESS_NAME,
                SUM
                (
                    CASE
                        WHEN    pi.process_complete_date IS NOT NULL            AND 
                                TRUNC(pi.process_complete_date) = ddate.d_date 
                        THEN    1 
                    ELSE
                        0 
                    END
                ) OVER (PARTITION BY pi.process_id, ddate.d_date)                               AS  COMPLETE_PROCESS_COUNT,
                SUM
                (
                    CASE 
                        WHEN    pi.process_complete_date IS NULL 
                        THEN    1 
                    ELSE 
                        0 
                    END
                )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  ACTIVE_PROCESS_COUNT,
                ROUND
                (
                    AVG
                    (
                        CASE 
                            WHEN    pi.PROCESS_COMPLETE_DATE IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  AVG_PROCESS_AGE,
                ROUND
                (
                    MIN
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MIN_PROCESS_AGE,
                ROUND
                (
                    MAX
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MAX_PROCESS_AGE,
                ROUND
                (
                    AVG
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NOT NULL 
                            THEN    pi.process_complete_date - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  AVG_PROCESS_COMPLETE_TIME,
                ROUND
                (
                    MIN
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NOT NULL 
                            THEN    pi.process_complete_date - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MIN_PROCESS_COMPLETE_TIME,
                ROUND
                (
                    MAX
                    (
                        CASE 
                            WHEN    pi.PROCESS_COMPLETE_DATE IS NOT NULL 
                            THEN    pi.PROCESS_COMPLETE_DATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MAX_PROCESS_COMPLETE_TIME,
                SUM
                (
                    CASE 
                        WHEN    upper(pi.timeliness_status) = 'TIMELY' 
                        THEN    1 
                        ELSE    0 
                    END
                )   over (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  TIMELY_PROCESS_COUNT,
                SUM
                (
                    CASE 
                        WHEN    upper(pi.timeliness_status) = 'UNTIMELY' 
                        THEN    1 
                        ELSE    0 
                    END
                )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  UNTIMELY_PROCESS_COUNT
            FROM 
                D_BPM_PROCESS_INSTANCE          pi
                JOIN 
                    BPM_D_DATES                 ddate
                ON 
                (
                    ddate.D_DATE = TRUNC(pi.process_start_date)
                )
        )                                                                                           pi
        ON 
        (
            pbd.process_id  =   pi.PROCESS_ID   AND 
            pbd.d_date      =   pi.d_date
        )
        WHEN MATCHED THEN
            UPDATE SET 
                pbd.complete_process_count      =   pi.complete_process_count,
                pbd.active_process_count        =   pi.active_process_count,
                pbd.avg_process_age             =   pi.avg_process_age,
                pbd.min_process_age             =   pi.min_process_age,
                pbd.max_process_age             =   pi.max_process_age,
                pbd.avg_process_complete_time   =   pi.avg_process_complete_time,
                pbd.min_process_complete_time   =   pi.min_process_complete_time,
                pbd.max_process_complete_time   =   pi.max_process_complete_time,
                pbd.timely_process_count        =   pi.timely_process_count,
                pbd.untimely_process_count      =   pi.untimely_process_count
        WHEN NOT MATCHED THEN
            INSERT
                (
                    PROCESS_ID,
                    D_DATE,
                    PROCESS_NAME,
                    COMPLETE_PROCESS_COUNT,
                    ACTIVE_PROCESS_COUNT,
                    AVG_PROCESS_AGE,
                    MIN_PROCESS_AGE,
                    MAX_PROCESS_AGE,
                    AVG_PROCESS_COMPLETE_TIME,
                    MIN_PROCESS_COMPLETE_TIME,
                    MAX_PROCESS_COMPLETE_TIME,
                    TIMELY_PROCESS_COUNT,
                    UNTIMELY_PROCESS_COUNT
                )
                VALUES
                (
                    pi.process_id,
                    pi.d_date,
                    pi.process_name,
                    pi.complete_process_count,
                    pi.active_process_count,
                    pi.avg_process_age,
                    pi.min_process_age,
                    pi.max_process_age,
                    pi.avg_process_complete_time,
                    pi.min_process_complete_time,
                    pi.max_process_complete_time,
                    pi.timely_process_count,
                    pi.untimely_process_count
                );        
  
  COMMIT;
  END;                

PROCEDURE REFRESH_MW_DATA AS
  v_num_days_add NUMBER;
  BEGIN
    SELECT TO_NUMBER(value)
    INTO v_num_days_add
    FROM corp_etl_control
    WHERE name = 'REFRESH_DEMO_DATA_NUMDAYS';
    
    UPDATE arena_task_data
    SET create_date = create_date + v_num_days_add
     ,complete_date = complete_date + v_num_days_add
     ,instance_start_date = instance_start_date + v_num_days_add
     ,status_date = status_date + v_num_days_add
     ,last_update_date = last_update_date + v_num_days_add
     ,work_receipt_date = work_receipt_date + v_num_days_add
     ,claim_date = claim_date + v_num_days_add;
    
    COMMIT; 
    
    LOAD_MW_SIM_DATA;
    LOAD_ACTUALS_DATA;
    POPULATE_PROCESS_INSTANCE;
    
    COMMIT;
  END;
END;
/