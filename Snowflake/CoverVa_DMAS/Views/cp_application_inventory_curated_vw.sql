CREATE OR REPLACE VIEW coverva_dmas.cp_application_inventory_curated_vw
AS
select distinct 
    'NO' as migrated
  , sr.task_id as sr_id
  , tt2.task_type_name as sr_type
  , date(sr.created_on) as sr_create_date
  , sr.task_status as sr_status
  , date(sr.status_date) as sr_status_date
  , cel.external_ref_id as consumer_id
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
  , pactd1.dob as date_of_birth
  , pactd2.apctinhshd as num_applicants_in_household
  , pactd2.apprvdapct as num_approved_applications
  , pactd.expedited as expedited
  , pactd.locality as locality
  , pactd.inbncortyp as inbound_correspondence_type
  , concat(pactd.cwfn, ' ' ,pactd.cwln) as case_worker_name
  , srnote.text as sr_notes
  , tasknote.task_notes as task_notes
  , sr.due_in_days as sr_due_in_days
  , sr.default_due_date as sr_default_due_date
  , papp.due_in_days as process_app_due_in_days
  , papp.default_due_date as process_app_default_due_date
  , null as second_vcl_sent_date
  , null as third_vcl_sent_date
  , null as vcl_exception
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('APPROVED','DENIED') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end pre_release_recon_complete
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('COVERAGE_CORRECTION_NEEDED','VCL') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null)) then 1 else 0 end pre_release_recon_incomplete
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('APPROVED') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end pre_release_outcome_approved
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('DENIED')) then 1 else 0 end pre_release_outcome_denied
  , Case when ((srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null) or srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat='VCL')then 1 else 0 end pre_release_outcome_pending_cviu
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('COVERAGE_CORRECTION_NEEDED')) then 1 else 0 end pre_release_outcome_pending_dmas
  , initact.acttk as first_action_taken
  , initact.updated_on as first_action_taken_date
  , act2.acttk second_action_taken
  , act2.updated_on as second_action_taken_date
  , act3.acttk as third_action_taken
  , act3.updated_on as third_action_taken_date 
  , initdispo.dispo as first_disposition
  , initdispo.updated_on as first_disposition_date
  , dispo2.dispo as second_disposition
  , dispo2.updated_on as second_disposition_date
  , dispo3.dispo as third_disposition
  , dispo3.updated_on as third_disposition_date
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" cel ON (cel.internal_id = sr.task_id and cel.internal_ref_type = 'SERVICE_REQUEST' AND cel.external_ref_type = 'CONSUMER' and cel.project_id = 117)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                , t.due_in_days, t.default_due_date, t.override_due_date, t.override_performed_by, t.task_disposition
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117  )
           ) papp on (papp.srid = sr.task_id) 
LEFT JOIN (select x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."153" as decsnsrc          
           from (select td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_TASK_DETAIL_VW" td where td.task_field_id in (55,71,148,153) 
                 and td.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,153)) x
           ) srctd on (srctd.task_id = sr.task_id)
LEFT JOIN (select x.SRID as SRID, x.task_id, x."71" as dispo, x."112" as facnam, x."147" as appsubstat, x."93" as rsn, x."161" as dnlrsn 
                , x."12" as chnl, x."113" as factyp,  x."144" as ats, x."153" as dcsrc, x."120" as mirq, x."117" as hpe, x."4" as cwln, x."3" as cwfn
                , x."119" as locality, x."131" as expedited, x."59" as inbncortyp
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59)) x
           ) pactd on (pactd.srid = sr.task_id) 
LEFT JOIN (select x.SRID as SRID, x.task_id, x."146" as appsigdt, x."102" as mywsdt, x."145" as appdtrcd, x."103" as dtrcd, x."38" as dob, x."173" as vclsent, x."175" as vcldue            
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_date
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (146,102,145,103,38,173,175))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117   
                 ) pivot (max(selection_date) for task_field_id in (146,102,145,103,38,173,175)) x
           ) pactd1 on (pactd1.srid = sr.task_id)
LEFT JOIN (select x.SRID as SRID, x.task_id, x."160" as apctinhshd, x."159" as apprvdapct         
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_numeric
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (160,159))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117   
                 ) pivot (max(selection_numeric) for task_field_id in (160,159)) x
           ) pactd2 on (pactd2.srid = sr.task_id) 

  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 1 ) initdispo on (initdispo.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 1 ) initact on (initact.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 2 ) dispo2 on (dispo2.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 2 ) act2 on (act2.srid = sr.task_id)  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 3 ) dispo3 on (dispo3.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 3 ) act3 on (act3.srid = sr.task_id) 
  
  
