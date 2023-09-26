create table coverva_dmas.cp_application_inventory
as
select distinct 'NO' as migrated
  , sr.task_id as sr_id
  , tt2.task_type_name as sr_type
  , date(sr.created_on) as sr_create_date
  , sr.task_status as sr_status
  , date(sr.status_date) as sr_status_date  
  , appstat.apptype as app_type
  , appstat.bu as business_unit
  , extapid.ext_app_id as t_number
  , coalesce(mywsdt.mywsdt, date(sr.created_on)) as my_workspace_date
  , channel.channel as channel
  , dispo.dispo as disposition
  , acttk.acttk as action_taken  
  , dispo.task_id as complete_task_id
  , dispo.task_status as complete_task_status
  , date(dispo.status_date) as complete_task_date
  , dispo.task_type_name as complete_task_type
  , dispo.staff_assigned_to as completed_by_id
  , emp2.name as completed_by_name
FROM "MARSDB"."MARSDB_TASKS" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN (select * from
          (select distinct tdh.task_id, tdh.task_detail_history_id, tdh.TASK_FIELD_ID, tdh.task_field_name, tdh.SELECTION_VARCHAR as apptype,
                  CASE WHEN tdh.selection_varchar like '%CPU%' THEN 'CPU'    
                       WHEN tdh.selection_varchar like '%PW%' THEN 'CPU'
                       WHEN tdh.selection_varchar like '%CVIU%' THEN 'CVIU'
                       ELSE NULL
                       END AS bu,
                  row_number() over (partition by tdh.task_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
                      from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" tdh
           where tdh.task_field_id = 148
          ) where rn = 1 ) appstat on (appstat.task_id = sr.task_id)
LEFT JOIN (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as ext_app_id,
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" tdh2
           where tdh2.task_field_id = 55 )
           where rn = 1 ) extapid ON (extapid.TASK_ID = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_date as mywsdt
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (el.external_ref_id = th.task_id and th.task_field_id = 102)
           where el.external_ref_type = 'TASK'
           AND   el.internal_ref_type = 'SERVICE_REQUEST'
          ) where rn = 1 ) mywsdt on (mywsdt.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_TYPE" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 13474)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 71)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
          ) where rn = 1 ) dispo on (dispo.srid = sr.task_id and dispo.task_status = 'Complete')                
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as acttk
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id and t.task_type_id = 13474)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 144)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
          ) where rn = 1 ) acttk on (acttk.srid = sr.task_id and acttk.task_status = 'Complete')  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_varchar as channel
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 12)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
          ) where rn = 1 ) channel on (channel.srid = sr.task_id)
LEFT JOIN (SELECT distinct u.user_id,
                  concat(s.first_name, ' ',s.last_name) as name,
                  s.maximus_id,
                  t.TEAM_NAME,
                  pr.role_name
           FROM "MARSDB"."MARSDB_USER" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp2 on (emp2.user_id = dispo.staff_assigned_to)  
where 1=1  
AND sr.task_type_id IN ('13473','13475') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
union all
-- migrated apps
select distinct 'YES' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"  
  , appstat.apptype as "App Type"
  , appstat.bu as "Business Unit"
  , coalesce(extapid.ext_app_id, i.VACMS_App_ID) as "External App ID"
  , coalesce(date(sr.created_on), mywsdt.mywsdt) as "My Workspace Date"
  , channel.channel as "Channel"
  , dispo.dispo as "Disposition"
  , acttk.acttk as "Action Taken"
  , dispo.task_id as complete_task_id
  , dispo.task_status as complete_task_status
  , date(dispo.status_date) as complete_task_date
  , dispo.task_type_name as complete_task_type
  , dispo.staff_assigned_to as "Completed By ID"
  , emp2.name as "Completed by Name"    
FROM "MARSDB"."MARSDB_TASKS" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN "MARSDB"."MARSDB_ETL_INCIDENTS_INIT" i on (i.cp_task_id = sr.task_id)
LEFT JOIN (select * from
          (select distinct tdh.task_id, tdh.task_detail_history_id, tdh.TASK_FIELD_ID, tdh.task_field_name, tdh.SELECTION_VARCHAR as apptype,
                  CASE WHEN tdh.selection_varchar like '%CPU%' THEN 'CPU'    
                                                                              WHEN tdh.selection_varchar like '%PW%' THEN 'CPU'
                       WHEN tdh.selection_varchar like '%CVIU%' THEN 'CVIU'
                       ELSE NULL
                       END AS bu,
                  row_number() over (partition by tdh.task_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
                      from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" tdh
           where tdh.task_field_id = 148
          ) where rn = 1 ) appstat on (appstat.task_id = sr.task_id)
LEFT JOIN (select * from
          (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as ext_app_id,
                  row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" tdh2
          where tdh2.task_field_id = 55 )
           where rn = 1 ) extapid ON (extapid.TASK_ID = sr.task_id)
LEFT JOIN (select tt.task_id
                , case when tt.task_info like '%My Workspace Date%' then right(left(tt.task_info, 28),10)
                       when tt.task_info like '%DMAS Received Date%' then right(left(tt.task_info, 29),10)
                       end as mywsdt
                                 from "MARSDB"."MARSDB_TASKS" tt
           where (tt.task_info not like  ('%No My Workspace Date received%')
           and tt.task_info not like ('%No DMAS Received Date receive%'))) mywsdt on (mywsdt.task_id = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_TYPE" tt on (t.task_type_id = tt.task_type_id)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 71)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
          ) where rn = 1 ) dispo on (dispo.srid = sr.task_id and dispo.task_status = 'Complete')                
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as acttk
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 144)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
          ) where rn = 1 ) acttk on (acttk.srid = sr.task_id and acttk.task_status = 'Complete')  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID
           , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_varchar as channel
           ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 12)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
          ) where rn = 1 ) channel on (channel.srid = sr.task_id)
