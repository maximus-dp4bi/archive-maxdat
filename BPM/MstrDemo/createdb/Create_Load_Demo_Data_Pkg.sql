CREATE OR REPLACE PACKAGE LOAD_DEMO_DATA_PKG AS

  PROCEDURE TRUNCATE_PP_TABLE;
  PROCEDURE LOAD_PP_STAGE;
  PROCEDURE INS_PP_HORIZON;
  PROCEDURE INS_PP_FORECAST_STG;
  PROCEDURE UPD_FORECAST_INVENTORY;
  PROCEDURE UPD_FORECAST_INTAKE;
  PROCEDURE UPD_FORECAST_COMPLETIONS;
  PROCEDURE UPD_INVENTORY_AVG_AGE;
  PROCEDURE UPD_INVENTORY_MINMAX_AGE;
  PROCEDURE UPD_FORECAST_JEOPARDY;
  PROCEDURE UPD_FORECAST_HOURS_ASSIGNED;
  PROCEDURE UPD_FORECAST_HANDLE_TIMES;
  PROCEDURE UPD_FORECAST_PROCESS_FLAG;
  PROCEDURE INS_PPD_PLAN_HORIZON;
  PROCEDURE INS_PP_F_FORECAST;
  PROCEDURE UPD_FORECAST_STG;
  PROCEDURE LOAD_FORECAST_DATA;
  PROCEDURE REFRESH_PP_TABLES;
  PROCEDURE REFRESH_ALL_DEMO_DATA;
END;
/
CREATE OR REPLACE PACKAGE BODY LOAD_DEMO_DATA_PKG AS

PROCEDURE TRUNCATE_PP_TABLE AS
  BEGIN
    
    DELETE FROM PP_STG_FCST_BY_INV_AGE;
    DELETE FROM PP_STG_FCST_VOLUME;
    DELETE FROM PP_F_FORECAST;
    
    COMMIT;  
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PP_STG_FORECAST';
  
  END;
PROCEDURE LOAD_PP_STAGE AS
  BEGIN
    
    INSERT INTO PP_STG_FCST_VOLUME(HORIZON_START_DATE
    ,HORIZON_END_DATE
    ,DAY_OF_PLAN
    ,FORECAST_HOUR
    ,UNIT_OF_WORK_NAME
    ,ARRIVAL_VOLUME
    ,COMPLETION_VOLUME
    ,STAFF_HOURS
    ,HANDLE_TIME_AVG
    ,HANDLE_TIME_MIN
    ,HANDLE_TIME_MAX
    ,CFG_PRODUCTION_PLAN_ID)
    SELECT horizon_start_date
    ,horizon_end_date
    ,day_of_plan
    ,forecast_hour
    ,unit_of_work_name
    ,arrival_volume
    ,completion_volume
    ,staff_hours
    ,handle_time_avg
    ,handle_time_min
    ,handle_time_max
    ,cfg_production_plan_id
    FROM pp_fcst_volume_data_ffile
    WHERE process_date IS NULL;

    INSERT INTO PP_STG_FCST_BY_INV_AGE(
    HORIZON_START_DATE
    ,HORIZON_END_DATE
    ,DAY_OF_PLAN
    ,FORECAST_HOUR
    ,UNIT_OF_WORK_NAME
    ,INVENTORY_AGE
    ,INVENTORY_VOLUME
    ,CFG_PRODUCTION_PLAN_ID)
    SELECT horizon_start_date
    ,horizon_end_date
    ,day_of_plan
    ,forecast_hour
    ,unit_of_work_name
    ,inventory_age
    ,inventory_volume
    ,cfg_production_plan_id
    FROM pp_fcst_inventory_data_ffile
    WHERE process_date IS NULL;
    
    UPDATE PP_STG_FCST_VOLUME
       SET FORECAST_DATE = TRUNC(HORIZON_START_DATE + (DAY_OF_PLAN - 1)) WHERE FORECAST_DATE IS NULL;
    
    UPDATE PP_STG_FCST_BY_INV_AGE
       SET FORECAST_DATE = TRUNC(HORIZON_START_DATE + (DAY_OF_PLAN - 1)) WHERE FORECAST_DATE IS NULL;
    COMMIT;
  END;
  
PROCEDURE INS_PP_HORIZON AS

  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;  
  
  BEGIN
      FOR RECS IN 
      (         
        SELECT PP_CFG_HORIZON.CFG_HORIZON_ID,
               (SELECT MAX(FORECAST_VERSION)
                  FROM PP_STG_FORECAST
                 WHERE CFG_HORIZON_ID IN (PP_CFG_HORIZON.CFG_HORIZON_ID)) AS FORECAST_VERSION
          FROM PP_CFG_HORIZON,
               (SELECT DISTINCT CFG_PRODUCTION_PLAN_ID,
                                HORIZON_START_DATE,
                                HORIZON_END_DATE
                  FROM PP_STG_FCST_BY_INV_AGE
                 WHERE CFG_PRODUCTION_PLAN_ID = 1
                   AND PROCESS_DATE IS NULL) INV
         WHERE PP_CFG_HORIZON.CFG_PRODUCTION_PLAN_ID = INV.CFG_PRODUCTION_PLAN_ID
           AND PP_CFG_HORIZON.HORIZON_START_DATE = INV.HORIZON_START_DATE
           AND PP_CFG_HORIZON.HORIZON_END_DATE = INV.HORIZON_END_DATE
                   
        ) 
        LOOP
            
       UPDATE PP_STG_FORECAST
          SET END_DATE = SYSDATE
        WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
          AND FORECAST_VERSION = RECS.FORECAST_VERSION;
    
        V_CNT := V_CNT + 1;
        END LOOP;
   
        IF v_cnt = 0 THEN
           --if horizon does not exist
          INSERT INTO PP_CFG_HORIZON
             (CFG_HORIZON_ID, CFG_PRODUCTION_PLAN_ID, HORIZON_START_DATE, HORIZON_START_HOUR, HORIZON_END_DATE, 
              HORIZON_END_HOUR, HORIZON_NAME, HORIZON_DESCRIPTION, CREATE_DATE, LAST_UPDATE_DATE)
          SELECT SEQ_CFG_HORIZON_ID.NEXTVAL AS NXVL,
                 INV.CFG_PRODUCTION_PLAN_ID,
                 INV.HORIZON_START_DATE,
                 0 AS HSH,
                 INV.HORIZON_END_DATE,
                 0 AS HEH,
                 TO_CHAR(INV.HORIZON_START_DATE, 'MM/DD/YYYY') || ' - ' || TO_CHAR(INV.HORIZON_END_DATE, 'MM/DD/YYYY') AS HZNAME,
                 NULL,
                 SYSDATE,
                 SYSDATE
            FROM (SELECT DISTINCT CFG_PRODUCTION_PLAN_ID,
                                  HORIZON_START_DATE,
                                  HORIZON_END_DATE
                    FROM PP_STG_FCST_BY_INV_AGE
                   WHERE CFG_PRODUCTION_PLAN_ID = 1
                     AND PROCESS_DATE IS NULL) INV;
                     
        END IF;
   
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Update Prev Version End Date - Processed ' || V_CNT, SYSDATE); 
        COMMIT;
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Update Prev Version End Date - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
  END;  

