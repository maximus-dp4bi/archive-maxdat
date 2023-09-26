CREATE OR REPLACE VIEW coverva_dmas.cp_application_initial_review_vw
AS
  SELECT distinct tt.task_type_name,f.task_id, f.created_on, fcomp.task_status, fcomp.status_date, fcomp.updated_by, emp.name as completed_by_name 
            ,coalesce(extappid2.extappidsr,extapid.ext_app_id) as external_app_id, dispo.dispo as disposition,actkn.actkn as action_taken 
           FROM MARSDB.MARSDB_TASKS_HISTORY_VW f 
             JOIN MARSDB.MARSDB_TASK_TYPE_VW tt on (f.task_type_id = tt.task_type_id AND f.project_id = tt.project_id) 
             LEFT JOIN (select * from ( 
               select distinct th.action, th.task_id, th.task_history_id, th.status_date, th.task_status, th.task_type_id, th.updated_by, th.updated_on, 
               row_number() over (partition by th.task_id  order by th.task_history_id asc) rn 
               from MARSDB.MARSDB_TASKS_HISTORY_VW th 
               where th.project_id = 117 and th.task_status = 'Complete' and th.updated_by <> 3486) 
               where rn = 1 ) fcomp ON (fcomp.TASK_ID = f.task_id) 
             LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name 
               FROM MARSDB.MARSDB_USER_VW u 
               LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on (u.user_id = tu.USER_ID and tu.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_STAFF_VW s on (s.STAFF_ID = u.STAFF_ID) 
               LEFT JOIN MARSDB.MARSDB_TEAM_VW t on (t.TEAM_ID = tu.TEAM_ID and t.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on (upr.USER_ID = u.USER_ID and upr.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on (pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID and pr.project_id = 117) 
               where u.project_id = 117 ) emp on (emp.user_id = fcomp.updated_by) 
             LEFT JOIN (select * from 
              (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as ext_app_id, 
                      row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id desc, tdh2.task_history_id desc) rn 
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh2 
               where tdh2.task_field_id = 55 and tdh2.project_id = 117) 
               where rn = 1 ) extapid ON (extapid.TASK_ID = f.task_id) 
             LEFT JOIN (select * from 
              (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispo, updated_on, updated_by, 
                      row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id asc, tdh2.task_history_id asc) rn 
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh2 
               where tdh2.task_field_id = 71 and tdh2.project_id = 117 and tdh2.SELECTION_VARCHAR is not null) 
               where rn = 1 ) dispo ON (dispo.TASK_ID = f.task_id) 
             LEFT JOIN (select * from 
              (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as actkn,updated_on, updated_by, 
                      row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id asc, tdh2.task_history_id asc) rn 
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh2 
               where tdh2.task_field_id = 144 and tdh2.project_id = 117 and  tdh2.SELECTION_VARCHAR is not null) 
               where rn = 1 ) actkn ON (actkn.TASK_ID = f.task_id) 
            LEFT JOIN (select * from (         
               select distinct el.internal_id as SRID, el.external_ref_id as proc_app_task_id 
               , th.task_detail_history_id, th.task_detail_id, th.task_id, th.task_history_id, th.task_field_id, th.selection_varchar as extappidsr 
               ,row_number() over(partition by th.task_id, th.task_detail_id  order by th.task_detail_history_id desc, th.task_history_id desc  ) rn 
               from MARSDB.MARSDB_EXTERNAL_LINKS_VW el 
               left join MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (el.internal_id = th.task_id and th.task_field_id = 55) 
               where el.external_ref_type = 'TASK' 
               AND   el.internal_ref_type = 'SERVICE_REQUEST' 
               AND   el.project_id = 117 ) where rn = 1 ) extappid2 on (extappid2.proc_app_task_id = f.task_id) 
           WHERE  1=1 
           AND   f.task_type_id = 13474 
           AND   f.task_status = 'Complete' 
           AND   f.project_id = 117 
           AND   f.updated_by <> 3486 
          UNION ALL 
          SELECT distinct tt.task_type_name 
            , f.task_id, f.created_on, fcomp.task_status, fcomp.status_date, fcomp.updated_by 
            , emp.name as completed_by_name 
            , exaid.selection_varchar as external_app_id2 
            , dispo.dispo as disposition 
            , actkn.actkn as action_taken 
          FROM MARSDB.MARSDB_TASKS_HISTORY_VW f 
            JOIN MARSDB.MARSDB_TASK_TYPE_VW tt on (f.task_type_id = tt.task_type_id) 
            LEFT JOIN (select * from ( 
               select distinct th.action, th.task_id, th.task_history_id, th.status_date, th.task_status, th.task_type_id, th.updated_by, th.updated_on, 
               row_number() over (partition by th.task_id  order by th.task_history_id asc) rn 
               from MARSDB.MARSDB_TASKS_HISTORY_VW th 
               where th.project_id = 117 and th.task_status = 'Complete') 
               where rn = 1 ) fcomp ON (fcomp.TASK_ID = f.task_id) 
            LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name 
               FROM MARSDB.MARSDB_USER_VW u 
               LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu on (u.user_id = tu.USER_ID and tu.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_STAFF_VW s on (s.STAFF_ID = u.STAFF_ID) 
               LEFT JOIN MARSDB.MARSDB_TEAM_VW t on (t.TEAM_ID = tu.TEAM_ID and t.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr on (upr.USER_ID = u.USER_ID and upr.project_id = 117) 
               LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr on (pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID and pr.project_id = 117) 
               where u.project_id = 117) emp on (emp.user_id = fcomp.updated_by) 
            LEFT JOIN (select * from (select distinct tdh.task_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.SELECTION_VARCHAR 
                            , row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn 
                from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh where tdh.task_field_id = 55 and tdh.project_id = 117 
               ) where rn = 1 ) exaid on exaid.task_id = f.task_id 
            LEFT JOIN (select * from 
              (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as dispo, updated_on, updated_by, 
                      row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id asc, tdh2.task_history_id asc) rn 
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh2 
               where tdh2.task_field_id = 71 and tdh2.project_id = 117 and tdh2.SELECTION_VARCHAR is not null) 
               where rn = 1 ) dispo ON (dispo.TASK_ID = f.task_id) 
           LEFT JOIN (select * from 
              (select tdh2.task_id, tdh2.TASK_FIELD_ID, tdh2.task_field_name, tdh2.SELECTION_VARCHAR as actkn,updated_on, updated_by, 
                      row_number() over (partition by tdh2.task_id  order by tdh2.task_detail_history_id asc, tdh2.task_history_id asc) rn 
               from MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh2 
               where tdh2.task_field_id = 144 and tdh2.project_id = 117 and  tdh2.SELECTION_VARCHAR is not null) 
               where rn = 1 ) actkn ON (actkn.TASK_ID = f.task_id) 
           where 1=1 
           and   f.task_type_id = 15182 
           and   f.task_status = 'Complete' 
           and   f.project_id = 117 
           and   f.updated_by <> 3486;