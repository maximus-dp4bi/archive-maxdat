CREATE OR REPLACE VIEW coverva_dmas.cp_application_inventory_vw
AS

WITH appstat AS (select * from
          (select distinct tdh.task_id, tdh.task_detail_history_id, tdh.TASK_FIELD_ID, tdh.task_field_name, tdh.SELECTION_VARCHAR as apptype,
                  CASE WHEN tdh.selection_varchar like '%CPU%' THEN 'CPU'    
                       WHEN tdh.selection_varchar like '%PW%' THEN 'CPU'
                       WHEN tdh.selection_varchar like '%CVIU%' THEN 'CVIU'
                       ELSE NULL
                       END AS bu,
                  row_number() over (partition by tdh.task_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
                      from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh
           where tdh.task_field_id = 148 and tdh.project_id = 117)
           where rn = 1 )
 , extapid AS (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as ext_app_id,
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh2
           where tdh2.task_field_id = 55 and tdh2.project_id = 117)
           where rn = 1 )   
 , mywsdt AS  (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_date as mywsdt
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (el.external_ref_id = th.task_id and th.task_field_id = 102 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
           and   el.project_id = 117)
           where rn = 1 ) 
  , duedate AS (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.selection_date as vcl_due_date, -- VCL Due Date
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh2
           where tdh2.task_field_id = 175 and tdh2.project_id = 117)
           where rn = 1 )
  , dispocur AS (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispocur, tdh2.updated_on,
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_VW" tdh2
           where tdh2.task_field_id = 71 and tdh2.project_id = 117 )
           where rn = 1 )
  , dispohx AS (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispohx, tdh2.updated_on,
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_id desc, tdh2.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh2
           where tdh2.task_field_id = 71 and tdh2.project_id = 117  )
           where rn = 1 )
  , dispo AS (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to, th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 13474 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete' and el.project_id = 117  )
           where rn = 1 ),
   dispo3 AS  (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR, tdh.updated_on                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 71 and tdh.project_id = 117 -- Disposition
           ) where rn = 1 )
   , dispo2a AS (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_detail_id,  t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to, th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 13474 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_VW" th on (t.task_id = th.task_id and th.task_field_id = 71 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete' and el.project_id = 117  )
           where rn = 1 )
    , acttk AS (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as acttk
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id --and t.task_type_id = 13474 
           and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete' and el.project_id = 117 )
           where rn = 1 )
    , curtsk AS (select distinct el.internal_id as SRID, t.task_id, t.task_type_id, tt.task_type_name, t.task_status, t.status_date, t.staff_assigned_to
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117
           and t.task_status not in ('Closed','Complete','Cancelled')
           )
    , channel AS (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_varchar as channel
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 12 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 1 )
     , emp AS (SELECT distinct u.user_id,
                  concat(s.first_name, ' ',s.last_name) as name,
                  s.maximus_id,
                  t.TEAM_NAME,
                  pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           )
     , emp2 AS (SELECT distinct u.user_id,
                  concat(s.first_name, ' ',s.last_name) as name,
                  s.maximus_id,
                  t.TEAM_NAME,
                  pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) 
    ,ft AS (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.SELECTION_VARCHAR as ft
           , row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (el.external_ref_id = th.task_id and th.task_field_id = 113 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
           and   el.project_id = 117
          ) where rn = 1 )
    ,fn AS (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.SELECTION_VARCHAR as fn
           , row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (el.external_ref_id = th.task_id and th.task_field_id = 112 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
           and   el.project_id = 117
          ) where rn = 1 )
   ,substat1 AS  (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR, tdh.updated_on                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_id desc ) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_VW" tdh where tdh.task_field_id = 147 and tdh.project_id = 117 -- Substatus
           ) where rn = 1 )
   ,substat2 AS (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR, tdh.updated_on                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc ) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 147 and tdh.project_id = 117 -- substatus
           ) where rn = 1 )
   ,dnrsn AS (select * from (                                                                                                                        
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, dnl.report_label as dnrsn --th.selection_varchar as dnrsn
           , t.staff_assigned_to, th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 13474 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 161 and th.project_id = 117)
           left join "MARSDB"."MARSDB_ENUM_DENIAL_REASONS_VW" dnl ON th.SELECTION_VARCHAR = dnl.value AND th.project_id = dnl.project_id
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117
          ) where rn = 1 ),
