use database MARS_DP4BI_DEV;
use database MARS_DP4BI_UAT;

use schema public;

CREATE OR REPLACE VIEW ECMS_D_APPLICATIONS_INSTANCE_SV AS
WITH MW AS(
with TASK_DETAILS as (
select
     project_id   
    ,task_id
    ,task_field_id
    ,task_field_name
    ,selection_varchar
    ,selection_numeric
    ,selection_date
    ,updated_on
    ,CREATED_BY
from (select 
          task_id
         ,task_field_name
         ,project_id
         ,selection_varchar
         ,selection_numeric
         ,selection_date
         ,task_field_id
         ,updated_on
         ,CREATED_BY
         ,RANK() OVER (PARTITION BY task_field_id,task_id,project_id ORDER BY task_detail_history_id DESC) tdcarn
      from
         MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
        WHERE TASK_ID IN (SELECT TASK_ID FROM MARSDB.MARSDB_TASK_DETAIL_VW WHERE TASK_FIELD_ID = 148 )
     ) r
      where 
         tdcarn = 1
),
   USER_INFO AS (SELECT 
                        U.USER_ID,
                        U.STAFF_ID,
                        U.PROJECT_ID,
                        S.FIRST_NAME,
                        S.LAST_NAME,
                        S.MAXIMUS_ID,
                        UPR.USER_PROJECT_ROLE_ID,
                        UPR.PROJECT_ROLE_ID,
                        PR.ROLE_NAME,
                        USV.BUSINESS_UNIT_ID,
                        USV.BUSINESS_UNIT_NAME
                        FROM MARSDB.MARSDB_USER_VW U
                            --ON TO_VARCHAR(CUW.USER_ID) = T.STAFF_WORKED_BY AND CUW.PROJECT_ID = T.PROJECT_ID 
                        INNER JOIN D_USER_SV USV
                            ON USV.USER_ID = U.USER_ID AND USV.USER_PROJECT_ID = U.PROJECT_ID
                        INNER JOIN MARSDB.MARSDB_STAFF_VW S   
                            ON S.STAFF_ID = U.STAFF_ID 
                        INNER JOIN 
                        (
                            SELECT  * 
                              FROM  (
                                        SELECT  upr.user_id
                                                ,upr.user_project_role_id
                                                ,upr.project_role_id
                                                ,RANK() OVER (PARTITION BY upr.user_id ORDER BY upr.created_on DESC) rnk
                                          FROM  MARSDB.MARSDB_USER_PROJECT_ROLE_VW  upr 
                                         WHERE  upr.IS_DEFAULT = 1 
                                           AND  COALESCE(upr.END_DATE,CURRENT_DATE()) >= CURRENT_DATE()
                                    ) 
                             WHERE  rnk = 1
                        )   upr                     
                            ON UPR.USER_ID = U.USER_ID
                        INNER JOIN MARSDB.MARSDB_PROJECT_ROLE_VW PR
                            ON PR.PROJECT_ROLE_ID = UPR.PROJECT_ROLE_ID 
                        WHERE U.PROJECT_ID = 419 AND PR.PROJECT_ID = 419 )
SELECT  T.PROJECT_ID,
        TD.SELECTION_VARCHAR AS APPLICATION_ID,
        TO_DATE(T.CREATE_DATE_TIME) AS APPLICATION_CREATE_DATE,
        T.CREATE_DATE_TIME AS APPLICATION_CREATE_TIME,
        TT.SELECTION_VARCHAR AS APPLICATION_TYPE,
        T.TASK_PRIORITY AS APPLICATION_PRIORITY,
        TSR.SELECTION_VARCHAR AS APPLICATION_SOURCE,
        TST.SELECTION_VARCHAR AS APPLICATION_STATUS,
        TO_DATE(T.CURR_LAST_UPDATE_DATE_TIME) AS APPLICATION_STATUS_DATE,
        T.TASK_INFO AS APPLICATION_INFO,
        T.TASK_NOTES AS APPLICATION_NOTES,
        'TBD' AS APPLICATION_ASSOCIATION,
        TO_DATE(T.CREATE_DATE_TIME) AS APPLICATION_RECEIVED_DATE,
        TO_DATE(T.CURR_LAST_UPDATE_DATE_TIME) AS APPLICATION_PROCESSED_DATE,
        
        T.CURR_CREATED_BY_USER_ID AS APPLICATION_CREATED_BY_USER_ID,-- TO BE CONFIRMED,
        CRT_BY.MAXIMUS_ID AS APPLICATION_CREATED_BY_MAXIMUS_ID,
        CRT_BY.FIRST_NAME AS APPLICATION_CREATED_BY_FIRST_NAME,
        CRT_BY.LAST_NAME AS APPLICATION_CREATED_BY_LAST_NAME,
        CRT_BY.ROLE_NAME AS APPLICATION_CREATED_BY_USER_ROLE,
        CRT_BY.BUSINESS_UNIT_ID AS APPLICATION_CREATED_BY_BUSINESS_UNIT_ID,
        CRT_BY.BUSINESS_UNIT_NAME AS APPLICATION_CREATED_BY_BUSINESS_UNIT_NAME,
        SA.USER_ID AS APPLICATION_ASSIGNED_USER_ID,-- TO BE CONFIRMED,
        SA.MAXIMUS_ID AS APPLICATION_ASSIGNEE_MAXIMUS_ID,
        SA.FIRST_NAME AS APPLICATION_ASSIGNEE_FIRST_NAME,
        SA.LAST_NAME AS APPLICATION_ASSIGNEE_LAST_NAME,
        SA.ROLE_NAME AS APPLICATION_ASSIGNEE_USER_ROLE,
        SA.BUSINESS_UNIT_ID AS APPLICATION_ASSIGNEE_BUSINESS_UNIT_ID,
        SA.BUSINESS_UNIT_NAME AS APPLICATION_ASSIGNEE_BUSINESS_UNIT_NAME,  
        TDD.SELECTION_DATE AS APPLICATION_DUE_DATE,
        T.SLA_DAYS AS APPLICATION_SLA_DAYS,
        T.SLA_DAYS_TYPE AS APPLICATION_SLA_TYPE,
        DATEDIFF(DAY,T.CREATE_DATE_TIME,T.CURR_LAST_UPDATE_DATE_TIME) AS APPLICATION_AGE,
        'TBD' AS APPLICATION_AGE_TYPE,
        TDIS.SELECTION_VARCHAR AS APPLICATION_DISPOSITION,
        T.TASK_CLAIM_STATUS AS APPLICATION_CLAIM_STATUS,
        SW.USER_ID AS APPLICATION_WORKED_BY_USER_ID,-- TO BE CONFIRMED,
        SW.MAXIMUS_ID AS APPLICATION_WORKED_BY_MAXIMUS_ID,
        SW.FIRST_NAME AS APPLICATION_WORKED_BY_FIRST_NAME,
        SW.LAST_NAME AS APPLICATION_WORKED_BY_LAST_NAME,
        SW.ROLE_NAME AS APPLICATION_WORKED_BY_USER_ROLE,
        SW.BUSINESS_UNIT_ID AS APPLICATION_WORKED_BY_BUSINESS_UNIT_ID,
        SW.BUSINESS_UNIT_NAME AS APPLICATION_WORKED_BY_BUSINESS_UNIT_NAME,  
        TO_DATE(TDIS.UPDATED_ON) AS APPLICATION_COMPLETE_DATE,
        TDIS.UPDATED_ON AS APPLICATION_COMPLETE_TIME,
        T.TOTAL_TIME_WORKED AS TOTAL_TIME_WORKED,
        APP_LINK.INTERNAL_ID AS SOURCE_REF_ID,
        APP_LINK.EXTERNAL_REF_TYPE AS SOURCE_REF_ID_TYPE, 
        T.ESCALATED_FLAG AS APPLICATION_FLAG,
        SE.USER_ID AS ESCALATED_TO_USER_ID, 
        SE.MAXIMUS_ID AS ESCALATED_TO_MAXIMUS_ID,
        SE.LAST_NAME AS ESCALATED_TO_LAST_NAME, 
        SE.FIRST_NAME AS ESCALATED_TO_FIRST_NAME, 
        SE.BUSINESS_UNIT_ID AS ESCALATED_TO_BUSINESS_UNIT_ID,
        SE.BUSINESS_UNIT_NAME AS ESCALATED_TO_BUSINESS_UNIT_NAME,  
        'TBD' AS APPLICATION_CYCLE_TIME,
        'TBD' AS APPLICATION_REASON, 
        'TBD' AS APPLICATION_ABOUT, 
        TM.SELECTION_NUMERIC AS MMIS_MEMBER_ID,
        TC.SELECTION_NUMERIC AS EXTERNAL_CASE_ID,
        TL.SELECTION_VARCHAR AS LOCALITY, 
        TB.SELECTION_VARCHAR AS BUSINESS_UNIT,
        TDIS.SELECTION_VARCHAR AS APPLICATION_DECISION,
        TOUT.SELECTION_VARCHAR AS APPLICATION_OUTCOMES,
        TDL.TASK_FIELD_NAME AS LDSS_REASON,
        CASE WHEN T.CREATE_DATE_TIME IS NOT NULL THEN 1 ELSE 0 END AS REVIEWED_FLAG,
        CASE WHEN T.CURR_LAST_UPDATE_DATE_TIME IS NOT NULL THEN 1 ELSE 0 END AS PROCESSED_FLAG,
        'TBD' AS INCOMPLETE_FLAG,
        TFT.SELECTION_VARCHAR AS FACILITY_TYPE,
        TFN.SELECTION_VARCHAR AS FACILITY_NAME,
        'TBD' AS APPLICATION_DETERMINATIONS,
        CASE WHEN T.SLA_DAYS = 45 THEN 1 ELSE 0 END AS SLA_45_DAYS,
        CASE WHEN T.SLA_DAYS = 5 THEN 1 ELSE 0 END AS SLA_5_DAYS,
        TD.TASK_ID AS TASK_ID,
        CASE WHEN  (TDIS.TASK_FIELD_ID = 71 AND TDIS.SELECTION_VARCHAR IS NULL) 
            AND ((TDIS.TASK_FIELD_ID = 42 AND TDIS.SELECTION_VARCHAR = 'SENT_VCL') OR (TDIS.TASK_FIELD_ID = 144 AND TDIS.SELECTION_VARCHAR = 'SENT_VCL')) 
                THEN TDIS.TASK_ID ELSE NULL END AS VCL_TASK_ID,
        CASE WHEN  (TDIS.TASK_FIELD_ID = 71 AND TDIS.SELECTION_VARCHAR IS NULL) 
            AND ((TDIS.TASK_FIELD_ID = 42 AND TDIS.SELECTION_VARCHAR IN ( 'SENT_NOA', 'TRANSFERRED_TO_LDSS')
             ) OR (TDIS.TASK_FIELD_ID = 144 AND TDIS.SELECTION_VARCHAR  IN ( 'SENT_NOA', 'TRANSFERRED_TO_LDSS'))) 
                THEN TDIS.TASK_ID ELSE NULL END AS NO_VCL_TASK_ID,
        TDCV.TASK_ID AS VERIFICATION_CHECKLIST_TASK_ID,
        TDIS.TASK_ID AS  TASK_ID_PROCESSED_WITHIN_5_DAYS,
        CASE WHEN T.TASK_TYPE_ID = 13510 THEN T.TASK_ID ELSE NULL END AS TASK_ID_VERIFICATIONS,
        CASE WHEN TDIS.SELECTION_VARCHAR IS NULL THEN 1 ELSE 0 END AS APPLICATIONS_PENDING_FLAG
        FROM 

        (SELECT * FROM PUBLIC.MW_D_TASK_INSTANCE_SV 
            WHERE  TASK_ID IN  (SELECT TASK_ID FROM MARSDB.MARSDB_TASK_DETAIL_VW WHERE TASK_FIELD_ID = 148 ))T -- REMOVE THIS FILTER
        
        --LEFT JOIN MARSDB.MARSDB_TASKS_VW TSK
            --ON T.TASK_ID = TSK.TASK_ID AND T.PROJECT_ID = TSK.PROJECT_ID
                
        LEFT JOIN TASK_DETAILS TD
            ON TD.TASK_ID = T.TASK_ID AND TD.PROJECT_ID = T.PROJECT_ID AND TD.TASK_FIELD_ID = 55 
        
        LEFT JOIN TASK_DETAILS TT
            ON TT.TASK_ID = T.TASK_ID AND TT.PROJECT_ID = T.PROJECT_ID AND TT.TASK_FIELD_ID = 148
            
        LEFT JOIN TASK_DETAILS TSR
            ON TSR.TASK_ID = T.TASK_ID AND TSR.PROJECT_ID = T.PROJECT_ID AND TSR.TASK_FIELD_ID = 153
            
        LEFT JOIN TASK_DETAILS TST
            ON TST.TASK_ID = T.TASK_ID AND TST.PROJECT_ID = T.PROJECT_ID AND TST.TASK_FIELD_ID = 147
        
        LEFT JOIN TASK_DETAILS TDD
            ON TDD.TASK_ID = T.TASK_ID AND TDD.PROJECT_ID = T.PROJECT_ID AND TDD.TASK_FIELD_ID = 109
            
        LEFT JOIN TASK_DETAILS TDIS
            ON TDIS.TASK_ID = T.TASK_ID AND TDIS.PROJECT_ID = T.PROJECT_ID AND TDIS.TASK_FIELD_ID = 71
        
        LEFT JOIN TASK_DETAILS TC
            ON TC.TASK_ID = T.TASK_ID AND TC.PROJECT_ID = T.PROJECT_ID AND TC.TASK_FIELD_ID = 91
        
        LEFT JOIN TASK_DETAILS TL
            ON TL.TASK_ID = T.TASK_ID AND TL.PROJECT_ID = T.PROJECT_ID AND TL.TASK_FIELD_ID = 119

        LEFT JOIN TASK_DETAILS TB
            ON TB.TASK_ID = T.TASK_ID AND TB.PROJECT_ID = T.PROJECT_ID AND TB.TASK_FIELD_ID = 100
        
        LEFT JOIN TASK_DETAILS TOUT
            ON TOUT.TASK_ID = T.TASK_ID AND TOUT.PROJECT_ID = T.PROJECT_ID AND TOUT.TASK_FIELD_ID = 162       
        
        LEFT JOIN TASK_DETAILS TM
            ON TM.TASK_ID = T.TASK_ID AND TM.PROJECT_ID = T.PROJECT_ID AND TDIS.TASK_FIELD_ID = 111
        
        LEFT JOIN TASK_DETAILS TFT
            ON TFT.TASK_ID = T.TASK_ID AND TFT.PROJECT_ID = T.PROJECT_ID AND TFT.TASK_FIELD_ID = 113
            
        LEFT JOIN TASK_DETAILS TFN
            ON TFN.TASK_ID = T.TASK_ID AND TFN.PROJECT_ID = T.PROJECT_ID AND TFN.TASK_FIELD_ID = 112
              
        LEFT JOIN USER_INFO CRT_BY
            ON TO_VARCHAR(CRT_BY.USER_ID) = T.CURR_CREATED_BY_USER_ID AND CRT_BY.PROJECT_ID = T.PROJECT_ID 
        
        LEFT JOIN USER_INFO SA
            ON TO_VARCHAR(SA.USER_ID) = T.CURR_OWNER_USER_ID AND SA.PROJECT_ID = T.PROJECT_ID           
        
        LEFT JOIN USER_INFO SW
            ON TO_VARCHAR(SW.USER_ID) = T.STAFF_WORKED_BY_USER_ID AND SW.PROJECT_ID = T.PROJECT_ID
        
        LEFT JOIN USER_INFO SE
            ON TO_VARCHAR(SE.USER_ID) = T.ESCALATED_TO_USER_ID AND SE.PROJECT_ID = T.PROJECT_ID
            
        
        LEFT JOIN (SELECT *
                 FROM(SELECT distinct EX.PROJECT_ID,EX.INTERNAL_ID,EX.EXTERNAL_REF_ID ,EX.EXTERNAL_REF_TYPE
                      FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW EX
                      WHERE UPPER(ex.INTERNAL_REF_TYPE) = 'TASK'
                      AND UPPER(ex.EXTERNAL_REF_TYPE) = 'APPLICATION'
                      AND ex.EFFECTIVE_END_DATE IS NULL ) tmp 
                    ) APP_LINK ON APP_LINK.INTERNAL_ID = T.TASK_ID AND APP_LINK.PROJECT_ID = T.PROJECT_ID
                    
        LEFT JOIN TASK_DETAILS TDL  
                ON APP_LINK.EXTERNAL_REF_ID = TDL.TASK_ID 
                AND T.TASK_TYPE_ID = 13508 
  
        LEFT JOIN TASK_DETAILS TDCV  
                ON APP_LINK.EXTERNAL_REF_ID = TDCV.TASK_ID 
                AND TDCV.TASK_FIELD_ID = 59 AND TDCV.SELECTION_VARCHAR LIKE '%VCL%' 
  )
 SELECT MW.*   
FROM MW;