LEFT JOIN (select distinct el.internal_id as SRID, listagg(t.task_notes, ' <Task Notes> ') as task_notes
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           where el.project_id = 117 and el.external_ref_type = 'TASK' and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_notes is not null
           group by el.internal_id ) tasknote on (tasknote.srid = sr.task_id)   
LEFT JOIN (select distinct tn.task_id, listagg(tn.text, ' <Note Text> ') as text
           from "MARSDB"."MARSDB_TASK_NOTES_VW" tn where tn.text is not null and tn.project_id = 117
           group by tn.task_id) srnote on (srnote.task_id = sr.task_id) 
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp1 on (emp1.user_id = papp.updated_by)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp2 on (emp2.user_id = papp.staff_assigned_to)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp3 on (emp3.user_id = initdispo.updated_by)
where 1=1  
and sr.project_id = 117
AND sr.task_type_id IN ('13473','13475') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
--and sr.task_id in (952018)
union all
-- migrated apps  -- 
select distinct 
    'YES' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"
  , cel.external_ref_id as "Consumer ID"
  , srctd.apptp as "App Type"
  , CASE WHEN srctd.apptp like '%CPU%' THEN 'CPU'    
         WHEN srctd.apptp like '%PW%' THEN 'CPU'
         WHEN srctd.apptp like '%CVIU%' THEN 'CVIU'
         ELSE NULL END AS "Business Unit"
  , coalesce(srctd.exapid, i.VACMS_App_ID) as "External App ID" 
  , mywsdt2.mywsdt as "My Work Space Date" 
  , date(initdispo.updated_on) as "Initial Disposition Date"
  , emp3.name as "Initial Disposition By Staff Name"
  , srctd.dispo as "Disposition"
  , pactd.ats as "Action Taken"
  , srctd.decsnsrc as "SR Decision Source"
  , papp.task_id as "Process App Task ID"
  , papp.task_type_name as "Process App Task Type"
  , papp.task_status as "Process App Status"
  , papp.status_date as "Process App Status Date"
  , papp.updated_on as "Process App Update Date"
  , papp.updated_by as "Process App Updated By ID"
  , emp1.name as "Process App Updated By Name"
  , papp.staff_assigned_to as "Process App Assigned To ID"
  , emp2.name as "Process App Assigned To Name"
  , pactd.dispo as "Proc App Dispo"
  , pactd.chnl as "Channel"
  , pactd.factyp as "Facility Type"
  , pactd.facnam as "Facilty Name"
  , pactd.appsubstat as "Substatus"
  , pactd.rsn as "Reason"
  , pactd.dnlrsn as "Denial Reason"
  , pactd.dcsrc as "Decision Source"
  , pactd.mirq as "Missing Info Required"
  , pactd.hpe as "HPE?"
  , pactd1.vclsent as "VCL Sent Date"  
  , pactd1.vcldue as "VCL Due Date"    
  , pactd1.appsigdt as "App Signature Date"
  , pactd1.appdtrcd as "App Received Date"
  , pactd1.dtrcd as "Date Received"
  , pactd1.dob as "Date of Birth"
  , pactd2.apctinhshd as "No. Applicants in Household"
  , pactd2.apprvdapct as "No. Approved Applicants"
  , pactd.expedited as "Expedited"
  , pactd.locality as "Locality"
  , pactd.inbncortyp as "Inbound Correspondence Type"
  , concat(pactd.cwfn, ' ' ,pactd.cwln) as "Case Worker Name"
  , srnote.text as "SR Notes"
  , tasknote.task_notes as "Task Notes"
  , sr.due_in_days as "SR due in Days"
  , sr.default_due_date as "SR Default Due Date"
  , papp.due_in_days as "Proc App Due in Days"
  , papp.default_due_date as "Proc App Default Due Date"
  , null as "Second VCL Sent Date"
  , null as "Third VCL Sent Date"
  , null as "VCL Exception"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('APPROVED','DENIED') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end "Pre Release Recon Complete"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('COVERAGE_CORRECTION_NEEDED','VCL') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null)) then 1 else 0 end "Pre Release Recon Incomplete"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('APPROVED') or  (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end "Pre Release Outcome Approved"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('DENIED')) then 1 else 0 end  "Pre Release Outcome Denied"
  , Case when ((srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null) or srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat='VCL')then 1 else 0 end "Pre Release Outcome Pending CVIU"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and pactd.appsubstat in ('COVERAGE_CORRECTION_NEEDED')) then 1 else 0 end "Pre Release Outcome Pending DMAS"   
  , initact.acttk as "First Action Taken", initact.updated_on as "First Action Taken Date"
  , act2.acttk as "Second Action Taken", act2.updated_on as "Second Action Taken Date"
  , act3.acttk as "Third Action Taken", act3.updated_on as "Third Action Taken Date"  
  , initdispo.dispo as "First Dispostion", initdispo.updated_on as "First Disposition Date"
  , dispo2.dispo as "Second Disposition", dispo2.updated_on as "Second Disposition Date"  
  , dispo3.dispo as "Third Disposition", dispo3.updated_on as "Third Disposition Date"
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN "MARSDB"."MARSDB_ETL_INCIDENTS_INIT" i on (i.cp_task_id = sr.task_id)
LEFT JOIN "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" cel ON (cel.internal_id = sr.task_id and cel.internal_ref_type = 'SERVICE_REQUEST' AND cel.external_ref_type = 'CONSUMER' and cel.project_id = 117)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                 , t.due_in_days, t.default_due_date
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117  )
           ) papp on (papp.srid = sr.task_id) 
