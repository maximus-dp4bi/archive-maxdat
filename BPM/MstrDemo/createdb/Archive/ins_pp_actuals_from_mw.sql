--MW Arrivals
DECLARE
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
/
--MW Completions
DECLARE
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
/
--MW Inventory Jeopardy
DECLARE
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
/

--MW Inventory Min/Max
DECLARE
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
 /
 --Handle Time/Staff
 DECLARE
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
  /
--MW Inventory Avg Age
DECLARE
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
/

--Avg Handle Times and Staff Hours From MW_Tasks
DECLARE
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
  /
--MW Actual Details Arrivals
DECLARE
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
/
--MW Actual Details Completions
DECLARE
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
/
--Actuals Backfill Missing Days

DECLARE
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
/