--Stage Forecast  
PROCEDURE INS_PP_FORECAST_STG  AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;

  BEGIN
      FOR RECS IN 
      (
          SELECT INV.HORIZON_START_DATE,
                          INV.HORIZON_END_DATE,
                          (SELECT CFG_UOW_ID
                             FROM PP_CFG_UNIT_OF_WORK
                            WHERE UNIT_OF_WORK_NAME = INV.UNIT_OF_WORK_NAME) AS UOW_ID,
                          INV.FORECAST_DATE,
                          INV.FORECAST_HOUR,
                          INV.IDENTIFIER,
                          (SELECT CFG_HORIZON_ID
                             FROM PP_CFG_HORIZON
                            WHERE CFG_PRODUCTION_PLAN_ID = 1
                              AND TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') =
                                  INV.HORIZON_START_DATE
                              AND HORIZON_START_HOUR = 0
                              AND TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') =
                                  INV.HORIZON_END_DATE
                              AND HORIZON_END_HOUR = 0) AS CFG_HORIZON_ID,
                          (SELECT NVL(MAX(FORECAST_VERSION), 0) + 1
                             FROM PP_STG_FORECAST
                            WHERE CFG_HORIZON_ID =
                                  (SELECT CFG_HORIZON_ID
                                     FROM PP_CFG_HORIZON
                                    WHERE CFG_PRODUCTION_PLAN_ID = 1
                                      AND TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') = INV.HORIZON_START_DATE
                                      AND HORIZON_START_HOUR = 0
                                      AND TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') = INV.HORIZON_END_DATE
                                      AND HORIZON_END_HOUR = 0)) AS STG_FORECAST_VERSION
                     FROM (SELECT DISTINCT CFG_PRODUCTION_PLAN_ID,
                                           TO_CHAR(HORIZON_START_DATE,'MM/DD/YYYY') AS HORIZON_START_DATE,
                                           TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                                           TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                                           TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                                           FORECAST_HOUR,
                                           TRIM(UNIT_OF_WORK_NAME) ||
                                           TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                                           TO_CHAR(FORECAST_HOUR) AS IDENTIFIER
                             FROM PP_STG_FCST_BY_INV_AGE
                            WHERE CFG_PRODUCTION_PLAN_ID = 1
                              AND PROCESS_DATE IS NULL) INV
                   
        ) 
        LOOP
            INSERT INTO PP_STG_FORECAST
              (SPPF_ID,
               CFG_HORIZON_ID,
               FORECAST_DATE,
               FORECAST_HOUR,
               CFG_UOW_ID,
               FORECAST_VERSION,
               EFFECTIVE_DATE,
               END_DATE,
               IDENTIFIER)
            VALUES
              (SEQ_SPPF_ID.NEXTVAL,
               RECS.CFG_HORIZON_ID,
               TO_DATE(RECS.FORECAST_DATE, 'MM/dd/yyyy'),
               RECS.FORECAST_HOUR,
               RECS.UOW_ID,
               RECS.STG_FORECAST_VERSION,
               SYSDATE,
               TO_DATE('07/7/7777', 'MM/dd/yyyy'),
               RECS.IDENTIFIER);
    
        V_CNT := V_CNT + 1;
        END LOOP;
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc UOW - Processed ' || V_CNT, SYSDATE); 
        COMMIT;
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc UOW - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
  END;