LEFT JOIN (select x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."153" as decsnsrc          
           from (select td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_TASK_DETAIL_VW" td where td.task_field_id in (55,71,148,153) 
                 and td.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,153)) x
           ) srctd on (srctd.task_id = sr.task_id)
LEFT JOIN (select x.SRID as SRID, x.task_id, x."71" as dispo, x."112" as facnam, x."147" as appsubstat, x."93" as rsn, x."161" as dnlrsn 
                , x."12" as chnl, x."113" as factyp,  x."144" as ats, x."153" as dcsrc, x."120" as mirq, x."117" as hpe, x."4" as cwln, x."3" as cwfn
                , x."119" as locality, x."131" as expedited, x."59" as inbncortyp
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,112,147,93,161,12,113,144,153,120,117,3,4,119,131,59)) x
           ) pactd on (pactd.srid = sr.task_id) 
LEFT JOIN (select x.SRID as SRID, x.task_id, x."146" as appsigdt, x."102" as mywsdt, x."145" as appdtrcd, x."103" as dtrcd, x."38" as dob, x."173" as vclsent, x."175" as vcldue            
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_date
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (146,102,145,103,38,173,175))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117   
                 ) pivot (max(selection_date) for task_field_id in (146,102,145,103,38,173,175)) x
          ) pactd1 on (pactd1.srid = sr.task_id)
LEFT JOIN (select x.SRID as SRID, x.task_id, x."160" as apctinhshd, x."159" as apprvdapct         
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_numeric
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (160,159))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117   
                 ) pivot (max(selection_numeric) for task_field_id in (160,159)) x
           ) pactd2 on (pactd2.srid = sr.task_id)
LEFT JOIN (select tt.task_id
                , case when tt.task_info like '%My Workspace Date%' then right(left(tt.task_info, 28),10)
                       when tt.task_info like '%DMAS Received Date%' then right(left(tt.task_info, 29),10)
                       end as mywsdt
           from "MARSDB"."MARSDB_TASKS_VW" tt
           where tt.project_id = 117 
           and (tt.task_info not like ('%No My Workspace Date received%')
           and  tt.task_info not like ('%No DMAS Received Date receive%'))) mywsdt2 on (mywsdt2.task_id = sr.task_id)   


LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 1 ) initdispo on (initdispo.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 1 ) initact on (initact.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 2 ) dispo2 on (dispo2.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 2 ) act2 on (act2.srid = sr.task_id)  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 3 ) dispo3 on (dispo3.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 13474)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 3 ) act3 on (act3.srid = sr.task_id) 
  
LEFT JOIN (select distinct el.internal_id as SRID, listagg(t.task_notes, ' <Task Notes> ') as task_notes
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           where el.project_id = 117 and el.external_ref_type = 'TASK' and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_notes is not null
           group by el.internal_id ) tasknote on (tasknote.srid = sr.task_id)   