dispo2 as    (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispo, tdh2.updated_on, 
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh2
           where tdh2.task_field_id = 71 and tdh2.project_id = 117)
           where rn = 1 ),
dispoa AS (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispo, tdh2.updated_on, 
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_VW" tdh2
           where tdh2.task_field_id = 71 and tdh2.project_id = 117)
           where rn = 1 ),
           
duedate2 as   (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_date as vcldt
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (el.external_ref_id = th.task_id and th.task_field_id = 175 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
           AND   el.project_id = 117
          ) where rn = 1 ),
            
duedate3 as  (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.selection_date as vcl_due_date                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 175 and tdh.project_id = 117 -- VCL Due Date
           ) where rn = 1 ),
mywsdt2  AS (select tt.task_id
                , TRY_CAST(case when tt.task_info like '%My Workspace Date%' then right(left(tt.task_info, 28),10)
                       when tt.task_info like '%DMAS Received Date%' then right(left(tt.task_info, 29),10)
                       end AS DATE) as mywsdt2
           from "MARSDB"."MARSDB_TASKS_VW" tt
           where tt.project_id = 117 
           and (tt.task_info not like ('%No My Workspace Date received%')
           and  tt.task_info not like ('%No DMAS Received Date receive%'))),
   mywsdt3  AS (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_id, th.task_id, th.task_field_id, th.selection_date as mywsdt3
           ,row_number() over(partition by th.task_id  order by th.task_detail_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_VW" th on (el.external_ref_id = th.task_id and th.task_field_id = 102 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
           AND   el.project_id = 117
          ) where rn = 1 ) ,
    dispo2a2 AS (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to, th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 13474 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_VW" th on (t.task_id = th.task_id and th.task_field_id = 71 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117
           and t.task_status = 'Complete'
          ) where rn = 1 ),
  dispo2a3 AS    (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_detail_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to , th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 15182 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_VW" th on (t.task_id = th.task_id and th.task_field_id = 71 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
           and el.project_id = 117
          ) where rn = 1 ),
curtsk2 as  (select distinct el.internal_id as SRID, t.task_id, t.task_type_id, tt.task_type_name, t.task_status, t.status_date, t.staff_assigned_to
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           AND el.project_id = 117
           ) ,
mwsd as    (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_date              
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 102 and tdh.project_id = 117 -- My ES date
           ) where rn = 1 ),
cnl as   (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 12 and tdh.project_id = 117 -- Channel
           ) where rn = 1 ) ,
  dispo as  (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR, tdh.updated_on                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 71 and tdh.project_id = 117 -- Disposition
           ) where rn = 1 ) ,
  fn3 as  (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR as fn               
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 112 and tdh.project_id = 117 -- facility name
          ) where rn = 1 ),
  ft3 as        (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR as ft               
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 113 and tdh.project_id = 117 -- faciity type
           ) where rn = 1 ),
  dnrsn3 as    (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name,dnl.report_label as dnrsn --tdh.SELECTION_VARCHAR as dnrsn              
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh
              left join "MARSDB"."MARSDB_ENUM_DENIAL_REASONS_VW" dnl ON tdh.SELECTION_VARCHAR = dnl.value AND tdh.project_id = dnl.project_id
            where tdh.task_field_id = 161 and tdh.project_id = 117 -- denial reason
           ) where rn = 1 ),
  dispo23 as         (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to , th.updated_on
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 15182 and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
           and el.project_id = 117
          ) where rn = 1 ),
    acttk33 as      (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name
                         , th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar        
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.project_id = 117 and th.task_field_id = 144)
           where el.project_id = 117 and el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST'
          ) where rn = 1 ),
     curtsk3 as     (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name
                         , th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar        
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 )
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status not in ('Cancelled','Closed','Complete')
           and el.project_id = 117
          ) where rn = 1 ),
    comptsk3 as      (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name
                         , th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar        
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 )
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.project_id = 117)
           where el.external_ref_type = 'TASK'
           and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status in ('Closed','Complete')
           and el.project_id = 117
          ) where rn = 1 )
