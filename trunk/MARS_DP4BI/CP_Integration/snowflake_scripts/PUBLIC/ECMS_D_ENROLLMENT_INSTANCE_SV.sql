use database MARS_DP4BI_DEV;
use database MARS_DP4BI_UAT;
use database MARS_DP4BI_PROD;

use schema public;

CREATE OR REPLACE VIEW ECMS_D_ENROLLMENT_INSTANCE_SV AS
WITH MW AS
(
    WITH task_details AS 
    (
        SELECT  project_id ,
                task_id ,
                task_field_id ,
                task_field_name ,
                selection_varchar ,
                selection_numeric ,
                selection_date ,
                selection_date_time ,
                updated_on ,
                created_by ,
                created_on
         FROM   (
                    SELECT  project_id ,
                            task_id ,
                            task_field_id ,
                            task_field_name ,
                            selection_varchar ,
                            selection_numeric ,
                            selection_date ,
                            selection_date_time ,
                            updated_on ,
                            created_by ,
                            created_on ,
                            RANK() OVER (PARTITION BY task_field_id,
                            task_id,
                            project_id
                            ORDER BY
                                task_detail_history_id DESC
                            )   tdcarn
                     FROM   MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW 
                )   r
        WHERE   tdcarn = 1 
    ),
    proj AS
    (
        SELECT  p.* 
          FROM  MARSDB.MARSDB_PROJECT_VW    p
         WHERE  UPPER(p.project_name) LIKE '%COVER%VA%' 
    )
    SELECT  ts_app.task_id                                                              AS  INCIDENT_NUMBER,
            ts_app.task_type_id                                                         AS  TASK_TYPE_ID,
            tt.task_type_name                                                           AS  TASK_TYPE_NAME,
            'TBD'                                                                       AS  FACILITY_TYPE,
            'TBD'                                                                       AS  FACILITY_NAME,
            'TBD'                                                                       AS  AID_CATEGORY_CODE,
            COALESCE(tdeai.selection_varchar, cr.application_id)                        AS  EXTERNAL_APPLICATION_ID,  
            COALESCE(app_link_ti.application_id, app_link_tx.application_id)            AS  APPLICATION_ID,
            tdat.selection_varchar                                                      AS  APPLICATION_TYPE,
            cons.consumer_id                                                            AS  CONSUMER_ID,
            cons.consumer_first_name                                                    AS  CONSUMER_FIRST_NAME,
            cons.consumer_last_name                                                     AS  CONSUMER_LAST_NAME,
            cons.consumer_gender                                                        AS  CONSUMER_GENDER,
            CASE    WHEN    cons.consumer_age < 19
                    THEN    '<19'
                    WHEN    cons.consumer_age BETWEEN 20 AND 29
                    THEN    '20-29'
                    WHEN    cons.consumer_age BETWEEN 30 AND 39
                    THEN    '30-39'
                    WHEN    cons.consumer_age BETWEEN 40 AND 49
                    THEN    '40-49'
                    WHEN    cons.consumer_age BETWEEN 50 AND 59
                    THEN    '50-59'
                    WHEN    cons.consumer_age BETWEEN 60 AND 64
                    THEN    '60-64'
                    WHEN    cons.consumer_age >= 65
                    THEN    '>=65'
            END                                                                         AS  CONSUMER_AGE,
            COALESCE(tdprl.selection_varchar, cons.consumer_preferred_language)         AS  CONSUMER_PREFERRED_LANGUAGE,
            tdhosp.selection_varchar                                                    AS  HOSPITAL_NAME,
            tde.selection_varchar                                                       AS  ENROLLMENT_STATUS,
            tde.updated_on::DATE                                                        AS  ENROLLMENT_STATUS_DATE,
            cr.contact_type                                                             AS  CALLER_CATEGORY,
            crr.contact_record_reason_type                                              AS  CALL_REASON,
            tdacttak.selection_varchar                                                  AS  ACTION_TAKEN,
            tdprog.selection_varchar                                                    AS  PROGRAM,
            ts_app.create_date_time::DATE                                               AS  RECEIVED_DATE,
            tdbu.selection_varchar                                                      AS  BUSINESS_UNIT,
            ts_app.created_by_business_unit_id                                          AS  CREATED_BY_BUSINESS_UNIT_ID,
            ts_app.created_by_business_unit_name                                        AS  CREATED_BY_BUSINESS_UNIT_NAME,
            ts_app.updated_by_business_unit_id                                          AS  UPDATED_BY_BUSINESS_UNIT_ID,
            ts_app.updated_by_business_unit_name                                        AS  UPDATED_BY_BUSINESS_UNIT_NAME,
            ts_app.staff_assigned_to_business_unit_id                                   AS  STAFF_ASSIGNED_TO_BUSINESS_UNIT_ID,
            ts_app.staff_assigned_to_business_unit_name                                 AS  STAFF_ASSIGNED_TO_BUSINESS_UNIT_NAME  
      FROM  MW_D_TASK_INSTANCE_SV   ts_app
            JOIN    
            proj
            ON
            (
                ts_app.project_id = proj.project_id
            )
            JOIN
            MARSDB.MARSDB_TASK_TYPE_VW  tt
            ON
            (
                    ts_app.task_type_id = tt.task_type_id
                AND ts_app.project_id = tt.project_id
            )
            -- Get the latest Application linked to the task (task internal)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS TASK_ID,
                                    ex.external_ref_id  AS  APPLICATION_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.internal_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'TASK'
                               AND  UPPER(ex.external_ref_type) = 'APPLICATION'
                               AND  ex.effective_end_date IS NULL
                        )   tmp 
                 WHERE  exrn = 1
            )   app_link_ti
            ON 
            (
                    ts_app.task_id = app_link_ti.task_id
                AND ts_app.project_id = app_link_ti.project_id
            )
            -- Get the latest Application linked to the task (task external)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS APPLICATION_ID,
                                    ex.external_ref_id  AS  TASK_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.external_ref_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'APPLICATION'
                               AND  UPPER(ex.external_ref_type) = 'TASK'
                               AND  ex.effective_end_date IS NULL
                        )   tmp 
                 WHERE  exrn = 1
            )   app_link_tx
            ON 
            (
                    ts_app.task_id = app_link_tx.task_id
                AND ts_app.project_id = app_link_tx.project_id
            )
            -- Get the latest Contact Record linked to the task (task internal)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS  TASK_ID,
                                    ex.external_ref_id  AS  CONTACT_RECORD_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.internal_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'TASK'
                               AND  UPPER(ex.external_ref_type) = 'CONTACT_RECORD'
                               AND  ex.effective_end_date IS NULL

                        )   tmp 
                 WHERE  exrn = 1
            )   cr_link_ti
            ON 
            (
                    ts_app.task_id = cr_link_ti.task_id
                AND ts_app.project_id = cr_link_ti.project_id
            )
            -- Get the latest Contact Record linked to the task (task external)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS  CONTACT_RECORD_ID,
                                    ex.external_ref_id  AS TASK_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.external_ref_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'CONTACT_RECORD'
                               AND  UPPER(ex.external_ref_type) = 'TASK'
                               AND  ex.effective_end_date IS NULL
                    
                        )   tmp 
                 WHERE  exrn = 1
            )   cr_link_tx
            ON 
            (
                    ts_app.task_id = cr_link_tx.task_id
                AND ts_app.project_id = cr_link_tx.project_id
            )
            -- Contact Record
            LEFT JOIN 
            MARSDB.MARSDB_CONTACT_RECORD_VW cr
            ON 
            (
                    COALESCE(cr_link_ti.contact_record_id, cr_link_tx.contact_record_id) = cr.contact_record_id
                AND ts_app.project_id = cr.project_id
            )
            -- Contact Record Reason
            LEFT JOIN
            MARSDB.MARSDB_CONTACT_RECORD_REASON_VW  crr 
            ON
            (
                    cr.contact_record_id = crr.contact_record_id
                AND cr.project_id = crr.project_id
            )  
            -- Get the latest Consumer linked to the task (task internal)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS TASK_ID,
                                    ex.external_ref_id  AS  CONSUMER_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.internal_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'TASK'
                               AND  UPPER(ex.external_ref_type) = 'CONSUMER'
                               AND  ex.effective_end_date IS NULL
                        )   tmp 
                 WHERE  exrn = 1
            )   cons_link_ti
            ON 
            (
                    ts_app.task_id = cons_link_ti.task_id
                AND ts_app.project_id = cons_link_ti.project_id
            )
            -- Get the latest Consumer linked to the task (task external)
            LEFT JOIN
            (
                SELECT  * 
                  FROM  (
                            SELECT  ex.project_id,
                                    ex.internal_id  AS CONSUMER_ID,
                                    ex.external_ref_id  AS TASK_ID,
                                    ROW_NUMBER() OVER (PARTITION BY ex.project_id, ex.external_ref_id ORDER BY ex.external_link_id DESC) exrn
                              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
                             WHERE  UPPER(ex.internal_ref_type) = 'CONSUMER'
                               AND  UPPER(ex.external_ref_type) = 'TASK'
                               AND  ex.effective_end_date IS NULL
                        )   tmp 
                 WHERE  exrn = 1
            )   cons_link_tx
            ON 
            (
                    ts_app.task_id = cons_link_tx.task_id
                AND ts_app.project_id = cons_link_tx.project_id
            )
            -- Consumer
            LEFT JOIN 
            (
                SELECT  c.*,
                        CASE   WHEN    c.consumer_date_of_birth IS NOT NULL
                               THEN    DATEDIFF(year, c.consumer_date_of_birth, CURRENT_TIMESTAMP::DATE)
                               ELSE    NULL
                        END   AS  CONSUMER_AGE,
                        c.gender_code AS CONSUMER_GENDER,
                        (
                            SELECT  TOP 1
                                    dc.consumer_preferred_language
                              FROM  D_CONSUMER_SV   dc
                             WHERE  dc.consumer_id = c.consumer_id
                               AND  dc.project_id = c.project_id
                        )   AS  CONSUMER_PREFERRED_LANGUAGE
                 FROM   MARSDB.MARSDB_CONSUMER_VW   c
            )   cons
            ON 
            (
                    COALESCE(cons_link_ti.consumer_id, cons_link_tx.consumer_id) = cons.consumer_id
                AND ts_app.project_id = cons.project_id
            )          
            LEFT JOIN 
            -- Program
            task_details    tdprog
            ON 
            (
                    ts_app.task_id = tdprog.task_id 
                AND ts_app.project_id = tdprog.project_id
                AND tdprog.task_field_id = 44 
                AND tdprog.selection_varchar IS NOT NULL
            )
            LEFT JOIN
            -- Preferred Language
            task_details    tdprl
            ON 
            (
                    ts_app.task_id = tdprl.task_id 
                AND ts_app.project_id = tdprl.project_id
                AND tdprl.task_field_id = 48
                AND tdprl.selection_varchar IS NOT NULL
            )
            LEFT JOIN 
            -- External Application ID
            task_details    tdeai
            ON 
            (
                    ts_app.task_id = tdeai.task_id 
                AND ts_app.project_id = tdeai.project_id
                AND tdeai.task_field_id = 55 
                AND tdeai.selection_varchar IS NOT NULL              
            )
            LEFT JOIN
            -- Action Taken
            task_details    tdacttak
            ON 
            (
                    ts_app.task_id = tdacttak.task_id 
                AND ts_app.project_id = tdacttak.project_id
                AND tdacttak.task_field_id = 59 
                AND tdacttak.selection_varchar IS NOT NULL              
            )
            LEFT JOIN 
            -- Enrollment
            task_details    tde
            ON 
            (
                    ts_app.task_id = tde.task_id 
                AND ts_app.project_id = tde.project_id
                AND tde.task_field_id = 71 
                AND ts_app.task_type_id IN (13493,13473,13494,13475,13474)               
            )
            LEFT JOIN 
            -- Business Unit
            task_details    tdbu
            ON 
            (
                    ts_app.task_id = tdbu.task_id 
                AND ts_app.project_id = tdbu.project_id
                AND tdbu.task_field_id = 100
                AND ts_app.task_type_id IN (13559, 13552, 13551)              
                AND tdbu.selection_varchar IS NOT NULL              
            )
            LEFT JOIN 
            -- Hospital
            task_details    tdhosp
            ON 
            (
                    ts_app.task_id = tdhosp.task_id 
                AND ts_app.project_id = tdhosp.project_id
                AND tdhosp.task_field_id = 112
                AND ts_app.task_type_id IN (13559, 13552, 13551)              
                AND tdhosp.selection_varchar IS NOT NULL              
            )
            LEFT JOIN 
            -- Application Type
            task_details    tdat
            ON 
            (
                    ts_app.task_id = tdat.task_id 
                AND ts_app.project_id = tdat.project_id
                AND tdat.task_field_id = 148
                AND tdat.selection_varchar IS NOT NULL              
            )
    WHERE   ts_app.task_type_id IN (13551, 13552, 13559, 13473, 13474, 13475, 13493, 13494)
)
SELECT  *
  FROM  MW;