LEFT JOIN (select distinct tn.task_id, listagg(tn.text, ' <Note Text> ') as text
           from "MARSDB"."MARSDB_TASK_NOTES_VW" tn where tn.text is not null and tn.project_id = 117
           group by tn.task_id) srnote on (srnote.task_id = sr.task_id) 
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp1 on (emp1.user_id = papp.updated_by)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp2 on (emp2.user_id = papp.staff_assigned_to)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp3 on (emp3.user_id = initdispo.updated_by)
where 1=1  
and sr.project_id = 117
and sr.task_type_id IN ('13473','13475')
and sr.CREATED_BY = '3486'
and mywsdt2.mywsdt > '2021-03-15'
union all
-- new sr types  15182  --- 14995 new / 14949 old
select distinct 
    'NO' as "Migrated"
  , sr.task_id as "SR ID"
  , tt2.task_type_name as "SR Type"
  , date(sr.created_on) as "SR Create Date"
  , sr.task_status as "SR Status"
  , date(sr.status_date) as "SR Status Date"
  , cel.external_ref_id as "Consumer ID"
  , srctd.apptp as "App Type"
  , CASE WHEN srctd.apptp like '%CPU%' THEN 'CPU'    
         WHEN srctd.apptp like '%PW%' THEN 'CPU'
         WHEN srctd.apptp like '%CVIU%' THEN 'CVIU'
         ELSE NULL END AS "Business Unit"
  , srctd.exapid as "External App ID"
  , srctd1.mywsdt as "My Work Space Date" 
  , date(initdispo.updated_on) as "Initial Disposition Date"
  , emp3.name as "Initial Disposition By Staff Name"
  , srctd.dispo as "Disposition"
  , pactd.ats as "Action Taken" -- 
  , srctd.dcsrc as "SR Decision Source"
  , papp.task_id as "Process App Task ID"
  , papp.task_type_name as "Process App Task Type"
  , papp.task_status as "Process App Status"
  , papp.status_date as "Process App Status Date"
  , papp.updated_on as "Process App Update Date"
  , papp.updated_by as "Process App Updated By ID"
  , emp1.name as "Process App Updated By Name"
  , papp.staff_assigned_to as "Process App Assigned To ID"
  , emp2.name as "Process App Assigned To Name"
  , pactd.dispo as "Proc App Dispo" --
  , srctd.chnl as "Channel"
  , srctd.factyp as "Facility Type"
  , srctd.facnam as "Facilty Name"
  , srctd.appsubstat as "Substatus"
  , srctd.rsn as "Reason"
  , srctd.dnlrsn as "Denial Reason"
  , srctd.dcsrc as "Decision Source"
  , srctd.mirq as "Missing Info Required"
  , srctd.hpe as "HPE?"
  , srctd1.vclsent as "VCL Sent Date"  
  , srctd1.vcldue as "VCL Due Date"    
  , srctd1.appsigdt as "App Signature Date"
  , srctd1.appdtrcd as "App Received Date"
  , srctd1.dtrcd as "Date Received"
  , srctd1.dob as "Date of Birth"
  , srctd2.apctinhshd as "No. Applicants in Household"
  , srctd2.apprvdapct as "No. Approved Applicants"
  , srctd.expedited as "Expedited"
  , srctd.locality as "Locality"
  , srctd.inbncortyp as "Inbound Correspondence Type"
  , concat(srctd.cwfn, ' ' ,srctd.cwln) as "Case Worker Name"
  , srnote.text as "SR Notes"
  , tasknote.task_notes as "Task Notes"
  , sr.due_in_days as "SR due in Days"
  , sr.default_due_date as "SR Default Due Date"
  , papp.due_in_days as "Proc App Due in Days"
  , papp.default_due_date as "Proc App Default Due Date"
  , vcl2.selection_date as "Second VCL Sent Date"
  , vcl3.selection_date "Third VCL Sent Date"
  , case when srctd1.vclsent <> vcl2.selection_date and srctd1.vclsent <> vcl3.selection_date and vcl2.selection_date is not null
         and vcl3.selection_date is not null and srctd1.vclsent is not null then 'VCL Exception' else null end as "VCL Exception"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat in ('APPROVED','DENIED') or (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end "Pre Release Recon Complete"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat in ('COVERAGE_CORRECTION_NEEDED','VCL') or (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null)) then 1 else 0 end "Pre Release Recon Incomplete"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat in ('APPROVED') or (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo='APPROVED')) then 1 else 0 end "Pre Release Outcome Approved"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat in ('DENIED')) then 1 else 0 end  "Pre Release Outcome Denied"
  , Case when ((srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat ='COVERAGE_CORRECTION_COMPLETED' and srctd.dispo is null) or srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat='VCL')then 1 else 0 end "Pre Release Outcome Pending CVIU"
  , Case when (srctd.apptp = 'PRE_RELEASE_APPLICATION_CVIU' and srctd.appsubstat in ('COVERAGE_CORRECTION_NEEDED')) then 1 else 0 end "Pre Release Outcome Pending DMAS" 
  , initact2.acttk as "First Action Taken", initact2.updated_on as "First Action Taken Date"
  , act2.acttk as "Secon Action Taken", act2.updated_on as "Second Action Taken Date"
  , act3.acttk as "Third Action Taken", act3.updated_on as "Third Action Taken Date"  
  , initdispo2.dispo as "First Dispostion", initdispo2.updated_on as "First Disposition Date"
  , dispo2.dispo as "Second Disposition", dispo2.updated_on as "Second Disposition Date"  
  , dispo3.dispo as "Third Disposition", dispo3.updated_on as "Third Disposition Date"
