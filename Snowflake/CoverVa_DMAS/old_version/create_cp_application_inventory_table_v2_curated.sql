 
 drop table coverva_dmas.cp_application_inventory;
 create table coverva_dmas.cp_application_inventory
 AS
 SELECT distinct 'NO' as migrated 
   , sr.task_id as sr_id 
   , tt2.task_type_name as sr_type 
   , date(sr.created_on) as sr_create_date 
   , sr.task_status as sr_status 
   , date(sr.status_date) as sr_status_date 
   , srctd.apptp as app_type 
   , CASE WHEN srctd.apptp like '%CPU%' THEN 'CPU' 
          WHEN srctd.apptp like '%PW%' THEN 'CPU' 
          WHEN srctd.apptp like '%CVIU%' THEN 'CVIU' 
          ELSE NULL END AS business_unit 
   , srctd.exapid as tracking_number 
   , pactd1.mywsdt as my_workspace_date
   , date(initdispo.updated_on) as initial_disposition_date
  , emp3.name as initial_disposition_staff
   , srctd.dispo as disposition
   , pactd.ats as action_taken
   , srctd.decsnsrc as sr_decision_source
   , papp.task_id as process_app_task_id
   , papp.task_type_name as process_app_task_type
   , papp.task_status as process_app_status
   , papp.status_date as process_app_status_date
   , papp.updated_on as process_app_update_date
   , papp.updated_by as process_app_updated_by_id
   , emp1.name as process_app_updated_by_name
   , papp.staff_assigned_to as process_app_assigned_to_id
   , emp2.name as process_app_assigned_to_name
   , pactd.dispo as process_app_disposition
   , pactd.chnl as channel
   , pactd.factyp as facility_type
   , pactd.facnam as facility_name
   , pactd.appsubstat as substatus
   , pactd.rsn as reason
   , pactd.dnlrsn as denial_reason
   , pactd.dcsrc as decision_source
   , pactd.mirq as missing_info_required
   , pactd.hpe as hpe_indicator
   , pactd1.vclsent as vcl_sent_date
   , pactd1.vcldue as vcl_due_date
   , pactd1.appsigdt as app_signature_date
   , pactd1.appdtrcd as app_received_date
   , pactd1.dtrcd as date_received
   , pactd.inbncortyp as inbound_correspondence_type
   , sr.due_in_days as sr_due_in_days
   , sr.default_due_date as sr_default_due_date
   , papp.due_in_days as process_app_due_in_days
   , papp.default_due_date as process_app_default_due_date
   , null as second_vcl_sent_date
   , null as third_vcl_sent_date
   , null as vcl_exception
 FROM MARSDB.MARSDB_TASKS_VW sr
 JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id) 
 LEFT JOIN (select * from (
            select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                 , t.due_in_days, t.default_due_date, t.override_due_date, t.override_performed_by, t.task_disposition
            from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
            join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
            left join MARSDB.MARSDB_TASK_TYPE_VW tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
            where el.external_ref_type = 'TASK'
            AND el.internal_ref_type = 'SERVICE_REQUEST'
            and el.project_id = 117  )  ) papp on (papp.srid = sr.task_id)
 LEFT JOIN (select x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."153" as decsnsrc
            from (select td.task_id, td.task_field_id, td.selection_varchar
                 from MARSDB.MARSDB_TASK_DETAIL_VW td where td.task_field_id in (55,71,148,153)
                  and td.project_id = 117
                  ) pivot (max(selection_varchar) for task_field_id in (55,71,148,153)) x
            ) srctd on (srctd.task_id = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."71" as dispo, x."112" as facnam, x."147" as appsubstat, x."93" as rsn, x."161" as dnlrsn 
                 , x."12" as chnl, x."113" as factyp,  x."144" as ats, x."153" as dcsrc, x."120" as mirq, x."117" as hpe, x."4" as cwln, x."3" as cwfn
                 , x."119" as locality, x."131" as expedited, x."59" as inbncortyp
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117
                  ) pivot (max(selection_varchar) for task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59)) x
            ) pactd on (pactd.srid = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."146" as appsigdt, x."102" as mywsdt, x."145" as appdtrcd, x."103" as dtrcd, x."38" as dob, x."173" as vclsent, x."175" as vcldue
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_date
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (146,102,145,103,38,173,175))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117
                  ) pivot (max(selection_date) for task_field_id in (146,102,145,103,38,173,175)) x
            ) pactd1 on (pactd1.srid = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."160" as apctinhshd, x."159" as apprvdapct
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_numeric
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (160,159))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117
                  ) pivot (max(selection_numeric) for task_field_id in (160,159)) x
            ) pactd2 on (pactd2.srid = sr.task_id)
 LEFT JOIN (select * from (                                     
            select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
            , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
            from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
            join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
            join MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
            where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
            where rn = 1 ) initdispo on (initdispo.srid = sr.task_id)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp1 on (emp1.user_id = papp.updated_by)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp2 on (emp2.user_id = papp.staff_assigned_to)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp3 on (emp3.user_id = initdispo.updated_by)
 where 1=1
 and sr.project_id = 117
 AND sr.task_type_id IN ('13473','13475') 
 and sr.CREATED_BY <> '3486'
 union all
 select distinct 'YES' as migrated
   , sr.task_id as sr_id
   , tt2.task_type_name as sr_type
   , date(sr.created_on) as sr_create_date
   , sr.task_status as sr_status
   , date(sr.status_date) as sr_status_date 
   , srctd.apptp as app_type
   , CASE WHEN srctd.apptp like '%CPU%' THEN 'CPU'
          WHEN srctd.apptp like '%PW%' THEN 'CPU'
          WHEN srctd.apptp like '%CVIU%' THEN 'CVIU'
          ELSE NULL END AS business_unit
   , coalesce(srctd.exapid, i.VACMS_App_ID) as tracking_number
   , mywsdt2.mywsdt as my_workspace_date
   , date(initdispo.updated_on) as initial_disposition_date
   , emp3.name as initial_disposition_staff
   , srctd.dispo as disposition
   , pactd.ats as action_taken
   , srctd.decsnsrc as sr_decision_source
   , papp.task_id as process_app_task_id
   , papp.task_type_name as process_app_task_type
   , papp.task_status as process_app_status
   , papp.status_date as process_app_status_date
   , papp.updated_on as process_app_update_date
   , papp.updated_by as process_app_updated_by_id
   , emp1.name as process_app_updated_by_name
   , papp.staff_assigned_to as process_app_assigned_to_id
   , emp2.name as process_app_assigned_to_name
   , pactd.dispo as process_app_disposition
   , pactd.chnl as channel
   , pactd.factyp as facility_type
   , pactd.facnam as facility_name
   , pactd.appsubstat as substatus
   , pactd.rsn as reason
   , pactd.dnlrsn as denial_reason
   , pactd.dcsrc as decision_source
   , pactd.mirq as missing_info_required
   , pactd.hpe as hpe_indicator
   , pactd1.vclsent as vcl_sent_date
   , pactd1.vcldue as vcl_due_date   
   , pactd1.appsigdt as app_signature_date
   , pactd1.appdtrcd as app_received_date
   , pactd1.dtrcd as date_received
   , pactd.inbncortyp as inbound_correspondence_type
   , sr.due_in_days as sr_due_in_days
   , sr.default_due_date as sr_default_due_date
   , papp.due_in_days as process_app_due_in_days
   , papp.default_due_date as process_app_default_due_date
   , null as second_vcl_sent_date
   , null as third_vcl_sent_date
   , null as vcl_exception
 FROM MARSDB.MARSDB_TASKS_VW sr
 JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id)
 LEFT JOIN MARSDB.MARSDB_ETL_INCIDENTS_INIT i on (i.cp_task_id = sr.task_id) 
 LEFT JOIN (select * from (                                                              
            select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                  , t.due_in_days, t.default_due_date
            from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
            join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
            left join MARSDB.MARSDB_TASK_TYPE_VW tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
            where el.external_ref_type = 'TASK'
            AND el.internal_ref_type = 'SERVICE_REQUEST'
            and el.project_id = 117  ) ) papp on (papp.srid = sr.task_id) 
 LEFT JOIN (select x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."153" as decsnsrc
            from (select td.task_id, td.task_field_id, td.selection_varchar
                  from MARSDB.MARSDB_TASK_DETAIL_VW td where td.task_field_id in (55,71,148,153)
                  and td.project_id = 117
                  ) pivot (max(selection_varchar) for task_field_id in (55,71,148,153)) x
            ) srctd on (srctd.task_id = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."71" as dispo, x."112" as facnam, x."147" as appsubstat, x."93" as rsn, x."161" as dnlrsn 
                 , x."12" as chnl, x."113" as factyp,  x."144" as ats, x."153" as dcsrc, x."120" as mirq, x."117" as hpe, x."4" as cwln, x."3" as cwfn
                 , x."119" as locality, x."131" as expedited, x."59" as inbncortyp
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117 
                  ) pivot (max(selection_varchar) for task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59)) x
            ) pactd on (pactd.srid = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."146" as appsigdt, x."102" as mywsdt, x."145" as appdtrcd, x."103" as dtrcd, x."38" as dob, x."173" as vclsent, x."175" as vcldue
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_date
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (146,102,145,103,38,173,175))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117   
                  ) pivot (max(selection_date) for task_field_id in (146,102,145,103,38,173,175)) x
            ) pactd1 on (pactd1.srid = sr.task_id)
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."160" as apctinhshd, x."159" as apprvdapct
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_numeric
                  from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                  join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                  join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (160,159))
                  where el.external_ref_type = 'TASK'
                  and   el.internal_ref_type = 'SERVICE_REQUEST'
                  and   el.project_id = 117  
                  ) pivot (max(selection_numeric) for task_field_id in (160,159)) x ) pactd2 on (pactd2.srid = sr.task_id)
 LEFT JOIN (select tt.task_id
                 , case when tt.task_info like '%My Workspace Date%' then right(left(tt.task_info, 28),10)
                        when tt.task_info like '%DMAS Received Date%' then right(left(tt.task_info, 29),10)
                        end as mywsdt
            from MARSDB.MARSDB_TASKS_VW tt
            where tt.project_id = 117 
            and (tt.task_info not like ('%No My Workspace Date received%')
            and  tt.task_info not like ('%No DMAS Received Date receive%'))) mywsdt2 on (mywsdt2.task_id = sr.task_id)
 LEFT JOIN (select * from (                                                             
            select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
            from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
            join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
            join MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
            where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
            where rn = 1 ) initdispo on (initdispo.srid = sr.task_id)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp1 on (emp1.user_id = papp.updated_by)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp2 on (emp2.user_id = papp.staff_assigned_to)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
            LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
            LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
            LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
            LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp3 on (emp3.user_id = initdispo.updated_by)
 where 1=1  
 and sr.project_id = 117
 and sr.task_type_id IN ('13473','13475')
 and sr.CREATED_BY = '3486'
 and mywsdt2.mywsdt > '2021-03-15'
 union all
 select distinct 'NO' as migrated
   , sr.task_id as sr_id
   , tt2.task_type_name as sr_type
  , date(sr.created_on) as sr_create_date
  , sr.task_status as sr_status
  , date(sr.status_date) as sr_status_date
  , srctd.apptp as app_type
  , CASE WHEN srctd.apptp like '%CPU%' THEN 'CPU'   
         WHEN srctd.apptp like '%PW%' THEN 'CPU'
         WHEN srctd.apptp like '%CVIU%' THEN 'CVIU'
         ELSE NULL END AS business_unit
  , srctd.exapid as tracking_number
  , srctd1.mywsdt as my_workspace_date
  , date(initdispo.updated_on) as initial_disposition_date
  , emp3.name as initial_disposition_staff
  , srctd.dispo as disposition
  , pactd.ats as action_taken
  , srctd.dcsrc as sr_decision_source
  , papp.task_id as process_app_task_id
  , papp.task_type_name as process_app_task_type
  , papp.task_status as process_app_status
  , papp.status_date as process_app_status_date
  , papp.updated_on as process_app_update_date
  , papp.updated_by as process_app_updated_by_id
  , emp1.name as process_app_updated_by_name
  , papp.staff_assigned_to as process_app_assigned_to_id
  , emp2.name as process_app_assigned_to_name
  , pactd.dispo as process_app_disposition 
  , srctd.chnl as channel
  , srctd.factyp as facility_type
  , srctd.facnam as facility_name
  , srctd.appsubstat as substatus
  , srctd.rsn as reason
  , srctd.dnlrsn as denial_reason
  , srctd.dcsrc as decision_source
  , srctd.mirq as missing_info_required
  , srctd.hpe as hpe_indicator
  , srctd1.vclsent as vcl_sent_date
  , srctd1.vcldue as vcl_due_date  
  , srctd1.appsigdt as app_signature_date
  , srctd1.appdtrcd as app_received_date
  , srctd1.dtrcd as date_received 
  , srctd.inbncortyp as inbound_correspondence_type 
  , sr.due_in_days as sr_due_in_days
  , sr.default_due_date as sr_default_due_date
  , papp.due_in_days as process_app_due_in_days
  , papp.default_due_date as process_app_default_due_date  
  , vcl2.selection_date as second_vcl_sent_date
  , vcl3.selection_date third_vcl_sent_date
  , case when srctd1.vclsent <> vcl2.selection_date and srctd1.vclsent <> vcl3.selection_date and vcl2.selection_date is not null
         and vcl3.selection_date is not null and srctd1.vclsent is not null then 'VCL Exception' else null end as vcl_exception
 FROM MARSDB.MARSDB_TASKS_VW sr
 JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id)
 LEFT JOIN (select * from (                                                              
            select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                 ,t.due_in_days, t.default_due_date
           from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
           join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           left join MARSDB.MARSDB_TASK_TYPE_VW tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117  )  ) papp on (papp.srid = sr.task_id) 
 LEFT JOIN (select x.SRID as SRID, x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."144" as ats
            from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                 from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                 join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
                 join MARSDB.MARSDB_TASK_DETAIL_VW td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,144))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,144)) x
           ) pactd on (pactd.srid = sr.task_id)   
 LEFT JOIN (select x.task_id, x."55" as exapid, x."4" as cwln, x."3" as cwfn, x."119" as locality, x."112" as facnam, x."147" as appsubstat, x."59" as inbncortyp
                 , x."93" as rsn, x."161" as dnlrsn, x."12" as chnl, x."148" as apptp, x."71" as dispo, x."113" as factyp, x."153" as dcsrc, x."120" as mirq
                 , x."117" as hpe, x."131" as expedited
            from (select td.task_id, td.task_field_id, td.selection_varchar
                  from MARSDB.MARSDB_TASK_DETAIL_VW td where td.task_field_id in (55,3,4,119,112,147,59,93,161,12,148,71,113,153,120,117,131) 
                  and td.project_id = 117 
                  ) pivot (max(selection_varchar) for task_field_id in (55,3,4,119,112,147,59,93,161,12,148,71,113,153,120,117,131)) x
            ) srctd on (srctd.task_id = sr.task_id)
 LEFT JOIN (select x.task_id, x."145" as appdtrcd, x."146" as appsigdt, x."102" as mywsdt, x."175" as vcldue, x."173" as vclsent, x."103" as dtrcd, x."38" as dob, x."174" as mircddt            
            from (select td.task_id, td.task_field_id, td.selection_date
                  from MARSDB.MARSDB_TASK_DETAIL_VW td where td.task_field_id in (145,146,102,175,173,103,38,174)
                  and td.project_id = 117  
                  ) pivot (max(selection_date) for task_field_id in (145,146,102,175,173,103,38,174)) x
            ) srctd1 on (srctd1.task_id = sr.task_id) 
 LEFT JOIN (select x.task_id, x."91" as extcaseid, x."160" as apctinhshd, x."159" as apprvdapct        
            from (select td.task_id, td.task_field_id, td.selection_numeric
                  from MARSDB.MARSDB_TASK_DETAIL_VW td where td.task_field_id in (91,160,159)     
                  and td.project_id = 117
                  ) pivot (max(selection_numeric) for task_field_id in (91,160,159)) x
            ) srctd2 on (srctd2.task_id = sr.task_id)
 LEFT JOIN (select * from (                                                              
            select distinct th.task_id as SRID, th.selection_varchar as dispo, th.updated_on, th.updated_by
              , row_number() over(partition by th.task_id  order by th.task_detail_history_id) rn
            from  MARSDB.MARSDB_TASKS_VW t
            join MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
            where t.project_id = 117 and t.task_type_id in (15180,15181) ) 
            where rn = 1 ) initdispo on (initdispo.srid = sr.task_id)
 LEFT JOIN (select * from (
               select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
                , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
               from MARSDB.MARSDB_EXTERNAL_LINKS_VW el
                 join MARSDB.MARSDB_TASKS_VW t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
                 join MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
               where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
            where rn = 1 ) initact on (initact.srid = sr.task_id)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
              LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
              LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
              LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
              LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
              LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp1 on (emp1.user_id = papp.updated_by)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
             LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
             LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
             LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
             LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
             LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117 ) emp2 on (emp2.user_id = papp.staff_assigned_to)
 LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
            FROM MARSDB.MARSDB_USER_VW u
             LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on u.user_id = tu.USER_ID
             LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.STAFF_ID = u.STAFF_ID
             LEFT JOIN MARSDB.MARSDB_TEAM_VW t on t.TEAM_ID = tu.TEAM_ID
             LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on upr.USER_ID = u.USER_ID
             LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
            where u.project_id = 117) emp3 on (emp3.user_id = initdispo.updated_by)
 LEFT JOIN (select * from (   
              select td.task_id, td.task_detail_history_id, td.task_field_id, td.selection_date, td.updated_on
                , row_number() over(partition by td.task_id order by td.task_detail_history_id desc) rn
              from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW td where td.task_field_id = 173
              and td.project_id = 117 and td.selection_date is not null)
            where rn = 2) vcl2 on (vcl2.task_id = sr.task_id)
 LEFT JOIN (select * from (
               select td.task_id, td.task_detail_history_id, td.task_field_id, td.selection_date, td.updated_on
                 , row_number() over(partition by td.task_id order by td.task_detail_history_id desc) rn
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW td where td.task_field_id = 173
                and td.project_id = 117 and td.selection_date is not null)
            where rn = 3) vcl3 on (vcl3.task_id = sr.task_id)
 where 1=1
 and sr.project_id = 117
 AND sr.task_type_id IN ('15180','15181')
 and sr.CREATED_BY <> '3486'
;

alter table coverva_dmas.cp_application_inventory add primary key(sr_id);
