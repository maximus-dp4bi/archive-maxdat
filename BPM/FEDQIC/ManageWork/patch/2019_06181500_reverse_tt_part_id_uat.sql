--undo data fix

--update fedqic_maxdat_stg so that c_status = part based combo id
update maxdat.fedqic_maxdat_stg
set c_status = 
CASE WHEN c_status like '%430' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 3))
     WHEN c_status like '%431' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 3))
     WHEN c_status like '%432' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 3))
     WHEN c_status like '%433' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 3))
     WHEN c_status like '%813848' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 6))
     ELSE c_status
     END;

--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;

--update corp_etl_mw
update maxdat.corp_etl_mw
set task_type_id = 
CASE WHEN task_type_id like '%430' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%431' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%432' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%433' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%813848' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 6))
     ELSE task_type_id
     END;     

     
 --update d_mw_task_instance
update maxdat.d_mw_task_instance
set task_type_id = 
CASE WHEN task_type_id like '%430' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%431' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%432' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%433' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     WHEN task_type_id like '%813848' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 6))
     ELSE task_type_id
     END;   
         
--reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;  


--undo config
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
where task_type_id like '%430'
--or task_type_id like '%431' --comment out for uat only
or task_type_id like '%432' 
or task_type_id like '%433' 
or task_type_id like '%813848';

--uat only
update  maxdat.d_bpm_task_type_entity 
set task_type_id = 
CASE WHEN task_type_id like '%431' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 3))
     ELSE task_type_id
     END;  


delete maxdat.d_task_types 
where task_type_id like '%430'
or task_type_id like '%431'
or task_type_id like '%432' 
or task_type_id like '%433' 
or task_type_id like '%813848'
--uat only
or task_type_id like '%433434'
or task_type_id like '%433435'
or task_type_id like '%433436';

-----------------------------------

select distinct(task_type_id) from maxdat.corp_etl_mw order by task_type_id;
select distinct(task_type_id) from maxdat.d_mw_task_instance order by task_type_id;
select * from maxdat.d_bpm_task_type_entity order by task_type_id;
select * from maxdat.d_task_types order by task_type_id;