FROM "MARSDB"."MARSDB_TASKS_VW" sr
JOIN "MARSDB"."MARSDB_TASK_TYPE_VW" tt2 on (sr.task_type_id = tt2.task_type_id)
LEFT JOIN "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" cel ON (cel.internal_id = sr.task_id and cel.internal_ref_type = 'SERVICE_REQUEST' AND cel.external_ref_type = 'CONSUMER' and cel.project_id = 117)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, t.task_id, tt.task_type_name, t.task_status, t.status_date, t.updated_on, t.updated_by, t.staff_assigned_to
                 ,t.due_in_days, t.default_due_date
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           left join "MARSDB"."MARSDB_TASK_TYPE_VW" tt on (t.task_type_id = tt.task_type_id and tt.project_id = 117)
           where el.external_ref_type = 'TASK'
           AND el.internal_ref_type = 'SERVICE_REQUEST'
           and el.project_id = 117  )
           ) papp on (papp.srid = sr.task_id) 
LEFT JOIN (select x.SRID as SRID, x.task_id, x."55" as exapid, x."71" as dispo, x."148" as apptp, x."144" as ats          
           from (select distinct el.internal_id as SRID, td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
                 join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
                 join "MARSDB"."MARSDB_TASK_DETAIL_VW" td on (td.task_id = t.task_id and td.project_id = 117 and td.task_field_id in (55,71,148,144))     
                 where el.external_ref_type = 'TASK'
                 and   el.internal_ref_type = 'SERVICE_REQUEST'
                 and   el.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,71,148,144)) x
           ) pactd on (pactd.srid = sr.task_id)   
LEFT JOIN (select x.task_id, x."55" as exapid, x."4" as cwln, x."3" as cwfn, x."119" as locality, x."112" as facnam, x."147" as appsubstat, x."59" as inbncortyp
                , x."93" as rsn, x."161" as dnlrsn, x."12" as chnl, x."148" as apptp, x."71" as dispo, x."113" as factyp, x."153" as dcsrc, x."120" as mirq
                , x."117" as hpe, x."131" as expedited
           from (select td.task_id, td.task_field_id, td.selection_varchar
                 from "MARSDB"."MARSDB_TASK_DETAIL_VW" td where td.task_field_id in (55,3,4,119,112,147,59,93,161,12,148,71,113,153,120,117,131) 
                 and td.project_id = 117 
                 ) pivot (max(selection_varchar) for task_field_id in (55,3,4,119,112,147,59,93,161,12,148,71,113,153,120,117,131)) x
           ) srctd on (srctd.task_id = sr.task_id)
LEFT JOIN (select x.task_id, x."145" as appdtrcd, x."146" as appsigdt, x."102" as mywsdt, x."175" as vcldue, x."173" as vclsent, x."103" as dtrcd, x."38" as dob, x."174" as mircddt            
           from (select td.task_id, td.task_field_id, td.selection_date
                 from "MARSDB"."MARSDB_TASK_DETAIL_VW" td where td.task_field_id in (145,146,102,175,173,103,38,174)     
                 and td.project_id = 117   
                 ) pivot (max(selection_date) for task_field_id in (145,146,102,175,173,103,38,174)) x
           ) srctd1 on (srctd1.task_id = sr.task_id) 
LEFT JOIN (select x.task_id, x."91" as extcaseid, x."160" as apctinhshd, x."159" as apprvdapct         
           from (select td.task_id, td.task_field_id, td.selection_numeric
                 from "MARSDB"."MARSDB_TASK_DETAIL_VW" td where td.task_field_id in (91,160,159)     
                 and td.project_id = 117  
                 ) pivot (max(selection_numeric) for task_field_id in (91,160,159)) x
           ) srctd2 on (srctd2.task_id = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct th.task_id as SRID, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by th.task_id  order by th.task_detail_history_id) rn
           from  "MARSDB"."MARSDB_TASKS_VW" t
           join  "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where t.project_id = 117 and t.task_type_id in (15180,15181) ) 
           where rn = 1 ) initdispo on (initdispo.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 1 ) initact on (initact.srid = sr.task_id)