select distinct 'NO' as migrated
  , sr.task_id as sr_id
  , tt2.task_type_name as sr_type
  , date(sr.created_on) as sr_create_date
  , sr.task_status as sr_status
  , date(sr.status_date) as sr_status_date
 -- , cel.external_ref_id as "Consumer ID"
  , appstat.apptype as app_type
  , appstat.bu as business_unit
  , extapid.ext_app_id as external_app_id
  , coalesce(mywsdt.mywsdt, date(sr.created_on)) as my_workspace_date
  , channel.channel as channel
  , dispocur.dispocur as disposition -- logical change  - same mapping
  , acttk.acttk as action_taken
  , curtsk.task_id as current_task_id
  , curtsk.task_type_name as current_task_type
  , curtsk.task_status as current_task_status
  , date(curtsk.status_date) as current_task_status_date
  , curtsk.staff_assigned_to as assigned_to_id
  , emp.name as assigned_to_name
  , dispo.task_id as complete_task_id
  , dispo.task_status as complete_task_status
  , date(dispo.status_date) as complete_task_date
  , dispo.task_type_name as complete_task_type
  , coalesce(dispo.staff_assigned_to, dispo.updated_by) as completed_by_id -- logical change - same mapping
  , emp2.name as completed_by_name 
  , duedate.vcl_due_date
  , ft.ft as facility_type -- new
  , fn.fn as facility_name -- new
  , dnrsn.dnrsn as denial_reason  -- new
  , coalesce(substat1.selection_varchar, substat2.selection_varchar) as substatus -- new  
  , dispohx.dispohx as sr_hix_disposition  -- new
  , dispohx.updated_on as sr_disposition_date_hx -- new
  , dispocur.updated_on as sr_disposition_date_cur -- new
  , dispo.dispo as proc_app_task_disposition_hx -- new
  , dispo2a.dispo as proc_app_task_disposition_cur  -- new  
  , dispo.updated_on as proc_app_task_disposition_date_hx  -- new  
  , dispo2a.updated_on as proc_app_task_disposition_date_cur  -- new 
  , null closed_renewal
  , null renewal_due_date
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN  appstat on (appstat.task_id = sr.task_id)
LEFT JOIN  extapid ON (extapid.TASK_ID = sr.task_id)
LEFT JOIN  duedate ON (duedate.TASK_ID = sr.task_id)  
LEFT JOIN mywsdt on (mywsdt.srid = sr.task_id)        
LEFT JOIN  dispocur ON (dispocur.TASK_ID = sr.task_id)  
LEFT JOIN  dispohx ON (dispohx.TASK_ID = sr.task_id)                     
LEFT JOIN  dispo on (dispo.srid = sr.task_id and dispo.task_status = 'Complete')   
LEFT JOIN  dispo2a on (dispo2a.srid = sr.task_id and dispo2a.task_status = 'Complete')              
LEFT JOIN  acttk on (acttk.srid = sr.task_id and acttk.task_status = 'Complete')  
LEFT JOIN  curtsk on (curtsk.SRID = sr.task_id)
LEFT JOIN  channel on (channel.srid = sr.task_id)
LEFT JOIN  emp on (emp.user_id = curtsk.staff_assigned_to)
LEFT JOIN  emp2 on (emp2.user_id = coalesce(dispo.staff_assigned_to, dispo.updated_by))  
LEFT JOIN  ft ON (ft.SRID = sr.task_id)
LEFT JOIN  fn ON (fn.SRID = sr.task_id)     
LEFT JOIN  substat1 on substat1.task_id = sr.task_id   
LEFT JOIN  substat2 on substat2.task_id = sr.task_id            
LEFT JOIN  dnrsn on (dnrsn.srid = sr.task_id)   
where 1=1  
and sr.project_id = 117
AND sr.task_type_id IN ('13473','13475') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
union all
-- migrated SRs
select distinct 'YES' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"
  , appstat.apptype as "App Type"
  , appstat.bu as "Business Unit"
  , coalesce(extapid.ext_app_id, i.VACMS_App_ID) as "External App ID"
  , mywsdt2.mywsdt2 as "My Workspace Date"
  , channel.channel as "Channel"
  , dispoa.dispo as "Disposition" -- logical change -- same mapping 
  , acttk.acttk as "Action Taken"
  , curtsk2.task_id as "Current Task ID"
  , curtsk2.task_type_name as "Current Task Type"
  , curtsk2.task_status as "Current Task Status"
  , date(curtsk2.status_date) as "Current Task Status Date"
  , curtsk2.staff_assigned_to as "Assigned To ID"
  , emp.name as "Assigned to Name"
  , dispo.task_id as complete_task_id
  , dispo.task_status as complete_task_status
  , date(dispo.status_date) as complete_task_date
  , dispo.task_type_name as complete_task_type
  , coalesce(dispo.staff_assigned_to, dispo.updated_by) as "Completed By ID"  -- logical change -- same mapping
  , emp2.name as "Completed by Name"   
  , duedate2.vcldt as "VCL Due Date"
  , ft.ft as "Facility Type" -- new
  , fn.fn as "Facility Name" -- new
  , dnrsn.dnrsn as "Denial Reason"  -- new 
  , coalesce(substat1.selection_varchar, substat2.selection_varchar) as "Substatus" -- new
