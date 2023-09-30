--undo data fix

--update fedqic_maxdat_stg so that c_status = part based combo id
update maxdat.fedqic_maxdat_stg
set c_status = 
CASE WHEN c_status like '%1578' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN c_status like '%1579' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN c_status like '%1580' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN c_status like '%1581' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN c_status like '%9286944' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 7))
     ELSE c_status
     END;

--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;

--update corp_etl_mw
update maxdat.corp_etl_mw
set task_type_id = 
CASE WHEN task_type_id like '%1578' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1579' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1580' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1581' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%9286944' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 7))
     ELSE task_type_id
     END;     

     
 --update d_mw_task_instance
update maxdat.d_mw_task_instance
set task_type_id = 
CASE WHEN task_type_id like '%1578' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1579' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1580' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%1581' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN task_type_id like '%9286944' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 7))
     ELSE task_type_id
     END;   
         
--reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;  


--undo config

insert into maxdat.BPM_D_OPS_GROUP_TASK values ('None','Awaiting Data Entry');
delete maxdat.BPM_D_OPS_GROUP_TASK
where task_type like '%- Part C'
or task_type like '%- Part A'
or task_type like '%- Part D-Drug' 
or task_type like '%- Part D-LEP' 
or task_type like '%- DME';

delete maxdat.CORP_ETL_LIST_LKUP
where value like '%- Part C'
or value like '%- Part A'
or value like '%- Part D-Drug' 
or value like '%- Part D-LEP' 
or value like '%- DME';
  
delete maxdat.d_bpm_task_type_entity 
where task_type_id like '%1578'
or task_type_id like '%1579'
or task_type_id like '%1580' 
or task_type_id like '%1581' 
or task_type_id like '%9286944'; 


insert into d_task_types 
        select 21539023,task_name,task_description,operations_group,sla_days, sla_days_type,sla_target_days,sla_jeopardy_days, unit_of_work
        from maxdat.d_task_types where task_type_id = 215390231580;

delete maxdat.d_task_types 
where task_type_id like '%1578'
or task_type_id like '%1579'
or task_type_id like '%1580' 
or task_type_id like '%1581' 
or task_type_id like '%9286944'; 




