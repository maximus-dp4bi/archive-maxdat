--ppit
select count(*) from coverva_dmas.dmas_application
where file_id in(10934,10949);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10949,10934)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10934);

update coverva_dmas.dmas_application_current
set file_id = 10949
where file_id = 10934;

--cviu
select count(*) from coverva_dmas.dmas_application
where file_id in(10931,10947);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10947,10931)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10931);

update coverva_dmas.dmas_application_current
set file_id = 10947
where file_id = 10931;

--cpui
select count(*) from coverva_dmas.dmas_application
where file_id in(10932,10946);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10946,10932)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10932);

update coverva_dmas.dmas_application_current
set file_id = 10946
where file_id = 10932;

--appmetric
select count(*) from coverva_dmas.dmas_application
where file_id in(10938,10930,10925);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10938,10930,10945,10925)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10938,10930,10925);

update coverva_dmas.dmas_application_current
set file_id = 10945
where file_id in(10938,10930,10925);

--cm43
select * from coverva_dmas.dmas_application
where file_id in(10928,10943);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10928,10943)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10928);

update coverva_dmas.dmas_application_current
set file_id = 10943
where file_id in(10928);

--pw
select * from coverva_dmas.dmas_application d
where file_id in(10924,10944,10929,10937);

select file_id,count(*) from coverva_dmas.dmas_application_current
where file_id in(10924,10944,10929,10937)
group by file_id;

delete from  coverva_dmas.dmas_application
where file_id in(10944,10929,10937);

select * from coverva_dmas.dmas_application_current
where file_id in(10944,10929,10937);

select *
from cm043_data_full_load c
where filename = 'CM_043_20230307_081857'
and exists(select 1 from cm043_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cm043_data_id < t.cm043_data_id);

select count(*) from app_metric_full_load c
where upper(filename) = 'APPMETRIC_03072023_160002'
and exists(select 1 from app_metric_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.appmetric_data_id < t.appmetric_data_id);

select count(*) from app_metric_pw_full_load c
where upper(filename) = 'APPMETRIC_PW_03072023_160002'
and exists(select 1 from app_metric_pw_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.appmetric_pw_data_id < t.appmetric_pw_data_id);

select count(*) from ppit_data_full_load c
where upper(filename) = 'PPIT_20230308_081904'
and exists(select 1 from ppit_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.ppit_data_id < t.ppit_data_id);

select count(*) from application_override_full_load c
where upper(filename) = 'RUNNING_MASTER_OVERRIDE_20230308_081900'
and exists(select 1 from application_override_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.app_override_id < t.app_override_id);

select count(*) from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

select count(*) from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_YESTERDAY_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

select count(*) from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_TRNS_YESTERDAY_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

select count(*) from cviu_data_full_load c
where upper(filename) = 'CVIU_INVENTORY_20230308_081858'
and exists(select 1 from cviu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cviu_data_id < t.cviu_data_id);

select count(*) from cpu_incarcerated_full_load c
where upper(filename) = 'CPU_I_INVENTORY_20230308_081857'
and exists(select 1 from cpu_incarcerated_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_incarcerated_id < t.cpu_incarcerated_id);

-----

delete from cm043_data_full_load c
where filename = 'CM_043_20230307_081857'
and exists(select 1 from cm043_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cm043_data_id < t.cm043_data_id);

delete from app_metric_full_load c
where upper(filename) = 'APPMETRIC_03072023_160002'
and exists(select 1 from app_metric_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.appmetric_data_id < t.appmetric_data_id);

delete from app_metric_pw_full_load c
where upper(filename) = 'APPMETRIC_PW_03072023_160002'
and exists(select 1 from app_metric_pw_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.appmetric_pw_data_id < t.appmetric_pw_data_id);

delete from ppit_data_full_load c
where upper(filename) = 'PPIT_20230308_081904'
and exists(select 1 from ppit_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.ppit_data_id < t.ppit_data_id);

delete from application_override_full_load c
where upper(filename) = 'RUNNING_MASTER_OVERRIDE_20230308_081900'
and exists(select 1 from application_override_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.app_override_id < t.app_override_id);

delete  from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

delete  from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_YESTERDAY_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

delete  from cpu_data_full_load c
where upper(filename) = 'CPUREPORT_TRNS_YESTERDAY_03082023_090102'
and exists(select 1 from cpu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_data_id < t.cpu_data_id);

delete from cviu_data_full_load c
where upper(filename) = 'CVIU_INVENTORY_20230308_081858'
and exists(select 1 from cviu_data_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cviu_data_id < t.cviu_data_id);

delete  from cpu_incarcerated_full_load c
where upper(filename) = 'CPU_I_INVENTORY_20230308_081857'
and exists(select 1 from cpu_incarcerated_full_load t where c.tracking_number = t.tracking_number and c.filename = t.filename and c.cpu_incarcerated_id < t.cpu_incarcerated_id);

delete from coverva_dmas.dmas_file_log d
WHERE 1=1
AND filename_prefix in(select filename_prefix from coverva_dmas.dmas_file_load_lkup where use_in_inventory = 'Y')
AND cast(load_date as date) >= current_date()
and not exists(select 1 from coverva_dmas.dmas_application t where d.file_id = t.file_id)
and not exists(select 1 from coverva_dmas.dmas_application_current t where d.file_id = t.file_id);


