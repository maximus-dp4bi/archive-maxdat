update  step_instance_stg
set mw_processed = 'N'
where step_instance_history_id in (
select step_instance_history_id 
from corp_etl_manage_work mw, 
     step_instance_stg sis,
     staff_lkup s_own,
     groups_stg g_team,
     groups_stg g_grp
where  mw.stage_done_date is null and mw.cancel_work_flag = 'N'
 and mw.task_id = sis.step_instance_id
-- and task_id in (131054,131451,130995,131041,130676,130707,130789)
and sis.owner     = s_own.Staff_id  (+)
and sis.team_id   = g_team.group_id (+)
and sis.group_id  = g_grp.group_id  (+)
and sis.step_instance_history_id in (select max(sis2.step_instance_history_id)
                                     from step_instance_stg sis2
                                     where sis2.step_instance_id = mw.task_id ) 
and (nvl(mw.owner_name,'o')       <> nvl(s_own.Display_Name,'o')
OR nvl(mw.group_name,'o')         <> nvl(g_grp.GROUP_NAME ,'o')
OR nvl(mw.team_name,'o')          <> nvl(g_team.GROUP_NAME ,'o')
OR nvl(mw.source_reference_id,01) <> nvl(sis.ref_id,01) )
);