LEFT JOIN (SELECT distinct u.user_id,
                  concat(s.first_name, ' ',s.last_name) as name,
                  s.maximus_id,
                  t.TEAM_NAME,
                  pr.role_name
           FROM "MARSDB"."MARSDB_USER" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp2 on (emp2.user_id = dispo.staff_assigned_to)    
where 1=1  
AND sr.task_type_id IN ('13473','13475')
and sr.CREATED_BY = '3486'
and mywsdt.mywsdt > '2021-03-15'
union all
select distinct 'NO' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"  
  , aptyp.selection_varchar as "App Type"
  , aptyp.bu as "Business Unit"  
  , exaid.selection_varchar as "External App ID"
  , coalesce(mwsd.selection_date, sr.created_on) as "My Workspace Date"
  , cnl.selection_varchar as "Channel"
  , coalesce (dispo2.dispo, dispo.selection_varchar) as "Disposition"
  , acttk3.selection_varchar as "Action Taken"
  , comptsk.task_id as complete_task_id
  , comptsk.task_status as complete_task_status
  , date(comptsk.status_date) as complete_task_date
  , comptsk.task_type_name as complete_task_type
  , comptsk.staff_assigned_to as "Completed By ID"
  , emp2.name as "Completed by Name"  
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id and tt2.project_id = 117)
LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR,                  
                          CASE WHEN tdh.selection_varchar like '%CPU%'  THEN 'CPU'    
                               WHEN tdh.selection_varchar like '%PW%'   THEN 'CPU'
                               WHEN tdh.selection_varchar like '%CVIU%' THEN 'CVIU'
                               ELSE NULL
                               END AS bu
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 148 and tdh.project_id = 117 -- App type
           ) where rn = 1 ) aptyp on aptyp.task_id = sr.task_id
LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 55 and tdh.project_id = 117 -- Ext App ID
           ) where rn = 1 ) exaid on exaid.task_id = sr.task_id
LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_date              
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 102 and tdh.project_id = 117 -- My ES date
           ) where rn = 1 ) mwsd on mwsd.task_id = sr.task_id          
LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 12 and tdh.project_id = 117 -- Channel
           ) where rn = 1 ) cnl on cnl.task_id = sr.task_id
LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR                
                        , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn
            from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" tdh where tdh.task_field_id = 71 and tdh.project_id = 117 -- Disposition
           ) where rn = 1 ) dispo on dispo.task_id = sr.task_id  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_history_id, th.task_detail_history_id, t.task_id, tt.task_type_name, t.task_status, t.status_date
           , t.updated_by, th.selection_varchar as dispo, t.staff_assigned_to
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc, th.task_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS_HISTORY" t on (el.external_ref_id = t.task_id)
           left join "MARSDB"."MARSDB_TASK_TYPE" tt on (t.task_type_id = tt.task_type_id and t.task_type_id = 15182)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id and th.task_field_id = 71)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status = 'Complete'
          ) where rn = 1 ) dispo2 on (dispo2.srid = sr.task_id and dispo2.task_status = 'Complete')  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name
                         , th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar        
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           left join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.project_id = 117 and th.task_field_id = 144)
           where el.project_id = 117 and el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST'
          ) where rn = 1 ) acttk3 on (acttk3.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name
                         , th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar        
           ,row_number() over(partition by el.internal_id  order by th.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS" el
           left join "MARSDB"."MARSDB_TASKS" t on (el.external_ref_id = t.task_id )
           join "MARSDB"."MARSDB_TASK_TYPE" tt on (t.task_type_id = tt.task_type_id)
           left join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY" th on (t.task_id = th.task_id)
           where el.external_ref_type = 'TASK'
           and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_status in ('Closed','Complete')
          ) where rn = 1 ) comptsk on (comptsk.srid = sr.task_id)            
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARS_DP4BI_PROD"."MARSDB"."MARSDB_USER" u
           LEFT JOIN "MARS_DP4BI_PROD"."MARSDB"."MARSDB_TEAM_USER" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARS_DP4BI_PROD"."MARSDB"."MARSDB_STAFF" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARS_DP4BI_PROD"."MARSDB"."MARSDB_TEAM" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARS_DP4BI_PROD"."MARSDB"."MARSDB_USER_PROJECT_ROLE" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARS_DP4BI_PROD"."MARSDB"."MARSDB_PROJECT_ROLE" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           --where u.project_id = 117
           ) emp2 on (emp2.user_id = comptsk.staff_assigned_to)           
where 1=1  
AND sr.task_type_id IN ('15180','15181') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
;

alter table coverva_dmas.cp_application_inventory add primary key(sr_id);