LEFT JOIN (select distinct el.internal_id as SRID, listagg(t.task_notes, ' <Task Notes> ') as task_notes
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117)
           where el.project_id = 117 and el.external_ref_type = 'TASK' and el.internal_ref_type = 'SERVICE_REQUEST'
           and t.task_notes is not null
           group by el.internal_id ) tasknote on (tasknote.srid = sr.task_id)   
LEFT JOIN (select distinct tn.task_id, listagg(tn.text, ' <Note Text> ') as text
           from "MARSDB"."MARSDB_TASK_NOTES_VW" tn where tn.text is not null and tn.project_id = 117
           group by tn.task_id) srnote on (srnote.task_id = sr.task_id) 
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp1 on (emp1.user_id = papp.updated_by)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp2 on (emp2.user_id = papp.staff_assigned_to)
LEFT JOIN (SELECT distinct u.user_id, concat(s.first_name, ' ',s.last_name) as name, s.maximus_id, t.TEAM_NAME, pr.role_name
           FROM "MARSDB"."MARSDB_USER_VW" u
           LEFT JOIN "MARSDB"."MARSDB_TEAM_USER_VW" tu on u.user_id = tu.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_STAFF_VW" s on s.STAFF_ID = u.STAFF_ID
           LEFT JOIN "MARSDB"."MARSDB_TEAM_VW" t on t.TEAM_ID = tu.TEAM_ID
           LEFT JOIN "MARSDB"."MARSDB_USER_PROJECT_ROLE_VW" upr on upr.USER_ID = u.USER_ID
           LEFT JOIN "MARSDB"."MARSDB_PROJECT_ROLE_VW" pr on pr.PROJECT_ROLE_ID = upr.PROJECT_ROLE_ID
           where u.project_id = 117
           ) emp3 on (emp3.user_id = initdispo.updated_by)
LEFT JOIN (select * from (    
           select td.task_id, td.task_detail_history_id, td.task_field_id, td.selection_date, td.updated_on
           , row_number() over(partition by td.task_id order by td.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" td where td.task_field_id = 173 
           and td.project_id = 117 and td.selection_date is not null) 
           where rn = 2) vcl2 on (vcl2.task_id = sr.task_id)   
LEFT JOIN (select * from (    
           select td.task_id, td.task_detail_history_id, td.task_field_id, td.selection_date, td.updated_on
           , row_number() over(partition by td.task_id order by td.task_detail_history_id desc) rn
           from "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" td where td.task_field_id = 173 
           and td.project_id = 117 and td.selection_date is not null) 
           where rn = 3) vcl3 on (vcl3.task_id = sr.task_id)   

LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 1 ) initdispo2 on (initdispo2.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 1 ) initact2 on (initact2.srid = sr.task_id)
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 2 ) dispo2 on (dispo2.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 2 ) act2 on (act2.srid = sr.task_id)  
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as dispo, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 71 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117)
           where rn = 3 ) dispo3 on (dispo3.srid = sr.task_id) 
LEFT JOIN (select * from (                                                              
           select distinct el.internal_id as SRID, th.task_id, th.selection_varchar as acttk, th.updated_on, th.updated_by
           , row_number() over(partition by el.internal_id, th.task_id  order by th.task_detail_history_id) rn
           from "MARSDB"."MARSDB_EXTERNAL_LINKS_VW" el
           join "MARSDB"."MARSDB_TASKS_HISTORY_VW" t on (el.external_ref_id = t.task_id and t.project_id = 117 and t.task_type_id = 15182)
           join "MARSDB"."MARSDB_TASK_DETAIL_HISTORY_VW" th on (t.task_id = th.task_id and t.task_history_id = th.task_history_id and th.task_field_id = 144 and th.selection_varchar is not null and th.project_id = 117)
           where el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' and el.project_id = 117 )
           where rn = 3 ) act3 on (act3.srid = sr.task_id)  
  
where 1=1  
and sr.project_id = 117
AND sr.task_type_id IN ('15180','15181') -- application sr, renewal sr respectively
and sr.CREATED_BY <> '3486'
;