, dispo2.dispo as "SR HIX Disposition"  -- new
  , dispo2.updated_on as "SR Disposition Date HX" -- new
  , dispoa.updated_on as "SR Disposition Date CUR" -- new
  , dispo.dispo as "Proc App Task Disposition HX" -- new
  , dispo2a2.dispo as "Proc App Task Disposition CUR"  -- new 
  , dispo.updated_on as "Proc App Task Disposition Date HX"  -- new  
  , dispo2a2.updated_on as "Proc App Task Disposition Date CUR"  -- new 
  , null closed_renewal
  , null renewal_due_date
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id and tt2.project_id = 117)
LEFT JOIN "MARSDB"."MARSDB_ETL_INCIDENTS_INIT" i on (i.cp_task_id = sr.task_id)
LEFT JOIN appstat on (appstat.task_id = sr.task_id)
LEFT JOIN extapid ON (extapid.TASK_ID = sr.task_id)    
LEFT JOIN dispo2 ON (dispo2.TASK_ID = sr.task_id)            
LEFT JOIN dispoa ON (dispoa.TASK_ID = sr.task_id)                    
LEFT JOIN duedate2 on (duedate2.srid = sr.task_id)    
LEFT JOIN  mywsdt2 on (mywsdt2.task_id = sr.task_id)     
---LEFT JOIN  mywsdt3 on (mywsdt3.srid = sr.task_id)                   
---LEFT JOIN  mywsdt3 on (mywsdt3.srid = sr.task_id)            
LEFT JOIN dispo on (dispo.srid = sr.task_id and dispo.task_status = 'Complete')     
LEFT JOIN dispo2a2 on (dispo2a2.srid = sr.task_id and dispo2a2.task_status = 'Complete')           
LEFT JOIN dnrsn on (dnrsn.srid = sr.task_id)    
LEFT JOIN acttk on (acttk.srid = sr.task_id and acttk.task_status = 'Complete')  
LEFT JOIN curtsk2 on (curtsk2.SRID = sr.task_id)
LEFT JOIN channel on (channel.srid = sr.task_id)
LEFT JOIN emp on (emp.user_id = curtsk2.staff_assigned_to)
LEFT JOIN emp2 on (emp2.user_id = coalesce(dispo.staff_assigned_to, dispo.updated_by))    
LEFT JOIN ft ON (ft.SRID = sr.task_id)
LEFT JOIN fn ON (fn.SRID = sr.task_id)     
LEFT JOIN substat1 on substat1.task_id = sr.task_id   
LEFT JOIN substat2 on substat2.task_id = sr.task_id               
where 1=1  
AND sr.task_type_id IN ('13473','13475')
and sr.CREATED_BY = '3486'
and mywsdt2.mywsdt2 > '2021-03-15'
and sr.project_id = 117
union all
-- new SRs
select distinct 'NO' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"
  , aptyp.apptype as "App Type"
  , aptyp.bu as "Business Unit"  
  , exaid.ext_app_id as "External App ID"
  , coalesce(mwsd.selection_date, sr.created_on) as "My Workspace Date"
  , cnl.selection_varchar as "Channel"
  , dispoa.dispo as "Disposition" -- logical change  - same mapping
  , acttk33.selection_varchar as "Action Taken"
  , curtsk3.task_id as "Current Task ID"
  , curtsk3.task_type_name as "Current Task Type"
  , curtsk3.task_status as "Current Task Status"
  , date(curtsk3.status_date) as "Current Task Status Date"
  , curtsk3.staff_assigned_to as "Assigned To ID"
  , emp.name as "Assigned to Name"
  , comptsk3.task_id as complete_task_id
  , comptsk3.task_status as complete_task_status
  , date(comptsk3.status_date) as complete_task_date
  , comptsk3.task_type_name as complete_task_type
  , coalesce(comptsk3.staff_assigned_to, comptsk3.updated_by) as "Completed By ID" -- logical change - same mapping
  , emp2.name as "Completed by Name"  
  , duedate3.vcl_due_date as "VCL Due Date"  
  , ft3.ft as "Facility Type" -- new
  , fn3.fn as "Facility Name" -- new
  , dnrsn3.dnrsn as "Denial Reason"  -- new
  , coalesce(substat1.selection_varchar, substat2.selection_varchar) as "Substatus" -- new  
  , dispo3.selection_varchar as "SR HIX Disposition"  -- new
  , dispo3.updated_on as "SR Disposition Date HX" -- new
  , dispoa.updated_on as "SR Disposition Date CUR" -- new
  , dispo23.dispo as "Proc App Task Disposition HX" -- new
  , dispo2a3.dispo as "Proc App Task Disposition CUR"  -- new 
  , dispo23.updated_on as "Proc App Task Disposition Date HX"  -- new  
  , dispo2a3.updated_on as "Proc App Task Disposition Date CUR"  -- new   
  , rap.closed_renewal
  , rap.renewal_due_date
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id and tt2.project_id = 117)
LEFT JOIN appstat aptyp on aptyp.task_id = sr.task_id
LEFT JOIN extapid exaid on exaid.task_id = sr.task_id  
LEFT JOIN duedate3 on duedate3.task_id = sr.task_id    
LEFT JOIN  mwsd on mwsd.task_id = sr.task_id          
LEFT JOIN cnl on cnl.task_id = sr.task_id
LEFT JOIN dispo3 on dispo3.task_id = sr.task_id    
LEFT JOIN  fn3 on fn3.task_id = sr.task_id
LEFT JOIN  ft3 on ft3.task_id = sr.task_id 
LEFT JOIN  dnrsn3 on dnrsn3.task_id = sr.task_id 
LEFT JOIN (SELECT x.task_id,
                  x.project_id,                     
                  x."688" as closed_renewal,
                  TO_DATE(x."687",'MM/DD/YYYY') as renewal_due_date                    
           FROM (SELECT td.task_id, td.project_id,td.task_field_id, td.updated_on,
                     CASE WHEN td.task_field_id = 687 THEN TO_CHAR(td.selection_date,'MM/DD/YYYY')
                        ELSE CASE WHEN td.selection_boolean = 1 THEN 'Y' ELSE 'N' END END selection_varchar                       
                 FROM "MARSDB"."MARSDB_TASK_DETAIL_VW" td 
                 WHERE td.task_field_id in (688,687)
                 AND td.project_id = 117               
            ) PIVOT (MAX(selection_varchar) FOR task_field_id in (688,687)) x ) rap on rap.task_id = sr.task_id   
LEFT JOIN  dispo23 on (dispo23.srid = sr.task_id and dispo23.task_status = 'Complete')  
LEFT JOIN  acttk33 on (acttk33.srid = sr.task_id)
LEFT JOIN  curtsk3 on (curtsk3.srid = sr.task_id)    
LEFT JOIN  comptsk3 on (comptsk3.srid = sr.task_id)    
LEFT JOIN  emp on (emp.user_id = curtsk3.staff_assigned_to)
LEFT JOIN  emp2 on (emp2.user_id = coalesce(comptsk3.staff_assigned_to, comptsk3.updated_by))        
LEFT JOIN  dispoa on dispoa.task_id = sr.task_id              
LEFT JOIN  dispo2a3 on (dispo2a3.srid = sr.task_id and dispo2a3.task_status = 'Complete')            
LEFT JOIN  substat1 on substat1.task_id = sr.task_id   
LEFT JOIN  substat2 on substat2.task_id = sr.task_id      
where 1=1
and sr.task_type_id IN ('15180','15181') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
and sr.project_id = 117
;
