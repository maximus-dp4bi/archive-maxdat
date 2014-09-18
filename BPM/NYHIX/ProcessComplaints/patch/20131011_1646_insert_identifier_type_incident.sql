delete from corp_etl_error_log where process_name =  'PROCESS INCIDENT COMPLAINTS';

delete from corp_etl_list_lkup where name = 'ProcessComp_Fwding_Target'
and  list_type = 'COMPLAINT';
       
insert into bpm_identifier_type_lkup(bil_id, name) values (10,'Incident ID');

update corp_etl_control set value = 200 where name = 'COMP_LOOK_BACK_DAYS';

commit;