--Forecast Inventory
PROCEDURE UPD_FORECAST_INVENTORY AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
      FOR RECS IN 
      (
          WITH ALL_RECS AS
          (
            SELECT FRCST_INV_VOL,
                   CFG_PRODUCTION_PLAN_ID,
                   TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                   UNIT_OF_WORK_NAME,
                   TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                   TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                   FORECAST_HOUR,
                   (TRIM(UNIT_OF_WORK_NAME) || TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                   TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
              FROM (SELECT SUM(INVENTORY_VOLUME) AS FRCST_INV_VOL,
                           CFG_PRODUCTION_PLAN_ID,
                           TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                           FORECAST_DATE,
                           HORIZON_START_DATE,
                           HORIZON_END_DATE,
                           FORECAST_HOUR
                      FROM PP_STG_FCST_BY_INV_AGE INV
                     WHERE INV.CFG_PRODUCTION_PLAN_ID = 1
                       AND INV.PROCESS_DATE IS NULL
                     GROUP BY CFG_PRODUCTION_PLAN_ID,
                              UNIT_OF_WORK_NAME,
                              FORECAST_DATE,
                              HORIZON_START_DATE,
                              HORIZON_END_DATE,
                              FORECAST_HOUR)
          ),
          HRZN AS 
          (
              SELECT DISTINCT CFG_HORIZON_ID
                FROM PP_CFG_HORIZON CFG, ALL_RECS
               WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
                 AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                     ALL_RECS.HORIZON_START_DATE
                 AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                     ALL_RECS.HORIZON_END_DATE
                 AND CFG.HORIZON_START_HOUR = 0
                 AND CFG.HORIZON_END_HOUR = 0
          ),
          VRSN AS
          (
               SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
                 FROM PP_STG_FORECAST, HRZN
                WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
          ) 
          SELECT ALL_RECS.FRCST_INV_VOL,
                 ALL_RECS.CFG_PRODUCTION_PLAN_ID,
                 ALL_RECS.FORECAST_DATE,
                 ALL_RECS.UNIT_OF_WORK_NAME,
                 ALL_RECS.HORIZON_START_DATE,
                 ALL_RECS.HORIZON_END_DATE,
                 ALL_RECS.FORECAST_HOUR,
                 ALL_RECS.IDENTIFIER,
                 HRZN.CFG_HORIZON_ID,
                 VRSN.FORECAST_VERSION
            FROM ALL_RECS, HRZN, VRSN
            ORDER BY ALL_RECS.UNIT_OF_WORK_NAME, ALL_RECS.FORECAST_DATE, ALL_RECS.FORECAST_HOUR 
        ) 
        LOOP
            UPDATE PP_STG_FORECAST
               SET INVENTORY = RECS.FRCST_INV_VOL
             WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
               AND IDENTIFIER = RECS.IDENTIFIER
               AND CFG_UOW_ID = (SELECT CFG_UOW_ID FROM PP_CFG_UNIT_OF_WORK WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
               AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
               AND FORECAST_HOUR = RECS.FORECAST_HOUR
               AND FORECAST_VERSION = RECS.FORECAST_VERSION
               AND PROCESS_DATE IS NULL;
    
        V_CNT := V_CNT + 1;
        END LOOP;
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Inventory - Processed ' || V_CNT, SYSDATE); 
        COMMIT;
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Inventory - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
  END;

--Proc Forecast Intake
PROCEDURE UPD_FORECAST_INTAKE AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;

  BEGIN
    FOR RECS IN 
    (
          WITH ALL_RECS AS
          (
              SELECT CFG_PRODUCTION_PLAN_ID,
                     FRCST_INTAKE_VOL,
                     TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                     FORECAST_HOUR,
                     UNIT_OF_WORK_NAME,
                     TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                     TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                     IDENTIFIER
                FROM (SELECT SUM(ARRIVAL_VOLUME) AS FRCST_INTAKE_VOL,
                             CFG_PRODUCTION_PLAN_ID,
                             FORECAST_DATE,
                             FORECAST_HOUR,
                             UNIT_OF_WORK_NAME,
                             HORIZON_START_DATE,
                             HORIZON_END_DATE,
                             (TRIM(UNIT_OF_WORK_NAME) ||
                             TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                             TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                        FROM (SELECT CFG_PRODUCTION_PLAN_ID,
                                     FORECAST_DATE,
                                     FORECAST_HOUR,
                                     ARRIVAL_VOLUME,
                                     TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                                     HORIZON_START_DATE,
                                     HORIZON_END_DATE
                                FROM PP_STG_FCST_VOLUME
                               WHERE CFG_PRODUCTION_PLAN_ID = 1
                                 AND PROCESS_DATE IS NULL)
                       GROUP BY CFG_PRODUCTION_PLAN_ID,
                                FORECAST_DATE,
                                FORECAST_HOUR,
                                UNIT_OF_WORK_NAME,
                                HORIZON_START_DATE,
                                HORIZON_END_DATE,
                                (TRIM(UNIT_OF_WORK_NAME) ||
                                TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                                TO_CHAR(FORECAST_HOUR))
                       ORDER BY UNIT_OF_WORK_NAME, FORECAST_DATE, FORECAST_HOUR)
               WHERE CFG_PRODUCTION_PLAN_ID = 1
          ),
          HRZN AS 
          (
              SELECT DISTINCT CFG_HORIZON_ID
                FROM PP_CFG_HORIZON CFG, ALL_RECS
               WHERE CFG.CFG_PRODUCTION_PLAN_ID =
                     ALL_RECS.CFG_PRODUCTION_PLAN_ID
                 AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                     ALL_RECS.HORIZON_START_DATE
                 AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                     ALL_RECS.HORIZON_END_DATE
                 AND CFG.HORIZON_START_HOUR = 0
                 AND CFG.HORIZON_END_HOUR = 0
          ),
          VRSN AS
          (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
          ) 
          SELECT ALL_RECS.FRCST_INTAKE_VOL,
                 ALL_RECS.CFG_PRODUCTION_PLAN_ID,
                 ALL_RECS.FORECAST_DATE,
                 ALL_RECS.UNIT_OF_WORK_NAME,
                 ALL_RECS.HORIZON_START_DATE,
                 ALL_RECS.HORIZON_END_DATE,
                 ALL_RECS.FORECAST_HOUR,
                 ALL_RECS.IDENTIFIER,
                 HRZN.CFG_HORIZON_ID,
                 VRSN.FORECAST_VERSION
            FROM ALL_RECS, HRZN, VRSN
           ORDER BY ALL_RECS.UNIT_OF_WORK_NAME,
                    ALL_RECS.FORECAST_DATE,
                    ALL_RECS.FORECAST_HOUR
  
      ) 
      LOOP
          UPDATE PP_STG_FORECAST
             SET ARRIVAL = RECS.FRCST_INTAKE_VOL
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
             AND IDENTIFIER = RECS.IDENTIFIER
             AND CFG_UOW_ID = (SELECT CFG_UOW_ID FROM PP_CFG_UNIT_OF_WORK WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
             AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
             AND FORECAST_HOUR = RECS.FORECAST_HOUR
             AND FORECAST_VERSION = RECS.FORECAST_VERSION
             AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Intake - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Intake - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Proc Forecast Completions
PROCEDURE UPD_FORECAST_COMPLETIONS AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
    FOR RECS IN 
    (
         WITH ALL_RECS AS
         (
            SELECT CFG_PRODUCTION_PLAN_ID,
                   FRCST_COMP_VOL,
                   TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                   FORECAST_HOUR,
                   UNIT_OF_WORK_NAME,
                   TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                   TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                   IDENTIFIER
              FROM (SELECT SUM(COMPLETION_VOLUME) AS FRCST_COMP_VOL,
                           CFG_PRODUCTION_PLAN_ID,
                           FORECAST_DATE,
                           FORECAST_HOUR,
                           UNIT_OF_WORK_NAME,
                           HORIZON_START_DATE,
                           HORIZON_END_DATE,
                           (TRIM(UNIT_OF_WORK_NAME) ||
                           TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                           TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                      FROM (SELECT CFG_PRODUCTION_PLAN_ID,
                                   FORECAST_DATE,
                                   FORECAST_HOUR,
                                   COMPLETION_VOLUME,
                                   TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                                   HORIZON_START_DATE,
                                   HORIZON_END_DATE
                              FROM PP_STG_FCST_VOLUME
                             WHERE CFG_PRODUCTION_PLAN_ID = 1 
                               AND PROCESS_DATE IS NULL)
                     GROUP BY CFG_PRODUCTION_PLAN_ID,
                              FORECAST_DATE,
                              FORECAST_HOUR,
                              UNIT_OF_WORK_NAME,
                              HORIZON_START_DATE,
                              HORIZON_END_DATE,
                              (TRIM(UNIT_OF_WORK_NAME) ||
                              TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                              TO_CHAR(FORECAST_HOUR)))
             WHERE CFG_PRODUCTION_PLAN_ID = 1
        ),
        HRZN AS
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
           SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
             FROM PP_STG_FORECAST, HRZN
            WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        )
        SELECT ALL_RECS.FRCST_COMP_VOL,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.FORECAST_DATE,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               ALL_RECS.FORECAST_HOUR,
               ALL_RECS.IDENTIFIER,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN
         ORDER BY ALL_RECS.UNIT_OF_WORK_NAME,
                  ALL_RECS.FORECAST_DATE,
                  ALL_RECS.FORECAST_HOUR
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST
             SET COMPLETION = RECS.FRCST_COMP_VOL
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
             AND IDENTIFIER = RECS.IDENTIFIER
             AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                 FROM PP_CFG_UNIT_OF_WORK
                                WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
             AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
             AND FORECAST_HOUR = RECS.FORECAST_HOUR
             AND FORECAST_VERSION = RECS.FORECAST_VERSION
             AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Completions - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Completions - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Proc Inv Avg Age
PROCEDURE UPD_INVENTORY_AVG_AGE AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
    FOR RECS IN 
    (
        WITH ALL_RECS AS
        (
         SELECT NVL(AVG_AGE, 0) AS AVG_AGE,
               CFG_PRODUCTION_PLAN_ID,
               TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
               UNIT_OF_WORK_NAME,
               TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
               TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
               FORECAST_HOUR,
               IDENTIFIER
              FROM (SELECT SUM(PRODUCT) /
                     DECODE(SUM(INVENTORY_VOLUME), 0, 1, SUM(INVENTORY_VOLUME)) AS AVG_AGE,
                     CFG_PRODUCTION_PLAN_ID,
                     UNIT_OF_WORK_NAME,
                     FORECAST_DATE,
                     HORIZON_START_DATE,
                     HORIZON_END_DATE,
                     FORECAST_HOUR,
                     (TRIM(UNIT_OF_WORK_NAME) || TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                     TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                FROM (SELECT INVENTORY_VOLUME * INVENTORY_AGE AS PRODUCT,
                             INVENTORY_VOLUME,
                             INVENTORY_AGE,
                             CFG_PRODUCTION_PLAN_ID,
                             TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                             FORECAST_DATE,
                             HORIZON_START_DATE,
                             HORIZON_END_DATE,
                             FORECAST_HOUR
                        FROM PP_STG_FCST_BY_INV_AGE INV
                       WHERE INV.CFG_PRODUCTION_PLAN_ID = 1
                         AND INV.PROCESS_DATE IS NULL)
               GROUP BY CFG_PRODUCTION_PLAN_ID,
                        UNIT_OF_WORK_NAME,
                        FORECAST_DATE,
                        HORIZON_START_DATE,
                        HORIZON_END_DATE,
                        FORECAST_HOUR,
                        TRIM(UNIT_OF_WORK_NAME) || TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                        TO_CHAR(FORECAST_HOUR))
  
        ),
        HRZN AS 
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        ) 
        SELECT ALL_RECS.AVG_AGE,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.FORECAST_DATE,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               ALL_RECS.FORECAST_HOUR,
               ALL_RECS.IDENTIFIER,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN
          ORDER BY ALL_RECS.UNIT_OF_WORK_NAME, ALL_RECS.FORECAST_DATE, ALL_RECS.FORECAST_HOUR           
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST
             SET INVENTORY_AGE_AVG   = RECS.AVG_AGE
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
                     AND IDENTIFIER = RECS.IDENTIFIER
                     AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                         FROM PP_CFG_UNIT_OF_WORK
                                        WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
                     AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
                     AND FORECAST_HOUR = RECS.FORECAST_HOUR
                     AND FORECAST_VERSION = RECS.FORECAST_VERSION
                     AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Inv Avg Age - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Inv Avg Age - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;    

--Proc Inv Min Max Age
PROCEDURE UPD_INVENTORY_MINMAX_AGE AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
    FOR RECS IN 
    (
        WITH ALL_RECS AS
        (
          SELECT MIN(INVENTORY_AGE) AS MIN_AGE,
                 MAX(INVENTORY_AGE) AS MAX_AGE,
                 CFG_PRODUCTION_PLAN_ID,
                 UNIT_OF_WORK_NAME,
                 TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                 TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE
                 FROM
                 (
                  SELECT INVENTORY_AGE,
                         CFG_PRODUCTION_PLAN_ID,
                         TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                         HORIZON_START_DATE,
                         HORIZON_END_DATE
                    FROM PP_STG_FCST_BY_INV_AGE INV
                   WHERE INV.CFG_PRODUCTION_PLAN_ID = 1
                     AND INV.PROCESS_DATE IS NULL)
                     GROUP BY CFG_PRODUCTION_PLAN_ID,
                                        UNIT_OF_WORK_NAME,
                                        HORIZON_START_DATE,
                                        HORIZON_END_DATE
  
        ),
        HRZN AS 
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        ) 
        SELECT ALL_RECS.MIN_AGE,
               ALL_RECS.MAX_AGE,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN      
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST
             SET INVENTORY_AGE_MIN   = RECS.MIN_AGE, 
                 INVENTORY_AGE_MAX   = RECS.MAX_AGE           
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
                     AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                         FROM PP_CFG_UNIT_OF_WORK
                                        WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
                     AND FORECAST_VERSION = RECS.FORECAST_VERSION
                     AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Inv Min Max Age - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Inv Min Max Age - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;                           

--Proc Forecast Jeopardy
PROCEDURE UPD_FORECAST_JEOPARDY AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
    FOR RECS IN 
    (
        WITH ALL_RECS AS
        (
          SELECT NVL(JEP_COUNT, 0) AS JEP_COUNT,
               CFG_PRODUCTION_PLAN_ID,
               TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
               UNIT_OF_WORK_NAME,
               TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
               TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
               FORECAST_HOUR,
               IDENTIFIER
          FROM (SELECT JEP_COUNT,
                       CFG_PRODUCTION_PLAN_ID,
                       FORECAST_DATE,
                       FORECAST_HOUR,
                       UNIT_OF_WORK_NAME,
                       HORIZON_START_DATE,
                       HORIZON_END_DATE,
                       (TRIM(UNIT_OF_WORK_NAME) ||
                       TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                       TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                  FROM (SELECT SUM(INVENTORY_VOLUME) AS JEP_COUNT,
                               CFG_PRODUCTION_PLAN_ID,
                               TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                               FORECAST_DATE,
                               HORIZON_START_DATE,
                               HORIZON_END_DATE,
                               FORECAST_HOUR
                          FROM PP_STG_FCST_BY_INV_AGE T1
                         WHERE 1 = 1
                           AND T1.CFG_PRODUCTION_PLAN_ID = 1
                           AND T1.INVENTORY_AGE >=
                               (SELECT JEOPARDY_INV_AGE
                                  FROM PP_CFG_UNIT_OF_WORK
                                 WHERE UNIT_OF_WORK_NAME =
                                       TRIM(T1.UNIT_OF_WORK_NAME))
                           AND T1.PROCESS_DATE IS NULL
                         GROUP BY CFG_PRODUCTION_PLAN_ID,
                                  UNIT_OF_WORK_NAME,
                                  FORECAST_DATE,
                                  HORIZON_START_DATE,
                                  HORIZON_END_DATE,
                                  FORECAST_HOUR))
        ),
        HRZN AS 
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        ) 
        SELECT ALL_RECS.JEP_COUNT,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.FORECAST_DATE,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               ALL_RECS.FORECAST_HOUR,
               ALL_RECS.IDENTIFIER,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN
          ORDER BY ALL_RECS.UNIT_OF_WORK_NAME, ALL_RECS.FORECAST_DATE, ALL_RECS.FORECAST_HOUR 
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST
             SET INVENTORY_JEOPARDY   = RECS.JEP_COUNT
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
                     AND IDENTIFIER = RECS.IDENTIFIER
                     AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                         FROM PP_CFG_UNIT_OF_WORK
                                        WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
                     AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
                     AND FORECAST_HOUR = RECS.FORECAST_HOUR
                     AND FORECAST_VERSION = RECS.FORECAST_VERSION
                     AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Jeopardy - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Jeopardy - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Proc Forecast Hours Assigned
PROCEDURE UPD_FORECAST_HOURS_ASSIGNED AS
V_ERRCODE varchar2(50);
V_ERRMSG varchar2(3000);
V_CNT NUMBER := 0;

  BEGIN
    FOR RECS IN 
    (
        WITH ALL_RECS AS
        (
            SELECT NVL(STAFF_HOURS, 0) AS HOURS_ASSIGNED,
                   CFG_PRODUCTION_PLAN_ID,
                   TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                   FORECAST_HOUR,
                   UNIT_OF_WORK_NAME,
                   TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                   TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                   IDENTIFIER
              FROM (SELECT SUM(STAFF_HOURS) AS STAFF_HOURS,
                           CFG_PRODUCTION_PLAN_ID,
                           FORECAST_DATE,
                           FORECAST_HOUR,
                           UNIT_OF_WORK_NAME,
                           HORIZON_START_DATE,
                           HORIZON_END_DATE,
                           (TRIM(UNIT_OF_WORK_NAME) ||
                           TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                           TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                      FROM (SELECT DISTINCT CFG_PRODUCTION_PLAN_ID,
                                            FORECAST_DATE,
                                            FORECAST_HOUR,
                                            TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                                            HORIZON_START_DATE,
                                            HORIZON_END_DATE,
                                            STAFF_HOURS
                              FROM PP_STG_FCST_VOLUME
                             WHERE CFG_PRODUCTION_PLAN_ID = 1 
                               AND PROCESS_DATE IS NULL) A
                     GROUP BY CFG_PRODUCTION_PLAN_ID,
                              FORECAST_DATE,
                              FORECAST_HOUR,
                              UNIT_OF_WORK_NAME,
                              HORIZON_START_DATE,
                              HORIZON_END_DATE,
                              (TRIM(UNIT_OF_WORK_NAME) ||
                              TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                              TO_CHAR(FORECAST_HOUR)))
             WHERE IDENTIFIER IN (SELECT DISTINCT (TRIM(UNIT_OF_WORK_NAME) ||
                                                  TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                                                  TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                                    FROM PP_STG_FCST_BY_INV_AGE INV
                                   WHERE INV.CFG_PRODUCTION_PLAN_ID = 1
                                     AND INV.PROCESS_DATE IS NULL)
        ),
        HRZN AS 
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        ) 
        SELECT ALL_RECS.HOURS_ASSIGNED,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.FORECAST_DATE,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               ALL_RECS.FORECAST_HOUR,
               ALL_RECS.IDENTIFIER,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN
          ORDER BY ALL_RECS.UNIT_OF_WORK_NAME, ALL_RECS.FORECAST_DATE, ALL_RECS.FORECAST_HOUR 
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST 
             SET STAFF_HOURS = RECS.HOURS_ASSIGNED
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
                     AND IDENTIFIER = RECS.IDENTIFIER
                     AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                         FROM PP_CFG_UNIT_OF_WORK
                                        WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
                     AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
                     AND FORECAST_HOUR = RECS.FORECAST_HOUR
                     AND FORECAST_VERSION = RECS.FORECAST_VERSION
                     AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Hours Assigned - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Hours Assigned - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Proc Forecast Handle Times
PROCEDURE UPD_FORECAST_HANDLE_TIMES AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  V_CNT NUMBER := 0;
  
  BEGIN
    FOR RECS IN 
    (
       WITH ALL_RECS AS
        (
          SELECT CFG_PRODUCTION_PLAN_ID,
                      AVG_HANDLE_TIME,
                      MIN_HANDLE_TIME,
                      MAX_HANDLE_TIME,
                      TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') AS FORECAST_DATE,
                      FORECAST_HOUR,
                      UNIT_OF_WORK_NAME,
                      TO_CHAR(HORIZON_START_DATE, 'MM/DD/YYYY') AS HORIZON_START_DATE,
                      TO_CHAR(HORIZON_END_DATE, 'MM/DD/YYYY') AS HORIZON_END_DATE,
                      IDENTIFIER
                 FROM (SELECT CFG_PRODUCTION_PLAN_ID,
                              AVG_HANDLE_TIME,
                              MIN_HANDLE_TIME,
                              MAX_HANDLE_TIME,
                              FORECAST_DATE,
                              FORECAST_HOUR,
                              UNIT_OF_WORK_NAME,
                              HORIZON_START_DATE,
                              HORIZON_END_DATE,
                              (TRIM(UNIT_OF_WORK_NAME) ||
                              TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                              TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                         FROM (SELECT CFG_PRODUCTION_PLAN_ID,
                                      HANDLE_TIME_AVG AS AVG_HANDLE_TIME,
                                      HANDLE_TIME_MIN AS MIN_HANDLE_TIME,
                                      HANDLE_TIME_MAX AS MAX_HANDLE_TIME,
                                      FORECAST_DATE,
                                      FORECAST_HOUR,
                                      TRIM(UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME,
                                      HORIZON_START_DATE,
                                      HORIZON_END_DATE
                                 FROM PP_STG_FCST_VOLUME
                                WHERE CFG_PRODUCTION_PLAN_ID = 1
                                  AND PROCESS_DATE IS NULL) A)
                WHERE IDENTIFIER IN
                      (SELECT DISTINCT (TRIM(UNIT_OF_WORK_NAME) ||
                                       TO_CHAR(FORECAST_DATE, 'DDMMYYYY') || '_' ||
                                       TO_CHAR(FORECAST_HOUR)) AS IDENTIFIER
                         FROM PP_STG_FCST_BY_INV_AGE INV
                        WHERE INV.CFG_PRODUCTION_PLAN_ID = 1 
                          AND INV.PROCESS_DATE IS NULL)
        ),
        HRZN AS 
        (
            SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON CFG, ALL_RECS
             WHERE CFG.CFG_PRODUCTION_PLAN_ID = ALL_RECS.CFG_PRODUCTION_PLAN_ID
               AND TO_CHAR(CFG.HORIZON_START_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_START_DATE
               AND TO_CHAR(CFG.HORIZON_END_DATE, 'MM/DD/YYYY') =
                   ALL_RECS.HORIZON_END_DATE
               AND CFG.HORIZON_START_HOUR = 0
               AND CFG.HORIZON_END_HOUR = 0
        ),
        VRSN AS
        (
             SELECT MAX(PP_STG_FORECAST.FORECAST_VERSION) AS FORECAST_VERSION
               FROM PP_STG_FORECAST, HRZN
              WHERE PP_STG_FORECAST.CFG_HORIZON_ID = HRZN.CFG_HORIZON_ID
        ) 
        SELECT ALL_RECS.AVG_HANDLE_TIME,
               ALL_RECS.MIN_HANDLE_TIME,
               ALL_RECS.MAX_HANDLE_TIME,
               ALL_RECS.CFG_PRODUCTION_PLAN_ID,
               ALL_RECS.FORECAST_DATE,
               ALL_RECS.UNIT_OF_WORK_NAME,
               ALL_RECS.HORIZON_START_DATE,
               ALL_RECS.HORIZON_END_DATE,
               ALL_RECS.FORECAST_HOUR,
               ALL_RECS.IDENTIFIER,
               HRZN.CFG_HORIZON_ID,
               VRSN.FORECAST_VERSION
          FROM ALL_RECS, HRZN, VRSN
          ORDER BY ALL_RECS.UNIT_OF_WORK_NAME, ALL_RECS.FORECAST_DATE, ALL_RECS.FORECAST_HOUR 
      ) 
      LOOP
  
          UPDATE PP_STG_FORECAST 
             SET HANDLE_TIME_AVG=RECS.AVG_HANDLE_TIME,
                 HANDLE_TIME_MIN=RECS.MIN_HANDLE_TIME,
                 HANDLE_TIME_MAX=RECS.MAX_HANDLE_TIME
           WHERE CFG_HORIZON_ID = RECS.CFG_HORIZON_ID
                     AND IDENTIFIER = RECS.IDENTIFIER
                     AND CFG_UOW_ID = (SELECT CFG_UOW_ID
                                         FROM PP_CFG_UNIT_OF_WORK
                                        WHERE UNIT_OF_WORK_NAME = RECS.UNIT_OF_WORK_NAME)
                     AND TO_CHAR(FORECAST_DATE, 'MM/DD/YYYY') = RECS.FORECAST_DATE
                     AND FORECAST_HOUR = RECS.FORECAST_HOUR
                     AND FORECAST_VERSION = RECS.FORECAST_VERSION
                     AND PROCESS_DATE IS NULL;
  
      V_CNT := V_CNT + 1;
      END LOOP;
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Handle Times - Processed ' || V_CNT, SYSDATE); 
      COMMIT;
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Process_Staging','Proc Forecast Handle Times - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Update Process Flag
PROCEDURE UPD_FORECAST_PROCESS_FLAG AS
  BEGIN
    UPDATE PP_STG_FCST_BY_INV_AGE SET PROCESS_DATE = SYSDATE WHERE CFG_PRODUCTION_PLAN_ID=1 AND PROCESS_DATE IS NULL;   
    UPDATE PP_STG_FCST_VOLUME SET PROCESS_DATE = SYSDATE WHERE CFG_PRODUCTION_PLAN_ID=1 AND PROCESS_DATE IS NULL;
    
    UPDATE pp_fcst_inventory_data_ffile SET PROCESS_DATE = SYSDATE WHERE CFG_PRODUCTION_PLAN_ID=1 AND PROCESS_DATE IS NULL;   
    UPDATE pp_fcst_volume_data_ffile SET PROCESS_DATE = SYSDATE WHERE CFG_PRODUCTION_PLAN_ID=1 AND PROCESS_DATE IS NULL;
    
    COMMIT;
  END;

--Process Load Semantic
--Insert New Horizon If Not Exist
PROCEDURE INS_PPD_PLAN_HORIZON AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);

  BEGIN
    INSERT INTO PP_D_PRODUCTION_PLAN_HORIZON
      (PPH_ID,
       PP_ID,
       HORIZON_START_DATE,
       HORIZON_START_HOUR,
       HORIZON_END_DATE,
       HORIZON_END_HOUR,
       HORIZON_NAME,
       HORIZON_DESCRIPTION,
       FORECAST_LAST_MODIFIED_DATE,
       CREATE_DATE,
       LAST_UPDATE_DATE)
    
      SELECT CFG_HORIZON_ID,
             CFG_PRODUCTION_PLAN_ID,
             HORIZON_START_DATE,
             HORIZON_START_HOUR,
             HORIZON_END_DATE,
             HORIZON_END_HOUR,
             HORIZON_NAME,
             HORIZON_DESCRIPTION,
             SYSDATE,
             SYSDATE,
             SYSDATE
        FROM PP_CFG_HORIZON
       WHERE CFG_PRODUCTION_PLAN_ID = 1
         AND CFG_HORIZON_ID NOT IN (SELECT DISTINCT PPH_ID
                                      FROM PP_D_PRODUCTION_PLAN_HORIZON
                                     WHERE PP_ID = 1);
    INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Load_Semantic','Insert New Horizon If Not Exist - Processed', SYSDATE); 
      COMMIT;
    
    
    EXCEPTION
    WHEN OTHERS 
      THEN 
        ROLLBACK;
        V_ERRCODE := SQLCODE;
        V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
        INSERT INTO PP_STG_LOG
          (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
          VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Load_Semantic','Insert New Horizon If Not Exist - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
          COMMIT; 
        RAISE;
  END;

--Insert into PP_F_FORECAST
PROCEDURE INS_PP_F_FORECAST AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  
  BEGIN
  
  INSERT INTO PP_F_FORECAST
    (FORECAST_ID,
     D_DATE,
     D_HOUR,
     UOW_ID,
     PPH_ID,
     FORECAST_VERSION,
     FCST_ARRIVAL,
     FCST_COMPLETION,
     FCST_INVENTORY,
     FCST_INVENTORY_AGE_AVG, 
     FCST_INVENTORY_AGE_MIN,
     FCST_INVENTORY_AGE_MAX,
     FCST_INVENTORY_JEOPARDY,
     FCST_HANDLE_TIME_AVG,
     FCST_HANDLE_TIME_MIN,
     FCST_HANDLE_TIME_MAX,
     FCST_STAFF_HOURS,
     FCST_EFFECTIVE_DATE,
     FCST_EFFECTIVE_END_DATE)
    SELECT SEQ_PP_F_FORECAST_ID.NEXTVAL,
           FORECAST_DATE,
           FORECAST_HOUR,
           CFG_UOW_ID,
           CFG_HORIZON_ID,
           FORECAST_VERSION,
           ARRIVAL,
           COMPLETION,
           INVENTORY,
           INVENTORY_AGE_AVG,
           INVENTORY_AGE_MIN,
           INVENTORY_AGE_MAX,
           INVENTORY_JEOPARDY,
           HANDLE_TIME_AVG,
           HANDLE_TIME_MIN,
           HANDLE_TIME_MAX,
           STAFF_HOURS,
           EFFECTIVE_DATE,
           END_DATE
      FROM PP_STG_FORECAST
     WHERE CFG_HORIZON_ID IN
           (SELECT DISTINCT CFG_HORIZON_ID
              FROM PP_CFG_HORIZON
             WHERE CFG_PRODUCTION_PLAN_ID = 1)
       AND PROCESS_DATE IS NULL;
  
  INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Load_Semantic','Insert into PP_F_FORECAST - Processed', SYSDATE); 
    
  COMMIT;
  
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Load_Semantic','Insert into PP_F_FORECAST - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;

--Set PP_STG_FORECAST Process Date
PROCEDURE UPD_FORECAST_STG AS
  V_ERRCODE varchar2(50);
  V_ERRMSG varchar2(3000);
  
  BEGIN
  
  UPDATE PP_STG_FORECAST SET PROCESS_DATE = SYSDATE
    WHERE CFG_HORIZON_ID IN (SELECT DISTINCT CFG_HORIZON_ID FROM PP_CFG_HORIZON WHERE CFG_PRODUCTION_PLAN_ID = 1)
  AND PROCESS_DATE IS NULL;   
  INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Forecast_Load_Semantic','Set PP_STG_FORECAST Process Date - Processed', SYSDATE); 
    COMMIT;
  
  
  EXCEPTION
  WHEN OTHERS 
    THEN 
      ROLLBACK;
      V_ERRCODE := SQLCODE;
      V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
      INSERT INTO PP_STG_LOG
        (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
        VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Forecast_Load_Semantic','Set PP_STG_FORECAST Process Date - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
        COMMIT; 
      RAISE;
  END;
  
  PROCEDURE LOAD_FORECAST_DATA AS
  BEGIN
   -- TRUNCATE_PP_TABLE;
    LOAD_PP_STAGE;
    INS_PP_HORIZON;
    INS_PP_FORECAST_STG;
    UPD_FORECAST_INVENTORY;
    UPD_FORECAST_INTAKE;
    UPD_FORECAST_COMPLETIONS;
    UPD_INVENTORY_AVG_AGE;
    UPD_INVENTORY_MINMAX_AGE;
    UPD_FORECAST_JEOPARDY;
    UPD_FORECAST_HOURS_ASSIGNED;
    UPD_FORECAST_HANDLE_TIMES;
    UPD_FORECAST_PROCESS_FLAG;
    INS_PPD_PLAN_HORIZON;
    INS_PP_F_FORECAST;
    UPD_FORECAST_STG;
    COMMIT;
  END;

PROCEDURE REFRESH_PP_TABLES AS
  
  v_cfg_nextval NUMBER;
  v_num_days_add NUMBER;
  BEGIN
    
    
    
    SELECT TO_NUMBER(value)
    INTO v_num_days_add
    FROM corp_etl_control
    WHERE name = 'REFRESH_DEMO_DATA_NUMDAYS';
    
    FOR x IN (SELECT pph_id,MIN(d_date + v_num_days_add) min_date,MAX(d_date + v_num_days_add) max_date
            FROM pp_f_forecast 
            GROUP BY pph_id
            ORDER BY pph_id DESC) LOOP
    
      BEGIN
        SELECT CFG_HORIZON_ID
        INTO v_cfg_nextval
        FROM PP_CFG_HORIZON
        WHERE horizon_start_date = x.min_date
        AND horizon_end_date = x.max_date    ;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN    
           SELECT SEQ_CFG_HORIZON_ID.NEXTVAL
           INTO v_cfg_nextval
           FROM dual;
      
          INSERT INTO PP_CFG_HORIZON
                   (CFG_HORIZON_ID, CFG_PRODUCTION_PLAN_ID, HORIZON_START_DATE, HORIZON_START_HOUR, HORIZON_END_DATE, 
                    HORIZON_END_HOUR, HORIZON_NAME, HORIZON_DESCRIPTION, CREATE_DATE, LAST_UPDATE_DATE)
          SELECT v_cfg_nextval
               ,CFG_PRODUCTION_PLAN_ID
               ,x.min_date
               ,0
               ,x.max_date
               ,0
               ,TO_CHAR(x.min_date, 'MM/DD/YYYY') || ' - ' || TO_CHAR(x.max_date, 'MM/DD/YYYY') AS HZNAME
               ,NULL
               ,SYSDATE
               ,SYSDATE
          FROM  PP_CFG_HORIZON inv
          WHERE cfg_horizon_id = x.pph_id;
      END;
      
      INS_PPD_PLAN_HORIZON;
      
      UPDATE pp_f_forecast
      SET d_date = d_date + v_num_days_add
          ,pph_id = v_cfg_nextval
      WHERE pph_id = x.pph_id ;
    
    END LOOP;
    
    COMMIT;
  END;  
  
  PROCEDURE REFRESH_ALL_DEMO_DATA AS  
    v_run_date DATE;
  BEGIN
    SELECT TO_DATE(value,'MM/DD/YYYY')
    INTO v_run_date
    FROM corp_etl_control
    WHERE name = 'REFRESH_DEMO_DATA_RUNDATE';
    
    IF v_run_date = TRUNC(sysdate) THEN
      LOAD_MW_AND_ACTUALS_PKG.REFRESH_MW_DATA;
      REFRESH_PP_TABLES;
    
      UPDATE corp_etl_control
      SET value = TO_CHAR(sysdate+7,'MM/DD/YYYY')
      WHERE name = 'REFRESH_DEMO_DATA_RUNDATE';
    
      COMMIT;    
    END IF;
    
  END;
END;
/