--update fedqic_maxdat_stg
alter table fedqic_maxdat_stg add (hold_priority NUMBER(19,0));
update maxdat.fedqic_maxdat_stg set hold_priority = c_appeal_priority;
update maxdat.fedqic_maxdat_stg set c_appeal_priority = null;
ALTER TABLE maxdat.fedqic_maxdat_stg modify c_appeal_priority VARCHAR2(255 CHAR);
update maxdat.fedqic_maxdat_stg set c_appeal_priority = hold_priority;
alter table maxdat.fedqic_maxdat_stg drop column hold_priority;
update maxdat.fedqic_maxdat_stg set c_appeal_priority =
case when c_appeal_priority = '1590' then 'Expedited'	
when c_appeal_priority = '1591' then 'Standard'	
when c_appeal_priority = '1592' then 'PreService'	
when c_appeal_priority = '1593' then 'Retrospective' 
end
where c_appeal_priority in ('1590','1591','1592','1593');
--update corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;
update maxdat.corp_etl_mw set task_priority =
case when task_priority = '1590' then 'Expedited'	
when task_priority = '1591' then 'Standard'	
when task_priority = '1592' then 'PreService'	
when task_priority = '1593' then 'Retrospective'
end
where task_priority in ('1590','1591','1592','1593');
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;
--update task instance table
update maxdat.d_mw_task_instance set task_priority =
case when task_priority = '1590' then 'Expedited'	
when task_priority = '1591' then 'Standard'	
when task_priority = '1592' then 'PreService'	
when task_priority = '1593' then 'Retrospective'
end
where task_priority in ('1590','1591','1592','1593');
---**************************************************
---verify with developer before committing the changes
--commit the changes
--commit;